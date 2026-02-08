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

## Esegui un prompt e esci

```bash
claude -p "analizza questo codice"
```

## Output JSON per script

Utile per automazioni e pipeline.

```bash
claude -p --output-format json "trova tutti i file CSV"
```

## Processa input da pipe

```bash
cat errors.log | claude -p "analizza questi errori"
```
