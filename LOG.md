# LOG

## 2026-11-07

- Aggiunta in `docs/ai/pi/index.md` la sezione sul modello predefinito: `/model`, impostazioni globali e di progetto, override CLI e ripristino delle sessioni.
- Allineata la guida Pi alla 1.5.0, verificando su repo, help e prove dirette: MCP integrato dalla 0.99.0, `--provider` richiede `--model`, nomi dei file di contesto in maiuscolo, `~/.claude/` non letta in automatico.
- Divisa `docs/ai/pi/index.md` in sottopagine: `riga-di-comando`, `modelli`, `interattiva`, `mcp`. File di contesto spostati in `personalizzazione`. Non documentato `pi auth login`: nel changelog è ancora in Unreleased.

## 2026-05-03

- Aggiunta pagina `ai/claude-code/file-di-base.md`: panoramica dei file di configurazione di Claude Code (CLAUDE.md, CLAUDE.local.md, mcp.json, settings.json, rules/, commands, skills, hooks)

## 2026-03-07

- Aggiunta subpage `ai/claude-code/docker-mcp-wsl2.md`: guida per usare Docker MCP Toolkit da WSL2 con Claude Code, con intro sul valore di Docker come hub centralizzato per i server MCP

## 2026-02-21

- Aggiunta pagina tematica `xan/qualita-dati.md`: verificare la qualità di un CSV (stats, celle vuote, valori fuori range, tipo errato, regex, duplicati)
- Aggiunta pagina tematica `xan/from.md`: importare dati in xan da Excel, JSON, NDJSON, testo e Markdown
- Aggiunta pagina tematica `xan/flatten.md`: spiega `xan flatten` con tutte le opzioni principali, inclusa `-N/--non-empty` (novità 0.56.0) per dati sparsi
- Aggiunta pagina tematica `xan/bisect.md`: ricerca binaria su CSV ordinati, esempi di ricerca esatta, prefisso, range e ordinamento numerico
- Aggiunta pagina tematica `xan/funzioni-fonetiche.md`: soundex, refined_soundex, phonogram in Moonblade per trovare nomi simili per suono e deduplicare anagrafiche
- Aggiunti file di esempio in `docs/xan/risorse/`
- Aggiornata navigazione `mkdocs.yml`
