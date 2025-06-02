# Utilizzo

Il modello di default è `gpt-4o-mini` e quindi per il primo utilizzo di `llm` è necessario impostare un'[API Key per OpenAI](https://llm.datasette.io/en/stable/setup.html#api-keys), con il comando:

```bash
llm keys set openai
```

!!! note "Nota"
    Non è obbligatorio usare `gpt-4o-mini` come modello di default, ma è consigliato per iniziare, perché in linea con la documentazione e le guide di `llm`.

## Lanciare un prompt

Un **prompt** è una richiesta, un messaggio, che si invia a un modello LLM per ottenere una risposta. È il modo per "comunicare" con l'intelligenza artificiale.

Per lanciarlo basta scriverlo nella shell, dopo `llm`, come in questo esempio:

```bash
llm "Crea 5 nomi per un ristorante italiano"
```

!!! note "Guida al Prompt Engineering"

    Il *Prompt engineering* è una disciplina relativamente nuova che consente di sviluppare e ottimizzare i prompt per utilizzare in modo efficiente i modelli linguistici (LM) per un'ampia varietà di applicazioni e argomenti di ricerca. Per approfondire puoi iniziare da [**questa guida dedicata**](https://www.promptingguide.ai/it).

Se vuoi usare un altro modello, prima guarda la lista dei modelli disponibili sulla tua macchina con `llm models list`. Avrai in *output* una lista come questa:

```text {.wordwrap-code}
Available models:
Anthropic Messages: anthropic/claude-3-7-sonnet-latest (aliases: claude-3.7-sonnet, claude-3.7-sonnet-latest)
Anthropic Messages: anthropic/claude-3-haiku-20240307 (aliases: claude-3-haiku)
GeminiPro: gemini-2.0-flash-thinking-exp-01-21
gpt4all: all-MiniLM-L6-v2-f16 - SBert, 43.76MB download, needs 1GB RAM
gpt4all: qwen2-1_5b-instruct-q4_0 - Qwen2-1.5B-Instruct, 894.10MB download, needs 3GB RAM
LLMGroq: groq/meta-llama/llama-4-scout-17b-16e-instruct
LLMGroq: groq/whisper-large-v3
OpenAI Chat: gpt-4.1 (aliases: 4.1)
Perplexity: r1-1776
Perplexity: sonar-reasoning-pro
```

Se vuoi usare ad esempio `gemini-2.0-flash-thinking-exp-01-21`, puoi farlo l'opzione `-m` seguito dal nome del modello:

```bash {.wordwrap-code}
llm -m gemini-2.0-flash-thinking-exp-01-21 "Crea 5 nomi per un ristorante italiano"
```

### Opzioni dei modelli

I modelli LLM hanno diverse opzioni che puoi configurare per personalizzare le risposte. Una delle più comuni è la *temperatura*, che controlla la casualità delle risposte generate.

Per visualizzare le opzioni disponibili per i modelli installati, puoi usare il comando:

```bash
llm models options
```

E ad esempio per il modello `gemini-2.0-flash-exp` sono queste:

```
GeminiPro: gemini-2.0-flash-exp
  Options:
    code_execution: boolean
    temperature: float
    max_output_tokens: int
    top_p: float
    top_k: int
    json_object: boolean
    google_search: boolean
  Attachment types:
    application/ogg, application/pdf, audio/aac, audio/aiff,
    audio/flac, audio/mp3, audio/mpeg, audio/ogg, audio/wav,
    image/heic, image/heif, image/jpeg, image/png, image/webp,
    text/csv, text/plain, video/3gpp, video/avi, video/mov, video/mp4,
    video/mpeg, video/mpg, video/quicktime, video/webm, video/wmv,
    video/x-flv
  Features:
  - streaming
  - schemas
  - async
  Keys:
    key: gemini
    env_var: LLM_GEMINI_KEY
```

Questo modello di intelligenza artificiale supporta diverse opzioni che permettono di personalizzare il comportamento della generazione di testo. Eccone alcune:

- `code_execution`: se attivato (`true`), permette al modello di eseguire codice incluso nel prompt. Utile per test, calcoli o demo tecniche.
- `temperature` *(float)*: controlla la creatività della risposta (per [approfondire](https://cloud.google.com/vertex-ai/generative-ai/docs/learn/prompts/adjust-parameter-values?hl=it)).
- `max_output_tokens` *(int)*: imposta il numero massimo di token (parole/parole spezzate) generabili in output. Il limite massimo è 8192 token.
- `json_object` *(boolean)*: se attivo, il modello prova a generare direttamente un oggetto JSON come output.
- `google_search` *(boolean)*: abilita la consultazione di Google per arricchire la risposta con informazioni aggiornate (se supportato dall'interfaccia).

Il modello può accettare in input file di tipo:

- audio (es. mp3, wav)
- immagine (es. jpeg, png)
- video (es. mp4, webm)
- documenti (es. pdf, csv, txt)

Inoltre ha queste funzionalità:

- *streaming*: ricevi l'output man mano che viene generato
- *schemas*: supporta output strutturati secondo schemi
- *async*: supporta richieste asincrone

Per impostare ad esempio la temperatura, si dovrà usare l'opzione `-o` seguito da `temperature` e dal suo valore. Ad esempio:

```bash {.wordwrap-code}
llm -o temperature 0.1 "Suggerisci tre titoli per un articolo che spiega perché il software libero è importante nelle scuole."
```

### Conteggio dei token utilizzati

Se si aggiunge al comando l'opzione `-u` si ha restituito in output anche il conteggio dei token utilizzati per il prompt e per la risposta. Ad esempio:

``` {.text .wordwrap-code}
llm "5 nomi di ristoranti italiani" -u

1.  **La Tavola del Nonno:** (Classico e accogliente, "La tavola del nonno" evoca ricordi di famiglia e cucina tradizionale.)
2.  **Osteria Acquolina:** (Un po' più rustico e invitante, "Acquolina" significa letteralmente "l'acquolina in bocca," promettendo sapori deliziosi.)
...

Token usage: 5 input, 209 output, {"candidatesTokenCount": 209, "promptTokensDetails": [{"modality": "TEXT", "tokenCount": 5}], "candidatesTokensDetails": [{"modality": "TEXT", "tokenCount": 209}]}
```


Oppure si possono leggere i `log` dei comandi lanciati, ed in *output* si avrà anche il conteggio dei token:

```bash
llm logs --short --usage
```


L'output sarà in `yaml` e simile a questo (qui sotto soltano uno degli elementi del log):

```yaml
- model: gemini-2.0-flash-exp
  datetime: '2025-06-02T14:12:15'
  conversation: 01jwrfrtayx55e4k1c3230smab
  prompt: 5 nomi di ristoranti italiani
  prompt_fragments: []
  system_fragments: []
  usage:
    input: 5
    output: 209
    details:
      candidatesTokenCount: 209
      promptTokensDetails:
      - modality: TEXT
        tokenCount: 5
      candidatesTokensDetails:
      - modality: TEXT
        tokenCount: 209
```

!!! tip "Utility per il conteggio dei token"
    Simon Willison ha sviluppato anche **[`ttok`](../ttok/index.md)**, un'*utility* a riga di comando per contare i token di un testo o per troncare quel testo a un certo numero di token.

## Leggere da `stdin`

Questa è una delle funzionalità più interessanti di `llm` nell'utilizzo a riga di comando: puoi leggere da `stdin` e quindi passare il testo a `llm` da un file o da un comando. Ad esempio, se hai un file `input.txt` con del testo, puoi fare:

```bash
cat input.txt | llm "mi fai una sintesi del testo che c'è in questo file?"
```

Oppure un esempio ispirato a una famosa vignetta di **xkcd**, che evidenzia come per certi comandi (come `tar`) non sia sempre semplice ricordarsi le opzioni corrette da usare.

<figure markdown="span">
  [![xkcd tar](images/xkcd_tar.png)](https://xkcd.com/1168/)
  <figcaption>La <a href="https://xkcd.com/1168/">vignetta "tar"</a> di xkcd</figcaption>
</figure>

Allora si può "passare" l'output di `man tar` [^man] a `llm` per chiedere come si usa il comando `tar` per estrarre il file `appunti.tar.gz`:

```bash
man tar | llm "come si usa il comando tar per estrarre il file appunti.tar.gz.
Scrivi soltanto il comando e commenta le opzioni"
```

[^man]: `man` è un comando per visualizzare i manuali dei comandi Unix/Linux.

Con `man tar` si ottiene l'output del manuale di `tar`, che contiene le istruzioni su come usare il comando. Passando questo output a `llm`, si può ottenere una risposta chiara e concisa su come eseguire l'operazione richiesta.

E l'output sarà qualcosa del genere (e la bomba non esploderà 😉):

```text {.wordwrap-code}
tar -xzf appunti.tar.gz

*   `-x`: Indica l'operazione di estrazione (extract).
*   `-z`: Indica che il file è compresso con gzip e che quindi deve essere decompresso durante l'estrazione.
*   `-f`: Specifica che il successivo argomento è il nome del file archivio da estrarre (`appunti.tar.gz`).
```

!!! note "Nota"
    La gran parte dei modelli sarebbero stati in grado di rispondere a questa domanda, senza bisogno di leggere il manuale di `tar`, ma è un esempio interessante per mostrare come si può usare `llm` per leggere da `stdin` e ottenere risposte utili.

