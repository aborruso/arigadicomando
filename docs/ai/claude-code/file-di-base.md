---
title: File di base di Claude Code
---

# File di base di Claude Code

Claude Code usa un insieme di file di testo per capire il contesto, gestire le connessioni e controllare i permessi. Molti di questi file esistono in due versioni: una **globale** (vale per tutti i progetti) e una **di progetto** (specifica del repository). Le note qui sotto si concentrano sull'uso a progetto, ma dove esiste un equivalente globale viene indicato.

## CLAUDE.md

È il file principale. Nella versione di progetto contiene l'architettura, la struttura delle cartelle e le best practice adottate — viene salvato nel repository e condiviso con tutto il team.

Claude lo legge automaticamente all'avvio di ogni sessione.

```
~/.claude/CLAUDE.md         # globale, vale per tutti i progetti
progetto/CLAUDE.md          # specifico del progetto, condiviso col team
progetto/.claude/CLAUDE.md  # alternativa equivalente alla riga sopra
```

## CLAUDE.local.md

Ha la stessa funzione di `CLAUDE.md`, ma è personale. Contiene note locali, percorsi specifici della tua macchina, preferenze individuali. Claude lo legge automaticamente se presente, ma **non** è ignorato da git in automatico: devi aggiungerlo tu al `.gitignore`. In alternativa, esegui `/init` e scegli l'opzione "personal": Claude Code lo aggiunge al `.gitignore` per te.

```
progetto/
├── CLAUDE.md          # condiviso
└── CLAUDE.local.md    # personale, ignorato da git
```

## Configurazione MCP

I server MCP (Model Context Protocol) si configurano in due posti:

```bash
~/.claude.json          # globale — vale per tutti i progetti
progetto/.mcp.json      # di progetto — si può committare nel repo
```

Il file `.mcp.json` nella root del progetto permette di condividere le connessioni MCP con il team. Il file globale `~/.claude.json` contiene anche preferenze, cache e dati di sessione di Claude Code.

## settings.json

Definisce i permessi: cosa Claude è autorizzato a fare. Puoi permettergli di eseguire i test, ma bloccargli l'accesso al file `.env`.

```bash
.claude/settings.json       # a livello di progetto
~/.claude/settings.json     # globale
```

Esempio:

```json
{
  "permissions": {
    "allow": ["Bash(pytest:*)"],
    "deny": ["Bash(cat:.env)"]
  }
}
```

## Cartella rules/

Quando `CLAUDE.md` diventa troppo grande, puoi spezzarlo in file separati dentro una cartella `rules/`. Ogni file si occupa di un aspetto specifico: stile del codice, convenzioni di test, regole di commit. Non serve referenziarli in `CLAUDE.md`: Claude carica automaticamente tutti i file `.md` presenti in `.claude/rules/` all'avvio della sessione.

```
.claude/
└── rules/
    ├── coding-style.md
    └── testing.md
```

## Commands e skills

Sono due meccanismi simili che spesso si confondono.

I **commands** sono file markdown singoli con un prompt: li invochi manualmente con `/nome`. Utili per workflow ripetitivi come `/review` o `/deploy`.

Le **skills** usano lo stesso meccanismo, ma sono più flessibili: puoi invocarle tu con `/nome`, oppure Claude le carica automaticamente quando riconosce che sono rilevanti per il task in corso. Ogni skill ha una descrizione che Claude legge all'avvio per decidere se usarla.

| | Commands | Skills |
|---|---|---|
| **Invocazione manuale** | ✓ | ✓ |
| **Auto-invocazione da Claude** | — | ✓ |
| **Struttura** | File singolo | Cartella con `SKILL.md` |

## Hooks

Gli hook eseguono script in risposta a eventi di Claude Code. Permettono di automatizzare controlli o bloccare azioni rischiose.

Esempi di utilizzo:

- Eseguire i test unitari ogni volta che il codice cambia
- Bloccare un comando pericoloso prima che venga eseguito
- Formattare automaticamente un file dopo ogni modifica

Si configurano in `settings.json` sotto la chiave `hooks`.
