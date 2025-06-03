---
title: L'Intelligenza Artificiale a riga di comando
hide:
  - toc
---

--8<-- "includes/lavori_in_corso.md"

# L'Intelligenza Artificiale a riga di comando

Immagina di avere una "**calcolatrice per le parole**": uno strumento che, anziché fare operazioni matematiche, lavora direttamente sul linguaggio. Questo è ciò che rappresentano i modelli linguistici di grandi dimensioni (LLM) come ChatGPT. Sono sistemi progettati per manipolare, trasformare, riscrivere, sintetizzare e analizzare testi. E **cosa c'è di più testuale**, diretto e potente **della riga di comando**?

!!! tip
    Il riferimento alla "**calcolatrice per le parole**" viene da una delle letture più stimolanti e didattiche a tema: "*[Think of language models like ChatGPT as a “calculator for words”](https://simonwillison.net/2023/Apr/2/calculator-for-words/)*" dell'eccezionale Simon Willison.

La *shell* è da sempre il regno della manipolazione del testo. **Ogni comando, ogni output, ogni pipeline è un flusso di stringhe**. Usare gli LLM da riga di comando non è solo possibile: **è naturale**. Quando interagiamo con un LLM in questo contesto, sfruttiamo al massimo la sua natura testuale e la potenza del terminale.

Grazie agli LLM possiamo:

- Riformulare stringhe, messaggi, comandi
- Spiegare script o righe di codice complesso
- Generare documentazione a partire da contenuti testuali
- Estrarre informazioni da log, configurazioni, output di comandi
- Rispondere a domande su contenuti testuali locali (file, man page, ecc.)

Queste operazioni si integrano perfettamente con l'uso di pipe (`|`), redirezioni (`>`), comandi come `cat`, `grep`, `jq`, `awk`, e con strumenti di automazione e scripting.

!!! note "Nota"
    Il termine "**AI**" è generico, inflazionato e spesso usato in modo fuorviante. Qui, per la scelta degli strumenti e della modalità d'uso, è forse più appropriato parlare di **LLM** (**_Large Language Models_**), un sottoinsieme specifico dell'**intelligenza artificiale** focalizzato sulla comprensione e generazione del linguaggio naturale. Questo sarà pertanto il termine più usato in questa sezione.

## Cosa troverai in questa sezione

Saranno presentati strumenti con cui è comodo utilizzare gli LLM e l'AI a riga di comando. Ne sono disponibili decine e decine, ma qui ne troverai un ristretto numero scelti a cura della redazione. Se vuoi contribuire, o proporre altri apri una issue o una pull request su [GitHub](https://github.com/aborruso/arigadicomando).
