# Ricette Nushell

## Generali

### Lanciare comandi Nushell da un'altra shell

Si usa l'eseguibile `nu` e il flag `-c` seguito dal comando Nushell che si vuole lanciare. Ad esempio:

```bash
nu -c 'ls | where size > 16kB | to json'
```
### Lanciare uno script Nushell da un'altra shell

```bash
$ cat myscript.nu
ls | pivot

$ nu myscript.nu
```

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

!!! note "Nota"

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

### Utilizzare comandi Nushell non disponibili per i dataframe

Non tutti i comandi Nushell sono applicabili al tipo di dato `dataframe`. Uno di questi è ad esempio il comando `transpose`. Per applicarlo ad esempio ad una pipeline di comandi che deriva da un `dataframe`, bisogna convertire il tutto in una tabella `nu`:


```bash
$df | describe | into nu | transpose | to csv | save foo.sv
```

Utile leggere [questa discussione](https://github.com/nushell/nushell/discussions/7016#discussioncomment-4064367).

### Applicare una query SQL a un dataframe

```
[[a, b, c];[1,2,3] [2,3,4] ]| into df | query df 'select * from df where a > 0 OR c > 2'
```

`df` è il nome di default assegnato al dataframe.


### Applicare un filtro regex tramite una maschera

Nell'esempio di sotto viene impostata una maschera tramite regex: quando il campo `CODICE_LOCALE_PROGETTO` contiene la stringa `PNRR`. Fissatala maschera poi si applica il comando `filter-with`.

```bash
let df = open-df  -d ";" --infer-schema 10000000 OpenCup_Progetti.csv
let mask = ($df.CODICE_LOCALE_PROGETTO =~ "PNRR")
$df | filter-with $mask
```

!!! note "Nota"

    Nell'apertura del dataframe viene usato il comando `--infer-schema 10000000`, perché si tratta di un file enorme, in cui nelle ultime righe di un campo che sembrava intero ci sono delle stringhe, quindi l'*inferencing* deve essere più profondo.

## Scripting

### Aprire tutti i file con una certa estensione in una cartella, estrarre valori e salvarli


```bash
ls *.csv | each { |it| open $it.name --raw | from csv --separator ";" | get Period } | flatten
```

- si filtrano tutti i file con estensione `csv`
- si apre ognuno `|it| open $it.name --raw | from csv --separator ";"`
- di ognuno si estra la colonna `Period`
- si "flattenizza" il risultato, perché l'output grezzo è una lista.

!!! note "Nota"

    Si apre il file con opzione `--raw` (grezza), in modo che non vengano fatte intepretazioni a partire dall'estensione del file, quindi ad esempio dare per scontato che il separatore di campo è la `,`.
