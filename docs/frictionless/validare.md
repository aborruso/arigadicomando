---
hide:
#  - navigation
#  - toc
title: frictionless - validare dati
---

# Validare dati

Il comando `validate` esegue la validazione di risorse e/o liste di risorse contenuti in un *datapackage*.

In input ad esempio una risorsa tabellare di questo tipo (`···` è per rappresentare una cella vuota):

| text | number | date | | type |
| --- | --- | --- | --- | --- |
| Lorem | 37.256 | 2022-01-13 | 012543 | A |
|···|···|···|···|···|
|  | Ciao | 2023-01-13 | C | |

In formato `CSV` è:

``` txt linenums="1"
text,number,date,,type
Lorem,37.256,2022-01-13,012543,A
,,,,
,Ciao,2023-01-13,78956,C
```

Questo input ha diversi problemi:

- la **colonna** numero 4, **non ha nome**;
- la **riga** 3 è **completamente vuota**;
- nella riga 4, **manca la colonna** 5.

Il comando `validate` di `frictionless` è in grado di riconoscerli e restituirli all'utente.

Utilizzando il file [`input_00.csv`](risorse/input_00.csv) come input e lanciando

```bash
frictionless validate input_00.csv
```

in output si avrà

``` hl_lines="30 31 33 35 36"
# -------
# invalid: input_00.csv
# -------

## Summary

+-----------------------------+-------------------+
| Description                 | Size/Name/Count   |
+=============================+===================+
| File name                   | input_00.csv      |
+-----------------------------+-------------------+
| File size (bytes)           | 76                |
+-----------------------------+-------------------+
| Total Time Taken (sec)      | 0.028             |
+-----------------------------+-------------------+
| Total Errors                | 3                 |
+-----------------------------+-------------------+
| Blank Label (blank-label)   | 1                 |
+-----------------------------+-------------------+
| Blank Row (blank-row)       | 1                 |
+-----------------------------+-------------------+
| Missing Cell (missing-cell) | 1                 |
+-----------------------------+-------------------+

## Errors

+-------+---------+-----------+-------------------------------------------------+
| row   | field   | code      | message                                         |
+=======+=========+===========+=================================================+
|       | 4       | blank-    | Label in the header in field at position "4" is |
|       |         | label     | blank                                           |
+-------+---------+-----------+-------------------------------------------------+
| 3     |         | blank-row | Row at position "3" is completely blank         |
+-------+---------+-----------+-------------------------------------------------+
| 4     | 5       | missing-  | Row at position "4" has a missing cell in field |
|       |         | cell      | "type" at position "5"                          |
+-------+---------+-----------+-------------------------------------------------+
```

La prima parte - `Summary` - restituisce un riepilogo. Tra le altre cose il nome del file, le sue dimensioni, il numero totale di errori, e il numero di errori per tipo.<br>
La seconda - `Errors` - restituisce i dettagli di ciascun errore (sopra evidenziati in giallo): numero di riga (la riga di intestazione è la `1`) e di colonna in cui è presente l'errore, e la descrizione di dettaglio dello stesso.

È interessante notare come gli errori estratti automaticamente, coincidano con quelli descritti "a mano".

## Output di validazione in formato JSON o YAML

È molto importante potere avere l'**_output_** di validazione in un **formato _machine readable_**, in modo da poter ad esempio fare una validazione giornaliera di uno o più file, archiviare l'esito in un file di *log* e infine avvisare automaticamente l'utente se il processo non è andato a buon fine.

Per farlo ci sono i _flag_ `--json` e `--yaml`. Ad esempio per l'_output_ in `JSON`, il comando sarà:

```bash
frictionless validate input_00.csv --json
```

??? example "Esempio di output in JSON"

    ``` .json
    {
      "version": "4.40.5",
      "time": 0.032,
      "errors": [],
      "tasks": [
        {
          "resource": {
            "path": "input_00.csv",
            "name": "input_00",
            "profile": "tabular-data-resource",
            "scheme": "file",
            "format": "csv",
            "hashing": "md5",
            "stats": {
              "hash": "cf404937d0c1a8001585d5593640c7c3",
              "bytes": 76,
              "fields": 5,
              "rows": 3
            },
            "encoding": "utf-8",
            "schema": {
              "fields": [
                {
                  "type": "string",
                  "name": "text"
                },
                {
                  "type": "string",
                  "name": "number"
                },
                {
                  "type": "date",
                  "name": "date"
                },
                {
                  "type": "string",
                  "name": "field4"
                },
                {
                  "type": "string",
                  "name": "type"
                }
              ]
            }
          },
          "time": 0.032,
          "scope": [
            "hash-count-error",
            "byte-count-error",
            "field-count-error",
            "row-count-error",
            "blank-header",
            "extra-label",
            "missing-label",
            "blank-label",
            "duplicate-label",
            "incorrect-label",
            "blank-row",
            "primary-key-error",
            "foreign-key-error",
            "extra-cell",
            "missing-cell",
            "type-error",
            "constraint-error",
            "unique-error"
          ],
          "partial": false,
          "errors": [
            {
              "label": "",
              "fieldName": "field4",
              "fieldNumber": 4,
              "fieldPosition": 4,
              "labels": [
                "text",
                "number",
                "date",
                "",
                "type"
              ],
              "rowPositions": [
                1
              ],
              "code": "blank-label",
              "name": "Blank Label",
              "tags": [
                "#table",
                "#header",
                "#label"
              ],
              "note": "",
              "message": "Label in the header in field at position \"4\" is blank",
              "description": "A label in the header row is missing a value. Label should be provided and not be blank."
            },
            {
              "cells": [],
              "rowNumber": 2,
              "rowPosition": 3,
              "code": "blank-row",
              "name": "Blank Row",
              "tags": [
                "#table",
                "#row"
              ],
              "note": "",
              "message": "Row at position \"3\" is completely blank",
              "description": "This row is empty. A row should contain at least one value."
            },
            {
              "cell": "",
              "fieldName": "type",
              "fieldNumber": 5,
              "fieldPosition": 5,
              "cells": [
                "",
                "Ciao",
                "2023-01-13",
                "C"
              ],
              "rowNumber": 3,
              "rowPosition": 4,
              "code": "missing-cell",
              "name": "Missing Cell",
              "tags": [
                "#table",
                "#row",
                "#cell"
              ],
              "note": "",
              "message": "Row at position \"4\" has a missing cell in field \"type\" at position \"5\"",
              "description": "This row has less values compared to the header row (the first row in the data source). A key concept is that all the rows in tabular data must have the same number of columns."
            }
          ],
          "stats": {
            "errors": 3
          },
          "valid": false
        }
      ],
      "stats": {
        "errors": 3,
        "tasks": 1
      },
      "valid": false
    }
    ```

## Validare un file tabellare a partire da uno schema

In *input* ad esempio questi dati

| text | number | date | code | type |
| --- | --- | --- | --- | --- |
| Lorem | 37.256 | 2022-01-13 | 012543 | A |
|  | Ciao | 2023-01-13 | 78956 | C |

che in CSV sono

``` txt linenums="1"
text,number,date,code,type
Lorem,37.256,2022-01-13,012543,A
,Ciao,2023-01-13,78956,C
```

A seguire l'elenco dei campi/colonne del file, e i vari vincoli sul tipo di campo, valori consentiti, obbligatorietà, ecc:

- `text`, un campo stringa, obbligatorio
- `number`, un campo numerico
- `date`, un campo di tipo data, con valori che non possono essere successivi al 15 maggio 2022
- `code`, un campo stringa, che deve essere composto da 6 caratteri numerici (può iniziare per `0`, quindi non è un numero)
- `type`, un campo stringa, che può avere come valori soltanto `A` e `B`.


Il file di sopra - [`input_01.csv`](risorse/input_01.csv) - rispetto a questo schema ha diversi problemi:

1. riga `3`, colonna `1`, il campo obbligatorio `text` non è valorizzato;
2. riga `3`, colonna `2`, c'è una stringa (`Ciao`) in un campo numerico;
3. riga `3`, colonna `3`, c'è una data che va oltre il 15 maggio 2022 (`2023-01-13`);
4. riga `3`, colonna `4`, c'è una stringa che non è composta da 6 numeri (`78956`);
5. riga `3`, colonna `5`, c'è un valore che non è né `A`, ne `B`, ma è `C`.

Questo schema si può descrivere in formato `YAML`, secondo [queste specifiche](https://specs.frictionlessdata.io/table-schema/). Il file di descrizione si potrà usare per validare il file e verificare che rispetti lo schema.

Qui sotto il contenuto del file [`schema_01.yml`](risorse/schema_01.yml), per descrivere e validare in formato _frictionless_ lo schema del file di sopra.


``` yaml hl_lines="16 18 19 21 24 28 29 31 33 34 36 38-41"
path: input_01.csv
name: input_01
profile: tabular-data-resource
scheme: file
format: csv
hashing: md5
encoding: utf-8
schema:
  missingValues:
    - "NA"
    - "NaN"
    - "null"
    - ""
  fields:
  - name: text
    type: string
    title: "label text"
    constraints:
      required: true # (1)
  - name: number
    type: number
    title: "label number"
  - name: date
    type: date
    title: "label date"
    description: "La data di accesso dell'utente nel sistema"
    example: '2020-05-15'
    constraints:
      maximum: '2022-05-15' # (2)
  - name: code
    type: string
    title: "label code"
    constraints:
      pattern: ^[0-9]{6}$ # (3)
  - name: type
    type: string
    title: "label type"
    constraints:
      enum: # (4)
        - A
        - B
```

1.  Il vincolo `required: true` impone che tutte le celle della colonna siano valorizzate
2.  Il valore massimo di data inseribile in questo campo
3.  L'espressione regolare che i valori delle celle di questo campo devono rispettare
4.  L'enumerazione, l'elenco, dei valori ammessi per le celle di questo campo

!!! tip "Creare automaticamente un file `YAML`"

    Utilizzando il comando [`describe`](descrivere.md), puoi creare la struttura di base di un file `frictionless` che descrive una risorsa, a cui aggiungere poi "a mano" ulteriori proprietà.

Per ogni campo è definito il tipo di campo, con il parametro `type`, e sono definiti altri vincoli specifici tramite il parametro `constraints` ([documentazione ufficiale](https://specs.frictionlessdata.io/table-schema/#rich-types)). Tra questi ad esempio:

- `required`, per indicare che i valori di quel campo sono obbligatori;
- `maximum`, per indicare qual è il valore massimo utilizzabile per un campo (non è applicabile a tutti i tipi di campo)
- `pattern`, per indicare, per un campo di tipo `string`, qual è l'espressione regolare da rispettare;
- `enum`, per indicare, per un campo di tipo `sting`, qual è l'elenco dei valori ammissibili.

Utilizzando questo file `YAML`, che fa riferimento al file `CSV` di _input_ (`path: input_01.csv`) è possibile lanciare la validazione:

```
frictionless validate schema_01.yml
```

In *output*, estratto automaticamente, l'elenco di errori annotato poco sopra.

``` txt
## Errors

+-------+---------+------------+----------------------------------------------------+
|   row |   field | code       | message                                            |
+=======+=========+============+====================================================+
|     3 |       1 | constraint | The cell "" in row at position "3" and field       |
|       |         | -error     | "text" at position "1" does not conform to a       |
|       |         |            | constraint: constraint "required" is "True"        |
+-------+---------+------------+----------------------------------------------------+
|     3 |       2 | type-error | Type error in the cell "Ciao" in row "3" and field |
|       |         |            | "number" at position "2": type is "number/default" |
+-------+---------+------------+----------------------------------------------------+
|     3 |       3 | constraint | The cell "2023-01-13" in row at position "3" and   |
|       |         | -error     | field "date" at position "3" does not conform to a |
|       |         |            | constraint: constraint "maximum" is "2022-05-15"   |
+-------+---------+------------+----------------------------------------------------+
|     3 |       4 | constraint | The cell "78956" in row at position "3" and field  |
|       |         | -error     | "code" at position "4" does not conform to a       |
|       |         |            | constraint: constraint "pattern" is "^[0-9]{6}$"   |
+-------+---------+------------+----------------------------------------------------+
|     3 |       5 | constraint | The cell "C" in row at position "3" and field      |
|       |         | -error     | "type" at position "5" does not conform to a       |
|       |         |            | constraint: constraint "enum" is "['A', 'B']"      |
+-------+---------+------------+----------------------------------------------------+
```

!!! tips "Applicare uno schema definito per un file, ad altri"

    Per farlo basta usare l'opzione `--path` e lanciare il comando inserendo il percorso del file su cui fare la validazione.

    ``` bash
    frictionless validate schema_01.yml --path /percorso/file.csv
    ```

## Opzioni del comando


```
Options:
  --type TEXT                     Specify type e.g. "package"
  --path TEXT                     Specify the data path explicitly (e.g. you
                                  need to use it if your data is JSON)

  --scheme TEXT                   Specify scheme  [default: inferred]
  --format TEXT                   Specify format  [default: inferred]
  --hashing TEXT                  Specify hashing algorithm  [default:
                                  inferred]

  --encoding TEXT                 Specify encoding  [default: inferred]
  --innerpath TEXT                Specify in-archive path  [default: first]
  --compression TEXT              Specify compression  [default: inferred]
  --control TEXT                  An inline JSON object or a path to a JSON
                                  file that provides the control
                                  (configuration for the data Loader)

  --dialect TEXT                  An inline JSON object or a path to a JSON
                                  file that provides the dialect
                                  (configuration for the parser)

  --sheet TEXT                    The sheet to use from the input data (only
                                  with XLS and ODS files/plugins)

  --table TEXT                    The table to use from the SQL database (SQL
                                  plugin)

  --keys TEXT                     The keys to use as column names for the
                                  Inline or JSON data plugins

  --keyed / --no-keyed            Whether the input data is keyed for the
                                  Inline or JSON data plugins

  --header-rows TEXT              Comma-separated row numbers [default:
                                  inferred]

  --header-join TEXT              Multiline header joiner [default: inferred]
  --pick-fields TEXT              Comma-separated fields to pick e.g.
                                  "1,name1"

  --skip-fields TEXT              Comma-separated fields to skip e.g.
                                  "2,name2"

  --limit-fields INTEGER          Limit fields by this integer e.g. "10"
  --offset-fields INTEGER         Offset fields by this integer e.g "5"
  --pick-rows TEXT                Comma-separated rows to pick e.g.
                                  "1,<blank>"

  --skip-rows TEXT                Comma-separated rows to skip e.g. "2,3,4,5"
  --limit-rows INTEGER            Limit rows by this integer e.g "100"
  --offset-rows INTEGER           Offset rows by this integer e.g. "50"
  --schema TEXT                   Specify a path to a schema
  --stats-hash TEXT               Expected hash based on hashing option
  --stats-bytes INTEGER           Expected size in bytes
  --stats-fields INTEGER          Expected amount of fields
  --stats-rows INTEGER            Expected amount of rows
  --buffer-size INTEGER           Limit the amount of bytes to be extracted as
                                  a buffer  [default: 10000]

  --sample-size INTEGER           Limit the number of rows to be extracted as
                                  a sample  [default: 100]

  --field-type TEXT               Force all the fields to have this type
  --field-names TEXT              Comma-separated list of field names
  --field-confidence FLOAT        Infer confidence. A float from 0 to 1. If 1,
                                  (sampled) data is guaranteed to be valid
                                  against the inferred schema  [default: 0.9]

  --field-float-numbers / --no-field-float-numbers
                                  Make number floats instead of decimals
                                  [default: False]

  --field-missing-values TEXT     Comma-separated list of missing values
                                  [default: ""]

  --schema-sync / --no-schema-sync
                                  Sync the schema based on the data's header
                                  row

  --basepath TEXT                 Basepath of the resource/package
  --pick-errors TEXT              Comma-separated errors to pick e.g. "type-
                                  error"

  --skip-errors TEXT              Comma-separated errors to skip e.g. "blank-
                                  row"

  --limit-errors INTEGER          Limit errors by this integer
  --limit-memory INTEGER          Limit memory by this integer in MB
  --original / --no-original      Don't call infer on resources
  --parallel / --no-parallel      Enable multiprocessing
  --yaml / --no-yaml              Return in pure YAML format  [default: False]
  --json / --no-json              Return in JSON format  [default: False]
  --resource-name TEXT            Name of resource to validate
  --help                          Show this message and exit.
```
