---
hide:
#  - navigation
#  - toc
title: frictionless - Ricette
---

# Ricette

## Validazione

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
