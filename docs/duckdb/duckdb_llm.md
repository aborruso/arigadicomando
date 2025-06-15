---
search:
  exclude: true
---

# DuckDB e il dialogo con un LLM

## Motherduck

## Open Prompt Extension

È un'estensione per DuckDB che permette di dialogare con un LLM (Large Language Model): <https://github.com/quackscience/duckdb-extension-openprompt>

Si deve prima installare poi caricare. Lanciata la `cli` quindi:

```bash
INSTALL open_prompt FROM community;
LOAD open_prompt;
```

Una volta caricata, si possono settare le variabili per le API che si vogliono usare. Sotto l'esempio d'uso di quelle di [Groq](https://groq.com/):

```bash
SET VARIABLE openprompt_api_url = 'https://api.groq.com/openai/v1/chat/completions';
SET VARIABLE openprompt_api_token = 'xxxxxxxx';
SET VARIABLE openprompt_model_name = 'llama-3.3-70b-versatile';
```

E poi si può ad esempio fare una query come questa:

```sql
SELECT open_prompt('Il titolo di un romanzo con una papera come protagonista') AS response;
```

```
┌───────────────────────────────┐
│           response            │
│            varchar            │
├───────────────────────────────┤
│ "La papera dalle piume d'oro" │
└───────────────────────────────┘
```

E si può combinare il `prompt` con un (o più) campo di una tabella:

```sql
SELECT 'Palermo,Sicilia' AS citta, open_prompt('Estrai soltanto il nome della nazione, senza aggiungere altro. In lingua tedesca: ' || citta) AS nazione;
```

```
┌─────────────────┬─────────┐
│      citta      │ nazione │
│     varchar     │ varchar │
├─────────────────┼─────────┤
│ Palermo,Sicilia │ Italien │
└─────────────────┴─────────┘
```

## FlockMTL

Estensione di DuckDB per combinare l'analisi analitica e l'analisi semantica utilizzando modelli linguistici: <https://github.com/dsg-polymtl/flockmtl>
