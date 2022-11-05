# Ricette Nushell

## dataframe

### Creare un dataframe a partire da un CSV

```bash
let df = open-df input.csv
```

### Descrivere un dataframe

```bash
$df | describe
```

### Filtrare un dataframe per il valore di una colonna

```bash
$df | filter ((col ANNO) > 2001)
```

### Avere numero di righe e colonne

```bash
$df | shape
```

### Conteggiare il numero di record per valori distinti di un campo

Qui sotto ad esempio, il conteggio di record, per valori distinti della colonna `REGMCR`.<br>
Il conteggio è fatto sulla colonna `ANNO`, ma poteva essere fatto su qualunque altra.

```bash
$df | group-by REGMCR  | agg [(col ANNO | count  ) ]
```

In output:

|index|REGMCR|ANNO|
|-|-|-|
|0|4|25238|
|1|20|15322|
|2|14|6728|
|3|17|14627|
|4|15|39949|
|5|18|14305|
|6|11|14443|
|7|3|60338|
|8|6|17455|
|9|7|15086|
|10|16|24787|
|11|10|12339|
|12|1|52535|
|13|19|47234|
|14|5|24254|
|15|13|11706|
|16|8|35748|
|17|9|29619|
|18|12|36093|

### Combinare conteggi aggregati per la stessa colonna

Qui sotto ad esempio, per valori distinti di `REGMCR`, si conteggiano per la colonna `ANNO` il numero totale di record e il numero di valori distinti presenti.

```bash
$df | group-by REGMCR  | agg [(col ANNO | count | as ANNO_count  ) (col ANNO | n-unique | as ANNO_unique)] | into nu
```

!!! note ""

    In questo caso è necessario rinominare il campo `ANNO` usando il comando `as`, perché i due conteggi si fanno sulla stessa colonna e si avrebbe due volte il nome campo `ANNO`; e la cosa non è consentita.

In output


|index|REGMCR|ANNO_count|ANNO_unique|
|-|-|-|-|
|0|8|35748|1|
|1|16|24787|1|
|2|7|15086|1|
|3|15|39949|1|
|4|14|6728|1|
|5|6|17455|1|
|6|13|11706|1|
|7|5|24254|1|
|8|12|36093|1|
|9|4|25238|1|
|10|20|15322|1|
|11|11|14443|1|
|12|3|60338|1|
|13|19|47234|1|
|14|18|14305|1|
|15|10|12339|1|
|16|17|14627|1|
|17|1|52535|1|
|18|9|29619|1|


### Avere l'ouput di un comando in stdout

Bisogna prima trasformare il dataframe in una tabella `nu`, con il comando `into nu`.

Ad esempio

```bash
$df | describe | into nu | to csv
```

### Trasporre l'output del comando `describe`

Bisogna prima convertire l'output in una tabella `nu`, perché il comando `transpose` non è abilitato per i dataframe:

```bash
$df | describe | into nu | transpose | to csv | save foo.sv
```

Utile leggere [questa discussione](https://github.com/nushell/nushell/discussions/7016#discussioncomment-4064367).
