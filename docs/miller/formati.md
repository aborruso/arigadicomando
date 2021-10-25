# Formati

Miller legge e scrive diversi formati di testo strutturato.

## Formato nativo (DKVP)

Il formato nativo è fatto a coppie chiave-valore. Ad esempio il file [`base`](../miller/risorse/base) sottostante:

```
nome=andy,dataNascita=1973-05-08,altezza=176,peso=86.5
nome=chiara,dataNascita=1993-12-13,altezza=162,peso=58.3
nome=guido,dataNascita=2001-01-22,altezza=196,peso=90.4
```

A seguire, lo stesso input in altri dei formati supportati da Miller.

## CSV

```
nome,dataNascita,altezza,peso
andy,1973-05-08,176,86.5
chiara,1993-12-13,162,58.3
guido,2001-01-22,196,90.4
```

## TSV

```
nome	dataNascita	altezza	peso
andy	1973-05-08	176	86.5
chiara	1993-12-13	162	58.3
guido	2001-01-22	196	90.4
```

## NIDX: Index-numbered

```
andy 1973-05-08 176 86.5
chiara 1993-12-13 162 58.3
guido 2001-01-22 196 90.4
```

## JSON (tabulare)

```json
{ "nome": "andy", "dataNascita": "1973-05-08", "altezza": 176, "peso": 86.5 }
{ "nome": "chiara", "dataNascita": "1993-12-13", "altezza": 162, "peso": 58.3 }
{ "nome": "guido", "dataNascita": "2001-01-22", "altezza": 196, "peso": 90.4 }
```

## PPRINT: Pretty-printed tabular

```
+--------+-------------+---------+------+
| nome   | dataNascita | altezza | peso |
+--------+-------------+---------+------+
| andy   | 1973-05-08  | 176     | 86.5 |
| chiara | 1993-12-13  | 162     | 58.3 |
| guido  | 2001-01-22  | 196     | 90.4 |
+--------+-------------+---------+------+
```

## XTAB: Vertical tabular

```
nome        andy
dataNascita 1973-05-08
altezza     176
peso        86.5

nome        chiara
dataNascita 1993-12-13
altezza     162
peso        58.3

nome        guido
dataNascita 2001-01-22
altezza     196
peso        90.4
```

## Markdown

```
| nome | dataNascita | altezza | peso |
| --- | --- | --- | --- |
| andy | 1973-05-08 | 176 | 86.5 |
| chiara | 1993-12-13 | 162 | 58.3 |
| guido | 2001-01-22 | 196 | 90.4 |
```

# Conversione di formato

A seguire un esempio di conversione da `CSV` a `Markdown`.

```
mlr --icsv --omd cat base.csv >output.md
```

Con `--icsv` si imposta come formato di `i`nput il `csv`, mendre con `--omd` il formato di `o`utput in `md`(`Markdown`).<br>Se si volesse come output un file `JSON` basterebbe modificare il comando di sopra in:

```
mlr --icsv --ojson cat base.csv >output.json
```

Lo stesso criterio per gli altri formati.

C'è anche una versione breve, che unisce tutto in un solo parametro. Ad esempio per la conversione da `CSV` a `Markdown` sarà:

```
mlr --c2m cat base.csv >output.md
```

Il parametro `--c2m` sta per `CSV TO MARKDOWN`. In analogia, per il passaggio da `CSV` a `JSON` sarà `--c2j`.
