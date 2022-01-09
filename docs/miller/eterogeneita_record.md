# Eterogeneità dei record

Per Miller il modo nativo di "pensare" ai dati è per **record eterogenei**: ogni record non deve necessariamente avere lo stesso numero di campi degli altri.

!!! info "I record non hanno lo stesso numero di campi"

    ```
    nome=andy,dataNascita=1973-05-08,altezza=176,peso=86.5,comuneNascita=Roma
    nome=chiara,dataNascita=1993-12-13,altezza=162,peso=58.3,comuneNascita=Milano
    nome=guido,altezza=196,peso=90.4,comuneNascita=Roma
    nome=sara,dataNascita=2000-02-22,altezza=166,peso=70.4,comuneNascita=Roma
    nome=giulia,dataNascita=1997-08-13,altezza=169,peso=68.3
    ```

## Terminologia

Esistono tre tipi di eterogeneità: [`ragged`](#ragged), [`irregular`](#irregular) e [`sparse`](#sparse).

### Dati rettangolari

Qui un esempio di dati "rettangolari", in formato `CSV`: 3 i campi previsti, e ogni record ha valorizzato 3 campi.

``` title="eterogenita.csv"
a,b,c
1,2,3
4,5,6
7,8,9
```

### Dati rettangolari, ma con celle vuote

Questo è un file che non ha record eterogenei, ma ha alcune celle vuote (per il campo `b` a riga 2 e per il campo `a` a riga 3).

``` title="eterogeneita_vuoti.csv"
a,b,c
1,2,3
4,,6
,8,9
```

In Miller è possibile usare il verbo [`fill-empty`](verbi.md#fill-empty), per attribuirgli un valore (ad esempio `NA`). La gestione dei valori sconosciuti o nulli è tra la [:material-table: buone pratiche](https://ondata.github.io/guidaPraticaPubblicazioneCSV/guida/linee_guida_pubblicazione/P05_trattamento_valori_sconosciuti/) della pubblicazione di dati in formato CSV.

!!! comando "mlr --icsv --opprint fill-empty -v NA ./eterogeneita_vuoti.csv"

    ```
    a  b  c
    1  2  3
    4  NA 6
    NA 8  9
    ```

!!! warning "Il verbo `fill-empty` richiede Miller >= 6.0"


### Ragged

Questo è il caso di eterogeneità, dovuta a errori di struttura del file. Come questo di sotto.

``` title="eterogeneita_ragged.csv"
a,b,c
1,2,3
4,5
7,8,9,10
```

Se si prova semplicemente a stamparlo a schermo, Miller restituisce un errore:

!!! comando "mlr --csv cat ./eterogeneita_ragged.csv"

    ```
    a,b,c
    1,2,3
    mlr :  mlr: CSV header/data length mismatch 3 != 2 at filename eterogeneita_ragged.csv row 3.
    ```

Questi gli errori del file, che ha un'intestazione composta da 3 campi:

1. nella riga 2, ci sono 2 campi e non 3;
2. nella riga 4, ci sono 4 campi e non 3.

Miller è in grado di gestire anche questa eterogeneità, che deriva da errori, utilizzando il [*flag*](flag.md#csv) `--allow-ragged-csv-input`:

!!! comando "mlr --csv --allow-ragged-csv-input ./eterogeneita_ragged.csv"

    ```
    a,b,c,4
    1,2,3,
    4,5,,
    7,8,9,10
    ```

Per il primo errore è stata aggiunta una cella vuota; per il secondo è stato aggiunto un campo a cui è stato assegnato un'etichetta numerica - `4` - corrispondente al suo ordine nella lista dei campi.
### Irregular

Un altro tipo di eterogeneità è legata a campi ordinati diversamente per ogni riga:

``` title="eterogeneita_irregular.json"
{"a": 1, "b": 2, "c": 3}
{"c": 6, "a": 4, "b": 5}
{"b": 8, "c": 9, "a": 7}
```

Se fosse necessario uniformare l'ordine si possono usare i verbi [`regularize`](verbi.md#regularize) o [`sort-within-records`](verbi.md#sort-within-records).

Il verbo `regularize` riordina le righe nello stesso ordine della prima (qualunque sia l'ordine); il verbo `sort-in-records` usa semplicemente l'ordine alfabetico.

### Sparse

In ultimo c'è l'eterogeneità più frequente, legata a record che non sono composti tutti dagli stessi campi. Come ad esempio il `JSON` sottostante.

``` title="eterogeneita_sparse.json"
{
  "host": "xy01.east",
  "status": "running",
  "volume": "/dev/sda1"
}
{
  "host": "xy92.west",
  "status": "running"
}
{
  "purpose": "failover",
  "host": "xy55.east",
  "volume": "/dev/sda1",
  "reimaged": true
}
```

Si può utilizzare il verbo [`unsparsify`](verbi.md#unsparsify) per fare in modo che tutti i record abbiano gli stessi campi.

!!! comando "mlr --json unsparsify ./eterogeneita_sparse.json"

```
{
  "host": "xy01.east",
  "status": "running",
  "volume": "/dev/sda1",
  "purpose": "",
  "reimaged": ""
}
{
  "host": "xy92.west",
  "status": "running",
  "volume": "",
  "purpose": "",
  "reimaged": ""
}
{
  "host": "xy55.east",
  "status": "",
  "volume": "/dev/sda1",
  "purpose": "failover",
  "reimaged": true
}
```
