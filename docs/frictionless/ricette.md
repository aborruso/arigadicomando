---
hide:
#  - navigation
#  - toc
title: frictionless - Ricette
---

# Ricette

## Validare

### Impostare i valori da considerare come nulli

Ad esempio, per dire di considerare come valori nulli, le celle che contengono `NULL` o `N`:

```bash
frictionless validate --field-missing-values "NULL,N" input.csv
```

### Non validare una o più colonne

È possibile farlo sia tramite nome colonna, che numero di colonna.


```bash
frictionless validate --skip-fields "fieldA,fieldB" input.csv
```

```bash
frictionless validate --skip-fields "22,46" input.csv
```

### Eseguire soltanto certi tipi di test

``` bash
frictionless validate --pick-errors "type-error,missing-cell" input.csv
```

### Non eseguire uno specifico test di validazione

Ad esempio non eseguire il controllo ([`missing-label`](tipi-errore.md#blank-row)) che verifica che tutte le colonne abbiano un'etichetta:

```bash
frictionless validate --skip-errors missing-label input.csv
```

### Definire il separatore di campo, senza inferencing

`frictionless`, quando legge un file in formato `CSV`, prova a estrarne automaticamente il separatore di campo. Se si vuole forzarne la definizione:

``` bash
frictionless validate --dialect '{"delimiter": ";"}' input.csv
```

### Aumentare l'ampiezza di informazioni da usare per fare inferencing su un file

`frictionless` per dedurre ad esempio l'_encoding_ di un file `CSV` (e tante altre informazioni) usa un _byte sample_ di 10.000. Se si vuole ampliare, c'è l'opzione `--buffer-size`.

``` bash
frictionless validate --buffer-size 250000 input.csv
```

## Estrarre

### Come estrarre uno specifico foglio, di un foglio elettronico

```bash
frictionless extract input.ods --dialect '{"sheet": "Sheet2"}'
```

### Estrarre soltanto le righe che passano la validazione

``` bash
frictionless extract --valid  input.csv --csv
```

!!! note

    Da un'idea di `aborruso`, proposta tramite le issue [`#963`](https://github.com/frictionlessdata/frictionless-py/issues/963) e [`#1004`](https://github.com/frictionlessdata/frictionless-py/issues/1004).

### Estrarre soltanto le righe che non passano la validazione

``` bash
frictionless extract --invalid  input.csv --csv
```
