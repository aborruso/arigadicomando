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

## Permessi: consentire comandi senza conferma

Per impostazione predefinita, Claude Code chiede conferma prima di eseguire certi comandi. Puoi sbloccare quelli che usi spesso (ad esempio i comandi di lettura) in modo che vengano eseguiti automaticamente.

### Configurazione globale

Modifica (o crea) il file `~/.claude/settings.json` e aggiungi i comandi nella sezione `permissions.allow`:

```json
{
  "permissions": {
    "allow": [
      "Bash(ls:*)",
      "Bash(grep:*)",
      "Bash(wc:*)"
    ]
  }
}
```

Il pattern è `Bash(comando:*)` — il `*` significa "con qualsiasi argomento".

Se il file esiste già, puoi aggiungere le voci da terminale con `jq`:

```bash
jq '.permissions.allow += ["Bash(ls:*)", "Bash(grep:*)"]' ~/.claude/settings.json | sponge ~/.claude/settings.json
```

!!! note
    `sponge` fa parte del pacchetto `moreutils`. In alternativa, salva l'output su un file temporaneo e rinomina.

### Configurazione a livello di progetto

Puoi creare un file `.claude/settings.json` nella root del progetto con la stessa struttura:

```json
{
  "permissions": {
    "allow": [
      "Bash(ls:*)",
      "Bash(grep:*)"
    ]
  }
}
```

Vale solo per quel progetto e può essere committato nel repository, utile per condividere le impostazioni con il team.
