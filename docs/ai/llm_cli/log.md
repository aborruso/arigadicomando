---
search:
  exclude: true
---

--8<-- "includes/lavori_in_corso.md"

# Database delle conversazioni

`llm` archivia tutto ciò che elabora in un database `SQLite`. Il file è quello che si ottiene lanciando il comando:

```bash
llm logs path
```

E in output si ottiene il percorso del file, che di solito è `/home/nome_utente/.config/io.datasette.llm/logs.db`.
