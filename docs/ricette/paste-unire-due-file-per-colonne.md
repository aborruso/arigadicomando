---
tags:
  - paste
  - qsv
  - unire
  - colonne
title: Come unire colonne di testo da file separati
hide:
#  - navigation
  - toc
---

# Come unire colonne di testo da file separati

## Usando paste

Immaginiamo di avere questi due file e di volerli unire in orizzontale, per avere un unico file composto da tre colonne (in questo caso i due file di input sono dei `CSV`).

```csv title="input_01"
a,1
d,7
c,2
```

```csv title="input_01"
2022
2024
1985
```

Esiste un'*utility* standard di Linux, [`paste`](../../utilities/#paste), che si utilizza proprio per casi di questo tipo.

Il comando da lanciare è

```bash
paste -d "," input_01 input_02 >output
```

che restituirà in output

```csv title="output"
a,1,2022
d,7,2024
c,2,1985
```

Con `-d ","` si restituisce a `paste` il fatto che il separatore di colonne del file di input è la `,`.

!!! warning

    `paste` non è `format aware`

## Usando qsv

A partire dagli stessi file di sopra, il comando per [`qsv`](../../utilities/#qsv) da usare è [`cat`](https://github.com/jqnatividad/qsv/blob/master/src/cmd/cat.rs#L7):

```bash
qsv cat columns input_01 input_02 >output
```

!!! note

    `qsv` è `format aware`
