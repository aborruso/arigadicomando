# Ricette

## Concatenare in "verticale" più file

Il verbo "tipico" per concatenare due o più file è [`cat`](verbi.md#cat). Ad esempio se voglio unire in verticale questi due file `CSV`

=== "base.cv"

    ```
    nome,dataNascita,altezza,peso
    andy,1973-05-08,176,86.5
    chiara,1993-12-13,162,58.3
    guido,2001-01-22,196,90.4
    ```

=== "base_merge.csv"

    ```
    nome,dataNascita,altezza,peso,coloreOcchi
    marco,1983-12-08,183,,verdi
    licia,1993-12-07,158,57.9,neri
    ```

il comando da lanciare sarà

```bash
mlr --csv cat base.csv base_merge.csv >output.csv
```

che darà in output

```
+--------+-------------+---------+------+
| nome   | dataNascita | altezza | peso |
+--------+-------------+---------+------+
| andy   | 1973-05-08  | 176     | 86.5 |
| chiara | 1993-12-13  | 162     | 58.3 |
| guido  | 2001-01-22  | 196     | 90.4 |
| marco  | 1983-12-08  | 183     | -    |
| licia  | 1993-12-07  | 158     | 57.9 |
+--------+-------------+---------+------+
```

È possibile fare il *merge*, l'unione in verticale, anche di due file con uno **schema** in parte **diverso**, perché Miller gestiste l'[eterogeneità dei record](eterogeneita_record.md). Se ad esempio si è in presenza di un file che ha una colonna in più (`coloreOcchi`) rispetto a [`base.csv`](risorse/base.csv), come questo ([`base_altro.csv`](risorse/base_altro.csv))

```
nome,dataNascita,altezza,peso,coloreOcchi
marco,1983-12-08,183,,verdi
licia,1993-12-07,158,57.9,neri
```

il verbo da usare è [`unsparsify`](verbi.md#unsparsify). Il comando sarà:

```bash
mlr --csv unsparsify base.csv base_altro.csv >output.csv
```

In output, verrà aggiunta la colonna `coloreOcchi`, che non sarà valorizzata per i record del file che in partenza non aveva questa colonna:

```
+--------+-------------+---------+------+-------------+
| nome   | dataNascita | altezza | peso | coloreOcchi |
+--------+-------------+---------+------+-------------+
| andy   | 1973-05-08  | 176     | 86.5 | -           |
| chiara | 1993-12-13  | 162     | 58.3 | -           |
| guido  | 2001-01-22  | 196     | 90.4 | -           |
| marco  | 1983-12-08  | 183     | -    | verdi       |
| licia  | 1993-12-07  | 158     | 57.9 | neri        |
+--------+-------------+---------+------+-------------+
```

## Suddividere un file di input in più file di output, ogni xxx record

```
 mlr --csv put -q '
  begin {
    @batch_size = 1000;
  }
  index = int(floor((NR-1) / @batch_size));
  label = fmtnum(index,"%04d");
  filename = "part-".label.".json";
  tee > filename, $*
' ./input.csv
```

Verrà creato un file di output, con nome `part-000XXX`, ogni 1000 (si imposta tramite `@batch_size`) record.

## Estrarre le righe che contengono il valore massimo di un campo

Alcune delle righe sottostanti, sono identiche, fatta eccezione per il V campo.

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

Se si vogliono estrarre soltanto quelle con il valore massimo del V campo, raggruppate per i valori degli altri 4, il verbo da usare è [top](verbi.md#top)

!!! comando "mlr --csv -N top -f 5  -g 1,2,3,4 input.tsv"

    ```
    1,861265,C,A,1,0.148
    1,861265,C,G,1,0.108
    1,861265,C,T,1,0.216
    2,193456,G,A,1,0.094
    2,193456,G,C,1,0.152
    2,193456,G,T,1,0.056
    ```

Vedi <https://stackoverflow.com/a/70664880/757714>

## Eseguire un comando esterno all'interno di una funzione

All'interno di un comando Miller è possibile lanciare una *utility* esterna, usando la funzione [`system`](https://miller.readthedocs.io/en/latest/reference-dsl-builtin-functions/index.html#system).

Immaginiamo ad esempio di avere un file come questo

``` title="input.txt"
a,b
1,"15,1,2/AX,22,1/C,1/A,1/BA,2,3"
```

e di voler applicare il cosiddetto *natural sorting* alla stringa `15,1,2/AX,22,1/C,1/A,1/BA,2,3`, ottenendo questo ordinamento `1,1/A,1/BA,1/C,2,2/AX,3,15,22`.

Utilizzando le *utility* standard della shell di Linux basterebbe fare così (in `paste` si usa `-` perché l'input è l'[`stdin`](https://stackoverflow.com/a/26480035/757714)):

```
echo "15,1,2/AX,22,1/C,1/A,1/BA,2,3" | tr , "\n" | sort -V | paste -sd, -
```

Per riportare questa sintassi[^1] in un comando Miller, il comando sarebbe come questo di sotto, in cui viene creato il campo `toto`, che raccoglie valori derivanti dal lancio di *utility* esterne, grazie alla funzione `system`.

[^1]: qui commentata su [explainshell](https://explainshell.com/explain?cmd=echo+%2215%2C1%2C2%2FAX%2C22%2C1%2FC%2C1%2FA%2C1%2FBA%2C2%2C3%22+%7C+tr+%2C+%22%5Cn%22+%7C+sort+-V+%7C+paste+-sd%2C+-)

```
<input.txt mlr --c2p --barred cat  then put -S '$toto=system("echo ".$b." | tr , \"\n\" | sort -V | paste -sd, -")'
```

E l'output:

```
+---+-------------------------------+-------------------------------+
| a | b                             | toto                          |
+---+-------------------------------+-------------------------------+
| 1 | 15,1,2/AX,22,1/C,1/A,1/BA,2,3 | 1,1/A,1/BA,1/C,2,2/AX,3,15,22 |
+---+-------------------------------+-------------------------------+
```

Nel comando bisogna avere cura di inserire eventuali `escape` a caratteri come `"`.

## Fare un trova e sostituisci per campo

È un'operazione classica che si realizza sfruttando il verbo [**`put`**](./verbi.md#put) e funzioni come [`sub`](https://miller.readthedocs.io/en/latest/reference-dsl-builtin-functions/index.html#sub) e [`gsub`](https://miller.readthedocs.io/en/latest/reference-dsl-builtin-functions/index.html#gsub).

Se ad esempio si vuole cercare la stringa `Denis` e sostituirla con `Dennis`, nel campo `nomeCampo`, la sintassi tipo è:

```bash
mlr --csv put '$nomeCampo=sub($nomeCampo,"Denis","Dennis")' input.csv
```

La funzione `sub` ha tre argomenti, separati `,`:

- a cosa applicare la sostituzione;
- cosa cercare;
- con cosa sostituirlo.

Alcune note:

- i nomi dei campi, nelle funzioni scritte in `put` hanno come prefisso il `$`. Se ci sono spazi usare le parentesi graffe (i.e. `${nome campo}`);
- in questo esempio si dice al campo `nomeCampo`, che sarà uguale a se stesso, con le sostituzioni da fare.

È possibile usare le **espressioni regolari**, usando la sintassi del caso, ed è possibile mettere in fila enne processi di sostituzione, separati da `;`:<br>

```
$nomeCampo=sub($nomeCampo,"Denis","Dennis");$altroCampo=sub($altroCampo,"^Bau","Miao")
```

!!! note "Nota bene"

    `sub` esegue il trova e sostituisci della **prima occorrenza** che trova in una cella, mentre `gsub` per **tutte le occorrenze** in quella cella.

## Fare un trova e sostituisci globale

È comodo utilizzare [`DSL`](https://miller.readthedocs.io/en/latest/reference-dsl/), il linguaggio di scripting di Miller e usare un [ciclo *for*](https://miller.readthedocs.io/en/latest/reference-dsl-control-structures/#for-loops):

```
mlr --csv -S put 'for (k in $*) {$[k] = gsub($[k], "e", "X")}' foo.csv
```

Per tutti i campi - `k` - verrà applicata la funzione [`gsub`](https://miller.readthedocs.io/en/latest/reference-dsl-builtin-functions/index.html#gsub) (trova e sostituisci globale con supporto a espressioni regolari), che (in questo esempio) cerca la stringa `e` e la sostituisce con `X`.

L'opzione `-S` per forzare che tutti i campi siano interpretati come stringhe.

## Rimuovere i ritorni a capo nelle celle

Prendendo spunto dalla ricetta sul [trova e sostituisce globale](ricette.md#fare-un-trova-e-sostituisci-globale), basta cercare il carattere di ritorno a capo.

In input un CSV come quello di sotto ([qui](risorse/rimuovi-a-capo.txt)), in cui all'interno delle celle, ci sono dei ritorno a capo materializzati da dei *line feed*, ovvero mappati con i caratteri speciali `\n`.

``` title="rimuovi-a-capo.txt"
Campo 1,Campo 2
"Cella con
A capo
Fastidiosi",Ipsum
Lorem,"uno
Due
Tre
Quattro
Cinque"
```

Si può cercare appunto `\n` e sostituirlo con spazio, e poi rimuovere eventuali doppi spazi usando il verbo [`clean-whitespace`](verbi.md#clean-whitespace):

```
mlr --csv -S put 'for (k in $*) {$[k] = gsub($[k], "\n", " ")}' then clean-whitespace rimuovi-a-capo.txt
```

In output:

```
Campo 1,Campo 2
Cella con A capo Fastidiosi,Ipsum
Lorem,uno Due Tre Quattro Cinque
```

!!! note "Nota bene"

    `\n` non è l'unico modo di materializzare un [ritorno a capo](https://en.wikipedia.org/wiki/Carriage_return?oldformat=true), quindi è possibile dover modificare l'esempio di sopra.

## Suddividere un file in più parti, in dipendenza del valore di un campo

A partire ad esempio da

    DeviceID,AreaName,Longitude,Latitude
    12311,Dubai,55.55431,25.45631
    12311,Dubai,55.55432,25.45634
    12311,Dubai,55.55433,25.45637
    12311,Dubai,55.55431,25.45621
    12309,Dubai,55.55427,25.45627
    12309,Dubai,55.55436,25.45655
    12412,Dubai,55.55441,25.45657
    12412,Dubai,55.55442,25.45656

e lanciando

    mlr --csv --from input.csv put -q 'tee > $DeviceID.".csv", $*'

si avranno questi tre file

    #12311.csv
    DeviceID,AreaName,Longitude,Latitude
    12311,Dubai,55.55431,25.45631
    12311,Dubai,55.55432,25.45634
    12311,Dubai,55.55433,25.45637
    12311,Dubai,55.55431,25.45621

    #12412.csv
    DeviceID,AreaName,Longitude,Latitude
    12412,Dubai,55.55441,25.45657
    12412,Dubai,55.55442,25.45656

    #12309.csv
    DeviceID,AreaName,Longitude,Latitude
    12309,Dubai,55.55427,25.45627
    12309,Dubai,55.55436,25.45655
