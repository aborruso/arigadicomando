---
search:
  exclude: true
---

## Importare file

Se importo un file con ST_Read, funzione basata con GDAL, viene creata una colonna con i dati geometrici come `wkb_geometry `.<br>
In fase di import o di lettura si può convertire in `GEOMETRY` usando la funzione `ST_GeomFromWKB`.

```sql
CREATE TABLE zones AS
SELECT *, ST_GeomFromWKB(wkb_geometry) AS geom
FROM st_read('input.shp');
```


## Esportare file

```sql
COPY (
    SELECT
    citta,geom
    FROM table)
TO 'output.geojson'
WITH (FORMAT GDAL, DRIVER 'GeoJSON', LAYER_CREATION_OPTIONS 'WRITE_BBOX=YES');
```

Nota: posso usare geom, perché è stato importato come `ST_GeomFromWKB(wkb_geometry) AS geom`
