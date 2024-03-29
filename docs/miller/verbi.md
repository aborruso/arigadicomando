# Verbi

I verbi sono i sub comandi di Miller. Queste le categorie:

- quelli analoghi allo Unix-toolkit: [cat](#cat), [cut](#cut), [grep](#grep), [head](#head), [join](#join), [sort](#sort), [tac](#tac), [tail](#tail), [top](#top), [uniq](#uniq).
- quelli con funziolità simili a quelli di `awk`: [filter](#filter), [put](#put), [sec2gmt](#sec2gmt), [sec2gmtdate](#sec2gmtdate), [step](#step), [tee](#tee).
- quelli statistici: [bar](#bar), [bootstrap](#bootstrap), [decimate](#decimate), [histogram](#histogram), [least-frequent](#least-frequent), [most-frequent](#most-frequent), [sample](#sample), [shuffle](#shuffle), [stats1](#stats1), [stats2](#stats2).
- quelli orientati all'[eterogeneità dei record](eterogeneita_record.md), sebbene tutti i verbi di Miller sono in grado di gestire record eterogenei: [group-by](#group-by), [group-like](#group-like), [having-fields](#having-fields).
- e altri ancora: [check](#check), [count-distinct](#count-distinct), [label](#label), [merge-fields](#merge-fields), [nest](#nest), [nothing](#nothing), [regularize](#regularize), [rename](#rename), [reorder](#reorder), [reshape](#reshape), [seqgen](#seqgen).

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

### altkv

Mappa una lista di valori, come coppie alternate chiave/valore.

!!! aiuto "mlr altkv --help"

    ```
    Usage: mlr altkv [options]
    Given fields with values of the form a,b,c,d,e,f emits a=b,c=d,e=f pairs.
    ```

Ad esempio

!!! comando "echo "a,b,c,d" | mlr --ocsv altkv"

    ```json
    {"a":"b","c":"d"}
    ```


### bar

Per creare dei grafici a barre (bruttini 🙃), rimpiazzando dei valori numeri con una serie di asterichi. Per allinearli meglio si possono usare le opzioni di output `--opprint` o `--oxtab`.

!!! aiuto "mlr bar --help"

    ```
    Replaces a numeric field with a number of asterisks, allowing for cheesy
    bar plots. These align best with --opprint or --oxtab output format.
    Options:
    -f   {a,b,c}      Field names to convert to bars.
    --lo {lo}         Lower-limit value for min-width bar: default '0.000000'.
    --hi {hi}         Upper-limit value for max-width bar: default '100.000000'.
    -w   {n}          Bar-field width: default '40'.
    --auto            Automatically computes limits, ignoring --lo and --hi.
                    Holds all records in memory before producing any output.
    -c   {character}  Fill character: default '*'.
    -x   {character}  Out-of-bounds character: default '#'.
    -b   {character}  Blank character: default '.'.
    Nominally the fill, out-of-bounds, and blank characters will be strings of length 1.
    However you can make them all longer if you so desire.
    ```

A partire ad esempio da questo file di input:

``` title="bar.csv"
Area,percUtenti
Nord,25
Centro,32
Sud e isole,43
```

!!! comando "mlr --c2p bar -f percUtenti ./bar.csv"

    ```
    Area        percUtenti
    Nord        **********..............................
    Centro      ************............................
    Sud e isole *****************.......................
    ```

### bootstrap

L'uso tipico di `bootstrap` è quello di estrarre un campione *random* dall'input, con un numero di record pari al numero record di input; con doppioni possibili.

!!! aiuto "mlr bootstrap --help"

    ```
    Emits an n-sample, with replacement, of the input records.
    See also mlr sample and mlr shuffle.
    Options:
     -n Number of samples to output. Defaults to number of input records.
        Must be non-negative.
    ```

Sotto un esempio in cui a partire dal file di input, composto da 5 record distinti, sono estratti in modo randomico 5 record.

!!! comando "mlr --csv bootstrap base_category.csv"

    ```
    nome,dataNascita,altezza,peso,comuneNascita
    guido,2001-01-22,196,90.4,Roma
    chiara,1993-12-13,162,58.3,Milano
    chiara,1993-12-13,162,58.3,Milano
    guido,2001-01-22,196,90.4,Roma
    chiara,1993-12-13,162,58.3,Milano
    ```


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

### check

È un verbo che non produce un output, salvo un report sulla correttezza di "formattazione" del file di input.

!!! aiuto "mlr check --help"

    ```
    Consumes records without printing any output.
    Useful for doing a well-formatted check on input data.
    Options:
    ```

Se ad esempio si ha un file `CSV`, con un numero di campi nell'intestazione (`4`) diverso da quello del corpo (`5`), come questo

``` title="check.csv"
nome,dataNascita,altezza,comuneNascita
andy,1973-05-08,176,86.5,Roma
chiara,1993-12-13,162,58.3,Milano
guido,2001-01-22,196,90.4,Roma
```

si avrà l'output sottostante

!!! comando " mlr --csv check check.csv"

    ```
    mlr :  mlr: CSV header/data length mismatch 4 != 5 at filename ./check.csv row 2.
    ```

### clean-whitespace

È un prezioso comando, per "pulire" i dati: rimuove gli spazi ridondanti.

!!! aiuto "mlr clean-whitespace --help"

    ```
    For each record, for each field in the record, whitespace-cleans the keys and/or
    values. Whitespace-cleaning entails stripping leading and trailing whitespace,
    and replacing multiple whitespace with singles. For finer-grained control,
    please see the DSL functions lstrip, rstrip, strip, collapse_whitespace,
    and clean_whitespace.

    Options:
    -k|--keys-only    Do not touch values.
    -v|--values-only  Do not touch keys.
    It is an error to specify -k as well as -v -- to clean keys and values,
    leave off -k as well as -v.
    ```

Riuove in particolare uno o più spazi bianchi a inizio e fine cella e due o più spazi all'interndo della cella. Ad esempio nel file sottostante ci sono due spazi tra `Busto` e `Arsizio`, uno spazio a fine cella dopo `andy` e uno a inizio cella i corrispondenza di `chiara`. Questi sono ridondanti, e nella grandissima parte dei casi sono da rimuovere.

```json title="clean-whitespace.json"
{"nome":"andy ","dataNascita":"1973-05-08","comuneNascita":"Roma"}
{"nome":" chiara","dataNascita":"1993-12-13","comuneNascita":"Busto  Arsizio"}
```

Per pulire il file:

!!! comando "mlr --json clean-whitespace input.json"

    ```json
    {"nome":"andy","dataNascita":"1973-05-08","comuneNascita":"Roma"}
    {"nome":"chiara","dataNascita":"1993-12-13","comuneNascita":"Busto Arsizio"}
    ```

Due comode opzioni:

- `-k` fa la pulizia soltanto nei nomi dei campi, nelle chiavi;
- `-v` fa la pulizia soltanto nei valori.

### count

Restituisce il numero di record. Miller tiene conto del formato, quindi per un CSV composto da 6 righe, 1 di intestazione più 5 di dati, restituirà 5.

!!! aiuto "mlr count --help"

    ```
    Prints number of records, optionally grouped by distinct values for specified field names.
    Options:
    -g {a,b,c} Optional group-by-field names for counts, e.g. a,b,c
    -n {n} Show only the number of distinct values. Not interesting without -g.
    -o {name} Field name for output-count. Default "count".
    ```

File di esempio:

``` title="base_category.csv"
nome,dataNascita,altezza,peso,comuneNascita
andy,1973-05-08,176,86.5,Roma
chiara,1993-12-13,162,58.3,Milano
guido,2001-01-22,196,90.4,Roma
sara,2000-02-22,166,70.4,Roma
giulia,1997-08-13,169,68.3,Milano
```

Comando di esempio:

!!! comando "mlr --csv count ./base_category.csv"

    ```
    count
    5
    ```

Se si desidera soltanto l'output numerico, senza riga di intestazione, si può fare in tantissimi modi. Uno è quello di cambiare il formato di output in [NIDX](formati.md#nidx-index-numbered):

!!! comando "mlr --c2n count ./base_category.csv"

    ```
    5
    ```

### count-distinct

Restituisce il numero di record che hanno valori distinti, per uno o più campi specificati.

!!! aiuto "mlr count-distinct --help"

    ```
    Prints number of records having distinct values for specified field names.
    Same as uniq -c.

    Options:
    -f {a,b,c}    Field names for distinct count.
    -n            Show only the number of distinct values. Not compatible with -u.
    -o {name}     Field name for output count. Default "count".
                  Ignored with -u.
    -u            Do unlashed counts for multiple field names. With -f a,b and
                  without -u, computes counts for distinct combinations of a
                  and b field values. With -f a,b and with -u, computes counts
                  for distinct a field values and counts for distinct b field
                  values separately.
    ```

File di esempio:

``` title="count-distinct.csv"
nome,dataNascita,altezza,peso,comuneNascita,sesso
andy,1973-05-08,176,86.5,Roma,maschio
chiara,1993-12-13,162,58.3,Milano,femmina
guido,2001-01-22,196,90.4,Roma,maschio
sara,2000-02-22,166,70.4,Roma,femmina
giulia,1997-08-13,169,68.3,Milano,femmina
```

Ad esempio il conteggio per combinazioni distinte di comune di nascita e sesso:

!!! comando "mlr --csv count-distinct -f comuneNascita,sesso -o conteggio ./base_category.csv"

    ```
    comuneNascita,sesso,conteggio
    Roma,maschio,2
    Milano,femmina,2
    Roma,femmina,1
    ```

Aggiungendo il parametro `-u`, si ottengono i valori distinti non per combinazioni distinti dei campi indicati, ma per ogni singolo campo.

!!! comando "mlr --csv count-distinct -f comuneNascita,sesso -o conteggio -u ./base_category.csv"

    ```
    field,value,count
    comuneNascita,Roma,3
    comuneNascita,Milano,2
    sesso,maschio,2
    sesso,femmina,3
    ```



### count-similar

Aggiunge un campo, con il conteggio dei record che ha lo stesso valore per uno o più campi.

!!! aiuto "mlr count-similar --help"

    ```
    Ingests all records, then emits each record augmented by a count of
    the number of other records having the same group-by field values.
    Options:
    -g {a,b,c} Group-by-field names for counts, e.g. a,b,c
    -o {name} Field name for output-counts. Defaults to "count".
    ```

File di esempio:

``` title="base_category.csv"
nome,dataNascita,altezza,peso,comuneNascita
andy,1973-05-08,176,86.5,Roma
chiara,1993-12-13,162,58.3,Milano
guido,2001-01-22,196,90.4,Roma
sara,2000-02-22,166,70.4,Roma
giulia,1997-08-13,169,68.3,Milano
```

A seguire ad esempio viene aggiunto il campo `conteggio` al file di input, con il conteggio dei valori distinti per il campo `comuneNascita`.

!!! comando "mlr --csv count-similar -g comuneNascita -o conteggio ./base_category.csv"

    ```
    nome,dataNascita,altezza,peso,comuneNascita,conteggio
    andy,1973-05-08,176,86.5,Roma,3
    guido,2001-01-22,196,90.4,Roma,3
    sara,2000-02-22,166,70.4,Roma,3
    chiara,1993-12-13,162,58.3,Milano,2
    giulia,1997-08-13,169,68.3,Milano,2
    ```


### cut

Estrae/rimuove dall'input uno o più campi.

!!! aiuto "mlr cut --help"

    ```
    Passes through input records with specified fields included/excluded.
    Options:
     -f {a,b,c} Comma-separated field names for cut, e.g. a,b,c.
     -o Retain fields in the order specified here in the argument list.
        Default is to retain them in the order found in the input data.
     -x|--complement  Exclude, rather than include, field names specified by -f.
     -r Treat field names as regular expressions. "ab", "a.*b" will
       match any field name containing the substring "ab" or matching
       "a.*b", respectively; anchors of the form "^ab$", "^a.*b$" may
       be used. The -o flag is ignored when -r is present.
    Examples:
      mlr cut -f hostname,status
      mlr cut -x -f hostname,status
      mlr cut -r -f '^status$,sda[0-9]'
      mlr cut -r -f '^status$,"sda[0-9]"'
      mlr cut -r -f '^status$,"sda[0-9]"i' (this is case-insensitive)
    ```

File di esempio:

``` title="base_category.csv"
nome,dataNascita,altezza,peso,comuneNascita
andy,1973-05-08,176,86.5,Roma
chiara,1993-12-13,162,58.3,Milano
guido,2001-01-22,196,90.4,Roma
sara,2000-02-22,166,70.4,Roma
giulia,1997-08-13,169,68.3,Milano
```

Per estrarre soltanto il campo `nome`:

!!! comando "mlr --csv cut -f nome base_category.csv"

    ```
    nome
    andy
    chiara
    guido
    sara
    giulia
    ```

Per rimuovere il campo `nome`, bisognerà aggiungere l'opzione `-x`:

!!! comando "mlr --csv cut -x -f nome base_category.csv"

    ```
    dataNascita,altezza,peso,comuneNascita
    1973-05-08,176,86.5,Roma
    1993-12-13,162,58.3,Milano
    2001-01-22,196,90.4,Roma
    2000-02-22,166,70.4,Roma
    1997-08-13,169,68.3,Milano
    ```

Per impostare il filtro tramite espressione regolare si usa l'opzione `-r`. Ad esempio estrarre soltanto i campi che iniziano per `a` e che terminano per `o`:

!!! comando "mlr --csv cut -r -f "^a","o$" base_category.csv"

    ```
    altezza,peso
    176,86.5
    162,58.3
    196,90.4
    166,70.4
    169,68.3
    ```

### decimate

Estrae un record ogni `n`, opzionalmente per categoria.

!!! aiuto "mlr decimate --help"

    ```
    Passes through one of every n records, optionally by category.
    Options:
     -b Decimate by printing first of every n.
     -e Decimate by printing last of every n (default).
     -g {a,b,c} Optional group-by-field names for decimate counts, e.g. a,b,c.
     -n {n} Decimation factor (default 10).
    ```

### fill-down

Se un dato record ha un valore mancante per un dato campo, verrà riempito dal valore corrispondente del record precedente, se presente.

!!! aiuto "mlr fill-down --help"

    ```
    If a given record has a missing value for a given field, fill that from
    the corresponding value from a previous record, if any.
    By default, a 'missing' field either is absent, or has the empty-string value.
    With -a, a field is 'missing' only if it is absent.

    Options:
     --all Operate on all fields in the input.
     -a|--only-if-absent If a given record has a missing value for a given field,
         fill that from the corresponding value from a previous record, if any.
         By default, a 'missing' field either is absent, or has the empty-string value.
         With -a, a field is 'missing' only if it is absent.
     -f  Field names for fill-down.
    ```

File di esempio:

``` title="fill-down.csv"
a,b,c
1,,3
4,5,
7,,9
```

Con l'opzione `-all` il verbo viene applicato per tutti i record:

!!! comando "mlr --csv  fill-down --all  fill-down.csv"

    ```
    a,b,c
    1,,3
    4,5,3
    7,5,9
    ```

Con `-f` è possibile scegliere di applicaro a 1 o più campi.

### fill-empty

!!! warning "Il verbo `fill-empty` richiede Miller >= 6.0"

Riempe le celle vuote, con un valore specifico

!!! aiuto "mlr fill-empty --help"

    ```
    Fills empty-string fields with specified fill-value.
    Options:
    -v {string} Fill-value: defaults to "N/A"
    -S          Don't infer type -- so '-v 0' would fill string 0 not int 0.
    ```

File di esempio:

``` title="fill-down.csv"
a,b,c
1,,3
4,5,
7,,9
```

Come impopstazione predefinita, il valore assegnato sarà `N/A`, ma è possibile impostarlo con `-v`:

!!! comando "mlr --csv  fill-empty fill-down.csv"

    ```
    a,b,c
    1,N/A,3
    4,5,N/A
    7,N/A,9
    ```

### filter

!!! aiuto "mlr filter --help"

    ```
    Options:
    -f {file name} File containing a DSL expression (see examples below). If the filename
       is a directory, all *.mlr files in that directory are loaded.

    -e {expression} You can use this after -f to add an expression. Example use
       case: define functions/subroutines in a file you specify with -f, then call
       them with an expression you specify with -e.

    (If you mix -e and -f then the expressions are evaluated in the order encountered.
    Since the expression pieces are simply concatenated, please be sure to use intervening
    semicolons to separate expressions.)

    -s name=value: Predefines out-of-stream variable @name to have
        Thus mlr put -s foo=97 '$column += @foo' is like
        mlr put 'begin {@foo = 97} $column += @foo'.
        The value part is subject to type-inferencing.
        May be specified more than once, e.g. -s name1=value1 -s name2=value2.
        Note: the value may be an environment variable, e.g. -s sequence=$SEQUENCE

    -x (default false) Prints records for which {expression} evaluates to false, not true,
       i.e. invert the sense of the filter expression.

    -q Does not include the modified record in the output stream.
       Useful for when all desired output is in begin and/or end blocks.

    -S and -F: There are no-ops in Miller 6 and above, since now type-inferencing is done
       by the record-readers before filter/put is executed. Supported as no-op pass-through
       flags for backward compatibility.


    Parser-info options:

    -w Print warnings about things like uninitialized variables.

    -W Same as -w, but exit the process if there are any warnings.

    -p Prints the expressions's AST (abstract syntax tree), which gives full
      transparency on the precedence and associativity rules of Miller's grammar,
      to stdout.

    -d Like -p but uses a parenthesized-expression format for the AST.

    -D Like -d but with output all on one line.

    -E Echo DSL expression before printing parse-tree

    -v Same as -E -p.

    -X Exit after parsing but before stream-processing. Useful with -v/-d/-D, if you
       only want to look at parser information.

    Records will pass the filter depending on the last bare-boolean statement in
    the DSL expression. That can be the result of <, ==, >, etc., the return value of a function call
    which returns boolean, etc.

    Examples:
      mlr --csv --from example.csv filter '$color == "red"'
      mlr --csv --from example.csv filter '$color == "red" && flag == true'
    More example filter expressions:
      First record in each file:
        'FNR == 1'
      Subsampling:
        'urand() < 0.001'
      Compound booleans:
        '$color != "blue" && $value > 4.2'
        '($x < 0.5 && $y < 0.5) || ($x > 0.5 && $y > 0.5)'
      Regexes with case-insensitive flag
        '($name =~ "^sys.*east$") || ($name =~ "^dev.[0-9]+"i)'
      Assignments, then bare-boolean filter statement:
        '$ab = $a+$b; $cd = $c+$d; $ab != $cd'
      Bare-boolean filter statement within a conditional:
        'if (NR < 100) {
          $x > 0.3;
        } else {
          $x > 0.002;
        }
        '
      Using 'any' higher-order function to see if $index is 10, 20, or 30:
        'any([10,20,30], func(e) {return $index == e})'

    See also https://miller.readthedocs.io/reference-dsl for more context.
    ```

### flatten

!!! aiuto "mlr flatten --help"

    ```
    Flattens multi-level maps to single-level ones. Example: field with name 'a'
    and value '{"b": { "c": 4 }}' becomes name 'a.b.c' and value 4.
    Options:
    -f Comma-separated list of field names to flatten (default all).
    -s Separator, defaulting to mlr --flatsep value.
    ```

### format-values

!!! aiuto "mlr format-values --help"

    ```
    Applies format strings to all field values, depending on autodetected type.
    * If a field value is detected to be integer, applies integer format.
    * Else, if a field value is detected to be float, applies float format.
    * Else, applies string format.

    Note: this is a low-keystroke way to apply formatting to many fields. To get
    finer control, please see the fmtnum function within the mlr put DSL.

    Note: this verb lets you apply arbitrary format strings, which can produce
    undefined behavior and/or program crashes.  See your system's "man printf".

    Options:
    -i {integer format} Defaults to "%d".
                        Examples: "%06lld", "%08llx".
                        Note that Miller integers are long long so you must use
                        formats which apply to long long, e.g. with ll in them.
                        Undefined behavior results otherwise.
    -f {float format}   Defaults to "%f".
                        Examples: "%8.3lf", "%.6le".
                        Note that Miller floats are double-precision so you must
                        use formats which apply to double, e.g. with l[efg] in them.
                        Undefined behavior results otherwise.
    -s {string format}  Defaults to "%s".
                        Examples: "_%s", "%08s".
                        Note that you must use formats which apply to string, e.g.
                        with s in them. Undefined behavior results otherwise.
    -n                  Coerce field values autodetected as int to float, and then
                        apply the float format.
    ```

### fraction

!!! aiuto "mlr fraction --help"

    ```
    For each record's value in specified fields, computes the ratio of that
    value to the sum of values in that field over all input records.
    E.g. with input records  x=1  x=2  x=3  and  x=4, emits output records
    x=1,x_fraction=0.1  x=2,x_fraction=0.2  x=3,x_fraction=0.3  and  x=4,x_fraction=0.4

    Note: this is internally a two-pass algorithm: on the first pass it retains
    input records and accumulates sums; on the second pass it computes quotients
    and emits output records. This means it produces no output until all input is read.

    Options:
    -f {a,b,c}    Field name(s) for fraction calculation
    -g {d,e,f}    Optional group-by-field name(s) for fraction counts
    -p            Produce percents [0..100], not fractions [0..1]. Output field names
                  end with "_percent" rather than "_fraction"
    -c            Produce cumulative distributions, i.e. running sums: each output
                  value folds in the sum of the previous for the specified group
                  E.g. with input records  x=1  x=2  x=3  and  x=4, emits output records
                  x=1,x_cumulative_fraction=0.1  x=2,x_cumulative_fraction=0.3
                  x=3,x_cumulative_fraction=0.6  and  x=4,x_cumulative_fraction=1.0
    ```

### gap

!!! aiuto "mlr gap --help"

    ```
    Emits an empty record every n records, or when certain values change.
    Options:
    Emits an empty record every n records, or when certain values change.
    -g {a,b,c} Print a gap whenever values of these fields (e.g. a,b,c) changes.
    -n {n} Print a gap every n records.
    One of -f or -g is required.
    -n is ignored if -g is present.
    ```

### grep

!!! aiuto "mlr grep --help"

    ```
    Passes through records which match the regular expression.
    Options:
    -i  Use case-insensitive search.
    -v  Invert: pass through records which do not match the regex.
    Note that "mlr filter" is more powerful, but requires you to know field names.
    By contrast, "mlr grep" allows you to regex-match the entire record. It does
    this by formatting each record in memory as DKVP, using command-line-specified
    ORS/OFS/OPS, and matching the resulting line against the regex specified
    here. In particular, the regex is not applied to the input stream: if you
    have CSV with header line "x,y,z" and data line "1,2,3" then the regex will
    be matched, not against either of these lines, but against the DKVP line
    "x=1,y=2,z=3".  Furthermore, not all the options to system grep are supported,
    and this command is intended to be merely a keystroke-saver. To get all the
    features of system grep, you can do
      "mlr --odkvp ... | grep ... | mlr --idkvp ..."
    ```

### group-by

!!! aiuto "mlr group-by --help"

    ```
    Outputs records in batches having identical values at specified field names.Options:
    ```

### group-like

!!! aiuto "mlr group-like --help"

    ```
    Outputs records in batches having identical field names.
    Options:
    ```

### having-fields

!!! aiuto "mlr having-fields --help"

    ```
    Conditionally passes through records depending on each record's field names.
    Options:
      --at-least      {comma-separated names}
      --which-are     {comma-separated names}
      --at-most       {comma-separated names}
      --all-matching  {regular expression}
      --any-matching  {regular expression}
      --none-matching {regular expression}
    Examples:
      mlr having-fields --which-are amount,status,owner
      mlr having-fields --any-matching 'sda[0-9]'
      mlr having-fields --any-matching '"sda[0-9]"'
      mlr having-fields --any-matching '"sda[0-9]"i' (this is case-insensitive)
    ```

### head

!!! aiuto "mlr head --help"

    ```
    Passes through the first n records, optionally by category.
    Without -g, ceases consuming more input (i.e. is fast) when n records have been read.
    Options:
    -g {a,b,c} Optional group-by-field names for head counts, e.g. a,b,c.
    -n {n} Head-count to print. Default 10.
    ```

### histogram

!!! aiuto "mlr histogram --help"

    ```
    Just a histogram. Input values < lo or > hi are not counted.
    -f {a,b,c}    Value-field names for histogram counts
    --lo {lo}     Histogram low value
    --hi {hi}     Histogram high value
    --nbins {n}   Number of histogram bins. Defaults to 20.
    --auto        Automatically computes limits, ignoring --lo and --hi.
                  Holds all values in memory before producing any output.
    -o {prefix}   Prefix for output field name. Default: no prefix.
    ```

### json-parse

!!! aiuto "mlr json-parse --help"

    ```
    Tries to convert string field values to parsed JSON, e.g. "[1,2,3]" -> [1,2,3].
    Options:
    -f {...} Comma-separated list of field names to json-parse (default all).
    ```

### json-stringify

!!! aiuto "mlr json-stringify --help"

    ```
    Produces string field values from field-value data, e.g. [1,2,3] -> "[1,2,3]".
    Options:
    -f {...} Comma-separated list of field names to json-parse (default all).
    --jvstack Produce multi-line JSON output.
    --no-jvstack Produce single-line JSON output per record (default).
    ```

### join

!!! aiuto "mlr join --help"

    ```
    Joins records from specified left file name with records from all file names
    at the end of the Miller argument list.
    Functionality is essentially the same as the system "join" command, but for
    record streams.
    Options:
      -f {left file name}
      -j {a,b,c}   Comma-separated join-field names for output
      -l {a,b,c}   Comma-separated join-field names for left input file;
                   defaults to -j values if omitted.
      -r {a,b,c}   Comma-separated join-field names for right input file(s);
                   defaults to -j values if omitted.
      --lp {text}  Additional prefix for non-join output field names from
                   the left file
      --rp {text}  Additional prefix for non-join output field names from
                   the right file(s)
      --np         Do not emit paired records
      --ul         Emit unpaired records from the left file
      --ur         Emit unpaired records from the right file(s)
      -s|--sorted-input  Require sorted input: records must be sorted
                   lexically by their join-field names, else not all records will
                   be paired. The only likely use case for this is with a left
                   file which is too big to fit into system memory otherwise.
      -u           Enable unsorted input. (This is the default even without -u.)
                   In this case, the entire left file will be loaded into memory.
                   If you wish to use a prepipe command for the main input as well
                   as here, it must be specified there as well as here.
      --prepipex {command} Likewise.
    File-format options default to those for the right file names on the Miller
    argument list, but may be overridden for the left file as follows. Please see
      -i {one of csv,dkvp,nidx,pprint,xtab}
      --irs {record-separator character}
      --ifs {field-separator character}
      --ips {pair-separator character}
      --repifs
      --implicit-csv-header
      --no-implicit-csv-header
    For example, if you have 'mlr --csv ... join -l foo ... ' then the left-file format will
    be specified CSV as well unless you override with 'mlr --csv ... join --ijson -l foo' etc.
    Likewise, if you have 'mlr --csv --implicit-csv-header ...' then the join-in file will be
    expected to be headerless as well unless you put '--no-implicit-csv-header' after 'join'.
    Please use "mlr --usage-separator-options" for information on specifying separators.
    Please see https://miller.readthedocs.io/en/latest/reference-verbs.html#join for more information
    including examples.
    ```

### label

!!! aiuto "mlr label --help"

    ```
    Given n comma-separated names, renames the first n fields of each record to
    have the respective name. (Fields past the nth are left with their original
    names.) Particularly useful with --inidx or --implicit-csv-header, to give
    useful names to otherwise integer-indexed fields.

    Options:
    ```

### least-frequent

!!! aiuto "mlr least-frequent --help"

    ```
    Shows the least frequently occurring distinct values for specified field names.
    The first entry is the statistical anti-mode; the remaining are runners-up.
    Options:
    -f {one or more comma-separated field names}. Required flag.
    -n {count}. Optional flag defaulting to 10.
    -b          Suppress counts; show only field values.
    -o {name}   Field name for output count. Default "count".
    See also "mlr most-frequent".
    ```

### merge-fields

!!! aiuto "mlr merge-fields --help"

    ```
    Computes univariate statistics for each input record, accumulated across
    specified fields.
    Options:
    -a {sum,count,...}  Names of accumulators. One or more of:
      count    Count instances of fields
      mode     Find most-frequently-occurring values for fields; first-found wins tie
      antimode Find least-frequently-occurring values for fields; first-found wins tie
      sum      Compute sums of specified fields
      mean     Compute averages (sample means) of specified fields
      var      Compute sample variance of specified fields
      stddev   Compute sample standard deviation of specified fields
      meaneb   Estimate error bars for averages (assuming no sample autocorrelation)
      skewness Compute sample skewness of specified fields
      kurtosis Compute sample kurtosis of specified fields
      min      Compute minimum values of specified fields
      max      Compute maximum values of specified fields
    -f {a,b,c}  Value-field names on which to compute statistics. Requires -o.
    -r {a,b,c}  Regular expressions for value-field names on which to compute
                statistics. Requires -o.
    -c {a,b,c}  Substrings for collapse mode. All fields which have the same names
                after removing substrings will be accumulated together. Please see
                examples below.
    -i          Use interpolated percentiles, like R's type=7; default like type=1.
                Not sensical for string-valued fields.
    -o {name}   Output field basename for -f/-r.
    -k          Keep the input fields which contributed to the output statistics;
                the default is to omit them.

    String-valued data make sense unless arithmetic on them is required,
    e.g. for sum, mean, interpolated percentiles, etc. In case of mixed data,
    numbers are less than strings.

    Example input data: "a_in_x=1,a_out_x=2,b_in_y=4,b_out_x=8".
    Example: mlr merge-fields -a sum,count -f a_in_x,a_out_x -o foo
      produces "b_in_y=4,b_out_x=8,foo_sum=3,foo_count=2" since "a_in_x,a_out_x" are
      summed over.
    Example: mlr merge-fields -a sum,count -r in_,out_ -o bar
      produces "bar_sum=15,bar_count=4" since all four fields are summed over.
    Example: mlr merge-fields -a sum,count -c in_,out_
      produces "a_x_sum=3,a_x_count=2,b_y_sum=4,b_y_count=1,b_x_sum=8,b_x_count=1"
      since "a_in_x" and "a_out_x" both collapse to "a_x", "b_in_y" collapses to
      "b_y", and "b_out_x" collapses to "b_x".
    ```

### most-frequent

!!! aiuto "mlr most-frequent --help"

    ```
    Shows the most frequently occurring distinct values for specified field names.
    The first entry is the statistical mode; the remaining are runners-up.
    Options:
    -f {one or more comma-separated field names}. Required flag.
    -n {count}. Optional flag defaulting to 10.
    -b          Suppress counts; show only field values.
    -o {name}   Field name for output count. Default "count".
    See also "mlr least-frequent".
    ```

### nest

!!! aiuto "mlr nest --help"

    ```
    Explodes specified field values into separate fields/records, or reverses this.
    Options:
      --explode,--implode   One is required.
      --values,--pairs      One is required.
      --across-records,--across-fields One is required.
      -f {field name}       Required.
      --nested-fs {string}  Defaults to ";". Field separator for nested values.
      --nested-ps {string}  Defaults to ":". Pair separator for nested key-value pairs.
      --evar {string}       Shorthand for --explode --values ---across-records --nested-fs {string}
      --ivar {string}       Shorthand for --implode --values ---across-records --nested-fs {string}
    Please use "mlr --usage-separator-options" for information on specifying separators.

    Examples:

      mlr nest --explode --values --across-records -f x
      with input record "x=a;b;c,y=d" produces output records
        "x=a,y=d"
        "x=b,y=d"
        "x=c,y=d"
      Use --implode to do the reverse.

      mlr nest --explode --values --across-fields -f x
      with input record "x=a;b;c,y=d" produces output records
        "x_1=a,x_2=b,x_3=c,y=d"
      Use --implode to do the reverse.

      mlr nest --explode --pairs --across-records -f x
      with input record "x=a:1;b:2;c:3,y=d" produces output records
        "a=1,y=d"
        "b=2,y=d"
        "c=3,y=d"

      mlr nest --explode --pairs --across-fields -f x
      with input record "x=a:1;b:2;c:3,y=d" produces output records
        "a=1,b=2,c=3,y=d"

    Notes:
    * With --pairs, --implode doesn't make sense since the original field name has
      been lost.
    * The combination "--implode --values --across-records" is non-streaming:
      no output records are produced until all input records have been read. In
      particular, this means it won't work in tail -f contexts. But all other flag
      combinations result in streaming (tail -f friendly) data processing.
    * It's up to you to ensure that the nested-fs is distinct from your data's IFS:
      e.g. by default the former is semicolon and the latter is comma.
    See also mlr reshape.
    ```

### nothing

!!! aiuto "mlr nothing --help"

    ```
    Drops all input records. Useful for testing, or after tee/print/etc. have
    produced other output.
    Options:
    ```

### put

!!! aiuto "mlr put --help"

    ```
    Options:
    -f {file name} File containing a DSL expression (see examples below). If the filename
       is a directory, all *.mlr files in that directory are loaded.

    -e {expression} You can use this after -f to add an expression. Example use
       case: define functions/subroutines in a file you specify with -f, then call
       them with an expression you specify with -e.

    (If you mix -e and -f then the expressions are evaluated in the order encountered.
    Since the expression pieces are simply concatenated, please be sure to use intervening
    semicolons to separate expressions.)

    -s name=value: Predefines out-of-stream variable @name to have
        Thus mlr put -s foo=97 '$column += @foo' is like
        mlr put 'begin {@foo = 97} $column += @foo'.
        The value part is subject to type-inferencing.
        May be specified more than once, e.g. -s name1=value1 -s name2=value2.
        Note: the value may be an environment variable, e.g. -s sequence=$SEQUENCE

    -x (default false) Prints records for which {expression} evaluates to false, not true,
       i.e. invert the sense of the filter expression.

    -q Does not include the modified record in the output stream.
       Useful for when all desired output is in begin and/or end blocks.

    -S and -F: There are no-ops in Miller 6 and above, since now type-inferencing is done
       by the record-readers before filter/put is executed. Supported as no-op pass-through
       flags for backward compatibility.


    Parser-info options:

    -w Print warnings about things like uninitialized variables.

    -W Same as -w, but exit the process if there are any warnings.

    -p Prints the expressions's AST (abstract syntax tree), which gives full
      transparency on the precedence and associativity rules of Miller's grammar,
      to stdout.

    -d Like -p but uses a parenthesized-expression format for the AST.

    -D Like -d but with output all on one line.

    -E Echo DSL expression before printing parse-tree

    -v Same as -E -p.

    -X Exit after parsing but before stream-processing. Useful with -v/-d/-D, if you
       only want to look at parser information.

    Examples:
      mlr --from example.csv put '$qr = $quantity * $rate'
    More example put expressions:
      If-statements:
        'if ($flag == true) { $quantity *= 10}'
        'if ($x > 0.0 { $y=log10($x); $z=sqrt($y) } else {$y = 0.0; $z = 0.0}'
      Newly created fields can be read after being written:
        '$new_field = $index**2; $qn = $quantity * $new_field'
      Regex-replacement:
        '$name = sub($name, "http.*com"i, "")'
      Regex-capture:
        'if ($a =~ "([a-z]+)_([0-9]+)) { $b = "left_\1"; $c = "right_\2" }'
      Built-in variables:
        '$filename = FILENAME'
      Aggregations (use mlr put -q):
        '@sum += $x; end {emit @sum}'
        '@sum[$shape] += $quantity; end {emit @sum, "shape"}'
        '@sum[$shape][$color] += $x; end {emit @sum, "shape", "color"}'
        '
          @min = min(@min,$x);
          @max=max(@max,$x);
          end{emitf @min, @max}
        '

    See also https://miller.readthedocs.io/reference-dsl for more context.
    ```

### regularize

Il verbo `regularize` riordina le righe nello stesso ordine della prima (qualunque sia l'ordine).

!!! aiuto "mlr regularize --help"

    ```
    Outputs records sorted lexically ascending by keys.
    Options:
    ```

### remove-empty-columns

!!! aiuto "mlr remove-empty-columns --help"

    ```
    Omits fields which are empty on every input row. Non-streaming.
    Options:
    ```

### rename

!!! aiuto "mlr rename --help"

    ```
    Renames specified fields.
    Options:
    -r         Treat old field  names as regular expressions. "ab", "a.*b"
               will match any field name containing the substring "ab" or
               matching "a.*b", respectively; anchors of the form "^ab$",
               "^a.*b$" may be used. New field names may be plain strings,
               or may contain capture groups of the form "\1" through
               "\9". Wrapping the regex in double quotes is optional, but
               is required if you wish to follow it with 'i' to indicate
               case-insensitivity.
    -g         Do global replacement within each field name rather than
               first-match replacement.
    Examples:
    mlr rename old_name,new_name'
    mlr rename old_name_1,new_name_1,old_name_2,new_name_2'
    mlr rename -r 'Date_[0-9]+,Date,'  Rename all such fields to be "Date"
    mlr rename -r '"Date_[0-9]+",Date' Same
    mlr rename -r 'Date_([0-9]+).*,\1' Rename all such fields to be of the form 20151015
    mlr rename -r '"name"i,Name'       Rename "name", "Name", "NAME", etc. to "Name"
    ```

### reorder

!!! aiuto "mlr reorder --help"

    ```
    Moves specified names to start of record, or end of record.
    Options:
    -e Put specified field names at record end: default is to put them at record start.
    -f {a,b,c} Field names to reorder.
    -b {x}     Put field names specified with -f before field name specified by {x},
               if any. If {x} isn't present in a given record, the specified fields
               will not be moved.
    -a {x}     Put field names specified with -f after field name specified by {x},
               if any. If {x} isn't present in a given record, the specified fields
               will not be moved.

    Examples:
    mlr reorder    -f a,b sends input record "d=4,b=2,a=1,c=3" to "a=1,b=2,d=4,c=3".
    mlr reorder -e -f a,b sends input record "d=4,b=2,a=1,c=3" to "d=4,c=3,a=1,b=2".
    ```

### repeat

!!! aiuto "mlr repeat --help"

    ```
    Copies input records to output records multiple times.
    Options must be exactly one of the following:
    -n {repeat count}  Repeat each input record this many times.
    -f {field name}    Same, but take the repeat count from the specified
                       field name of each input record.
    Example:
      echo x=0 | mlr repeat -n 4 then put '$x=urand()'
    produces:
     x=0.488189
     x=0.484973
     x=0.704983
     x=0.147311
    Example:
      echo a=1,b=2,c=3 | mlr repeat -f b
    produces:
      a=1,b=2,c=3
      a=1,b=2,c=3
    Example:
      echo a=1,b=2,c=3 | mlr repeat -f c
    produces:
      a=1,b=2,c=3
      a=1,b=2,c=3
      a=1,b=2,c=3
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

### sample

!!! aiuto "mlr sample --help"

    ```
    Reservoir sampling (subsampling without replacement), optionally by category.
    See also mlr bootstrap and mlr shuffle.
    Options:
    -g {a,b,c} Optional: group-by-field names for samples, e.g. a,b,c.
    -k {k} Required: number of records to output in total, or by group if using -g.
    ```

### sec2gmtdate

!!! aiuto "mlr sec2gmtdate --help"

    ```
    Replaces a numeric field representing seconds since the epoch with the
    corresponding GMT year-month-day timestamp; leaves non-numbers as-is.
    This is nothing more than a keystroke-saver for the sec2gmtdate function:
      ../c/mlr sec2gmtdate time1,time2
    is the same as
      ../c/mlr put '$time1=sec2gmtdate($time1);$time2=sec2gmtdate($time2)'
    ```

### sec2gmt

!!! aiuto "mlr sec2gmt --help"

    ```
    Replaces a numeric field representing seconds since the epoch with the
    corresponding GMT timestamp; leaves non-numbers as-is. This is nothing
    more than a keystroke-saver for the sec2gmt function:
      mlr sec2gmt time1,time2
    is the same as
      mlr put '$time1 = sec2gmt($time1); $time2 = sec2gmt($time2)'
    Options:
    -1 through -9: format the seconds using 1..9 decimal places, respectively.
    --millis Input numbers are treated as milliseconds since the epoch.
    --micros Input numbers are treated as microseconds since the epoch.
    --nanos  Input numbers are treated as nanoseconds since the epoch.
    ```

### seqgen

!!! aiuto "mlr seqgen --help"

    ```
    Passes input records directly to output. Most useful for format conversion.
    Produces a sequence of counters.  Discards the input record stream. Produces
    output as specified by the options

    Options:
    -f {name} (default "i") Field name for counters.
    --start {value} (default 1) Inclusive start value.
    --step {value} (default 1) Step value.
    --stop {value} (default 100) Inclusive stop value.
    Start, stop, and/or step may be floating-point. Output is integer if start,
    stop, and step are all integers. Step may be negative. It may not be zero
    unless start == stop.
    ```

### shuffle

!!! aiuto "mlr shuffle --help"

    ```
    Outputs records randomly permuted. No output records are produced until
    all input records are read. See also mlr bootstrap and mlr sample.
    Options:
    ```

### skip-trivial-records

!!! aiuto "mlr skip-trivial-records --help"

    ```
    Passes through all records except those with zero fields,
    or those for which all fields have empty value.
    Options:
    ```

### sort

!!! aiuto "mlr sort --help"

    ```
    Sorts records primarily by the first specified field, secondarily by the second
    field, and so on.  (Any records not having all specified sort keys will appear
    at the end of the output, in the order they were encountered, regardless of the
    specified sort order.) The sort is stable: records that compare equal will sort
    in the order they were encountered in the input record stream.

    Options:
    -f  {comma-separated field names}  Lexical ascending
    -r  {comma-separated field names}  Lexical descending
    -c  {comma-separated field names}  Case-folded lexical ascending
    -cr {comma-separated field names}  Case-folded lexical descending
    -n  {comma-separated field names}  Numerical ascending; nulls sort last
    -nf {comma-separated field names}  Same as -n
    -nr {comma-separated field names}  Numerical descending; nulls sort first
    -t  {comma-separated field names}  Natural ascending
    -tr {comma-separated field names}  Natural descending
    -h|--help Show this message.

    Example:
      mlr sort -f a,b -nr x,y,z
    which is the same as:
      mlr sort -f a -f b -nr x -nr y -nr z
    ```

### sort-within-records

Riordina i campi in ordine lessicamente crescente per nome campo.

!!! aiuto "mlr sort-within-records --help"

    ```
    Outputs records sorted lexically ascending by keys.
    Options:
    -r        Recursively sort subobjects/submaps, e.g. for JSON input.
    ```

Ad esempio a questo file, in cui i campi hanno ordine diverso

``` title="eterogeneita_irregular.json"
{ "a": 1, "b": 2, "c": 3 }
{ "c": 6, "a": 4, "b": 5 }
{ "b": 8, "c": 9, "a": 7 }
```

si potrà applicare questo comando per ordinare i campi secondo l'ordine alfabetico dei loro nomi

!!! comando "mlr --json sort-within-records ./eterogeneita_irregular.json"

    ```
    { "a": 1, "b": 2, "c": 3 }
    { "a": 4, "b": 5, "c": 6 }
    { "a": 7, "b": 8, "c": 9 }
    ```


### stats1

!!! aiuto "mlr stats1 --help"

    ```
    Computes univariate statistics for one or more given fields, accumulated across
    the input record stream.
    Options:
    -a {sum,count,...} Names of accumulators: one or more of:
      median   This is the same as p50
      p10 p25.2 p50 p98 p100 etc.
      count    Count instances of fields
      mode     Find most-frequently-occurring values for fields; first-found wins tie
      antimode Find least-frequently-occurring values for fields; first-found wins tie
      sum      Compute sums of specified fields
      mean     Compute averages (sample means) of specified fields
      var      Compute sample variance of specified fields
      stddev   Compute sample standard deviation of specified fields
      meaneb   Estimate error bars for averages (assuming no sample autocorrelation)
      skewness Compute sample skewness of specified fields
      kurtosis Compute sample kurtosis of specified fields
      min      Compute minimum values of specified fields
      max      Compute maximum values of specified fields

    -f {a,b,c}     Value-field names on which to compute statistics
    --fr {regex}   Regex for value-field names on which to compute statistics
                   (compute statistics on values in all field names matching regex
    --fx {regex}   Inverted regex for value-field names on which to compute statistics
                   (compute statistics on values in all field names not matching regex)

    -g {d,e,f}     Optional group-by-field names
    --gr {regex}   Regex for optional group-by-field names
                   (group by values in field names matching regex)
    --gx {regex}   Inverted regex for optional group-by-field names
                   (group by values in field names not matching regex)

    --grfx {regex} Shorthand for --gr {regex} --fx {that same regex}

    -i             Use interpolated percentiles, like R's type=7; default like type=1.
                   Not sensical for string-valued fields.\n");
    -s             Print iterative stats. Useful in tail -f contexts (in which
                   case please avoid pprint-format output since end of input
                   stream will never be seen).
    Example: mlr stats1 -a min,p10,p50,p90,max -f value -g size,shape
    Example: mlr stats1 -a count,mode -f size
    Example: mlr stats1 -a count,mode -f size -g shape
    Example: mlr stats1 -a count,mode --fr '^[a-h].*$' -gr '^k.*$'
            This computes count and mode statistics on all field names beginning
             with a through h, grouped by all field names starting with k.

    Notes:
    * p50 and median are synonymous.
    * min and max output the same results as p0 and p100, respectively, but use
      less memory.
    * String-valued data make sense unless arithmetic on them is required,
      e.g. for sum, mean, interpolated percentiles, etc. In case of mixed data,
      numbers are less than strings.
    * count and mode allow text input; the rest require numeric input.
      In particular, 1 and 1.0 are distinct text for count and mode.
    * When there are mode ties, the first-encountered datum wins.
    ```

### stats2

!!! aiuto "mlr stats2 --help"

    ```
    Computes bivariate statistics for one or more given field-name pairs,
    accumulated across the input record stream.
    -a {linreg-ols,corr,...}  Names of accumulators: one or more of:
      linreg-ols Linear regression using ordinary least squares
      linreg-pca Linear regression using principal component analysis
      r2       Quality metric for linreg-ols (linreg-pca emits its own)
      logireg  Logistic regression
      corr     Sample correlation
      cov      Sample covariance
      covx     Sample-covariance matrix
    -f {a,b,c,d}   Value-field name-pairs on which to compute statistics.
                   There must be an even number of names.
    -g {e,f,g}     Optional group-by-field names.
    -v             Print additional output for linreg-pca.
    -s             Print iterative stats. Useful in tail -f contexts (in which
                   case please avoid pprint-format output since end of input
                   stream will never be seen).
    --fit          Rather than printing regression parameters, applies them to
                   the input data to compute new fit fields. All input records are
                   held in memory until end of input stream. Has effect only for
                   linreg-ols, linreg-pca, and logireg.
    Only one of -s or --fit may be used.
    Example: mlr stats2 -a linreg-pca -f x,y
    Example: mlr stats2 -a linreg-ols,r2 -f x,y -g size,shape
    Example: mlr stats2 -a corr -f x,y
    ```

### step

!!! aiuto "mlr step --help"

    ```
    Computes values dependent on the previous record, optionally grouped by category.
    Options:
    -a {delta,rsum,...}   Names of steppers: comma-separated, one or more of:
      delta    Compute differences in field(s) between successive records
      shift    Include value(s) in field(s) from previous record, if any
      from-first Compute differences in field(s) from first record
      ratio    Compute ratios in field(s) between successive records
      rsum     Compute running sums of field(s) between successive records
      counter  Count instances of field(s) between successive records
      ewma     Exponentially weighted moving average over successive records

    -f {a,b,c} Value-field names on which to compute statistics
    -g {d,e,f} Optional group-by-field names
    -F         Computes integerable things (e.g. counter) in floating point.
               As of Miller 6 this happens automatically, but the flag is accepted
               as a no-op for backward compatibility with Miller 5 and below.
    -d {x,y,z} Weights for ewma. 1 means current sample gets all weight (no
               smoothing), near under under 1 is light smoothing, near over 0 is
               heavy smoothing. Multiple weights may be specified, e.g.
               "mlr step -a ewma -f sys_load -d 0.01,0.1,0.9". Default if omitted
               is "-d 0.5".
    -o {a,b,c} Custom suffixes for EWMA output fields. If omitted, these default to
               the -d values. If supplied, the number of -o values must be the same
               as the number of -d values.

    Examples:
      mlr step -a rsum -f request_size
      mlr step -a delta -f request_size -g hostname
      mlr step -a ewma -d 0.1,0.9 -f x,y
      mlr step -a ewma -d 0.1,0.9 -o smooth,rough -f x,y
      mlr step -a ewma -d 0.1,0.9 -o smooth,rough -f x,y -g group_name

    Please see https://miller.readthedocs.io/en/latest/reference-verbs.html#filter or
    https://en.wikipedia.org/wiki/Moving_average#Exponential_moving_average
    for more information on EWMA.
    ```

### tac

!!! aiuto "mlr tac --help"

    ```
    Prints records in reverse order from the order in which they were encountered.
    Options:
    ```

### tail

!!! aiuto "mlr tail --help"

    ```
    Passes through the last n records, optionally by category.
    Options:
    -g {a,b,c} Optional group-by-field names for head counts, e.g. a,b,c.
    -n {n} Head-count to print. Default 10.
    ```

### tee

!!! aiuto "mlr tee --help"

    ```
    Options:
    -a    Append to existing file, if any, rather than overwriting.
    -p    Treat filename as a pipe-to command.
    Any of the output-format command-line flags (see mlr -h). Example: using
      mlr --icsv --opprint put '...' then tee --ojson ./mytap.dat then stats1 ...
    the input is CSV, the output is pretty-print tabular, but the tee-file output
    is written in JSON format.

    ```

### template

!!! aiuto "mlr template --help"

    ```
    Places input-record fields in the order specified by list of column names.
    If the input record is missing a specified field, it will be filled with the fill-with.
    If the input record possesses an unspecified field, it will be discarded.
    Options:
     -f {a,b,c} Comma-separated field names for template, e.g. a,b,c.
     -t {filename} CSV file whose header line will be used for template.
    --fill-with {filler string}  What to fill absent fields with. Defaults to the empty string.
    Example:
    * Specified fields are a,b,c.
    * Input record is c=3,a=1,f=6.
    * Output record is a=1,b=,c=3.
    ```

### top

Restituisce i record con i valori più grandi (o più piccoli), per uno o più campi, anche raggruppando per campi.

!!! aiuto "mlr top --help"

    ```
    -f {a,b,c}    Value-field names for top counts.
    -g {d,e,f}    Optional group-by-field names for top counts.
    -n {count}    How many records to print per category; default 1.
    -a            Print all fields for top-value records; default is
                  to print only value and group-by fields. Requires a single
                  value-field name only.
    --min         Print top smallest values; default is top largest values.
    -F            Keep top values as floats even if they look like integers.
    -o {name}     Field name for output indices. Default "top_idx".
    Prints the n records with smallest/largest values at specified fields,
    optionally by category.
    ```

Qui un file (senza intestazione, nel comando di sotto si usa infatti il flag [`-N`](flag.md#csv)), in cui i primi 4 campi sono a volte duplicati in più record.

``` title="input.csv"
1,861265,C,A,0.071
1,861265,C,A,0.148
1,861265,C,G,0.001
1,861265,C,G,0.108
1,861265,C,T,0
1,861265,C,T,0.216
2,193456,G,A,0.006
2,193456,G,A,0.094
2,193456,G,C,0.011
2,193456,G,C,0.152
2,193456,G,T,0.003
2,193456,G,T,0.056
```

Se se si vogliono estrarre le righe con il valore massimo del campo `5`, a parità di valori dei campi `1`,`2`,`3`,`4`, il comando sarà:

!!! comando "mlr --csv -N top -f 5  -g 1,2,3,4 input.tsv"

    ```
    1,861265,C,A,1,0.148
    1,861265,C,G,1,0.108
    1,861265,C,T,1,0.216
    2,193456,G,A,1,0.094
    2,193456,G,C,1,0.152
    2,193456,G,T,1,0.056
    ```

!!! caution "In output soltanto i campi definiti nel comando. Se si vogliono tutti, bisogna aggiungere `-a`"

### unflatten

!!! aiuto "mlr unflatten --help"

    ```
    Reverses flatten. Example: field with name 'a.b.c' and value 4
    becomes name 'a' and value '{"b": { "c": 4 }}'.
    Options:
    -f {a,b,c} Comma-separated list of field names to unflatten (default all).
    -s {string} Separator, defaulting to mlr --flatsep value.
    ```

### uniq

!!! aiuto "mlr uniq --help"

    ```
    Prints distinct values for specified field names. With -c, same as
    count-distinct. For uniq, -f is a synonym for -g.

    Options:
    -g {d,e,f}    Group-by-field names for uniq counts.
    -c            Show repeat counts in addition to unique values.
    -n            Show only the number of distinct values.
    -o {name}     Field name for output count. Default "count".
    -a            Output each unique record only once. Incompatible with -g.
                  With -c, produces unique records, with repeat counts for each.
                  With -n, produces only one record which is the unique-record count.
                  With neither -c nor -n, produces unique records.
    ```

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

Alcuni formati, come il `JSON`, non devono avere lo stesso numero di campi per record. Un esempio il file a seguire:

```json title="input.json"
[
  {
    "nome": "sara",
    "dataNascita": "2000-02-22",
    "altezza": 166,
    "peso": 70.4,
    "comuneNascita": "Roma"
  },
  {
    "nome": "giulia",
    "comuneNascita": "Milano"
  }
]
```

Con `unsparsify`, viene di default prodotto un output in cui tutti i record hanno gli stessi campi, e l'input viene fatto diventare rettangolare (vedi [eterogeneità dei record](eterogeneita_record.md)); laddove erano assenti viene assegnato un valore nullo.

!!! comando "mlr --json unsparsify input.json"

    ```json
    [
      {
        "nome": "sara",
        "dataNascita": "2000-02-22",
        "altezza": 166,
        "peso": 70.4,
        "comuneNascita": "Roma"
      },
      {
        "nome": "giulia",
        "dataNascita": "",
        "altezza": "",
        "peso": "",
        "comuneNascita": "Milano"
      }
    ]
    ```
