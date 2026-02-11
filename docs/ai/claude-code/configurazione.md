---
title: Configurazione Claude Code
---

# Configurazione Claude Code

Qui troverai note utili sulla configurazione di Claude Code.

## Server MCP globali

I server MCP (Model Context Protocol) globali si configurano, aggiungono e cancellano nel file:

```bash
~/.claude.json
```

Questo file contiene la configurazione di tutti i server MCP disponibili per Claude Code a livello di sistema.

### Aggiunta globale da riga di comando

Per aggiungere un server MCP globale (scope utente), puoi usare:

```bash
claude mcp add -s user -t http mospi-statistics https://mcp.mospi.gov.in
```

In questo esempio, `-s user` indica che il server viene aggiunto alla configurazione globale dell'utente.
