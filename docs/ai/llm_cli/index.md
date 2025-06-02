---
title: LLM CLI
---

# Introduzione

**LLM** è un'*utility* a riga di comando e una libreria Python per interagire con modelli di linguaggio di grandi dimensioni (LLM) come quelli di OpenAI, Anthropic, Google, Meta e tanti altri, compresi quelli installati in locale.

È scritta in `Python` da quel genio di [Simon Willison](https://simonwillison.net/), il creatore di [Datasette](https://datasette.io/).

La [guida ufficiale](https://llm.datasette.io/en/stable/) è scritta molto bene e questa non vuole essere una sua traduzione, ma una raccolta di appunti e suggerimenti per utilizzarla.

## Installazione

È una libreria Python, quindi si può installare con `pip`:

```bash
pip install llm
```

È molto comodo usare [`uv`](https://github.com/astral-sh/uv) per installare librerie e CLI Python:

```bash
uv tool install llm
```

## Primo utilizzo

Se si vuole utilizzare ad esempio con le API di OpenAI, bisogna recuperare una *API Key* da [OpenAI](https://platform.openai.com/api-keys), aprire la shell e impostarla per `llm` con il comando:

```bash
llm keys set openai
```

Dopo aver impostato la *API Key*, si può iniziare a chattare con il modello di linguaggio:

```bash
llm 'Crea 5 nomi per un ristorante italiano'
```

E in output si otterrà qualcosa del genere (notare che il testo è in formato Markdown):

```text {.wordwrap-code }}
Ecco 5 nomi per un ristorante italiano, con un piccolo commento su ognuno:

1.  **Trattoria della Nonna Emilia:** (Tradizione, familiarità, un nome di una nonna immaginaria evoca calore e autenticità). Perfetto per un ristorante con cucina tradizionale e casalinga.
2.  **Il Giardino Segreto:** (Romantico, misterioso, evoca un'atmosfera intima e speciale). Ottimo per un ristorante con un bel giardino o un'attenzione particolare all'ambiente.
3.  **Aromi di Sicilia:** (Geografico, specifico, focalizza l'attenzione su una regione ricca di sapori). Ideale se il ristorante si specializza in cucina siciliana.
4.  **Via Veneto Ristorante:** (Classico, elegante, riferimento a una strada iconica italiana). Adatto per un ristorante che punta a un'esperienza culinaria di lusso e raffinatezza.
5.  **Pasta e Passione:** (Semplice, diretto, esprime i due elementi fondamentali della cucina italiana). Un nome memorabile e accattivante, adatto a un ristorante con un focus sulla pasta fresca e fatta in casa.
```

Per utilizzare `llm` in modo più interattivo, si può avviare una sessione di chat:

```bash
llm chat
```

👉 Per approfondire l'utilizzo di `llm`, c'è una [**sezione dedicata**](utilizzo.md).


## Aggiornamento

Si può fare in diversi modi. Quello generico è:

```bash
llm install -U llm
```


## Plugin

Esistono [diversi **plugin** per `llm`](https://llm.datasette.io/en/stable/plugins/index.html#plugins). Con questi è possibile **aggiungere altri modelli** di `LLM` con cui interagire e/o attivare **funzionalità aggiuntive**.

### Installazione

```bash
llm install nome_plugin
```

### Aggiornamento plugin

```bash
llm install nome_plugin --upgrade
```

## Configurazione

### Salvataggio e utilizzo delle API Key

```bash
llm keys set nome_provider
```

Ad esempio per openai sarà:

```bash
llm keys set openai
```

Il file con la lista delle *Key* si ricava in questo modo:

```bash
llm keys path
```

La lista delle *Key* invece si ottiene con:

```bash
llm keys
```

### Lista dei modelli

```bash
llm models list
```

### Impostare un modello di default

```bash
llm models default nome_modello
```
