# Dalle frasi agli insight: `tokenize` + `vocab`

Se parti da testo libero, questa coppia è il motivo per cui `xan` sorprende:

- `tokenize` spezza il testo in token utili (parole, punteggiatura, ecc.);
- `vocab` trasforma quei token in metriche lessicali pronte da leggere.

Con pochi comandi passi da frasi grezze a segnali quantitativi come frequenze, importanza dei termini (TF-IDF) e relazione documento-termine.

## Dataset di partenza

Usa il file di esempio: `docs/xan/risorse/testi-mini.csv`

- CSV nel repository: [docs/xan/risorse/testi-mini.csv](https://github.com/aborruso/arigadicomando/blob/master/docs/xan/risorse/testi-mini.csv)
- Download diretto CSV: [raw.githubusercontent.com/.../testi-mini.csv](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/testi-mini.csv)

Estratto input:

```csv
id,titolo,testo
1,Bici urbana,"La ciclabile collega il centro alla stazione. Più bici, meno auto."
2,Verde pubblico,"Nuovi alberi nel quartiere: aria più pulita e strade più vivibili."
3,Mobilità casa-scuola,"Pedibus e zone 30 riducono traffico e rumore davanti alle scuole."
```

## Step 1: Tokenizzazione (`tokenize`)

Nel comando seguente, `words testo` significa:

- `words`: modalità di tokenizzazione per parole;
- `testo`: nome della colonna da tokenizzare (solo quel campo viene analizzato).
- `-T tipo`: aggiunge la colonna `tipo` (es. `word`, `punct`) e produce una riga per token.

```bash
xan tokenize words testo -T tipo --lower --drop punct docs/xan/risorse/testi-mini.csv > /tmp/token.csv
```

Porzione output (`/tmp/token.csv`):

```csv
id,titolo,token,tipo
1,Bici urbana,la,word
1,Bici urbana,ciclabile,word
1,Bici urbana,collega,word
1,Bici urbana,più,word
2,Verde pubblico,nuovi,word
2,Verde pubblico,alberi,word
```

Cosa sta succedendo:

- ogni parola diventa una riga;
- `id` e `titolo` restano attaccati al token, quindi non perdi il contesto;
- con `--lower --drop punct` normalizzi il testo ed elimini la punteggiatura.

## Step 2: Fotografia del corpus (`vocab corpus`)

Input: il file tokenizzato `/tmp/token.csv`.

Parametri chiave:

- `--doc id`: usa la colonna `id` come identificatore del documento;
- `--token token`: usa la colonna `token` come colonna dei token;
- `--implode`: indica che l'input ha già un token per riga (come l'output di `tokenize words` con `-T`).

```bash
xan vocab corpus --doc id --token token --implode /tmp/token.csv
```

Porzione output:

```csv
doc_count,token_count,distinct_token_count,average_doc_len
5,51,44,10.2
```

Cosa leggere:

- `doc_count`: quanti documenti analizzi;
- `doc_count`: numero di documenti unici nel corpus (identificati da `--doc`, qui `id`);
- `token_count`: volume totale del lessico;
- `distinct_token_count`: varietà lessicale;
- `average_doc_len`: lunghezza media (in token) dei documenti.

## Step 3: Parole chiave del corpus (`vocab token`)

Input: sempre `/tmp/token.csv`.

Parametri chiave:

- `--doc id`: raggruppa i token per documento;
- `--token token`: legge i token dalla colonna `token`;
- `--implode`: necessario perché il file è già in formato “un token per riga”.

```bash
xan vocab token --doc id --token token --implode /tmp/token.csv
```

Porzione output:

```csv
token,gf,df,df_ratio,idf,gfidf,pigeon
più,4,3,0.6,0.5108256237659907,6.666666666666667,0.9839999999999999
e,5,4,0.8,0.22314355131420976,6.25,0.8403999999999999
```

Cosa leggere:

- `gf`: quante volte una parola compare nel corpus;
- `df`: in quanti documenti compare;
- `idf`: quanto la parola è discriminante (più alto = più distintiva).

## Step 4: Relazione documento-parola (`vocab doc-token`)

Input: sempre `/tmp/token.csv`.

Parametri chiave:

- `--doc id`: calcola le metriche per coppia documento-termine;
- `--token token`: definisce il termine da analizzare;
- `--implode`: usa correttamente l'input già esploso in token.

```bash
xan vocab doc-token --doc id --token token --implode /tmp/token.csv
```

Porzione output:

```csv
id,token,tf,expected_tf,tfidf,bm25,chi2
2,più,2,0.8627450980392157,1.0216512475319814,0.6872258391671962,2.0740328820116054
3,e,2,1.0784313725490196,0.44628710262841953,0.30020031723566354,1.1132312252964427
1,collega,1,0.21568627450980393,1.6094379124341003,1.5594035731874445,3.7090909090909085
```

Significato colonne:

- `id`: identificatore del documento (nel nostro caso il valore della colonna `id`).
- `token`: termine analizzato.
- `tf`: frequenza del termine nel documento.
- `expected_tf`: frequenza attesa del termine nel documento, data la distribuzione nel corpus e la lunghezza del documento.
- `tfidf`: peso del termine nel documento rispetto all'intero corpus (più alto = più caratteristico).
- `bm25`: punteggio di rilevanza del termine con normalizzazione sulla lunghezza del documento.
- `chi2`: significatività statistica dell'associazione termine-documento.

Cosa leggere:

- qui non vedi solo parole globali: vedi **parola dentro documento**;
- `tfidf` e `bm25` aiutano a capire quali termini caratterizzano un documento specifico;
- è il passaggio che trasforma la tokenizzazione in insight azionabili (ranking, confronto documenti, ricerca semantica di base).

## Perché ti potrebbe essere utile

I casi sotto sono volutamente descritti ad alto livello: servono a dare il senso di analisi più complesse da costruire. In questi percorsi `xan` è un ottimo strumento di accompagnamento, perché aiuta a passare rapidamente dall'intuizione ai primi segnali misurabili.

1. Inchiesta su delibere, bandi o atti pubblici.
   In pochi minuti individui parole e temi che distinguono un ente, un periodo o un assessore, e scopri dove cambiano priorità e linguaggio.
2. Analisi di campagne elettorali e discorsi politici.
   Metti a confronto programmi e interventi: `tfidf` e `bm25` evidenziano i termini davvero identitari di ogni candidato, non solo quelli più frequenti.
3. Monitoraggio media e comunicati stampa.
   Su centinaia di testi trovi subito i frame narrativi dominanti e i termini emergenti, utile per titolare, contestualizzare e costruire grafici comparativi.
