# Dalle Frasi agli Insight: `tokenize` + `vocab`

Se parti da testo libero, questa coppia è il motivo per cui `xan` sorprende:

- `tokenize` spezza il testo in token utili (parole, punteggiatura, ecc.);
- `vocab` trasforma quei token in metriche lessicali pronte da leggere.

Con pochi comandi passi da frasi grezze a segnali quantitativi come frequenze, importanza dei termini (TF-IDF) e relazione documento-termine.

## Provalo Subito

Usa il file di esempio: `docs/xan/risorse/testi-mini.csv`

```bash
# 1) tokenizzazione (un token per riga)
xan tokenize words testo -T tipo docs/xan/risorse/testi-mini.csv > /tmp/token.csv

# 2) fotografia del corpus
xan vocab corpus --doc id --token token --implode /tmp/token.csv

# 3) parole più informative del corpus
xan vocab token --doc id --token token --implode /tmp/token.csv

# 4) relazione documento-parola (tf, tfidf, bm25, ...)
xan vocab doc-token --doc id --token token --implode /tmp/token.csv
```

Output atteso (in sintesi):

- `vocab corpus`: quanti documenti hai, quanti token totali e distinti;
- `vocab token`: quali parole pesano davvero nel corpus;
- `vocab doc-token`: in quale documento ogni parola è più caratteristica.

Mini esempio reale (dal CSV demo, con tokenizzazione `--lower --drop punct`):

| token | gf | df | idf |
|---|---:|---:|---:|
| `più` | 4 | 3 | 0.5108 |
| `e` | 5 | 4 | 0.2231 |

In un colpo d'occhio:

- `gf` mostra quante volte appare una parola nel corpus;
- `df` in quanti documenti compare;
- `idf` aiuta a distinguere i termini più discriminanti da quelli molto comuni.
