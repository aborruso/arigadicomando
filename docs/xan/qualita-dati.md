# Fare controlli su un CSV con xan

Prima di analizzare un dataset vale la pena fare un giro veloce per capire se i dati sono affidabili: ci sono celle vuote dove non dovrebbero esserci? Valori fuori scala? Email malformate? Righe duplicate?

xan non ha un comando di validazione dedicato, ma ha un set di strumenti componibili che permettono di fare questa esplorazione in modo rapido.

## Dataset di esempio

Usa il file di esempio: `docs/xan/risorse/qualita/contribuenti.csv`

- CSV nel repository: [docs/xan/risorse/qualita/contribuenti.csv](https://github.com/aborruso/arigadicomando/blob/master/docs/xan/risorse/qualita/contribuenti.csv)
- Download diretto CSV: [raw.githubusercontent.com/.../contribuenti.csv](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/qualita/contribuenti.csv)

Il file contiene 13 righe con vari problemi intenzionali: campi obbligatori vuoti, un'età negativa, un'età impossibile, un reddito non numerico, email malformate, una riga duplicata.

```csv
id,cognome,nome,codice_fiscale,eta,reddito,email,comune
1,Rossi,Mario,RSSMRA80A01H501Z,44,28500,mario.rossi@comune.it,Roma
2,Bianchi,Anna,BNCNNA92B42F205X,32,41200,anna.bianchi@email.com,Milano
3,Ferrari,Luca,,28,19800,,Torino
4,Conti,Sara,CNTSAR75C55G224W,-5,15300,sara.conti@pec.it,Firenze
5,Esposito,Carlo,SPSCRLO88D01F839Y,36,250000000,carlo@esposito,Napoli
...
```

## Panoramica generale con `stats`

Il punto di partenza è sempre `xan stats`: calcola statistiche per ogni colonna e rivela subito i problemi più evidenti.

```bash
xan stats contribuenti.csv | xan select field,count,count_empty,type,min,max
```

```csv
field,count,count_empty,type,min,max
id,13,0,int,1,13
cognome,13,0,string,,
nome,13,0,string,,
codice_fiscale,11,2,string,,
eta,13,0,int,-5,150
reddito,12,1,string,15300,250000000
email,12,1,string,,
comune,12,1,string,,
```

Cosa leggere:

- `count_empty`: `codice_fiscale` ha 2 celle vuote, `reddito`, `email` e `comune` ne hanno 1 ciascuno;
- `type`: `reddito` risulta `string` invece di `int` — segnale che una cella contiene un valore non numerico;
- `min`/`max` su `eta`: -5 e 150 — entrambi fuori da qualsiasi range plausibile.

Per isolare subito le colonne con celle vuote:

```bash
xan stats contribuenti.csv | xan filter 'count_empty > 0' | xan select field,count_empty
```

```csv
field,count_empty
codice_fiscale,2
reddito,1
email,1
comune,1
```

## Celle vuote

Per trovare le righe che hanno almeno un campo vuoto:

```bash
xan search --empty contribuenti.csv
```

```csv
id,cognome,nome,codice_fiscale,eta,reddito,email,comune
3,Ferrari,Luca,,28,19800,,Torino
7,De Luca,Marco,DLCMRC70F01L219P,54,,marco.deluca@libero.it,
12,Fontana,Pietro,,150,18900,pietro.fontana@gmail.com,Milano
```

Per restringere la ricerca a una colonna specifica, aggiungi `-s`:

```bash
xan search --empty -s codice_fiscale contribuenti.csv
```

```csv
id,cognome,nome,codice_fiscale,eta,reddito,email,comune
3,Ferrari,Luca,,28,19800,,Torino
12,Fontana,Pietro,,150,18900,pietro.fontana@gmail.com,Milano
```

## Valori fuori range

Con `xan filter` puoi definire soglie numeriche e isolare i valori anomali. Per trovare le righe con `eta` fuori dal range plausibile:

```bash
xan filter 'eta < 0 or eta > 120' contribuenti.csv
```

```csv
id,cognome,nome,codice_fiscale,eta,reddito,email,comune
4,Conti,Sara,CNTSAR75C55G224W,-5,15300,sara.conti@pec.it,Firenze
12,Fontana,Pietro,,150,18900,pietro.fontana@gmail.com,Milano
```

Lo stesso approccio funziona per qualsiasi campo numerico. Per trovare redditi oltre un milione:

```bash
xan filter 'try(int(reddito) > 1000000)' contribuenti.csv | xan select id,cognome,reddito
```

```csv
id,cognome,reddito
5,Esposito,250000000
```

`try()` fa sì che le righe con `reddito` vuoto o non numerico non generino errori — vengono semplicemente ignorate dal filtro.

## Valori non numerici in colonne numeriche

Se `stats` segnala una colonna numerica con `type` uguale a `string`, significa che almeno un valore non è un numero. Per trovare quali righe causano il problema:

```bash
xan filter 'try(int(reddito)) eq null and reddito ne ""' contribuenti.csv | xan select id,cognome,reddito
```

```csv
id,cognome,reddito
13,Lombardi,Chiara,abc
```

La condizione `reddito ne ""` esclude le celle semplicemente vuote, isolando solo quelle con un valore testuale non convertibile.

## Formato errato con regex

`xan search -r` filtra le righe che corrispondono a un pattern regex su una colonna. Con `-v` (invert) restituisce invece le righe che NON corrispondono — utile per trovare valori malformati.

Per trovare email che non rispettano il formato base `qualcosa@dominio.estensione`:

```bash
xan search -v -r '^[^@]+@[^@]+\.[^@]+$' -s email contribuenti.csv | xan select id,cognome,email
```

```csv
id,cognome,email
3,Ferrari,
5,Esposito,carlo@esposito
9,Greco,paolo.greco@
```

Tre problemi: una cella vuota, un dominio senza estensione, un indirizzo troncato.

## Duplicati

Per verificare se una colonna (o combinazione di colonne) contiene duplicati usa `xan dedup --check`. Il comando non modifica il file: restituisce un messaggio e un codice di uscita, utile per script e pipeline automatizzate.

```bash
xan dedup --check -s codice_fiscale contribuenti.csv
```

```
xan dedup: selection is NOT unique!
First duplicate record found at index 10:

codice_fiscale RSSMRA80A01H501Z
```

Per trovare tutti i valori duplicati e contarli, usa invece `xan frequency`:

```bash
xan frequency -s codice_fiscale contribuenti.csv | xan filter 'count > 1'
```

```csv
field,value,count
codice_fiscale,<empty>,2
codice_fiscale,RSSMRA80A01H501Z,2
```

Due codici fiscali compaiono più di una volta: le due celle vuote e il codice `RSSMRA80A01H501Z` che appartiene alla riga duplicata.

## Riepilogo: una sequenza di controllo

Questi comandi possono essere eseguiti in sequenza su qualsiasi file CSV come primo controllo:

```bash
# 1. panoramica generale
xan stats file.csv | xan select field,count,count_empty,type,min,max

# 2. colonne con celle vuote
xan stats file.csv | xan filter 'count_empty > 0' | xan select field,count_empty

# 3. righe con almeno un campo vuoto
xan search --empty file.csv

# 4. duplicati sull'identificatore
xan dedup --check -s id file.csv
```

I risultati orientano i controlli successivi più mirati (range, formato, tipo).
