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

## Elenca le conversazioni recenti

```bash
claude -r
```

L'output mostra le sessioni recenti: puoi scegliere quella che ti interessa dalla lista.

```text
  [Request interrupted by user for tool use]
  23 minutes ago · main · 1.5 MB

  [Request interrupted by user for tool use]
  50 minutes ago · main · 1.1 MB

  guarda gli aggiornamenti di oggi al codice, e aggiornara docs/evaluation-v1.2.13.md
  17 hours ago · main · 924.5 KB
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

## Processa input da pipe

```bash
cat errors.log | claude -p "analizza questi errori"
```

Esempio minimale:

```bash
cat logs.txt | claude -p "explain"
```
