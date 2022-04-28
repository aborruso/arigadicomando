# Da ordinare

# Esempi di query

La ricerca è basata su `solr`, e non è una ricerca per stringa esatta.

## Ricerca per titolo

Tutti i dataset che hanno nel titolo la parola `farmacie`:

```
ckanapi -r https://dati.gov.it/opendata/ search datasets q='(title:farmacie)'
```

Tutti i dataset che hanno nel titolo le parola `farmacie` e `anno`:

```
ckanapi -r https://dati.gov.it/opendata/ search datasets q='(title:farmacie title:anno)'
```

Tutti i dataset che hanno nel titolo le parola `farmacie` o `distributori`:

```
ckanapi -r https://dati.gov.it/opendata/ search datasets q='(title:farmacie OR title:distributori)'
```

## Ricerca per data di creazione dei metadati

```
ckanapi -r  https://dati.regione.sicilia.it action package_search fq='metadata_created:[2017-04-12T00:00:00Z TO 2022-06-30T23:59:05Z]' rows:1
```

Con `rows:1` prendo soltanto il primo risultato.

Oppure (è preferibile perché è un output jsonl)

```
ckanapi -r  https://dati.regione.sicilia.it search datasets fq='metadata_created:[2017-04-12T00:00:00Z TO 2022-06-30T23:59:05Z]' rows:1
```

# Esempi di filtri

## Tutti i dataset con 30 tag

```
ckanapi -r https://dati.gov.it/opendata/ search datasets fq='(num_tags:30)'
```

## Tutti i dataset di un'organizzazione

```
ckanapi -r https://dati.toscana.it/ search datasets fq='(organization:"comune-di-firenze")' -O datasets.jsonl.gz -z
```

Nota:

- `-O` per definire il file di output
- `-z` per impostare il file di output come file compresso

# Download

```bash
URL="https://mysample.url"
ckanapi -r "$URL" search datasets fq='(title:"taxes")' | \
jq -r '.id' | \
xargs -I _ ckanapi -r "$URL" dump datasets _ --datapackages=./out
```

Vedi <https://github.com/ckan/ckanapi/issues/197#issuecomment-1069173069>

# Varie

## Numero di dataset per organizzazione

```
ckanapi -r https://dati.toscana.it/ action package_search facet.field:'["organization"]' rows:0
```
