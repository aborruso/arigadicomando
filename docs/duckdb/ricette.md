---
search:
  exclude: true
---

# Import shapefile

- lancia duckdb:
- load spatial;
- importa shp, escludi la colonna wkb_geometry per come è e importale dentro come ST_GeomFromWKB per mapparla come geometry

```sql
CREATE TABLE GrigliaPop2021_ITA_DatiProv AS SELECT * EXCLUDE wkb_geometry, ST_GeomFromWKB(wkb_geometry) AS geom FROM ST_Read('GrigliaPop2021_ITA_DatiProv.shp');
```

- così si ha a disposizione una tabella spaziale su cui fare scripting spaziale

# Esporta una tabella spaziale come parquet

- lancia duckdb:
- load spatial;
- poi esportala come parquet impostando il campo geometrico come ST_AsWKB. In questo modo il file parquet di output potrà subire query spaziali (non è un geoparquet)

```sql
COPY  (SELECT * REPLACE (ST_AsWKB(geom) AS geom) FROM GrigliaPop2021_ITA_DatiProv)  TO 'GrigliaPop2021_ITA_DatiProv.parquet' (FORMAT PARQUET, CODEC 'ZSTD');
```

# fai query su parquet esportato

Alla colonna con contenuti geometrici, bisogna applicare ST_GeomFromWKB. A questo punto sarà possibile eseguire operazioni spaziali

```
duckdb -csv -c "load spatial;select ST_Area(ST_GeomFromWKB(geom)) from 'GrigliaPop2021_ITA_DatiProv.parquet' limit 10"
```

# Confronto tra Tabelle

`EXCEPT DISTINCT` è una funzione SQL che restituisce le righe presenti in una tabella ma non nell'altra, considerando solo righe uniche. È utile per confrontare due versioni di una tabella e individuare rapidamente le differenze o verificare se le tabelle sono identiche.

Scenario:

- Tabella 1: contiene i dati nuovi (es. aggiornamenti recenti).
- Tabella 2: contiene i dati vecchi (es. lo stato precedente).

```sql
SELECT *
FROM table_1
EXCEPT DISTINCT
SELECT *
FROM table_2;
```

In output tutte le righe presenti in `table_1` (nuova) che non si trovano in `table_2` (vecchia).

# Estrarre righe con errori

```bash
duckdb -c "copy (from read_csv('input.csv',store_rejects = true)) TO '/dev/null' WITH (FORMAT 'csv', HEADER);copy (FROM reject_errors) to 'reject_errors.csv'"
```

Note:

- `store_rejects = true`, fa in modo che venga creata la tabella `reject_errors` con le righe che hanno errori (se presenti);
- `TO '/dev/null' WITH (FORMAT 'csv', HEADER` fa in modo che le righe vengano lette tutte, ma non salvate. È necessario leggerle tutte, per avere in output tutte le righe con errori.
