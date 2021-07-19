---
og_image: imgs/2021-07-19_08h27_57.png
---

# Miller

Il suo eccezionale autore - :pray: [John Kerl](https://twitter.com/__jo_ker__) - [definisce](https://miller.readthedocs.io/en/latest/features.html) **Miller** come `awk`, `sed`, `cut`, `join` e `sort` per dati indicizzati con nome, come `CSV`, `TSV` e `JSON`.

Ha una fantastica **documentazione ufficiale** in inglese, consultabile [qui](https://miller.readthedocs.io/en/latest/index.html).

## Primi passi

Miller fa spesso riferimento nei suoi sub comandi al *toolkit* di `UNIX` e ai suoi esegubili come `cat`, `tail`, `cut`, `sort`, etc.. Questo è ad esempio un comando di base, che stampa a schermo il contenuto di un [file](./risorse/base.csv):

```bash
mlr --csv cat base.csv
```

Esistono altri tipi di sub comandi, che invece replicano alcune delle caratteristiche di `awk`, come `filter` e `put`.

I **sub comandi** di Miller si chiamano [**verbi**](./verbi.md),

Il comando di base `cat`, che stampa a schermo il contenuto di un file. <br>


- [formati](./formati.md);
- [verbi](./verbi.md);
- [*script*](./dsl.md) (`DSL`)
