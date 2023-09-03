---
tags:
  - split
title: Suddividere un file in parti
hide:
#  - navigation
  - toc
---

Con file di testo, specialmente quelli in cui ogni linea contiene un'informazione auto consistente (come il [JSON Lines](https://jsonlines.org/)), può essere utile suddividerli in più file.

Ad esempio, a partire da un file `500.000` righe, suddividerlo in blocchi di file da `50.000`.

Un'*utility* per farlo è [`split`](../utilities/index.md#split). La sintassi per l'esempio di sopra è:

```bash
split -l 50000 -d input.csv input_ --additional-suffix=.csv
```

!!! info "Informazioni"

    - `-l` per impostare il valore nel numero di righe;
    - `-d` per avere nel nome dei file di output un suffisso numerico progressivo;
    - `input.csv` è il nome del file di input;
    - `input_` per impostare il prefisso del nome del file di output;
    - `--additional-suffix=.csv` per aggiungere al nome dei file di *output* `.csv`.

In output si avranno i file `input_00.csv`, `input_01.csv`, ecc..

È possibile dividere il file anche in un determinato numero di parti e per tagli dimensionali in *byte*.

!!! warning

    `split` non è `format aware`
