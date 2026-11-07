---
title: Modalità interattiva
---

# Pi in modalità interattiva

```bash
pi
```

Avvia la TUI con editor, footer con costo e token, selezione modello e navigazione della cronologia. Digita `/` per cercare tra i comandi disponibili e usa `/hotkeys` per vedere le scorciatoie attive. L'elenco completo è nella [documentazione dei comandi](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/slash-commands.md).

Dalla versione 1.0 l'interfaccia è a schermo intero. Per tornare allo scorrimento normale del terminale usa `pi --tui-mode regular`, oppure imposta `"tuiMode": "regular"` in `settings.json`. Le preferenze più comuni si cambiano con `/settings`.

## Scrivere un prompt

- `Invio` invia il prompt e `Shift+Invio` va a capo
- `Ctrl+G` apre il prompt nell'editor esterno configurato
- `@` cerca un file da aggiungere al prompt e `Tab` completa un percorso
- `Ctrl+O` espande o comprime l'output degli strumenti
- `Ctrl+T` mostra o nasconde i blocchi di ragionamento

## Correggere la rotta mentre Pi lavora

Puoi scrivere anche mentre Pi sta lavorando:

- `Invio` manda un messaggio che orienta la risposta successiva
- `Alt+Invio` accoda un messaggio da elaborare quando Pi ha finito
- `Alt+Su` riporta nell'editor i messaggi in coda
- `Esc` interrompe il lavoro in corso

Windows Terminal riserva alcune scorciatoie con `Alt`: le alternative sono nella [guida alla configurazione del terminale](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/terminal-setup.md).

## Comandi bash nell'editor

Dall'editor interattivo puoi eseguire comandi shell direttamente:

```text
!ls -la
```

Il risultato entra nella conversazione: il modello lo vede e può usarlo come contesto.

```text
!!ls -la
```

Con il doppio `!!` il comando viene eseguito ma **non** entra nella conversazione. Utile per operazioni di servizio che non vuoi intasare il contesto.

## Cambiare modello al volo

- `/model` o `Ctrl+L`: apre il selettore di tutti i modelli disponibili
- `/scoped-models`: imposta i modelli preferiti
- `Ctrl+P`: cicla rapidamente tra i preferiti
- `/thinking` o `Shift+Tab`: cambia il livello di ragionamento (`off`, `minimal`, `low`, `medium`, `high`, `xhigh`, `max`), secondo quelli supportati dal modello

Vedi anche la pagina [Modelli](modelli.md).

## Gestire le sessioni

- `/new`: avvia una nuova sessione
- `/resume`: apre un'altra sessione salvata
- `/name`: assegna un nome alla sessione
- `/session`: mostra file, ID, numero di messaggi, token e costo
- `/import`: importa una sessione da un file JSONL

Le sessioni vengono salvate in formato JSONL in `~/.pi/agent/sessions/`, organizzate per directory di lavoro.

## Navigare la cronologia della sessione

`/tree` mostra tutti i messaggi della sessione e permette di tornare a un punto precedente e ripartire da lì: utile quando una risposta ha preso la direzione sbagliata. Il ramo che lasci non viene cancellato.

```text
/fork    # crea una nuova sessione da un messaggio precedente
/clone   # duplica il ramo corrente in una nuova sessione
```

## Esportare e condividere una sessione

```text
/export
```

Salva la sessione in HTML o JSONL. Il file HTML ha un'interfaccia navigabile per leggere la sessione, filtrare per tipo di messaggio (tool, user, assistant) e scaricare il JSON grezzo.

Con `/share` la sessione viene invece caricata online e ottieni un link per visualizzarla: di norma su Radius se hai configurato quell'autenticazione, altrimenti in un gist GitHub privato. Rileggila prima di condividerla: può contenere prompt, output dei comandi, contenuto dei file e credenziali.

Per copiare solo l'ultima risposta usa `/copy` o `Ctrl+X`.

## Gestire il contesto

```text
/compact
/compact "concentrati sulle API di autenticazione"
```

Compatta la conversazione quando si avvicina al limite del contesto. Si possono aggiungere istruzioni personalizzate per guidare la compattazione. Pi di norma lo fa anche da solo, e la cronologia originale resta nel file della sessione.
