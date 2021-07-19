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

Utile sopratutto per per conversione di formato (vedi [formati](./formati.md)) e per concatenare file con lo stesso schema.

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
