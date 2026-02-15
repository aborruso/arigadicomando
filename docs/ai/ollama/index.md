---
title: Ollama
---

# Ollama

[Ollama](https://ollama.com/) è uno strumento per eseguire modelli LLM in locale, direttamente da terminale.

In questa pagina trovi il minimo essenziale per iniziare su Linux:

1. installazione;
2. aggiunta di un modello;
3. primo utilizzo.

## Installazione (Linux)

Per installare Ollama:

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

Verifica che sia installato:

```bash
ollama --version
```

Su distribuzioni Linux con `systemd`, il servizio parte in automatico. In caso contrario, puoi avviarlo manualmente:

```bash
ollama serve
```

## Aggiungere un modello

Esempio con un modello piccolo e open di Microsoft: [`phi3:mini`](https://ollama.com/library/phi3).

```bash
ollama pull phi3:mini
```

Per vedere i modelli scaricati:

```bash
ollama list
```

## Usarlo

Prompt singolo:

```bash
ollama run phi3:mini "Spiega in modo semplice cos'è una pipe in Linux"
```

Sessione interattiva:

```bash
ollama run phi3:mini
```

Invio di un file via pipe:

```bash
cat appunti.txt | ollama run phi3:mini "Riassumi il testo in 5 punti"
```

Per uscire dalla sessione interattiva, usa `/bye`.

## Lanciare una coding CLI (Claude Code o OpenCode)

Con `ollama launch` puoi configurare e avviare tool come Claude Code e OpenCode usando un modello locale oppure un modello cloud gestito da Ollama.

### 1) Verifica versione

Serve Ollama `v0.15+`:

```bash
ollama --version
```

### 2) Scegli e scarica un modello

Modello locale (esempio):

```bash
ollama pull glm-4.7-flash
```

Modello cloud gestito da Ollama (esempio):

```bash
ollama pull glm-4.7:cloud
```

### 3) Avvia la CLI

Per Claude Code con modello cloud:

```bash
ollama launch claude --model minimax-m2.5:cloud
```

Per Claude Code con modello locale:

```bash
ollama launch claude --model glm-4.7-flash
```

Per OpenCode con modello cloud:

```bash
ollama launch opencode --model minimax-m2.5:cloud
```

Per OpenCode con modello locale:

```bash
ollama launch opencode --model glm-4.7-flash
```

Se non specifichi `--model`, il comando è interattivo e ti fa scegliere il modello (locale o cloud), senza dover impostare variabili d'ambiente o file di configurazione manuali.

Se vuoi solo configurare, senza avviare subito il tool:

```bash
ollama launch opencode --model minimax-m2.5:cloud --config
```

!!! note "Nota pratica"
    Per sessioni di coding lunghe, Ollama consiglia modelli con contesto ampio (almeno `64000` token) e, se necessario, di usare i modelli cloud.
