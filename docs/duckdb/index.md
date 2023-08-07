---
search:
  exclude: true
---

# duckdb

È un database relazionale progettato per:

- fornire **prestazioni elevate** con **_query_ analitiche** di aggregazione, suddivisione, filtraggio, di **grandi banche dati**;
- essere ottimizzato per [**database colonnari**](#database-colonnari);
- essere **facilmente installabile** e integrabile in altre applicazioni, ambienti e *pipeline*, grazie alla sua natura *embedded*;
- essere **testato** in modo approfondito grazie a test automatici continui e verifiche di sicurezza;
- essere **_open source_**.

## Installazione

## Utilizzo

## Database colonnari

In un database colonnare i dati sono organizzati in colonne anziché in righe.

Nel caso di un database per righe tradizionale, i dati vengono memorizzati in modo che ogni riga rappresenti una singola entità o un *record*. Ogni colonna rappresenta un attributo o una caratteristica di quel *record*. Ad esempio, in un database di clienti, ogni riga potrebbe rappresentare un cliente diverso, mentre le colonne possono rappresentare attributi come il nome, l'indirizzo, l'email e così via.

Un database colonnare, al contrario, organizza i dati per colonne anziché per righe. Ciò significa che tutti i valori per una specifica colonna sono memorizzati insieme, indipendentemente da quale entità o record li possiede. Questo tipo di struttura può offrire vantaggi in termini di prestazioni e compressione dei dati, poiché le colonne contengono valori dello stesso tipo e possono essere compressi più efficacemente.

I database per righe sono generalmente più adatti per operazioni che coinvolgono l'accesso e la modifica di un intero record. Ad esempio, se si desidera recuperare tutti i dati di un singolo cliente, il database per righe sarà più efficiente in quanto può accedere a tutte le colonne di quel record in modo sequenziale.

D'altra parte, i database colonnari sono ottimali per operazioni che coinvolgono l'analisi di grandi quantità di dati. Poiché i valori delle colonne sono memorizzati insieme, è possibile eseguire operazioni come l'aggregazione, il calcolo di statistiche o il filtraggio dei dati in modo più rapido ed efficiente. Inoltre, i database colonnari sono spesso più efficienti nella compressione dei dati, riducendo lo spazio di archiviazione necessario.

Quindi, se il focus principale è sulle operazioni di transazione e l'accesso a record completi, un database per righe può essere più adatto. Se invece si tratta di analisi di grandi quantità di dati o di operazioni aggregate, un database colonnare può essere più performante.



## Siti utili

- DuckDB Snippets https://duckdbsnippets.com/
