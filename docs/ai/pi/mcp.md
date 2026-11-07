---
title: MCP
---

# MCP in Pi

Dalla versione 0.99.0 Pi si collega ai server [MCP](https://modelcontextprotocol.io) senza estensioni aggiuntive, sia locali (stdio) sia remoti (HTTP). Il vecchio trasporto SSE non è supportato.

## Aggiungere un server

```bash
# Server locale
pi mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem .

# Server remoto
pi mcp add docs --url https://example.com/mcp --bearer-token-env-var DOCS_TOKEN

# Stato dei server configurati
pi mcp list

# Rimuovere un server
pi mcp remove docs
```

`pi mcp list` si collega a ogni server attivo e mostra stato, strumenti ed errori. Termina con exit code 1 se un server non è collegato, quindi si può usare anche negli script. Per i server con OAuth c'è `pi mcp login <server>`.

## Dove sta la configurazione

I server finiscono in `~/.pi/agent/mcp.json`, oppure in `.pi/mcp.json` se aggiungi `-l` per limitarli al progetto. La configurazione di progetto viene letta solo dopo che hai dato fiducia alla cartella.

Il formato è lo stesso degli altri client MCP:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    },
    "docs": {
      "url": "https://example.com/mcp",
      "headers": { "Authorization": "Bearer ${DOCS_TOKEN}" },
      "description": "Cerca e legge la documentazione del prodotto"
    }
  }
}
```

Da Claude Desktop, Claude Code o Cursor basta copiare la voce esistente sotto `mcpServers`. Per VS Code, Codex e OpenCode serve una piccola conversione, descritta nella [documentazione MCP](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/mcp.md).

Dopo una modifica fatta fuori dalla sessione, ricarica con `/reload`.

## Gestire i server dall'editor

Nell'editor interattivo `/mcp` elenca i server con stato, numero di strumenti ed esposizione. Da lì puoi fare il login, riconnettere, attivare o disattivare un server, anche solo per il progetto corrente.

Con `--no-mcp` disattivi il supporto MCP per una singola esecuzione. Gli errori dei server vengono registrati in `~/.pi/agent/mcp.log`.

## Come il modello raggiunge gli strumenti

Ogni strumento si chiama `mcp__<server>__<strumento>`. L'impostazione `exposure` del server decide come il modello ci arriva:

| Esposizione | Comportamento | Quando usarla |
|---|---|---|
| `codemode` (predefinita) | Chiamabile dagli script di codemode, ma non dichiarato al modello | Server generici, quando serve combinare o filtrare le chiamate |
| `deferred` | Dichiarato solo dopo che `tool_search` lo trova | Server grandi i cui strumenti vanno chiamati direttamente |
| `direct` | Dichiarato al modello come uno strumento integrato | Pochi strumenti di uso frequente |
| `hidden` | Registrato ma non raggiungibile | Strumenti da tenere fuori uso |

Con `toolExposure` si cambia l'esposizione di singoli strumenti, anche con pattern:

```json
{
  "mcpServers": {
    "github": {
      "url": "https://api.githubcopilot.com/mcp/",
      "exposure": "deferred",
      "toolExposure": {
        "search_code": "direct",
        "get_*": "codemode",
        "delete_*": "hidden"
      }
    }
  }
}
```

Per limitare una singola esecuzione agli strumenti di un solo server:

```bash
pi --tools read,codemode,'mcp__docs__*'
```

## Codemode

`codemode` è uno strumento che permette al modello di scrivere un piccolo script JavaScript che chiama gli altri strumenti, anche in parallelo. Al modello arriva solo l'output dello script, quindi un risultato grande può essere filtrato prima di consumare contesto.

Lo script gira in una sandbox QuickJS senza API di Node, file system, rete o timer: esce all'esterno solo attraverso gli strumenti e i modelli che ha a disposizione. Gli strumenti che chiama, però, conservano i loro permessi.

Si attiva da solo quando si collega un server con esposizione `codemode`. Per impedirlo, imposta `"autoEnableCodemode": false` in `mcp.json`, accanto a `mcpServers`. Per usarlo anche senza server MCP:

```bash
pi --tools +codemode
```

Oppure, in modo permanente, in `settings.json`:

```json
{
  "defaultTools": ["+codemode"]
}
```

Vedi la [documentazione di codemode](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/codemode.md).
