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

## Formati file

Questi sono i *flag* legati ai formati.

Lista:

* `--asv or --asvlite`: Use ASV format for input and output data.
* `--csv or -c`: il formato CSV come input e output.
* `--csvlite`: Use CSV-lite format for input and output data.
* `--dkvp`: Use DKVP format for input and output data.
* `--gen-field-name`: Specify field name for --igen. Defaults to "i".
* `--gen-start`: Specify start value for --igen. Defaults to 1.
* `--gen-step`: Specify step value for --igen. Defaults to 1.
* `--gen-stop`: Specify stop value for --igen. Defaults to 100.
* `--iasv or --iasvlite`: Use ASV format for input data.
* `--icsv`: il formato CSV come input.
* `--icsvlite`: Use CSV-lite format for input data.
* `--idkvp`: Use DKVP format for input data.
* `--igen`: Ignore input files and instead generate sequential numeric input using --gen-field-name, --gen-start, --gen-step, and --gen-stop values. See also the seqgen verb, which is more useful/intuitive.
* `--ijson`: il formato JSON come input.
* `--ijsonl`: Use JSON Lines format for input data.
* `--inidx`: Use NIDX format for input data.
* `--io {format name}`: Use format name for input and output data. For example: `--io csv` is the same as `--csv`.
* `--ipprint`: Use PPRINT format for input data.
* `--itsv`: il formato TSV come input.
* `--itsvlite`: Use TSV-lite format for input data.
* `--iusv or --iusvlite`: Use USV format for input data.
* `--ixtab`: Use XTAB format for input data.
* `--json or -j`: il formato JSON come input and output.
* `--jsonl`: Use JSON Lines format for input and output data.
* `--nidx`: Use NIDX format for input and output data.
* `--oasv or --oasvlite`: Use ASV format for output data.
* `--ocsv`: il formato CSV come output.
* `--ocsvlite`: Use CSV-lite format for output data.
* `--odkvp`: Use DKVP format for output data.
* `--ojson`: il formato JSON come output.
* `--ojsonl`: Use JSON Lines format for output data.
* `--omd`: Use markdown-tabular format for output data.
* `--onidx`: Use NIDX format for output data.
* `--opprint`: Use PPRINT format for output data.
* `--otsv`: il formato TSV come output.
* `--otsvlite`: Use TSV-lite format for output data.
* `--ousv or --ousvlite`: Use USV format for output data.
* `--oxtab`: Use XTAB format for output data.
* `--pprint`: Use PPRINT format for input and output data.
* `--tsv`: il formato TSV come input e output.
* `--tsvlite or -t`: Use TSV-lite format for input and output data.
* `--usv or --usvlite`: Use USV format for input and output data.
* `--xtab`: Use XTAB format for input and output data.
* `-i {format name}`: Use format name for input data. For example: `-i csv` is the same as `--icsv`.
* `-o {format name}`: Use format name for output data.  For example: `-o csv` is the same as `--ocsv`.
