---
tags:
  - paste
  - unire
  - colonne
title: Come unire colonne di testo da file separati
hide:
#  - navigation
  - toc
---

# Come unire colonne di testo da file separati

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
paste -d "," input_01 input_01>output
```

che restituirà in output

```csv title="output"
a,1,2022
d,7,2024
c,2,1985
```

Con `-d ","` si restituisce a `paste` il fatto che il separatore di colonne del file di input è la `,`.
