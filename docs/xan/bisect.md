# Ricerca rapida su CSV ordinati con `xan bisect`

Quando cerchi un valore in un CSV grande, `xan filter` scansiona tutto il file dall'inizio alla fine. Se il file è ordinato, puoi fare molto meglio: `xan bisect` usa la **ricerca binaria** e individua la posizione giusta nel file senza leggere ogni riga.

Il guadagno è concreto: su un milione di righe `bisect` è circa **10 volte più veloce** di `filter`.

Il vincolo è uno solo: **il file deve essere già ordinato** sulla colonna che cerchi, e deve esistere su disco (non funziona da stdin).

## Dataset di esempio

Usa i file di esempio nella cartella `docs/xan/risorse/bisect/`:

- Ordinato per `comune` (alfabetico): [`capoluoghi.csv`](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/bisect/capoluoghi.csv)
- Ordinato per `popolazione` (numerico crescente): [`capoluoghi_per_pop.csv`](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/bisect/capoluoghi_per_pop.csv)

Estratto di `capoluoghi.csv` (ordinato per `comune`):

```csv
codice,comune,regione,popolazione
LOM002,Brescia,Lombardia,196745
SIC002,Catania,Sicilia,301248
CAL001,Catanzaro,Calabria,87024
CAL002,Cosenza,Calabria,60775
TOS001,Firenze,Toscana,358079
...
```

## Ricerca esatta (`-S`)

Con `-S` (o `--search`) `bisect` restituisce solo le righe che corrispondono esattamente al valore cercato:

```bash
xan bisect -S comune Napoli capoluoghi.csv
```

Output:

```csv
codice,comune,regione,popolazione
CAM001,Napoli,Campania,909048
```

Senza `-S`, `bisect` si posiziona nel punto dove il valore si inserirebbe nel file e restituisce tutto da lì in poi — comportamento utile per le query di prefisso e di range descritte sotto.

## Ricerca per prefisso

`bisect` senza `-S` fa una "lower bound": si posiziona alla prima riga che è maggiore o uguale al valore dato, e scarica tutto ciò che segue. Combinando con `xan filter` ottieni i soli valori con un certo prefisso.

Tutti i capoluoghi che iniziano con `P`:

```bash
xan bisect comune P capoluoghi.csv | xan filter 'comune.startswith("P")'
```

Output:

```csv
codice,comune,regione,popolazione
SIC001,Palermo,Sicilia,640598
ABR002,Pescara,Abruzzo,116286
TOS002,Pisa,Toscana,90617
BAS002,Potenza,Basilicata,66076
```

`bisect` individua subito la prima riga con `comune >= "P"` e scarica solo la coda del file; `filter` rimuove le righe che non iniziano con `P`.

## Query di range (lettere C–F)

Senza `-S`, `bisect` restituisce tutto ciò che viene dopo il punto di inserimento del valore cercato nel file — non solo le righe che corrispondono esattamente. Questo permette di costruire query di range combinando `bisect` con `xan filter`.

Per ottenere tutti i capoluoghi con `comune` compreso tra C e F:

- `bisect comune C` salta le righe precedenti alla lettera C e scarica tutto da lì in poi;
- `xan filter 'lt(comune, "G")'` tiene solo le righe il cui `comune` viene prima della G (`lt` sta per *less than*).

```bash
xan bisect comune C capoluoghi.csv | xan filter 'lt(comune, "G")'
```

Output:

```csv
codice,comune,regione,popolazione
SIC002,Catania,Sicilia,301248
CAL001,Catanzaro,Calabria,87024
CAL002,Cosenza,Calabria,60775
TOS001,Firenze,Toscana,358079
LAZ001,Frosinone,Lazio,46243
```

## Ordinamento numerico (`-N`)

Se il file è ordinato per un campo numerico devi indicarlo con `-N` (o `--numeric`), altrimenti `bisect` usa l'ordine lessicografico e i risultati sarebbero errati.

Il file `capoluoghi_per_pop.csv` è ordinato per `popolazione` in senso crescente. Per trovare tutti i capoluoghi con più di 300.000 abitanti:

```bash
xan bisect -N popolazione 300000 capoluoghi_per_pop.csv
```

Output:

```csv
codice,comune,regione,popolazione
SIC002,Catania,Sicilia,301248
TOS001,Firenze,Toscana,358079
SIC001,Palermo,Sicilia,640598
CAM001,Napoli,Campania,909048
LOM001,Milano,Lombardia,1409252
LAZ002,Roma,Lazio,2783809
```

Per trovare i capoluoghi con più di 500.000 abitanti:

```bash
xan bisect -N popolazione 500000 capoluoghi_per_pop.csv
```

```csv
codice,comune,regione,popolazione
SIC001,Palermo,Sicilia,640598
CAM001,Napoli,Campania,909048
LOM001,Milano,Lombardia,1409252
LAZ002,Roma,Lazio,2783809
```

## Ordinamento decrescente (`-R`)

Se il file è ordinato in senso decrescente (dal valore più alto al più basso), aggiungi `-R` (o `--reverse`):

```bash
xan bisect -N -R popolazione 500000 capoluoghi_per_pop.csv
```

## Cosa succede se il file non è ordinato

Se provi a usare `bisect` su un file non ordinato, il comando se ne accorge e ti avverte:

```
xan bisect: input is not sorted in specified order!
See first and last values: 196745 and 52929
```

Il controllo avviene sul primo e ultimo valore: se risultano fuori ordine, il comando si ferma prima di restituire risultati sbagliati.

## Riepilogo opzioni

| Opzione | Cosa fa |
|---|---|
| `-S`, `--search` | Restituisce solo le righe che corrispondono esattamente al valore |
| `-N`, `--numeric` | Tratta i valori come numeri (file ordinato numericamente) |
| `-R`, `--reverse` | File ordinato in senso decrescente |
| `-E`, `--exclude` | Esclude le righe che corrispondono esattamente (upper bound) |
