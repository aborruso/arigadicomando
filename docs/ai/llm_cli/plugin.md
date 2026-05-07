--8<-- "includes/lavori_in_corso.md"

# I plugin

I *plugin* di `llm` estendono le sue funzionalità. La gran parte viene utilizzata per aggiungere modelli di intelligenza artificiale, ma esistono anche plugin che aggiungono strumenti, comandi CLI, template e altro.

Per installare un plugin si usa `llm install`, seguito dal nome del pacchetto:

```bash
llm install llm-gemini
```

Per vedere i plugin installati:

```bash
llm plugins
```

Per aggiornare un plugin alla versione più recente, si usa l'opzione `-U`:

```bash
llm install -U llm-gemini
```

Per disinstallare un plugin:

```bash
llm uninstall llm-gemini -y
```

La documentazione ufficiale sui plugin è disponibile alla pagina <https://llm.datasette.io/en/stable/plugins/index.html>; l'elenco completo dei plugin disponibili si trova invece alla pagina <https://llm.datasette.io/en/stable/plugins/directory.html>.
