---
search:
  exclude: true
---

# Interpreter

## Come lanciarlo

Qui sotto un esempio che sfrutta le API di [Groq](https://groq.com/) e il modello `llama-3.3-70b-versatile`:

```
interpreter -ab "https://api.groq.com/openai/v1" -ak "xxxx" --model "llama-3.3-70b-versatile" --context_window 128000 --groq
```

- `-ab` e `-ak` sono URL e API key delle API di Groq.
- `--model` è il modello che si vuole usare.
