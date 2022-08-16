---
hide:
  - navigation
#  - toc
title: frictionless
---
# ckanapi cli

## Esempi di query

La ricerca è basata su `solr`, e non è una ricerca per stringa esatta.

### Ricerca per titolo

Tutti i dataset che hanno nel titolo la parola `farmacie`:

```
ckanapi -r https://dati.gov.it/opendata/ search datasets q='(title:"farmacie")'
```

Tutti i dataset che hanno nel titolo le parola `farmacie` e `anno`:

```
ckanapi -r https://dati.gov.it/opendata/ search datasets q='(title:"farmacie" title:"anno")'
```

Tutti i dataset che hanno nel titolo le parola `farmacie` o `distributori`:

```
ckanapi -r https://dati.gov.it/opendata/ search datasets q='(title:"farmacie" OR title:"distributori")'
```

### Ricerca per data di creazione dei metadati

```
ckanapi -r  https://dati.regione.sicilia.it action package_search fq='metadata_created:[2017-04-12T00:00:00Z TO 2022-06-30T23:59:05Z]' rows:1
```

Con `rows:1` prendo soltanto il primo risultato.

Oppure (è preferibile perché è un output jsonl)

```
ckanapi -r  https://dati.regione.sicilia.it search datasets fq='metadata_created:[2017-04-12T00:00:00Z TO 2022-06-30T23:59:05Z]' rows:1
```

### Ricerca dataset per formato risorsa

La ricerca di dataset per formato delle risorse contenute, dalla documentazione ufficiale non sembra possibile. È però possibile farlo, usando un parametro non documentato, di cui c'è traccia nella [documentazione sulle viste](https://docs.ckan.org/en/2.9/maintaining/data-viewer.html#migrating-from-previous-ckan-versions): `res_format`.

```
ckanapi -r https://dati.gov.it/opendata/ search datasets fq='(res_format:"CSV")' rows=1
```

È possibile ovviamente mettere arricchire la query. Ad esempio combinando con il nome dell'organizzazione:

```
ckanapi -r https://dati.gov.it/opendata/ search datasets fq='(res_format:"CSV" AND organization:"regione-toscana")' rows=1
```

Ad agosto del 2022, la cosa risulta ancora non documentata: <https://github.com/ckan/ckan/discussions/7013>.

### Utilizzare più parametri di ricerca di un dataset e combinarli in AND

```
ckanapi search datasets -r https://dati.gov.it/opendata/ fq='(organization:"comune-di-torino" AND groups:"ambiente")' rows=1
```

Nota bene: `rows=1` limita l'output a un solo risultato. Qui è inserito soltanto per testare la *query*.


## Esempi di filtri

### Tutti i dataset con 30 tag

```
ckanapi -r https://dati.gov.it/opendata/ search datasets fq='(num_tags:30)'
```

### Tutti i dataset di un'organizzazione

```
ckanapi -r https://dati.toscana.it/ search datasets fq='(organization:"comune-di-firenze")' -O datasets.jsonl.gz -z
```

Note:

- `-O` per definire il file di output. È un JSON Lines;
- `-z` per avere l'output JSON Lines compresso in gzip.

## Varie

### Numero di dataset per organizzazione

```
ckanapi -r https://dati.toscana.it/ action package_search facet.field:'["organization"]' rows:0
```

### Numero di dataset per un dato gruppo tematico

```
ckanapi -r https://dati.gov.it/opendata/ action package_search fq='(groups:"ambiente")' facet.field:'["organization"]' rows=0
```

### Download dei risultati di una ricerca in loop

```bash
URL="https://mysample.url"
ckanapi -r "$URL" search datasets fq='(title:"taxes")' | \
jq -r '.id' | \
xargs -I _ ckanapi -r "$URL" dump datasets _ --datapackages=./out
```

Vedi <https://github.com/ckan/ckanapi/issues/197#issuecomment-1069173069>
