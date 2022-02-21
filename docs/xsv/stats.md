---
hide:
#  - navigation
  - toc
title: xsv - stats
---

Il comando **`stats`** restituisce delle statistiche di base, per ogni campo:

  - `type`, il tipo di campo (è un valore dedotto, non letto, quindi ci potrebbe essere qualche errore);
  - `sum`, la somma;
  - `min`, il minimo (se numerico);
  - `max`, il massimo (se numerico);
  - `min_length`, la lunghezza minima;
  - `max_length`, la lunghezza massima;
  - `mean`, la media;
  - `stddev`, la deviazione standard;
  - `median`, la mediana;
  - `mode`, la moda;
  - `cardinality`, la cardinalità, ovvero quanti valori distinti.

Ad esempio applicato a [questo file](../data/colored-shapes.csv)

```bash
xsv stats  --everything docs/data/colored-shapes.csv
```

restituisce

| field | type | sum | min | max | min_length | max_length | mean | stddev | median | mode | cardinality |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| color | Unicode |  | blue | yellow | 3 | 6 |  |  |  | red | 6 |
| shape | Unicode |  | circle | triangle | 6 | 8 |  |  |  | square | 3 |
| flag | Integer | 4020 | 0 | 1 | 1 | 1 | 0.3988886683865837 | 0.48966978528326777 | 0 | 0 | 2 |
| i | Integer | 2526603201 | 56 | 499974 | 2 | 6 | 250704.82248462 | 144927.94969629444 | 251091 | N/A | 10056 |
| u | Float | 5022.132880999998 | 0.000044 | 0.999969 | 8 | 8 | 0.49832634262750636 | 0.29031110004586974 | 0.497603 | 0.969583 | 10027 |
| v | Float | 5016.69704200001 | -0.092709 | 1.0725 | 8 | 9 | 0.4977869658662455 | 0.28882812412153674 | 0.49699249999999995 | N/A | 10026 |
| w | Float | 5034.4910549999895 | 0.042795 | 0.901171 | 8 | 8 | 0.49955259525699414 | 0.033577377526502444 | 0.499945 | 0.542539 | 9434 |
| x | Float | 50464.12851900001 | 1.113294 | 8.921095 | 8 | 8 | 5.007355479162526 | 1.1660887238185873 | 4.997097 | 6.466293 | 10071 |

!!! note "Nota"

    Se avesse pure il **conteggio** dei **valori nulli**, sarebbe perfetto.
