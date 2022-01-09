# Flag

A seguire sono riportati i *flag* che si possono utilizzare in Miller. Ad esempio, nel comando

!!! comando "mlr --icsv --ojson head -n 1 ./base_category.csv"

    ```json
    {
      "nome": "andy",
      "dataNascita": "1973-05-08",
      "altezza": 176,
      "peso": 86.5,
      "comuneNascita": "Roma"
    }
    ```

`--icsv` e `--ojson` sono i *flag* con cui impostare il [formato](formati.md) di *input* e *output*.

## CSV

Si tratta di *flag* applicabili al formato `CSV`.

Lista:

- `--allow-ragged-csv-input` o `--ragged`: Se una riga dati ha meno campi della riga di intestazione, viene riempire con i campi rimanenti, vuoti. Se una riga di dati ha più campi della riga di intestazione, Miller utilizza dei nomi di campo numerici interi, a partire da 1;

## JSON

Si tratta di *flag* applicabili al formato `CSV`.

Lista:

- `--jlistwrap`, include l'output [JSON](formati.md#json) (che di default è un JSON lines), tra `[]`;
- `--no-jvstack`, dispone gli oggetti/array di output su una riga;
