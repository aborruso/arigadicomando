# Verbi

I verbi sono i sub comandi di Miller.

## File di esempio

!!! info "File per sviluppare esempi"
    Per la gran parte degli esempi sviluppati in questa pagina, verrà usato il file [`base_category.csv`](./risorse/base_category.csv) (vedi sotto).<br>
    È stato scelto un file piccolo e semplice, per ragioni didattiche e di leggibilità.

    | nome | dataNascita | altezza | peso | comuneNascita |
    | --- | --- | --- | --- | --- |
    | andy | 1973-05-08 | 176 | 86.5 | Roma |
    | chiara | 1993-12-13 | 162 | 58.3 | Milano |
    | guido | 2001-01-22 | 196 | 90.4 | Roma |
    | sara | 2000-02-22 | 166 | 70.4 | Roma |
    | giulia | 1997-08-13 | 169 | 68.3 | Milano |


``` title="base_category.csv"
nome,dataNascita,altezza,peso,comuneNascita
andy,1973-05-08,176,86.5,Roma
chiara,1993-12-13,162,58.3,Milano
guido,2001-01-22,196,90.4,Roma
sara,2000-02-22,166,70.4,Roma
giulia,1997-08-13,169,68.3,Milano
```

## Guida in linea per un verbo

Per aprire la guida in linea di un verbo, basta lanciare `mlr nomeVerbo --help`. Ad esempio per il verbo `cat`, il comando `mlr cat --help` restituirà:

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

A seguire, per ogni verbo, sarà inserito l'*help* ufficiale di ogni comando.

## Lista dei verbi

L'elenco completo dei verbi di Miller è nella [guida ufficiale](https://miller.readthedocs.io/en/latest/reference-verbs.html).

### cat

Utile sopratutto per conversione di formato (vedi [formati](./formati.md)) e per concatenare in "verticale" file con lo stesso schema (:cooking: [ricetta](ricette.md#concatenare-in-verticale-piu-file)).

!!! aiuto "mlr cat --help"

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

Il comando di base stampa a schermo il contenuto di un file:

!!! comando "mlr --csv cat base_category.csv"

    ```
    nome,dataNascita,altezza,peso,comuneNascita
    andy,1973-05-08,176,86.5,Roma
    chiara,1993-12-13,162,58.3,Milano
    guido,2001-01-22,196,90.4,Roma
    sara,2000-02-22,166,70.4,Roma
    giulia,1997-08-13,169,68.3,Milano
    ```

Con l'opzione `-n` si aggiunge un campo con un progressivo numerico intero che parte da `1`:

!!! comando "mlr --csv -n cat base.csv"

    ```
    n,nome,dataNascita,altezza,peso,comuneNascita
    1,andy,1973-05-08,176,86.5,Roma
    2,chiara,1993-12-13,162,58.3,Milano
    3,guido,2001-01-22,196,90.4,Roma
    4,sara,2000-02-22,166,70.4,Roma
    5,giulia,1997-08-13,169,68.3,Milano
    ```

Se all'opzione `-n` si aggiunge `-g` seguito da dal nome di uno o più campi, il "contatore" sarà applicato per gruppo e partirà da `1` distintamente per ogni gruppo. Qui sotto ad esempio il raggruppamento è fatto per `comuneNascita`:

!!! comando "mlr --csv cat -n -g comuneNascita base_category.csv"

    ```
    n,nome,dataNascita,altezza,peso,comuneNascita
    1,andy,1973-05-08,176,86.5,Roma
    1,chiara,1993-12-13,162,58.3,Milano
    2,guido,2001-01-22,196,90.4,Roma
    3,sara,2000-02-22,166,70.4,Roma
    2,giulia,1997-08-13,169,68.3,Milano
    ```

### reshape

Trasforma lo schema da `wide` a `long` e viceversa. Vedi [approfondimento](../dati/trasforma.md).

!!! aiuto "mlr reshape --help"

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

### unsparsify

!!! aiuto "mlr unsparsify --help"

    ```
    Usage: mlr unsparsify [options]
    Prints records with the union of field names over all input records.
    For field names absent in a given record but present in others, fills in
    a value. This verb retains all input before producing any output.
    Options:
    --fill-with {filler string}  What to fill absent fields with. Defaults to
                                the empty string.
    -f {a,b,c} Specify field names to be operated on. Any other fields won't be
              modified, and operation will be streaming.
    -h|--help  Show this message.
    Example: if the input is two records, one being 'a=1,b=2' and the other
    being 'b=3,c=4', then the output is the two records 'a=1,b=2,c=' and
    'a=,b=3,c=4'.
    ```
