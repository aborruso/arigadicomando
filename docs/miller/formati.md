# Formati

Miller legge e scrive diversi formati di testo strutturato.

## Formato nativo (DKVP)

Il formato nativo è fatto a coppie chiave-valore. Ad esempio il file [`input`](../visidata/risorse/cancella_le_a.vd) sottostante:

```
nome=andy,dataNascita=1973-05-08,altezza=176,peso=86.5
nome=chiara,dataNascita=1993-12-13,altezza=162,peso=58.3
nome=guido,dataNascita=2001-01-22,altezza=196,peso=90.4
```

A seguire lo stesso

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

# Conversione di formati
