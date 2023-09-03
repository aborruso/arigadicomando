---
draft: false
date: 2023-09-03
authors:
  - aborruso
categories:
  - Strumenti
tags:
  - miller
  - release
---

# Release 6.9 di Miller

Rilasciata una **nuova versione di Miller** con il supporto alla compressione ZSTD, una gestione migliore degli errori, il supporto ai nanosecondi nel *timestamp* e tanto altro.

<!-- more -->

!!! tip "Grazie infinite John"

    Il grande **John Kerl** è l'autore di [**Miller**](https://miller.readthedocs.io/), uno strumento che ha cambiato in meglio la mia vita lavorativa, facendomi imparare tanto e stimolandomi sempre ad approfondire temi vecchi e nuovi. Grazie, grazie, grazie!

Miller è lo strumento che ha ispirato di più la creazione di questo spazio e per la quale c'è una [sezione dedicata](/miller), ancora però in costruzione.<br>
Il 31 agosto 2023, è stata pubblicata la [*release* `6.9` di **Miller**](https://github.com/johnkerl/miller/releases/tag/v6.9.0).

A seguire alcune delle novità


## Timestamp

Per i `timestamp` sono state introdotte numerose [funzioni `DSL`](https://miller.readthedocs.io/en/6.9.0/reference-dsl-builtin-functions/#time-functions) per gestire i nanosecondi come numero intero a partire dalla [data *epoch*](https://www.wikiwand.com/it/Tempo_(Unix)): `gmt2nsec`, `localtime2nsec`, `nsec2gmt`, `nsec2gmtdate`, `nsec2localdate`, `nsec2localtime`, `strfntime`, `strfntime_local`, `strpntime`, `strpntime_local`, `sysntime` e `upntime`.

## Funzioni statistiche

Sono state introdotte le singole [**funzioni statistiche**](https://miller.readthedocs.io/en/6.9.0/reference-dsl-builtin-functions/index.html#stats-functions), prime presenti soltnato nel verbo [**`stats`**](https://miller.readthedocs.io/en/6.9.0/reference-verbs/index.html#stats1): ora possono essere usate su *array* e *map*.

## Verbi per "trova e sostituisci"

Aggiunti i nuovi verbi [`sub`](https://miller.readthedocs.io/en/6.9.0/reference-verbs/#sub), [`gsub`](https://miller.readthedocs.io/en/6.9.0/reference-verbs/#gsub) e [`ssub`](https://miller.readthedocs.io/en/6.9.0/reference-verbs/#ssub), per applicare comandi di **trova e sostituisci**, in modo molto più diretto e comodo della vecchia modalità via [verbo `put`](https://miller.readthedocs.io/en/6.9.0/reference-verbs/#put). Sono supportate le espressioni regolari.

Se ad esempio ho questa tabella di *input*:

| nome | dataNascita | altezza | peso |
| --- | --- | --- | --- |
| andy | 1973-05-08 | 176 | 86.5 |
| chiara | 1993-12-13 | 162 | 58.3 |
| guido | 2001-01-22 | 196 | 90.4 |


E voglio sostituire `1973` con `2021` nella colonna `dataNascita`, si può lanciare questo comando:

```
mlr --csv sub -f dataNascita 1973 2021 input.csv
```

Ed ottenere:

| nome | dataNascita | altezza | peso |
| --- | --- | --- | --- |
| andy | 2021-05-08 | 176 | 86.5 |
| chiara | 1993-12-13 | 162 | 58.3 |
| guido | 2001-01-22 | 196 | 90.4 |

In qualche modo correlata è l'introduzione della [funzione `contains`](https://miller.readthedocs.io/en/6.9.0/reference-dsl-builtin-functions/index.html#contains), che restituisce `true`, se il primo argomento contiene il secondo.

## Supporto nativo alla compressione ZSTD

La **compressione** **`ZSTD`** è ideata per essere efficiente sia in termini di **velocità** che di **rapporto** di **compressione**.<br>
Ne ho scritto da poco nel post "[Gestire file CSV grandi, brutti e cattivi](https://aborruso.github.io/posts/duckdb-intro-csv/#formato-zstd)".

Con la release `6.9` di Miller si potrà operare direttamente su file compresso in questa modalità, senza decomprimerlo. Ad esempio potrò leggere le prime 10 righe con:

```
mlr --csv --ifs ";" head input.csv.zst
```

Di questa novità sono un po' orgoglioso, perché deriva da [una mia proposta](https://github.com/johnkerl/miller/issues/1342), nata proprio mentre scrivevo il suddetto articolo. Prima c'era il supporto per `GZIP`, `BZIP2` e ZLIB.
