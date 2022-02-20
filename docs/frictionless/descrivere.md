---
hide:
#  - navigation
  - toc
title: frictionless - descrivere dati
---

# Descrivere dati

Il comando `describe` restituisce la descrizione di una sorgente dati.<br>
Il [file sottostante](../miller/risorse/base.csv) verrà usato come *input* di esempio.


| nome | dataNascita | altezza | peso |
| --- | --- | --- | --- |
| andy | 1973-05-08 | 176 | 86.5 |
| chiara | 1993-12-13 | 162 | 58.3 |
| guido | 2001-01-22 | 196 | 90.4 |

Si lancia come opzione, del programma principale:

```bash
frictionless describe ./base.csv
```

L'*output* (il formato predefinito è lo `YAML`) sarà:

```yaml
# --------
# metadata: ./base.csv
# --------

encoding: utf-8
format: csv
hashing: md5
name: base
path: ./base.csv
profile: tabular-data-resource
schema:
  fields:
    - name: nome
      type: string
    - name: dataNascita
      type: date
    - name: altezza
      type: integer
    - name: peso
      type: number
scheme: file
```

Per ogni sorgente analizzata:

  - il **separatore** di campo. Quando non appare nell'output (come qui sopra), vuol dire che è quello predefinito, ovvero in questo caso la `,` (sotto maggiori dettagli);
  - l'**_encoding_**;
  - il formato;
  - il nome;
  - il *path*;
  - lo **schema dati**, con nome e tipo di ogni campo. Il tipo di campo, per formati in cui non è definito (come il `CSV`) è dedotto e quindi può non sempre essere corretto.


Se il separatore non è la `,`, ovvero il carattere considerato standard per un `CSV`, questo verrà documentato in output.

Se ad esempio in input si ha [questo file](../miller/risorse/base-semicolon.csv):

``` title="base-semicolon.csv"
nome;dataNascita;altezza;peso
andy;1973-05-08;176;86.5
chiara;1993-12-13;162;58.3
guido;2001-01-22;196;90.4
```

Il comando `describe` restituirà in più la sezione `dialect`, con valorizzata la proprietà `delimiter`:

``` yml hl_lines="5 6"
# --------
# metadata: ./base-semicolon.csv
# --------

dialect:
  delimiter: ;
encoding: utf-8
format: csv
hashing: md5
name: base-semicolon
path: ./base-semicolon.csv
profile: tabular-data-resource
schema:
  fields:
    - name: nome
      type: string
    - name: dataNascita
      type: date
    - name: altezza
      type: integer
    - name: peso
      type: number
scheme: file
```

È possibile avere l'output in `JSON` aggiungendo l'opzione `--json`.
