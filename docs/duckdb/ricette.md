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
