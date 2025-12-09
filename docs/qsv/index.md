# qsv

**qsv** è un toolkit ultra-veloce per la manipolazione di dati strutturati, con oltre **50 comandi** disponibili. È costruito in Rust e utilizza [Polars](https://www.pola.rs/) per offrire prestazioni eccezionali nell'elaborazione di file CSV e altri formati di dati.

Ha una ottima **documentazione ufficiale** in inglese, consultabile [qui](https://qsv.dathere.com/).

## Caratteristiche principali

- **Velocità**: grazie a Rust e Polars, qsv è estremamente veloce anche con dataset di grandi dimensioni
- **Parallelizzazione**: sfrutta al meglio le CPU multi-core
- **Streaming**: la maggior parte dei comandi usa memoria costante e può processare file CSV di dimensioni arbitrarie
- **Formati supportati**: CSV, TSV, Excel, Open Document Spreadsheet, JSON/JSONL, DataPackage, Apache Arrow/Parquet, SQLite, PostgreSQL

## Installazione

qsv può essere installato in diversi modi:

- utilizzando i file binari precompilati, presenti nella [pagina delle release](https://github.com/dathere/qsv/releases)
- [compilandolo da sorgente](#compilazione-da-sorgente) (guida dettagliata sotto)
- utilizzando un gestore di pacchetti (vedi [documentazione ufficiale](https://qsv.dathere.com/))

## Risorse

- **Sito ufficiale**: [qsv.dathere.com](https://qsv.dathere.com/)
- **Repository GitHub**: [github.com/dathere/qsv](https://github.com/dathere/qsv)
- **Tutorial con 100 esercizi**: [100.dathere.com](https://100.dathere.com/)
- **qsv pro**: versione desktop con interfaccia grafica, disponibile su [qsvpro.dathere.com](https://qsvpro.dathere.com/)

---

## Compilazione da sorgente

Questa guida spiega passo passo come compilare **qsv** da sorgente usando una configurazione che riduce il consumo di memoria ed evita gli errori OOM durante la compilazione di Polars.

### 1. Clonare il repository qsv

Scegli dove posizionare la cartella del progetto, ad esempio nella tua home:

```bash
cd ~
git clone https://github.com/dathere/qsv.git
cd qsv
```

Questo scarica il codice sorgente e ti porta dentro la cartella del progetto.

### 2. Assicurarsi di usare il tag corretto (opzionale ma consigliato)

Per essere certo di compilare una versione stabile:

```bash
git checkout 11.0.2
```

### 3. Compilare qsv con impostazioni a bassa memoria

La compilazione di qsv richiede molta RAM a causa delle dipendenze Polars.
Per evitare che il kernel uccida `rustc`, si usa:

- **CARGO_BUILD_JOBS=1** → compila un solo crate alla volta
- **-C target-cpu=native** → ottimizza il binario per la tua CPU
- **--locked** → usa esattamente le versioni del lockfile
- **-F all_features** → abilita tutte le funzionalità

Comando completo:

```bash
CARGO_BUILD_RUSTFLAGS='-C target-cpu=native' CARGO_BUILD_JOBS=1 \
cargo build --release --locked -F all_features
```

La compilazione può richiedere un po' di tempo, ma con questa configurazione funziona anche su macchine con RAM limitata.

### 4. Trovare il binario compilato

A fine compilazione, il binario si trova qui:

```bash
./target/release/qsv
```

Puoi provarlo con:

```bash
./target/release/qsv --version
```

Se vuoi renderlo disponibile nel tuo PATH:

```bash
mkdir -p ~/.local/bin
cp target/release/qsv ~/.local/bin/
```

### 5. Pulizia opzionale dei file generati da cargo

Se vuoi liberare spazio dopo la compilazione:

```bash
rm -rf ~/.cargo/registry ~/.cargo/git /tmp/cargo-*
```

e per pulire la build del progetto:

```bash
rm -rf target
```

Questi file verranno ricreati automaticamente da cargo quando serviranno.
