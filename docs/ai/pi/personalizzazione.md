---
title: Personalizzazione
---

# Personalizzazione di Pi

Pi si estende senza toccare il codice sorgente. I tre oggetti principali sono **prompt template**, **skill** ed **estensioni**, componibili in **pacchetti** da condividere.

Dopo qualsiasi modifica alla configurazione, ricarica con `/reload` nell'editor interattivo oppure riavvia Pi. Per validazione e completamento nell'editor di testo, aggiungi `"$schema": "https://pi.dev/schemas/settings.schema.json"` a `settings.json`.

## File di contesto: `CLAUDE.md` e `AGENTS.md`

Pi legge automaticamente i file di contesto dalla directory corrente, dalle directory superiori e dalla sua directory di configurazione (`~/.pi/agent/`):

- `AGENTS.md`: standard condiviso tra agenti
- `CLAUDE.md`: lo stesso file usato da Claude Code

Su Linux il nome va scritto in maiuscolo: `agents.md` e `claude.md` in minuscolo vengono ignorati.

Se usi già Claude Code con un `CLAUDE.md` nel progetto, Pi lo caricherà automaticamente. Le istruzioni globali di Claude Code in `~/.claude/` invece non vengono lette: per istruzioni valide ovunque usa `~/.pi/agent/AGENTS.md`.

Con `--no-context-files` (`-nc`) disattivi il caricamento di questi file. Vengono letti anche se non hai dato fiducia alla cartella, quindi le istruzioni di un progetto sconosciuto vanno trattate come input non fidato.

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

I template supportano variabili, per adattare lo stesso prompt a contesti diversi: `$1`, `$2` per i singoli argomenti, `$@` per tutti, `${1:-valore}` per un valore predefinito.

## Skill

Le skill sono istruzioni in markdown che Pi carica come contesto aggiuntivo per eseguire task specifici. Il modello le carica da solo quando il task corrisponde, oppure le invochi con `/skill:nome`.

Pi le cerca in questi percorsi:

- `.pi/skills/` nella directory del progetto
- `.agents/skills/` nella directory del progetto e in quelle superiori
- `~/.pi/agent/skills/` — globali
- `~/.agents/skills/` — globali, percorso dello standard Agent Skills

Le skill di Claude Code in `~/.claude/skills/` non vengono caricate in automatico. Per riusarle, aggiungi la cartella all'impostazione `skills` di `~/.pi/agent/settings.json`:

```json
{
  "skills": ["~/.claude/skills"]
}
```

Per una sola esecuzione puoi usare il flag `--skill`:

```bash
pi --skill ~/.claude/skills
```

Per invocare una skill dall'editor interattivo, con eventuali argomenti:

```text
/skill:pdf-tools estrai report.pdf
```

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
pi install npm:<nome-pacchetto>      # globale, da npm
pi install npm:<nome-pacchetto> -l   # solo per il progetto corrente
pi install git:github.com/<utente>/<repo>   # da git
pi list                              # pacchetti installati
pi remove npm:<nome-pacchetto>       # rimuovi
pi update --extensions               # aggiorna i pacchetti installati
```

Il prefisso serve: un nome senza `npm:` o `git:` viene trattato come percorso locale.

Tra i pacchetti disponibili: sub-agent, accesso web. Per l'MCP non serve un pacchetto, perché il supporto è [integrato](mcp.md). Vedi [pi.dev](https://pi.dev/) per la lista aggiornata.

!!! warning "Attenzione ai pacchetti di terze parti"
    I pacchetti possono contenere script che Pi esegue. Verifica sempre il codice sorgente prima di installarli.
