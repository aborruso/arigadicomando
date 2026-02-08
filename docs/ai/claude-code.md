---
title: Claude Code da riga di comando
---

# Claude Code da riga di comando

[Claude Code](https://claude.com/product/claude-code) è un assistente per lavorare con file, codice e testi direttamente dal terminale. Qui trovi i comandi essenziali per usarlo in modo veloce quando ti serve “ricordare come si fa”.

## Come si lancia

```bash
claude
```

## Riprendi l'ultima sessione

```bash
claude -c
```

## Scegli una conversazione recente

```bash
claude -r
```

Mostra un picker con le sessioni recenti: puoi scegliere quella che ti interessa dalla lista.

```text
  [Request interrupted by user for tool use]
  23 minutes ago · main · 1.5 MB

  [Request interrupted by user for tool use]
  50 minutes ago · main · 1.1 MB

  guarda gli aggiornamenti di oggi al codice, e aggiornara docs/evaluation-v1.2.13.md
  17 hours ago · main · 924.5 KB
```

Puoi anche riprendere direttamente una sessione per ID o nome:

```bash
claude -r "auth-refactor" "Completa questa PR"
```

## Esegui un prompt e esci

```bash
claude -p "analizza questo codice"
```

## Output JSON per script

Utile per automazioni e pipeline.

```bash
claude -p --output-format json "trova tutti i file CSV"
```

Per specificare un modello diverso:

```bash
claude -p --model sonnet --output-format json "trova tutti i file CSV"
```

## Altri parametri utili

```bash
# Aggiungi directory di lavoro extra
claude --add-dir ../apps ../lib

# Aggiungi istruzioni al prompt di sistema
claude --append-system-prompt "Usa sempre TypeScript"

# Aggiungi istruzioni al prompt di sistema da file
claude --append-system-prompt-file prompt.md

# Sostituisci il prompt di sistema
claude --system-prompt "Sei un esperto Python"

# Sostituisci il prompt di sistema da file
claude --system-prompt-file system.md

# Limita gli strumenti disponibili
claude --tools "Bash,Edit,Read"

# Log verboso
claude --verbose

# Output streaming JSON
claude -p --output-format stream-json "analizza questi log"

# Output streaming JSON includendo i messaggi parziali
claude -p --output-format stream-json --include-partial-messages "analizza questi log"

# Usa un agente specifico
claude --agent planner

# Elenca gli agenti disponibili
claude --agents

# Aggiorna Claude Code
claude update
```

## Processa input da pipe

```bash
cat errors.log | claude -p "analizza questi errori"
```

Esempio minimale:

```bash
cat logs.txt | claude -p "explain"
```
