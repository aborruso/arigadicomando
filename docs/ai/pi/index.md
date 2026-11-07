---
title: Pi
---

# Pi

[Pi](https://pi.dev/) è un agente di codifica da terminale, volutamente minimalista. Parte con soli quattro strumenti (`read`, `write`, `edit`, `bash`) e cresce con te: aggiungi solo quello che ti serve, senza ereditare funzionalità che non vuoi.

Non include sub-agent, plan mode o pop-up di conferma per impostazione predefinita. Puoi aggiungere tutto questo tramite estensioni, pacchetti della community, o semplicemente chiedendo a Pi di costruirseli da solo. Il supporto [MCP](mcp.md) invece è integrato dalla versione 0.99.0.

Questa guida è allineata alla versione 1.5.0 ed è divisa in più pagine:

- [Riga di comando](riga-di-comando.md): esecuzioni non interattive, pipeline, JSON, strumenti e sessioni
- [Modelli](modelli.md): scegliere provider e modello, impostare il predefinito, livello di ragionamento
- [Modalità interattiva](interattiva.md): editor, comandi, cronologia della sessione, esportazione
- [MCP](mcp.md): collegare server MCP e usare codemode
- [Personalizzazione](personalizzazione.md): file di contesto, prompt template, skill, estensioni e pacchetti

## Installazione

```bash
curl -fsSL https://pi.dev/install.sh | sh
```

Oppure via npm (richiede Node.js 22.19 o superiore):

```bash
npm install -g --ignore-scripts @earendil-works/pi-coding-agent
```

Sono disponibili anche un installer per Windows e un flake Nix:

```powershell
powershell -c "irm https://pi.dev/install.ps1 | iex"
```

```bash
nix profile add github:earendil-works/pi/stable
```

Per aggiornare Pi (con Nix si usa invece `nix profile upgrade pi`):

```bash
pi update
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

Per controllare da uno script se un provider è pronto, senza avviare una sessione:

```bash
pi auth check --provider anthropic
```

Stampa `ready`, `not_ready` o `invalid`, con exit code `0`, `1` o `2`.

## Primi passi

Avvia Pi nella cartella su cui vuoi lavorare:

```bash
cd /percorso/del/progetto
pi
```

Per una singola richiesta, senza interfaccia, usa `-p`:

```bash
git diff | pi -p "scrivi un messaggio di commit per queste modifiche"
```

## Sicurezza

Pi non chiede conferma prima di ogni chiamata a uno strumento e agisce con i permessi dell'utente che lo ha avviato. Per lavori non presidiati o su materiale non fidato, la documentazione consiglia un container o un'altra sandbox.

Quando una cartella contiene risorse di progetto, come impostazioni ed estensioni in `.pi/`, Pi può chiederti se ti fidi prima di caricarle. Con `/trust` salvi la decisione, con `-a` (`--approve`) e `-na` (`--no-approve`) la imposti per una sola esecuzione. Questa fiducia regola solo cosa viene caricato all'avvio, non limita quello che gli strumenti possono fare. Vedi la [documentazione sulla sicurezza](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/security.md).

## Novità delle ultime versioni

- **1.5.0** (2 novembre 2026): aggiornamento di Pi tramite comando personalizzato con `PI_SELF_UPDATE_COMMAND` o `selfUpdateCommand`, modello GPT-6.1 Terra
- **1.3.0** (15 ottobre 2026): con `sessionShareDestination` scegli dove `/share` carica la sessione
- **1.2.0** (12 ottobre 2026): con `$schema` in `settings.json` l'editor valida e completa la configurazione
- **1.1.0** (7 ottobre 2026): `--tools` accetta voci `+nome` e `-nome` che modificano la selezione predefinita
- **1.0.4** (5 ottobre 2026): pattern con `*` in `--tools` e `--exclude-tools`, nuovo flag `--no-mcp`
- **1.0.0** (1 ottobre 2026): interfaccia a schermo intero come impostazione predefinita
- **0.99.0** (29 settembre 2026): supporto MCP e codemode integrati, colori presi dalla palette del terminale, accesso con l'account ChatGPT tramite `/login openai`

L'elenco completo è nelle [release su GitHub](https://github.com/earendil-works/pi/releases). Dall'editor interattivo lo vedi con `/changelog`.
