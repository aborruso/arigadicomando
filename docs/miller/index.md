# Miller

Il suo eccezionale autore - :pray: [John Kerl](https://twitter.com/__jo_ker__) - definisce [**Miller**](https://github.com/johnkerl/miller/) come `awk`, `sed`, `cut`, `join` e `sort` per file di testo strutturati come `CSV`, `TSV` e `JSON`.

Ha una ottima **documentazione ufficiale** in inglese, consultabile [qui](https://miller.readthedocs.io/en/latest/index.html).

## Installazione

Miller 6 si può installare in diversi modi:

- utilizzando i file binari precompilati, oresenti nella [pagina delle *release*](https://github.com/johnkerl/miller/releases);
- [compilandolo](https://miller.readthedocs.io/en/latest/build/) a partire dal codice sorgente;
- utilizzando un gestore di pacchetti:
    - Linux, `yum install miller` o `apt-get install miller` in dipenendenza della versione di Linux, o [Homebrew](https://docs.brew.sh/linux)
    - MacOS, `brew update` e `brew install miller`, o `sudo port selfupdate` e `sudo port install miller`, in dipendenza delle tue preferenze di [Homebrew](https://brew.sh) o [MacPorts](https://macports.org).
    - Windows, `choco install miller` utilizzando [Chocolatey](https://chocolatey.org).

## Primi passi

Miller fa spesso riferimento nei suoi sub comandi al *toolkit* di `UNIX` e ai suoi esegubili come `cat`, `tail`, `cut`, `sort`, etc.. <br>
Un esempio per iniziare: stampare a schermo il contenuto di un [file](./risorse/base.csv):

=== "comando"

    ```bash
    mlr --csv cat base.csv
    ```

=== "output"

    ```
    nome,dataNascita,altezza,peso
    andy,1973-05-08,176,86.5
    chiara,1993-12-13,162,58.3
    guido,2001-01-22,196,90.4
    ```

Nel comando di sopra `cat` è uno dei verbi di Miller.

Esistono altri tipi di sub comandi, che invece replicano alcune delle caratteristiche di `awk`, come `filter` e `put`.

I **sub comandi** di Miller si chiamano [**verbi**](./verbi.md)<!-- .slide: data-fullscreen -->




- [formati](./formati.md);
- [verbi](./verbi.md);
- [*script*](./dsl.md) (`DSL`)
