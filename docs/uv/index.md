# uv - Gestore di pacchetti Python ultra-veloce

`uv` è un gestore di pacchetti e ambienti virtuali Python estremamente veloce, scritto in Rust. È un'alternativa moderna a `pip`, `pipenv` e `poetry` che promette di essere 10-100 volte più veloce.

## Caratteristiche principali

- **Velocità estrema**: 10-100x più veloce di pip grazie all'implementazione in Rust
- **Gestione unificata**: Pacchetti, ambienti virtuali e progetti in un unico strumento
- **Compatibilità**: Funziona con l'ecosistema Python esistente
- **Risoluzione avanzata**: Algoritmi sofisticati per la risoluzione delle dipendenze
- **Cross-platform**: Supporta Windows, macOS e Linux

## Installazione

### Su Linux e macOS

Il modo più semplice è utilizzare il script di installazione ufficiale:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Con pip

Se preferisci usare pip:

```bash
pip install uv
```

### Con Homebrew (macOS)

```bash
brew install uv
```

### Con Cargo (Rust)

Se hai Rust installato:

```bash
cargo install uv
```

## Ricette

### Creare un nuovo progetto

Per creare un nuovo progetto Python con uv:

```bash
uv init mio-progetto
cd mio-progetto
```

Questo crea una struttura di progetto con:

- `pyproject.toml` - file di configurazione
- `README.md` - documentazione base
- `src/mio_progetto/` - codice sorgente
- `.python-version` - versione Python specifica

### Aggiungere dipendenze

Per aggiungere una nuova dipendenza al progetto:

```bash
# Aggiungere una dipendenza di runtime
uv add requests

# Aggiungere una dipendenza di sviluppo
uv add --dev pytest

# Aggiungere una dipendenza specifica per versione
uv add "django>=4.0,<5.0"
```

### Installare le dipendenze

Per installare tutte le dipendenze di un progetto esistente:

```bash
uv sync
```

### Pulire la cache

```bash
uv cache prune
```

### Installare un tool come cli indipendente

Per installare un tool come comando CLI indipendente, puoi usare il comando `uv tool install`:

```bash
uv tool install black
```

### Eseguire comandi nell'ambiente virtuale

Per eseguire comandi nell'ambiente virtuale del progetto:

```bash
# Eseguire un file Python
uv run python main.py

# Eseguire un modulo
uv run -m pytest

# Avviare una shell interattiva
uv run python
```

### Gestire versioni Python

```bash
# Installare una versione specifica di Python
uv python install 3.12

# Vedere tutte le versioni disponibili
uv python list

# Impostare la versione per il progetto corrente
uv python pin 3.12
```

### Creare script eseguibili

Puoi creare script che specificano le loro dipendenze:

```python
#!/usr/bin/env uv run
# /// script
# dependencies = [
#   "requests",
#   "beautifulsoup4",
# ]
# ///

import requests
from bs4 import BeautifulSoup

# Il tuo codice qui...
```

Salvalo come `script.py` e rendilo eseguibile:

```bash
chmod +x script.py
./script.py
```

### Lavorare con ambienti virtuali

```bash
# Creare un ambiente virtuale
uv venv

# Creare con una versione Python specifica
uv venv --python 3.11

# Attivare l'ambiente (Linux/macOS)
source .venv/bin/activate

# Installare pacchetti nell'ambiente attivo
uv pip install pandas numpy
```

### Migrare da requirements.txt

Se hai un progetto esistente con `requirements.txt`:

```bash
# Creare pyproject.toml da requirements.txt
uv init --python 3.11
uv add -r requirements.txt
```

### Lavorare con più progetti

```bash
# Creare workspace con più progetti
mkdir workspace
cd workspace

# Progetto principale
uv init app
cd app
uv add fastapi uvicorn

# Libreria condivisa
cd ..
uv init --lib shared
cd shared
uv add pydantic

# Nel progetto principale, aggiungere la libreria locale
cd ../app
uv add ../shared
```

### Esportare dipendenze

Per esportare le dipendenze in formati compatibili:

```bash
# Esportare come requirements.txt
uv export --format requirements-txt > requirements.txt

# Esportare solo dipendenze di produzione
uv export --no-dev --format requirements-txt > requirements-prod.txt
```

### Tool di sviluppo globali

Installare strumenti di sviluppo globalmente:

```bash
# Installare black globalmente
uv tool install black

# Eseguire uno strumento senza installarlo
uv tool run ruff check .

# Aggiornare tutti gli strumenti
uv tool upgrade --all
```

## Vantaggi rispetto ad altri strumenti

| Funzionalità | uv | pip | poetry | pipenv |
|--------------|----|----|--------|--------|
| Velocità | ⚡⚡⚡ | ⚡ | ⚡⚡ | ⚡ |
| Gestione dipendenze | ✅ | ❌ | ✅ | ✅ |
| Lock file | ✅ | ❌ | ✅ | ✅ |
| Ambienti virtuali | ✅ | ❌ | ✅ | ✅ |
| Gestione Python | ✅ | ❌ | ❌ | ❌ |
| Workspace | ✅ | ❌ | ✅ | ❌ |

## Risorse utili

- [Documentazione ufficiale](https://docs.astral.sh/uv/)
- [Repository GitHub](https://github.com/astral-sh/uv)
- [Guida migrazione da Poetry](https://docs.astral.sh/uv/guides/migration/)
- [Blog Astral - annunci e guide](https://astral.sh/blog)
