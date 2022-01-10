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
