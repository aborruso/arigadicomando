# Ricette Nushell

## dataframe

### Creare un dataframe a partire da un CSV

```bash
let df = open-df input.csv
```

### Descrivere un dataframe

```bash
$df | describe
```

### Avere l'ouput di un comando in stdout

Bisogna prima trasformare il dataframe in una tabella `nu`, con il comando `into nu`.

Ad esempio

```bash
$df | describe | into nu | to csv
```
