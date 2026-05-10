---
title: Personalizzazione
---

# Personalizzazione di Pi

Pi si estende senza toccare il codice sorgente. I tre oggetti principali sono **prompt template**, **skill** ed **estensioni**, componibili in **pacchetti** da condividere.

Dopo qualsiasi modifica alla configurazione, ricarica con `/reload` nell'editor interattivo oppure riavvia Pi.

## Prompt template

Sono slash command personalizzati: digiti `/codereview` e Pi espande automaticamente il testo completo del prompt prima di inviarlo al modello. Utili per prompt che ripeti spesso.

**Creare un template chiedendolo a Pi** (Pi legge la propria documentazione e lo genera):

```text
crea un prompt template per code review dettagliata e approfondita
```

Dopo `/reload`, il template è disponibile:

```text
/codereview
```

Il testo completo appare nell'editor, modificabile prima di inviare.

**Dove sono salvati:**

- `~/.pi/agent/prompts/` — globali, disponibili in tutte le sessioni
- `.pi/prompts/` nella directory del progetto — solo per quel workspace

Puoi anche creare i file a mano o copiare prompt che usi già con GitHub Copilot o altri agenti: basta metterli in una di queste directory.

I template supportano variabili, per adattare lo stesso prompt a contesti diversi.

## Skill

Le skill sono istruzioni in markdown che Pi carica come contesto aggiuntivo per eseguire task specifici. Si invocano con `/skill`.

Pi le cerca in questi percorsi:

- `.pi/skills/` nella directory del progetto
- `~/.pi/agent/skills/` — globali
- `~/.claude/` — **Pi carica automaticamente anche le skill di Claude Code**

Quest'ultimo punto è rilevante: se hai già skill configurate per Claude Code, Pi le trova e le usa senza configurazione aggiuntiva.

Per invocare una skill dall'editor interattivo:

```text
/skill
```

Appare un selettore con tutte le skill disponibili.

## Estensioni

Le estensioni sono file TypeScript che modificano il comportamento di Pi: possono aggiungere comandi, intercettare eventi, cambiare l'interfaccia, aggiungere widget all'editor o al footer.

**Pi può scrivere le proprie estensioni da solo.** Basta descrivere cosa vuoi:

```text
crea un'estensione per questo workspace che mostra una citazione
casuale di scienziati o scrittori famosi ad ogni avvio
```

Dopo `/reload` o riavvio, la citazione appare all'apertura di Pi.

Un esempio più utile per chi usa Pi come agente di codice — guardia sui comandi pericolosi:

```text
crea un'estensione per questo workspace che chieda conferma
prima di eseguire qualsiasi comando bash contenente rm -rf
o git push --force
```

Quando Pi tenta di eseguire uno di questi comandi, appare:

```text
⚠ Dangerous command detected: rm -rf hello/
Execute anyway? [y/n]
```

**Dove sono salvate:**

- `~/.pi/agent/extensions/` — globali
- `.pi/extensions/` nella directory del progetto — solo per quel workspace

Le estensioni del workspace non si attivano in altre sessioni Pi.

## Pacchetti

I pacchetti sono bundle di estensioni, skill e prompt template distribuiti via npm o git. Permettono di installare con un comando funzionalità che altri hanno già costruito.

```bash
pi install <nome-pacchetto>          # globale
pi install <nome-pacchetto> -l       # solo per il progetto corrente
pi list                              # pacchetti installati
pi remove <nome-pacchetto>           # rimuovi
```

Tra i pacchetti disponibili: sub-agent, MCP adapter, accesso web. Vedi [pi.dev](https://pi.dev/) per la lista aggiornata.

!!! warning "Attenzione ai pacchetti di terze parti"
    I pacchetti possono contenere script che Pi esegue. Verifica sempre il codice sorgente prima di installarli.
