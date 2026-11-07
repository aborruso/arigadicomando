---
title: Modelli
---

# Modelli in Pi

## Scegliere modello e provider

```bash
pi -p "riassumi" --provider anthropic --model claude-sonnet-5-5
pi -p "riassumi" --provider openai --model gpt-6.1-sol
pi -p "riassumi" --provider deepseek --model deepseek-v4-pro
```

`--provider` richiede sempre `--model`: da solo termina con un errore. In alternativa puoi indicare il provider dentro il modello, e `--model` accetta anche una ricerca approssimata e il livello di ragionamento dopo i due punti:

```bash
pi -p "riassumi" --model openai/gpt-6.1-sol
pi -p "riassumi" --model sonnet:high
```

Oppure passando direttamente la chiave API, anche in questo caso indicando il modello:

```bash
pi -p "riassumi" --api-key sk-... --provider anthropic --model claude-sonnet-5-5
```

Per elencare i modelli disponibili:

```bash
pi --list-models
pi --list-models gemini
```

Il [catalogo dei modelli](https://pi.dev/models) riporta provider, ID, limiti di contesto e prezzi. Per aggiornare quello locale usa `pi update --models`.

## Impostare il modello predefinito

Il modo più semplice è avviare Pi, aprire il selettore con `/model` e premere `Ctrl+S` sul modello scelto: diventa il predefinito per le nuove sessioni.

Puoi anche modificare direttamente `~/.pi/agent/settings.json`, aggiungendo o aggiornando questi due campi senza eliminare le altre impostazioni:

```json
{
  "defaultProvider": "anthropic",
  "defaultModel": "claude-sonnet-5-5"
}
```

- `defaultProvider` identifica il provider.
- `defaultModel` è l'ID del modello: usa `pi --list-models` per trovare quelli disponibili. Il provider deve essere già autenticato.

Per usare un modello predefinito **solo in un progetto**, inserisci gli stessi campi nel file `.pi/settings.json` nella directory del progetto: queste impostazioni hanno precedenza su quelle globali. Pi può chiederti se ti fidi della cartella: le risorse di progetto, compreso questo file, vengono caricate solo dopo il consenso.

Per scegliere invece un modello **solo per un'esecuzione**, senza modificare il predefinito, passa i flag dalla riga di comando:

```bash
pi --provider openai --model gpt-6.1-sol
```

I flag hanno precedenza sulle impostazioni nei file. Se riprendi una sessione esistente, Pi ripristina il modello e il livello di ragionamento della sessione: il predefinito riguarda le nuove sessioni.

Vedi anche la [documentazione delle impostazioni](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/settings.md).

## Livello di ragionamento

I livelli sono `off`, `minimal`, `low`, `medium`, `high`, `xhigh` e `max`. Pi li limita a quelli supportati dal modello.

```bash
pi --thinking high "risolvi questo problema"
```

`--thinking` ha precedenza sul suffisso indicato in `--model`. Nell'editor interattivo usa `/thinking`, dove `Ctrl+S` salva il livello per i prossimi avvii, oppure `Shift+Tab` per scorrerli. Il valore predefinito si imposta con `defaultThinkingLevel` in `settings.json`.

## Modelli preferiti

Per limitare i modelli tra cui si passa con `Ctrl+P`:

```bash
pi --models claude-sonnet,claude-haiku,gpt-6.1-sol
pi --models "github-copilot/*"
pi --models sonnet:high,haiku:low
```

Nell'editor interattivo la stessa scelta si fa con `/scoped-models`.

## Modelli locali

Pi si integra con il router di llama.cpp, che si gestisce con il comando `/llama`. Per Ollama, LM Studio e altri server compatibili si aggiunge l'endpoint in `~/.pi/agent/models.json`. Vedi la [documentazione dei modelli](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/models.md).
