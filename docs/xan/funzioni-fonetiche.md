# Trovare nomi simili per suono con le funzioni fonetiche di Moonblade

Nei dati reali lo stesso cognome compare spesso scritto in modi diversi: *Rossi*, *Rosi*, *Russi*. Il confronto esatto non trova nulla; il confronto fonetico sì.

Le funzioni `soundex`, `refined_soundex` e `phonogram` in Moonblade trasformano una stringa nel suo **codice fonico** — una rappresentazione di come suona, indipendentemente dalla grafia. Due parole con lo stesso codice si pronunciano in modo simile.

Le funzioni si usano nelle espressioni Moonblade all'interno di comandi come `xan map` e `xan filter`.

## Dataset di esempio

Usa il file di esempio: `docs/xan/risorse/fonetiche/anagrafe.csv`

- CSV nel repository: [docs/xan/risorse/fonetiche/anagrafe.csv](https://github.com/aborruso/arigadicomando/blob/master/docs/xan/risorse/fonetiche/anagrafe.csv)
- Download diretto CSV: [raw.githubusercontent.com/.../anagrafe.csv](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/fonetiche/anagrafe.csv)

Il file contiene 18 record con cognomi scritti in varianti ortografiche diverse:

```csv
id,cognome,nome,comune
1,Rossi,Mario,Roma
2,Rosi,Anna,Milano
3,Russi,Giovanni,Napoli
4,Ferrari,Lucia,Torino
5,Ferrary,Marco,Bologna
6,Ferraro,Sara,Palermo
7,Bianchi,Luca,Firenze
8,Bianki,Elena,Genova
...
```

## Come funzionano le tre funzioni

Le tre funzioni seguono lo stesso principio: ignorano le differenze di grafia e codificano solo il suono. Lo fanno in modo diverso, con granularità crescente.

**`soundex`** è l'algoritmo classico, sviluppato negli anni '40 per gestire varianti ortografiche nei registri anagrafici americani. Produce un codice di quattro caratteri: la prima lettera della parola seguita da tre cifre che rappresentano i gruppi consonantici principali. Consonanti foneticamente simili (come `c`, `g`, `k`) finiscono nello stesso gruppo e producono la stessa cifra. Vocali e lettere doppie vengono ignorate. Risultato: *Rossi*, *Rosi* e *Russi* producono tutti `R200`.

**`refined_soundex`** è una versione più precisa dello stesso algoritmo: usa una tabella di codifica più dettagliata e produce codici più lunghi. Distingue varianti che soundex classico raggrupperebbe: *Russo* e *Ruzzo* danno rispettivamente `R030` e `R050`.

**`phonogram`** usa un approccio diverso: si concentra sulle consonanti foneticamente rilevanti e produce codici brevi e compatti (es. `rs` per *Rossi*, `frr` per *Ferrari*). È più tollerante alle variazioni vocaliche e adatto a stringhe brevi.

Il comando seguente aggiunge al file tre nuove colonne, una per ciascuna funzione:

```bash
xan map 'soundex(cognome) as sdx, refined_soundex(cognome) as rsdx, phonogram(cognome) as phon' \
  anagrafe.csv
```

`xan map` valuta l'espressione per ogni riga e aggiunge le colonne risultanti in coda. L'espressione contiene tre chiamate separate, collegate dalla virgola: `soundex(cognome) as sdx` calcola il codice soundex del campo `cognome` e lo salva nella nuova colonna `sdx`; lo stesso pattern si ripete per `rsdx` e `phon`.

Output:

```csv
id,cognome,nome,comune,sdx,rsdx,phon
1,Rossi,Mario,Roma,R200,R030,rs
2,Rosi,Anna,Milano,R200,R030,rs
3,Russi,Giovanni,Napoli,R200,R030,rs
4,Ferrari,Lucia,Torino,F660,F09090,frr
5,Ferrary,Marco,Bologna,F660,F09090,frr
6,Ferraro,Sara,Palermo,F660,F09090,frr
7,Bianchi,Luca,Firenze,B520,B0830,bnʃ
8,Bianki,Elena,Genova,B520,B0830,bnk
9,Esposito,Carlo,Napoli,E212,E3103060,spst
10,Espositu,Rosa,Bari,E212,E3103060,spst
11,Conti,Pietro,Roma,C530,C0860,knt
12,Conte,Giulia,Milano,C530,C0860,knt
13,De Luca,Fabio,Napoli,D420,D07030,dlk
14,DeLuca,Marta,Salerno,D420,D07030,dlk
15,Santoro,Bruno,Palermo,S536,S086090,sntr
16,Santoru,Carla,Cagliari,S536,S086090,sntr
17,Russo,Paolo,Napoli,R200,R030,rs
18,Ruzzo,Teresa,Catanzaro,R200,R050,rs
```

Cosa notare:

- *Rossi*, *Rosi*, *Russi*, *Russo* producono tutti `R200` in soundex — stesso suono, grafia diversa;
- *Ferrari*, *Ferrary*, *Ferraro* danno tutti `F660`;
- `refined_soundex` è più granulare: distingue *Ruzzo* da *Russo* (`R050` vs `R030`), cosa che soundex classico non fa;
- `phonogram` produce codici più compatti e focalizzati sulle consonanti.

**Quando scegliere quale funzione:**

| Funzione | Caratteristiche |
|---|---|
| `soundex` | Algoritmo classico (anni '40), ampia tolleranza, può raggruppare cognomi troppo diversi |
| `refined_soundex` | Più preciso, distingue meglio varianti sottili |
| `phonogram` | Codici brevi basati sulle consonanti, adatto a testi brevi |

## Trovare tutti i record che suonano come un cognome

Per trovare nell'anagrafe tutti i record che suonano come *Rossi*:

```bash
xan map 'soundex(cognome) as sdx' anagrafe.csv \
  | xan filter 'eq(sdx, "R200")'
```

Output:

```csv
id,cognome,nome,comune,sdx
1,Rossi,Mario,Roma,R200
2,Rosi,Anna,Milano,R200
3,Russi,Giovanni,Napoli,R200
17,Russo,Paolo,Napoli,R200
18,Ruzzo,Teresa,Catanzaro,R200
```

Cinque persone con cognomi scritti in modo diverso, ma tutti con lo stesso suono.

Il flusso è:

1. `xan map` aggiunge la colonna `sdx` con il codice fonico per ogni riga;
2. `xan filter` seleziona solo le righe con il codice di *Rossi* (`R200`).

## Raggruppare varianti e trovare duplicati fonetici

Per vedere quali cognomi diversi condividono lo stesso codice fonico, ordina per codice e raggruppa:

```bash
xan map 'soundex(cognome) as sdx' anagrafe.csv \
  | xan sort -s sdx \
  | xan select sdx,cognome
```

Output:

```csv
sdx,cognome
B520,Bianchi
B520,Bianki
C530,Conti
C530,Conte
D420,De Luca
D420,DeLuca
E212,Esposito
E212,Espositu
F660,Ferrari
F660,Ferrary
F660,Ferraro
R200,Rossi
R200,Rosi
R200,Russi
R200,Russo
R200,Ruzzo
S536,Santoro
S536,Santoru
```

Ogni gruppo con lo stesso `sdx` rappresenta varianti foneticamente equivalenti.

## Deduplicare per suono

Per tenere un solo record per ogni "suono" distinto di cognome:

```bash
xan map 'soundex(cognome) as sdx' anagrafe.csv \
  | xan sort -s sdx \
  | xan dedup -s sdx \
  | xan select cognome,sdx
```

Output:

```csv
cognome,sdx
Bianchi,B520
Conti,C530
De Luca,D420
Esposito,E212
Ferrari,F660
Rossi,R200
Santoro,S536
```

Da 18 record con varianti ortografiche, si passa a 7 cognomi foneticamente distinti.

## Quando è utile

- **Pulizia di anagrafiche**: individuare nomi duplicati inseriti con grafie diverse in database diversi o in momenti diversi.
- **Ricerca tollerante agli errori**: trovare un cognome anche se è stato scritto male o traslitterato.
- **Confronto tra dataset**: unire due elenchi che usano convenzioni grafiche diverse per gli stessi nomi.
- **Verifica di dati raccolti manualmente**: moduli cartacei digitalizzati, dati storici, trascrizioni.
