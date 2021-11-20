# Verbi

I verbi sono i sub comandi di Miller.

!!! info "File per sviluppare esempi"
    Per la gran parte degli esempi sviluppati in questa pagina, verrà usato il file [`base.csv`](./risorse/base.csv) (vedi sotto).<br>
    È stato scelto un file piccolo e semplice, per ragioni didattiche e di leggibilità.

    | nome | dataNascita | altezza | peso |
    | --- | --- | --- | --- |
    | andy | 1973-05-08 | 176 | 86.5 |
    | chiara | 1993-12-13 | 162 | 58.3 |
    | guido | 2001-01-22 | 196 | 90.4 |

## Guida in linea per un verbo

Per aprire la guida in linea di un verbo, basta lanciare `mlr nomeVerbo -h`. Ad esempio per il verbo cat, il comando `mlr cat -h` restituirà

```
Usage: mlr cat [options]
Passes input records directly to output. Most useful for format conversion.
Options:
-n        Prepend field "n" to each record with record-counter starting at 1
-g {comma-separated field name(s)} When used with -n/-N, writes record-counters
          keyed by specified field name(s).
-v        Write a low-level record-structure dump to stderr.
-N {name} Prepend field {name} to each record with record-counter starting at 1
```

## Lista

L'elenco completo dei verbi di Miller è nella [guida ufficiale](https://miller.readthedocs.io/en/latest/reference-verbs.html).

### cat

Utile sopratutto per conversione di formato (vedi [formati](./formati.md)) e per concatenare file con lo stesso schema.

```
Usage: mlr cat [options]
Passes input records directly to output. Most useful for format conversion.
Options:
-n        Prepend field "n" to each record with record-counter starting at 1
-g {comma-separated field name(s)} When used with -n/-N, writes record-counters
          keyed by specified field name(s).
-v        Write a low-level record-structure dump to stderr.
-N {name} Prepend field {name} to each record with record-counter starting at 1
```

#### Stampa sulla shell il contenuto

```sh
mlr --csv cat base.csv
```

```
nome,dataNascita,altezza,peso
andy,1973-05-08,176,86.5
chiara,1993-12-13,162,58.3
guido,2001-01-22,196,90.4
```

### reshape

Trasforma lo schema da `wide` a `long` e viceversa. Vedi [approfondimento](../dati/trasforma.md).

```
Wide-to-long options:
  -i {input field names}   -o {key-field name,value-field name}
  -r {input field regexes} -o {key-field name,value-field name}
  These pivot/reshape the input data such that the input fields are removed
  and separate records are emitted for each key/value pair.
  Note: this works with tail -f and produces output records for each input
  record seen.
Long-to-wide options:
  -s {key-field name,value-field name}
  These pivot/reshape the input data to undo the wide-to-long operation.
  Note: this does not work with tail -f; it produces output records only after
  all input records have been read.
```

Ad esempio da `wide`

| Studente | Scuola | Matematica | Italiano |
| --- | --- | --- | --- |
| Andy | Liceo Cannizzaro | 7 | 6 |
| Lisa | Liceo Garibaldi | 6 | 7 |
| Giovanna | Liceo Garibaldi | 7 | 7 |

a `long`

| Studente | Scuola | materia | voto |
| --- | --- | --- | --- |
| Andy | Liceo Cannizzaro | Matematica | 7 |
| Andy | Liceo Cannizzaro | Italiano | 6 |
| Lisa | Liceo Garibaldi | Matematica | 6 |
| Lisa | Liceo Garibaldi | Italiano | 7 |
| Giovanna | Liceo Garibaldi | Matematica | 7 |
| Giovanna | Liceo Garibaldi | Italiano | 7 |


