# Ricette GDAL/OGR

## Scaricare dati da un webservice ArcGIS

Prima lo interrogo, per avere restituito il nome del layer e altri metadati:

```
ogrinfo -so -ro -al "https://map.sitr.regione.sicilia.it/gis/rest/services/catasto/cartografia_catastale/MapServer/6/query?where=objectid+%3D+objectid&outfields=*&f=json"
```

L'output sarà qualcosa come:

```
Layer name: ESRIJSON
Geometry: Polygon
Feature Count: 1000
Extent: (13.097299, 37.166626) - (13.976281, 37.694915)
Layer SRS WKT:
PROJCS["ETRS89 / UTM zone 33N",
    GEOGCS["ETRS89",
        DATUM["European_Terrestrial_Reference_System_1989",
            SPHEROID["GRS 1980",6378137,298.257222101,
                AUTHORITY["EPSG","7019"]],
            TOWGS84[0,0,0,0,0,0,0],
            AUTHORITY["EPSG","6258"]],
        PRIMEM["Greenwich",0,
            AUTHORITY["EPSG","8901"]],
        UNIT["degree",0.0174532925199433,
            AUTHORITY["EPSG","9122"]],
        AUTHORITY["EPSG","4258"]],
    PROJECTION["Transverse_Mercator"],
    PARAMETER["latitude_of_origin",0],
    PARAMETER["central_meridian",15],
    PARAMETER["scale_factor",0.9996],
    PARAMETER["false_easting",500000],
    PARAMETER["false_northing",0],
    UNIT["metre",1,
        AUTHORITY["EPSG","9001"]],
    AXIS["Easting",EAST],
    AXIS["Northing",NORTH],
    AUTHORITY["EPSG","25833"]]
OBJECTID: Integer (0.0)
COMUNE: String (4.0)
SEZIONE: String (1.0)
FOGLIO: String (4.0)
ALLEGATO: String (1.0)
SVILUPPO: String (1.0)
ORIGINE: String (20.0)
Shape_Length: Real (0.0)
Shape_Area: Real (0.0)
```

E poi, lo scarico paginando

```
ogr2ogr -overwrite -f SQLite -dsco SPATIALITE=YES -nlt MULTIPOLYGON -nln particelle particelle.sqlite  "https://map.sitr.regione.sicilia.it/gis/rest/services/catasto/cartografia_catastale/MapServer/6/query?where=objectid+%3D+objectid&outfields=*&f=json" ESRIJSON -lco FEATURE_SERVER_PAGING="YES"
```

Nota: `-nlt MULTIPOLYGON` perché l'oggetto di input qui è un `MULTIPOLYGON`.

## Usare gdal via docker

Si inizia con il prelevare l'immagine da un repository. Ad esempio questa di osgeo:

```bash
docker pull osgeo/gdal:alpine-normal-latest
```

E poi si può lanciare in modo **non interattivo** dalla propria shell:

```bash
docker run --rm -v "$(pwd)":/data osgeo/gdal:alpine-normal-latest gdalinfo data/input.tif
```

- `--rm` per rimuovere il container non appena si esce da esso;
- `-v` per specificare i volumi da montare nell'*host* e nel *container* `/from/host/:/on/container`

Nell'esempio di sopra sto montando la cartella corrente dell'*host* e la cartella `data` del *container*.

In **modo interattivo**, invece il comando diventa:

```bash
docker run -ti --rm -v "$(pwd)":/data osgeo/gdal:alpine-normal-latest /bin/sh
```

Si usa in questo esempio `/bin/sh`, perché lanciando l'`inspect` dell'immagine - `docker inspect osgeo/gdal:alpine-normal-latest` - si ha (vedi [qui](https://stackoverflow.com/a/29535285/757714)):

```json
"Cmd": [
    "/bin/sh",
    "-c",
    "#(nop) COPY dir:bfa76ede215e381fc0e06a919358cf3fe603fbc832802559c2e82eeec03e484d in /usr/ "
]
```
