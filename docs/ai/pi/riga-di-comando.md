---
title: Riga di comando
---

# Pi da riga di comando

## Modalità non interattiva (`-p`)

La modalità più utile per pipeline e script: esegue il prompt e restituisce la risposta su stdout.

```bash
pi -p "spiega questo errore: segmentation fault"
```

Legge da stdin e unisce l'input al prompt:

```bash
cat errori.log | pi -p "analizza questi errori e suggerisci le cause"
```

```bash
git diff | pi -p "scrivi un messaggio di commit per queste modifiche"
```

```bash
cat dati.csv | pi -p "descrivi la struttura di questo CSV"
```

Con `@` includi file di testo o immagini nel prompt:

```bash
pi -p "confronta i due file e riassumi le differenze" @prima.csv @dopo.csv
```

Se il prompt comincia con un trattino, usa `--` per chiudere le opzioni:

```bash
pi -p -- "- riassumi questi punti"
```

## Output JSON

Utile per automazioni: restituisce tutti gli eventi come JSON lines.

```bash
pi --mode json -p "analizza questo file" < report.txt
```

Per integrare Pi in un altro programma c'è anche `--mode rpc`, che legge comandi JSONL da stdin e scrive risposte ed eventi su stdout. Vedi il [protocollo RPC](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/rpc.md).

## Limitare gli strumenti

Per esecuzioni solo-lettura o controllate. Gli strumenti integrati sono `read`, `bash`, `edit`, `write`, `grep`, `find` e `ls` (più `powershell` su Windows); di quelli, solo i primi quattro sono attivi per impostazione predefinita.

```bash
# Solo lettura: un elenco semplice sostituisce la selezione predefinita
pi -p "analizza il codice" --tools read,grep,find,ls

# Modifica la selezione predefinita: aggiunge grep e toglie bash
pi -p "analizza il codice" --tools +grep,-bash

# Tutti gli strumenti predefiniti tranne bash
pi -p "analizza il codice" --exclude-tools bash

# Senza strumenti
pi -p "rispondi a questa domanda" --no-tools
```

`--tools` e `--exclude-tools` accettano anche pattern con `*`. Attenzione: un `--tools` con nomi semplici non toglie gli strumenti MCP, salvo che una voce cominci con `mcp__`. Per escluderli usa `--exclude-tools 'mcp__*'` o `--no-mcp`. Vedi la pagina [MCP](mcp.md).

Per cambiare la selezione in modo permanente c'è l'impostazione `defaultTools` di `settings.json`, che accetta le stesse voci:

```json
{
  "defaultTools": ["+grep", "-bash"]
}
```

## Sessioni

Riprendi l'ultima sessione della cartella corrente:

```bash
pi -c
```

Scegli una sessione salvata da un elenco:

```bash
pi -r
```

Avvia in modalità effimera (senza salvare):

```bash
pi --no-session
```

Altre opzioni utili:

- `--name`: assegna un nome alla sessione
- `--session`: apre una sessione a partire dal file o dall'ID, anche parziale
- `--fork`: crea una copia di una sessione nella cartella corrente
- `--session-dir`: sceglie la cartella in cui salvare e cercare le sessioni

Per esportare in HTML il file di una sessione, senza aprire Pi:

```bash
pi --export sessione.jsonl sessione.html
```

## Altri comandi

```bash
pi --offline          # niente attività di rete all'avvio
pi update --models    # aggiorna il catalogo dei modelli
pi update --all       # aggiorna Pi e i pacchetti installati
```

L'elenco completo delle opzioni è in `pi --help` e nella [documentazione della riga di comando](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/cli.md).
