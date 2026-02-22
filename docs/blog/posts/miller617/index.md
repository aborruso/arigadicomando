---
draft: false
date: 2026-02-21
authors:
  - aborruso
categories:
  - Strumenti
tags:
  - miller
  - release
  - yaml
  - dcf
description: "Miller 6.17.0 introduce YAML e DCF, regex più comode per reorder/nest e split con folder dedicata: cosa cambia davvero, con esempi input/output."
---

# Miller 6.17.0: YAML finalmente supportato

Ci sono release che aggiungono funzioni "belle da leggere", e release che ti fanno risparmiare tempo da subito.
La [release **Miller 6.17.0**](https://github.com/johnkerl/miller/releases/tag/v6.17.0) (pubblicata il **21 febbraio 2026**) è del secondo tipo: prende problemi reali emersi nelle issue e li trasforma in comandi più diretti.

Il risultato è semplice: meno passaggi intermedi, meno script collaterali, pipeline più corte.

<!-- more -->

![Open Graph della release Miller 6.17.0](images/miller617-og.jpg)

## YAML I/O nativo

Chi lavora con configurazioni, metadati, OpenAPI o cataloghi dati si trova spesso file YAML da esplorare al volo.
Prima, lo YAML non era un formato supportato da Miller: bisognava convertirlo in JSON (o CSV) con uno strumento esterno prima di poterlo elaborare.

**Prima** (YAML non era un formato di input/output di Miller)

Input (`input.yaml`):

```yaml
- id: 1
  city: Roma
  score: 10
- id: 2
  city: Milano
  score: 20
```

```bash
# Serviva una conversione esterna, ad esempio con yq
yq -o=json input.yaml | mlr --ijson --ocsv cat
```

Output:

```csv
city,id,score
Roma,1,10
Milano,2,20
```

**Dopo** (YAML è ora un formato nativo di Miller)

```bash
mlr --iyaml --ocsv cat input.yaml
```

Output:

```csv
city,id,score
Roma,1,10
Milano,2,20
```

Puoi trattare YAML come CSV/JSON nella stessa pipeline, senza passaggi manuali extra.

Esempio d'uso minimo con creazione campo derivato:

```yaml
- first_name: Ada
  last_name: Lovelace
- first_name: Alan
  last_name: Turing
```

```bash
mlr --yaml put '$full_name = $first_name . " " . $last_name' persone.yaml
```

Output:

```yaml
- first_name: Ada
  full_name: Ada Lovelace
  last_name: Lovelace
- first_name: Alan
  full_name: Alan Turing
  last_name: Turing
```

🎉 **Nota personale:** questa feature mi rende particolarmente orgoglioso, perché la richiesta iniziale è partita proprio da me con l'issue [#614](https://github.com/johnkerl/miller/issues/614).

## Supporto DCF (Debian Control Format)

DCF (*Debian Control Format*) è un formato testuale usato storicamente nei metadati dei pacchetti Debian e, più in generale, in file descrittivi composti da record.
Ogni record contiene campi `chiave: valore`, può avere righe di continuazione per i campi lunghi, e i record sono separati da una riga vuota.
Prima si ricorreva spesso a workaround con `grep`/`sed` prima di passare i dati a Miller.

**Prima**

Input (`sample.dcf`):

```text
Package: foo
Version: 1.0
Depends: libc6 (>= 2.0), libfoo (>= 1.2)
Description: A test package.

Package: bar
Version: 2.0
Recommends: foo
Description: Another package.
```

**Dopo**

```bash
mlr --idcf --ojson cat sample.dcf
```

Output:

```json
[
  {
    "Package": "foo",
    "Version": "1.0",
    "Depends": ["libc6 (>= 2.0)", "libfoo (>= 1.2)"],
    "Description": "A test package."
  },
  {
    "Package": "bar",
    "Version": "2.0",
    "Recommends": ["foo"],
    "Description": "Another package."
  }
]
```

È un miglioramento pratico quando i file hanno continuation lines e campi non sempre uguali tra record.

Verbi correlati: [`cat`](https://miller.readthedocs.io/en/6.17.0/reference-verbs/#cat).

## `reorder -r`: riordinare colonne con regex

Quando lo schema è variabile ma i prefissi sono stabili (`YYY_*`, `XXX_*`), elencare i campi uno per uno è fragile.

**Prima**

Input (`input.csv`):

```csv
id,YYY_city,foo,YYY_region,XXX_score,bar
1,Roma,a,Lazio,10,x
2,Milano,b,Lombardia,20,y
```

```bash
mlr --icsv --ocsv reorder -f YYY_city,YYY_region,XXX_score input.csv
```

Output:

```csv
YYY_city,YYY_region,XXX_score,id,foo,bar
Roma,Lazio,10,1,a,x
Milano,Lombardia,20,2,b,y
```

**Dopo**

```bash
mlr --icsv --ocsv reorder -r '^YYY,^XXX' input.csv
```

Output:

```csv
YYY_city,YYY_region,XXX_score,id,foo,bar
Roma,Lazio,10,1,a,x
Milano,Lombardia,20,2,b,y
```

Utile soprattutto nei dataset dove le colonne cambiano spesso ma seguono convenzioni di naming.

Verbi correlati: [`reorder`](https://miller.readthedocs.io/en/6.17.0/reference-verbs/#reorder).

## `nest -r`: selezione regex dei campi target

`nest` serve a esplodere o implodere campi con valori multipli delimitati: ad esempio trasforma un campo `tags=a;b;c` in tre campi separati (`tags_1`, `tags_2`, `tags_3`), oppure fa l'operazione inversa.
È utile ogni volta che dati strutturati sono compressi in un singolo campo con un separatore interno.

Nei dati reali capita di avere famiglie di colonne con nomi molto simili tra loro (`tags_1`, `tags_2`, `tags_3`, ...).
Prima, quando volevi usare nest, eri costretto a elencare hardcoded ogni campo per nome, uno per uno con `-f`.
Ora puoi selezionarli tutti in una sola chiamata usando una regex con `-r`: se domani compare `tags_5`, non devi toccare il comando.

**Prima**

Input (`input.csv`):

```csv
id,tags_1,tags_2,tags_3,tags_4,other
1,alpha;beta,gamma,delta,uno;due,z
2,red;blue,green,black,tre;quattro,k
```

```bash
mlr --icsv --ocsv nest --explode --values --across-fields -f tags_1 -f tags_2 -f tags_3 input.csv
```

Output:

```csv
id,tags_1,tags_2,tags_3_1,tags_4,other
1,alpha;beta,gamma,delta,uno;due,z
2,red;blue,green,black,tre;quattro,k
```

**Dopo**

```bash
mlr --icsv --ocsv nest --explode --values --across-fields -r '^tags_' input.csv
```

Output:

```csv
id,tags_1_1,tags_1_2,tags_2_1,tags_3_1,tags_4_1,tags_4_2,other
1,alpha,beta,gamma,delta,uno,due,z
2,red,blue,green,black,tre,quattro,k
```

Meno manutenzione quando aumentano o cambiano i campi della stessa famiglia.

🎉 **Nota personale:** anche questa mi rende felice: la richiesta iniziale era mia, nell'issue [#381](https://github.com/johnkerl/miller/issues/381).

Verbi correlati: [`nest`](https://miller.readthedocs.io/en/6.17.0/reference-verbs/#nest).

## `split --folder`: output diretto in cartella

Qui la novità non è nel risultato finale (i file prodotti), ma nel modo in cui lo esprimi.
Prima si usava spesso `--prefix` con path incorporato: funzionava, ma mescolava directory di destinazione e nome base dei file in un solo parametro.
Con `--folder` le due cose sono separate e il comando è più leggibile/manutenibile.

**Prima**

Input (`input.csv`):

```csv
id,city
1,Roma
2,Milano
3,Torino
```

```bash
mlr --icsv split -m 10 --prefix /tmp/test --suffix csv input.csv
```

Output (file creati):

```text
/tmp/test_1.csv
/tmp/test_2.csv
/tmp/test_3.csv
```

**Dopo**

```bash
mlr --icsv split -m 10 --folder /tmp --prefix test --suffix csv input.csv
```

Output (file creati):

```text
/tmp/test_1.csv
/tmp/test_2.csv
/tmp/test_3.csv
```

Quindi: stesso output, ma semantica migliore del comando.
Separare *destinazione* (`--folder`) e *nome file* (`--prefix`) rende script e automazioni più leggibili e meno ambigui.

Verbi correlati: [`split`](https://miller.readthedocs.io/en/6.17.0/reference-verbs/#split).

---

Questa non è una release "solo tecnica":
aggiunge due formati richiesti da tempo (YAML, DCF) e migliora tre verbi usati ogni giorno (`reorder`, `nest`, `split`) nei punti dove prima servivano workaround.

Per chi lavora con dati da riga di comando, è una release che si sente subito.
E oltre alle novità raccontate qui, include anche diversi bugfix e altre modifiche interne che rendono Miller ancora più solido.

## Fonti

- Release `v6.17.0`: <https://github.com/johnkerl/miller/releases/tag/v6.17.0>
- PR YAML: <https://github.com/johnkerl/miller/pull/1963>
- Issue YAML: <https://github.com/johnkerl/miller/issues/614>
- PR DCF: <https://github.com/johnkerl/miller/pull/1970>
- Issue DCF: <https://github.com/johnkerl/miller/issues/1804>
- PR `reorder -r`: <https://github.com/johnkerl/miller/pull/1960>
- Issue `reorder -r`: <https://github.com/johnkerl/miller/issues/1325>
- PR `nest -r`: <https://github.com/johnkerl/miller/pull/1961>
- Issue `nest -r`: <https://github.com/johnkerl/miller/issues/381>
- PR `split --folder`: <https://github.com/johnkerl/miller/pull/1962>
- Issue `split --folder`: <https://github.com/johnkerl/miller/issues/1754>
- Discussion origine `split --folder`: <https://github.com/johnkerl/miller/discussions/1402>
