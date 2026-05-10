---
title: Pi
---

# Pi

[Pi](https://pi.dev/) è un agente di codifica da terminale, volutamente minimalista. Parte con soli quattro strumenti (`read`, `write`, `edit`, `bash`) e cresce con te: aggiungi solo quello che ti serve, senza ereditare funzionalità che non vuoi.

Non include MCP, sub-agent, plan mode o pop-up di conferma per impostazione predefinita. Puoi aggiungere tutto questo tramite estensioni, pacchetti della community, o semplicemente chiedendo a Pi di costruirseli da solo.

## Installazione

```bash
curl -fsSL https://pi.dev/install.sh | sh
```

Oppure via npm:

```bash
npm install -g @earendil-works/pi-coding-agent
```

## Autenticazione

Con una chiave API:

```bash
export ANTHROPIC_API_KEY=sk-ant-...
pi
```

Con una sottoscrizione esistente (Anthropic Claude Pro/Max, ChatGPT Plus/Pro, GitHub Copilot):

```bash
pi
/login
```

Supporta anche API key di OpenAI, DeepSeek, Google Gemini, HuggingFace, OpenRouter e molti altri. Vedi [docs/providers.md](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/providers.md) per la lista completa.

## Modalità non interattiva (`-p`)

La modalità più utile per pipeline e script: esegue il prompt e restituisce la risposta su stdout.

```bash
pi -p "spiega questo errore: segmentation fault"
```

Legge da stdin e unisce l'input al prompt:

```bash
cat errori.log | pi -p "analizza questi errori e suggerisci le cause"
```

```bash
git diff | pi -p "scrivi un messaggio di commit per queste modifiche"
```

```bash
cat dati.csv | pi -p "descrivi la struttura di questo CSV"
```

## Output JSON

Utile per automazioni: restituisce tutti gli eventi come JSON lines.

```bash
pi --mode json -p "analizza questo file" < report.txt
```

## Scegliere modello e provider

```bash
pi -p "riassumi" --provider anthropic --model claude-sonnet-4-5
pi -p "riassumi" --provider openai --model gpt-4o
pi -p "riassumi" --provider deepseek
```

Oppure passando direttamente la chiave API:

```bash
pi -p "riassumi" --api-key sk-... --provider anthropic
```

Per elencare i modelli disponibili:

```bash
pi --list-models
pi --list-models gemini
```

## Limitare gli strumenti

Per esecuzioni solo-lettura o controllate:

```bash
# Solo lettura
pi -p "analizza il codice" --tools read,grep,find

# Senza strumenti
pi -p "rispondi a questa domanda" --no-tools
```

## Sessioni

Riprendi l'ultima sessione:

```bash
pi -c
```

Avvia in modalità effimera (senza salvare):

```bash
pi --no-session
```

## Modalità interattiva

```bash
pi
```

Avvia la TUI con editor, footer con costo e token, selezione modello e navigazione della cronologia.

### Comandi bash nell'editor

Dall'editor interattivo puoi eseguire comandi shell direttamente:

```text
!ls -la
```

Il risultato entra nella conversazione: il modello lo vede e può usarlo come contesto.

```text
!!ls -la
```

Con il doppio `!!` il comando viene eseguito ma **non** entra nella conversazione. Utile per operazioni di servizio che non vuoi intasare il contesto.

### Cambiare modello al volo

- `/model` — apre il selettore di tutti i modelli disponibili
- `/scoped-models` — imposta i modelli preferiti
- `Ctrl+P` — cicla rapidamente tra i preferiti
- `Shift+Tab` — cambia il livello di ragionamento (`off`, `minimal`, `low`, `medium`, `high`, `xhigh`)

### Navigare la cronologia della sessione

`/tree` mostra tutti i messaggi della sessione e permette di tornare a un punto precedente e ripartire da lì — utile quando una risposta ha preso la direzione sbagliata.

```text
/fork    # duplica la sessione da un messaggio precedente
/clone   # duplica il ramo corrente in una nuova sessione
```

Le sessioni vengono salvate in formato JSONL in `~/.pi/agent/sessions/`, organizzate per directory di lavoro.

### Esportare una sessione

```text
/export
```

Genera un file HTML con interfaccia navigabile per leggere la sessione, filtrare per tipo di messaggio (tool, user, assistant) e scaricare il JSON grezzo.

### Gestire il contesto

```text
/compact
/compact "concentrati sulle API di autenticazione"
```

Compatta la conversazione quando si avvicina al limite del contesto. Si possono aggiungere istruzioni personalizzate per guidare la compattazione.

## Compatibilità con `claude.md` e `agents.md`

Pi legge automaticamente i file di contesto dalla directory corrente e da home:

- `agents.md` — standard condiviso tra agenti
- `claude.md` — letto da Pi esattamente come da Claude Code

Se usi già Claude Code con un `claude.md` nel progetto o in home, Pi lo caricherà automaticamente. Vale la pena tenerne conto quando si aggiungono istruzioni globali in `~/.claude/claude.md`.

## Personalizzazione

Pi si estende tramite **prompt template**, **skill** ed **estensioni**, componibili in pacchetti. Vedi la pagina [Personalizzazione](personalizzazione.md) per esempi pratici su come crearli e usarli.
