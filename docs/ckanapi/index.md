---
hide:
  - navigation
#  - toc
title: ckanapi cli
---
# ckanapi cli

È [un'*utility*](../utilities/index.md#ckanapi) per per utilizzare le API di [CKAN](https://ckan.org/).<br>
`CKAN` è la piattaforma *open source* più usata per la realizzazione di portali open data: imparare a usare questo strumento è molto comodo, per interagire "a riga di comando" con tantissimi portali di questo tipo.

## Esempi di query

Le ricerche sono basate su `solr`, e per diversi campi non è una ricerca per stringa esatta (vedi [nota](#note-sulle-ricerche-fatte-su-ckan)).

### Ricerca per stringa

Ad esempio la stringa `furgoni`, in qualsiasi campo:

```
ckanapi -r https://dati.gov.it/opendata/ action package_search q='furgoni'
```

!!! note "Numero di risultati"

    Di default il numero di risultati presentati in un output di `package_search` è **pari a 10**. Per modificarlo bisogna introdurre il parametro `rows` (il valore massimo di default è pari a 1000).

### Il numero di risultati di una ricerca per dataset

L'azione `package_search` restituisce sempre in output, il parametro `count`. Si può allora impostare a `0` il numero di record di output da visualizzare (perché non si vuole qui leggere i dettagli dei risultati) ed estrarre dall'output del JSON soltanto `count`:

```
ckanapi -r https://dati.gov.it/opendata/ action package_search q='scuole' rows=0 | jq '.count'
```

La risposta è immediata, perché non vengono listate le decine di dataset che contengono la stringa `scuole`, ma soltanto il conteggio degli stessi.

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

### Ricerca dataset basata su field extra

Nei dataset spesso ci sono diversi campi descrittivi, nell'array `extras`. Due di esempio:

```json
{
  "key": "contact_email",
  "value": "dirigenteat@comune.copertino.le.it"
},
{
  "key": "contact_name",
  "value": "comune-di-copertino"
},
{
  "key": "identifier",
  "value": "c_c978:openpnrr-comune-di-copertino"
}
```

Per cercare tramite questi campi, si può usare il nome della `key`. Ad esempio:

```bash
ckanapi -r https://dati.gov.it/opendata/ action package_search fq='identifier:*pnrr*' rows=10
```

!!! note "Carattere jolly"

    `*` è il carattere jolly per le ricerche. Ad esempio con `identifier:*prova*` si avranno tutti i risultati che hanno come `identifier` "approvate", ma anche "approvadibomba".


### Ricerca per data di creazione dei metadati

```
ckanapi -r  https://dati.regione.sicilia.it action package_search fq='metadata_created:[2017-04-12T00:00:00Z TO 2022-06-30T23:59:05Z]' rows:1
```

Con `rows:1` prendo soltanto il primo risultato.

Oppure (è preferibile perché è un output jsonl)

```
ckanapi -r  https://dati.regione.sicilia.it search datasets fq='metadata_created:[2017-04-12T00:00:00Z TO 2022-06-30T23:59:05Z]' rows:1
```

### Ricerca dataset per formato delle risorse contenute

La ricerca di dataset per formato delle risorse contenute, dalla documentazione ufficiale non sembra possibile. È però possibile farlo, usando un parametro non documentato, di cui c'è traccia nella [documentazione sulle viste](https://docs.ckan.org/en/2.9/maintaining/data-viewer.html#migrating-from-previous-ckan-versions): `res_format`.

Per avere restituito ad esempio i dataset che contengono almeno una risorsa in formato `CSV`, il comando è:

```
ckanapi -r https://dati.gov.it/opendata/ search datasets fq='(res_format:"CSV")' rows=1
```

È possibile ovviamente arricchire la *query*, aggiungendo al filtro per formato, quello per organizzazione:

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

## Note sulle ricerche fatte su CKAN

Alcune delle ricerche fatte su CKAN, sfruttano come motore [`solr`](https://solr.apache.org/).<br>
Di `default`, su `solr`, i campi su cui è possibile eseguire una ricerca sono impostati come `type=text`, e su questi non è attiva una ricerca "esatta", ma sempre una ricerca *fuzzy*.<br>
Per la ricerca esatta i campi devono essere impostati come `type=string`.

Nello [schema `solr` di CKAN](https://github.com/ckan/ckan/blob/f2eb20ebf9de21016fd3d15ed028be1cce8d447c/ckan/config/solr/schema.xml) è possibile leggere il `type` dei vari campi. Ad esempio `res_format` è impostato come `string` e su questo sarà possibile eseguire ricerche esatte.
