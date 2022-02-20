---
hide:
#  - navigation
  - toc
title: csvkit - csvstat
---

Il comando **`csvstat`** restituisce delle statistiche di base, per ogni campo:

  - `column_id`, il numero della colonna (1, se è la prima e a seguire);
  - `column_name`, il nome;
  - `type`, il tipo di campo (è un valore dedotto, non letto, quindi ci potrebbe essere qualche errore);
  - `nulls`, il numero di valori nulli;
  - `unique`, il numero di valori univoci;
  - `min`, il valore minimo (se numerico);
  - `max`, il valore massimo (se numerico);
  - `sum`, la somma (se numerico);
  - `mean`, la media (se numerico);
  - `median`, la mediana (se numerico);
  - `stdev`, la deviazione standard (se numerico);
  - `len`, la lunghezza (se è un campo di testo).
  - `freq`, la lista dei valori più frequenti.


Ad esempio applicato a [questo file](../data/colored-shapes.csv)

```bash
csvstat --csv  --everything colored-shapes.csv
```

restituisce

| column_id | column_name | type | nulls | unique | min | max | sum | mean | median | stdev | len | freq |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | color | Text | False | 6 |  |  |  |  |  |  | 6 | red, blue, yellow, purple, green |
| 2 | shape | Text | False | 3 |  |  |  |  |  |  | 8 | square, triangle, circle |
| 3 | flag | Boolean | False | 2 |  |  |  |  |  |  |  | False, True |
| 4 | i | Number | False | 10056 | 56 | 499,974 | 2,526,603,201 | 250,704.822 | 251,091 | 144,935.141 |  | 18685, 26495, 36075, 49190, 68145 |
| 5 | u | Number | False | 10027 | 0 | 1 | 5,022.133 | 0.498 | 0.498 | 0.29 |  | 0.854026, 0.546961, 0.017264, 0.171977, 0.170643 |
| 6 | v | Number | False | 10026 | -0.093 | 1.072 | 5,016.697 | 0.498 | 0.497 | 0.289 |  | 0.971983, 0.090678, 0.221560, 0.004933, 0.464153 |
| 7 | w | Number | False | 9434 | 0.043 | 0.901 | 5,034.491 | 0.5 | 0.5 | 0.034 |  | 0.506155, 0.521158, 0.499156, 0.494010, 0.520913 |
| 8 | x | Number | False | 10071 | 1.113 | 8.921 | 50,464.129 | 5.007 | 4.997 | 1.166 |  | 5.458618, 4.011646, 5.332571, 4.315572, 5.178077 |

!!! info

    Nel comando di esempio soprastante, è stata aggiunta l'opzione `--csv`, per forzare l'output del comando in formato `CSV`.
