---
title: skills.sh
hide:
  - toc
---

# skills.sh

[skills.sh](https://skills.sh/) (di Vercel) è una CLI per installare e gestire skill su tutti i tool AI CLI che usi, ad esempio Claude Code, OpenCode, Codex, Cursor e altri.

Documentazione ufficiale: <https://skills.sh/docs>

## Installare una skill da un repository

Esempio:

```bash
npx skills add ondata/skills --skill openalex
```

## Installare una skill da una cartella locale

Esempio:

```bash
npx skills add ./skills/ondata-discussions
```

## Durante l'installazione

In modalità interattiva, durante l'installazione puoi scegliere:

1. su quale tool installare la skill (per esempio Claude Code, OpenCode, Codex);
2. se installarla come skill di progetto (default) o globale/locale utente (`-g`).
