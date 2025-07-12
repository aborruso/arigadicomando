---
title: MarkItDown
hide:
  - toc
---

# MarkItDown

[MarkItDown](https://github.com/microsoft/markitdown) è una utility a riga di comando sviluppata da Microsoft per convertire file Markdown in HTML, PDF e altri formati, con supporto avanzato per la formattazione e l'integrazione di contenuti multimediali.

E visto che per gli `LLM` il testo piano è il formato di input base, è prezioso e propedeutico poter convertire un PDF, un file Word, un Power Point, ecc. in testo piano `markdown` per poterlo poi processare con gli `LLM`.

## Installazione

MarkItDown si installa come tool Python. Puoi scegliere tra installazione diretta o ambiente isolato:

=== "comando | pip (tutto incluso)"
    ```bash
    pip install 'markitdown[all]'
    ```

=== "comando | uv tool (ambiente isolato)"
    ```bash
    uv tool install 'markitdown[all]'
    ```

## Esempi di utilizzo

Per convertire un file PDF in `markdown`:


```bash
markitdown path-to-file.pdf > document.md
```

Per convertire una pagina web in `markdown`:

```bash
markitdown https://example.com > page.md
```
