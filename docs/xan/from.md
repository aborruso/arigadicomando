# Importare dati in xan con `xan from`

xan lavora nativamente con CSV. Se i tuoi dati sono in un altro formato — Excel, JSON, testo semplice, tabelle Markdown — `xan from` li converte in CSV così da poterli usare immediatamente nel resto del pipeline.

Il formato viene rilevato automaticamente dall'estensione del file. Quando si legge da stdin va specificato esplicitamente con `-f`.

## File di esempio (download raw)

- [`dipendenti.json`](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/from/dipendenti.json) — JSON array
- [`eventi.ndjson`](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/from/eventi.ndjson) — NDJSON
- [`comuni.md`](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/from/comuni.md) — Markdown con tabella
- [`dati_pa.xlsx`](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/from/dati_pa.xlsx) — Excel con due schede

## Excel e ODS

Excel è il formato più diffuso nella pubblica amministrazione italiana. `xan from` converte qualsiasi scheda di un file `.xlsx`, `.xls`, `.xlsb` o `.ods` in CSV.

Per vedere le schede disponibili in un file:

```bash
xan from --list-sheets dati_pa.xlsx
```

```
Dipendenti
Comuni
```

Per convertire la prima scheda (quella di default):

```bash
xan from dati_pa.xlsx
```

```csv
id,nome,reparto
1,Alice Rossi,Anagrafe
2,Bruno Ferrari,Urbanistica
```

Per convertire una scheda specifica per nome:

```bash
xan from --sheet-name Comuni dati_pa.xlsx
```

```csv
comune,provincia
Firenze,FI
Prato,PO
```

Oppure per indice (0-based):

```bash
xan from --sheet-index 1 dati_pa.xlsx
```

## JSON

`xan from` converte un array JSON in CSV, usando le chiavi del primo record come intestazioni. Ogni oggetto nell'array diventa una riga.

Input (`dipendenti.json`):

```json
[
  {"id": 1, "nome": "Alice Rossi", "reparto": "Anagrafe", "comune": "Firenze", "anno_assunzione": 2018},
  {"id": 2, "nome": "Bruno Ferrari", "reparto": "Urbanistica", "comune": "Prato", "anno_assunzione": 2015},
  ...
]
```

```bash
xan from dipendenti.json
```

```csv
id,nome,reparto,comune,anno_assunzione
1,Alice Rossi,Anagrafe,Firenze,2018
2,Bruno Ferrari,Urbanistica,Prato,2015
3,Carla Bianchi,Anagrafe,Siena,2020
4,Diego Conti,Tributi,Firenze,2012
5,Elena De Luca,Urbanistica,Grosseto,2022
```

### Chiavi non consistenti tra record (`--sample-size`)

In un JSON reale non tutti gli oggetti hanno necessariamente le stesse chiavi. `xan from` risolve questo campionando i primi 64 record per stabilire l'elenco completo delle colonne, e riempiend con celle vuote le chiavi assenti in certi record.

Se il file è grande e le chiavi extra compaiono oltre i primi 64 record, potresti perdere colonne. In quel caso usa `--sample-size -1` per campionare l'intero file prima di emettere le intestazioni (costa più memoria, ma garantisce completezza):

```bash
xan from --sample-size -1 avvisi.json
```

### Ordinare le colonne (`--sort-keys`)

Di default le colonne seguono l'ordine in cui appaiono nei record JSON. Con `--sort-keys` vengono ordinate alfabeticamente, utile per armonizzare sorgenti diverse che usano lo stesso schema ma con chiavi in ordine diverso:

```bash
xan from --sort-keys avvisi.json
```

```csv
data,id,luogo,ora,titolo
2024-03-01,1,,,Chiusura uffici
...
```

### Oggetto singolo (`--single-object`)

Se il JSON è un singolo oggetto (non un array), di default `xan from` lo converte in due colonne `key` e `value`. Con `--single-object` lo tratta invece come un'unica riga, con le chiavi come intestazioni:

```bash
xan from --single-object config.json
```

Input:

```json
{"ente": "Comune di Firenze", "codice": "FI001", "regione": "Toscana", "sito": "https://comune.fi.it"}
```

Output:

```csv
ente,codice,regione,sito
Comune di Firenze,FI001,Toscana,https://comune.fi.it
```

## NDJSON e JSONL

Il formato NDJSON (newline-delimited JSON) ha un oggetto JSON per riga. È comune negli export di API, nei log applicativi e nei dataset di grandi dimensioni perché può essere letto in streaming senza caricare tutto in memoria.

Input (`eventi.ndjson`):

```
{"id": 1, "timestamp": "2024-01-10T08:15:00", "tipo": "accesso", "utente": "alice", "ip": "192.168.1.10"}
{"id": 2, "timestamp": "2024-01-10T08:22:00", "tipo": "download", "utente": "bruno", "ip": "192.168.1.25", "file": "report_2023.pdf"}
{"id": 3, "timestamp": "2024-01-10T09:01:00", "tipo": "accesso", "utente": "carla", "ip": "10.0.0.5"}
{"id": 4, "timestamp": "2024-01-10T09:45:00", "tipo": "errore", "utente": "alice", "ip": "192.168.1.10", "codice": 403}
{"id": 5, "timestamp": "2024-01-10T10:30:00", "tipo": "download", "utente": "alice", "ip": "192.168.1.10", "file": "bilancio_2024.xlsx"}
```

```bash
xan from eventi.ndjson
```

```csv
id,timestamp,tipo,utente,ip,file,codice
1,2024-01-10T08:15:00,accesso,alice,192.168.1.10,,
2,2024-01-10T08:22:00,download,bruno,192.168.1.25,report_2023.pdf,
3,2024-01-10T09:01:00,accesso,carla,10.0.0.5,,
4,2024-01-10T09:45:00,errore,alice,192.168.1.10,,403
5,2024-01-10T10:30:00,download,alice,192.168.1.10,bilancio_2024.xlsx,
```

I campi assenti in certi record (`file`, `codice`) diventano celle vuote. Il formato `.jsonl` si comporta in modo identico.

## Testo semplice (TXT)

Un file di testo con un valore per riga viene convertito in un CSV a colonna singola, di default chiamata `value`:

```bash
cat nominativi.txt | xan from -f txt
```

```csv
value
Alice Rossi
Bruno Ferrari
Carla Bianchi
```

Per rinominare la colonna usa `-c`:

```bash
cat nominativi.txt | xan from -f txt -c nominativo
```

```csv
nominativo
Alice Rossi
Bruno Ferrari
Carla Bianchi
```

## Tabelle Markdown

`xan from` estrae la prima tabella da un file Markdown. Utile per portare nel pipeline tabelle già formattate in documenti di testo o README.

Input (`comuni.md`):

```markdown
| comune | provincia | popolazione | superficie_kmq |
|--------|-----------|-------------|----------------|
| Firenze | FI | 358079 | 102.3 |
| Prato | PO | 194875 | 97.5 |
```

```bash
xan from comuni.md
```

```csv
comune,provincia,popolazione,superficie_kmq
Firenze,FI,358079,102.3
Prato,PO,194875,97.5
Siena,SI,53901,118.5
Grosseto,GR,80611,473.3
Arezzo,AR,98822,388.0
```

Se il documento contiene più tabelle puoi selezionarne una specifica con `--nth-table` (indice 0-based; valori negativi contano dalla fine):

```bash
xan from --nth-table 1 documento.md   # seconda tabella
xan from --nth-table -1 documento.md  # ultima tabella
```

## Lettura da stdin

Quando i dati arrivano da stdin non c'è estensione del file da cui inferire il formato: va specificato esplicitamente con `-f`.

```bash
curl -s https://example.com/api/data.json | xan from -f json
```

## Integrazione nel pipeline

`xan from` produce CSV su stdout, quindi si collega direttamente al resto dei comandi xan:

```bash
xan from dipendenti.json | xan filter 'eq(reparto, "Anagrafe")'
```

```csv
id,nome,reparto,comune,anno_assunzione
1,Alice Rossi,Anagrafe,Firenze,2018
3,Carla Bianchi,Anagrafe,Siena,2020
```

```bash
xan from eventi.ndjson | xan frequency -s tipo
```

```csv
value,count
accesso,2
download,2
errore,1
```
