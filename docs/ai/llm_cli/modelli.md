--8<-- "includes/lavori_in_corso.md"

# I modelli

Con `llm` cli puoi utilizzare la gran parte dei modelli oggi disponibili, sia quelli esposti tramite API su server remoti - quelli di OpenAI, Anthropic, Google, ecc. - sia quelli installati localmente.

La lista dei modelli disponibili si ottiene con il comando:

```bash
llm models list
```

Si può estendere il numero dei modelli disponibili tramite [*plugin*](plugin.md).

## Modelli decisionali

Esiste una famiglia di modelli che non scrivono testo: si chiamano modelli "decisionali" (*decision models*, o "System One"), e il primo è [Jev](https://simonwillison.net/2026/Sep/21/jev/) di TypeSafe AI. Ricevono un testo (lo *state*) e una domanda chiusa, e restituiscono un numero. I tipi di domanda sono tre:

- `noul`: sì/no, con una probabilità tra 0 e 1;
- `choice`: una categoria fra quelle indicate, con distribuzione di probabilità e confidenza;
- `score`: una posizione su una scala ordinata (ad esempio basso < medio < alto), con probabilità e confidenza.

Sono utili per classificare in serie molti testi a costi molto bassi: Jev costa 0,042 $ per milione di token in input, e l'output è gratuito. Nel [post di Simon Willison](https://simonwillison.net/2026/Sep/21/jev/) ci sono anche i limiti: è una scatola nera, può avere *bias*, e ha debolezze con numeri e date.

Servono `llm` 0.36 o superiore (`llm install -U llm`). Questi modelli accettano soltanto prompt singoli: non funzionano con `llm chat` né con l'opzione `-c` per continuare una conversazione.

### Jev con llm-typesafe

Il plugin [llm-typesafe](https://github.com/simonw/llm-typesafe) (in versione *alpha*) aggiunge il modello `typesafe/jev-latest`, con alias `jev`. La domanda va nel prompt di sistema (`-s`), il testo da valutare nel prompt:

```bash
llm install llm-typesafe
llm keys set typesafe
llm -m jev 'Please refund my last payment.' -s 'Does this message explicitly request a refund?'
```

```json
{"type": "noul", "noul": 0.99}
```

Il tipo di domanda si sceglie con `-o answer_type noul|choice|score`, i criteri con `-o criteria '{...}'`. L'esempio e l'output sono tratti dal README del plugin.

### Modelli decisionali di OpenAI

Il plugin [llm-openai-decisions](https://github.com/simonw/llm-openai-decisions) usa la stessa chiave `openai` e aggiunge il modello `openai-decisions/gpt-6-luna`:

```bash
llm install llm-openai-decisions
llm -m openai-decisions/gpt-6-luna 'Please refund my last payment.' -s 'Does this message explicitly request a refund?'
```

```json
{"name": "evaluation", "type": "predicate", "probability": 0.99}
```

Per una domanda a scelta si passano le categorie con una descrizione (o `null`):

```bash
llm -m openai-decisions/gpt-6-luna 'Please refund my last payment.' -s 'Which team should handle this?' \
  -o answer_type choice \
  -o choices '{"billing": "Payments and refunds", "technical": "Bugs and errors", "other": null}'
```

Anche questi esempi vengono dal README del plugin.

### Attenzione a OpenRouter

Con il plugin `llm-openrouter`, in `llm models` compare `openrouter/typesafe/jev-router`, ma **non è Jev**: è un *router* che usa Jev per scegliere a quale modello testuale girare la richiesta, e risponde in testo (ad esempio `Yes.`).

Su OpenRouter i modelli decisionali veri stanno su un'API separata, `https://openrouter.ai/api/alpha/decisions`, che `llm-openrouter` non supporta: dalla CLI `llm` non sono raggiungibili. Il catalogo (Jev, i modelli Perplexity, Cloudflare, OpenAI e altri) si legge da <https://openrouter.ai/api/v1/models?output_modalities=decisions>. Si possono interrogare con `curl`:

```bash
curl -s https://openrouter.ai/api/alpha/decisions \
  -H "Authorization: Bearer $(llm keys get openrouter)" \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "typesafe/jev-1.14",
    "state": "Please refund my last payment.",
    "questions": {
      "refund": {"type": "noul", "instructions": "Does this message explicitly request a refund?"}
    }
  }' | jq .answers
```

```json
{
  "refund": {
    "type": "noul",
    "noul": 0.99
  }
}
```

La chiamata è costata 0,0000118 $. Nello stesso `questions` si possono mettere più domande, anche di tipo `choice` e `score`.

Per applicare queste domande a ogni riga di una colonna di testo c'è [vd-jev](https://github.com/ondata/vd-jev), un plugin per [VisiData](https://www.visidata.org/) che usa proprio questa API di OpenRouter.
