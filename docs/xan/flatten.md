# Ispezionare i record in verticale con `xan flatten`

Quando un CSV ha molte colonne, la vista tabellare standard diventa difficile da leggere: i valori si spostano fuori schermo e perdi il contesto dei campi.

`xan flatten` ribalta la prospettiva: mostra ogni record in verticale, con il nome del campo a sinistra e il valore a destra. È pensato per esplorare i dati uno alla volta, senza bisogno di scrollare orizzontalmente.

## Dataset di esempio

Usa il file di esempio: `docs/xan/risorse/flatten/biblioteche.csv`

- CSV nel repository: [docs/xan/risorse/flatten/biblioteche.csv](https://github.com/aborruso/arigadicomando/blob/master/docs/xan/risorse/flatten/biblioteche.csv)
- Download diretto CSV: [raw.githubusercontent.com/.../biblioteche.csv](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/flatten/biblioteche.csv)

Il file contiene 5 biblioteche toscane con 16 colonne: dati anagrafici, contatti, orari, servizi. Molte celle sono vuote perché non tutte le biblioteche hanno tutti i servizi.

Estratto input:

```csv
id,nome,comune,provincia,indirizzo,telefono,email,sito_web,orario_lun_ven,orario_sab,orario_dom,...
1,Biblioteca Nazionale Centrale,Firenze,FI,Piazza dei Cavalleggeri 1,055 249191,bncf@...,https://...,08:15-19:15,08:15-13:30,,400,...
2,Biblioteca Medicea Laurenziana,Firenze,FI,Piazza San Lorenzo 9,055 210760,bml@...,https://...,08:00-13:30,,,30,...
```

## Uso base

```bash
xan flatten biblioteche.csv
```

Output (prima riga):

```
Row n°0
────────────────────────────────────────────────────────────────────────────────
id               1
nome             Biblioteca Nazionale Centrale
comune           Firenze
provincia        FI
indirizzo        Piazza dei Cavalleggeri 1
telefono         055 249191
email            bncf@beniculturali.it
sito_web         https://www.bncf.firenze.sbn.it
orario_lun_ven   08:15-19:15
orario_sab       08:15-13:30
orario_dom       <empty>
posti_lettura    400
sale_studio      6
wifi             sì
accesso_disabili sì
note             Deposito legale
```

Ogni campo compare su una riga separata. Le celle vuote appaiono come `<empty>` (qui mostrata soltanto la prima riga, per dare un'idea di come funziona).

Puoi limitare il numero di righe da leggere con `-l`:

```bash
xan flatten -l 3 biblioteche.csv
```

## Solo i campi compilati (`-N`)

Con dati sparsi — dove molte celle sono vuote — la vista standard riempie lo schermo di `<empty>` e diventa difficile da leggere.

L'opzione `-N` (o `--non-empty`) mostra solo i campi che hanno un valore:

```bash
xan flatten -N biblioteche.csv
```

Output della seconda riga (biblioteca con molti campi vuoti):

```
Row n°1
────────────────────────────────────────────────────────────────────────────────
id               2
nome             Biblioteca Medicea Laurenziana
comune           Firenze
provincia        FI
indirizzo        Piazza San Lorenzo 9
telefono         055 210760
email            bml@beniculturali.it
sito_web         https://bml.firenze.sbn.it
orario_lun_ven   08:00-13:30
posti_lettura    30
wifi             sì
accesso_disabili sì
note             Solo consultazione
```

Rispetto alla vista normale, spariscono `orario_sab`, `orario_dom` e `sale_studio` — che per questa biblioteca non sono compilati. Vedi subito cosa c'è, senza rumore.

## Selezionare le colonne (`-s`)

Se vuoi visualizzare solo alcune colonne puoi usare `-s`:

```bash
xan flatten -s "nome,comune,telefono,email,orario_lun_ven" -l 3 biblioteche.csv
```

Output:

```
Row n°0
────────────────────────────────────────────────────────────────────────────────
nome           Biblioteca Nazionale Centrale
comune         Firenze
telefono       055 249191
email          bncf@beniculturali.it
orario_lun_ven 08:15-19:15

Row n°1
────────────────────────────────────────────────────────────────────────────────
nome           Biblioteca Medicea Laurenziana
comune         Firenze
telefono       055 210760
email          bml@beniculturali.it
orario_lun_ven 08:00-13:30

Row n°2
────────────────────────────────────────────────────────────────────────────────
nome           Biblioteca Comunale
comune         Prato
telefono       0574 1837801
email          biblioteca@comune.prato.it
orario_lun_ven 09:00-19:00
```

Utile quando vuoi fare una verifica rapida su un sottoinsieme di campi senza caricare tutto l'output.

## Navigare file grandi con il pager

Per file con molti record, puoi scorrere l'output con `less`. Per mantenere i colori usa `--color always` e il flag `-r` di `less`:

```bash
xan flatten --color always biblioteche.csv | less -Sr
```

`-S` in `less` disabilita il word wrap orizzontale, `-r` mantiene i colori ANSI.

## Vista compatta (`-c`)

Con `--condense` (o `-c`) i valori lunghi vengono troncati con `…` anziché andare a capo. Utile per avere una panoramica veloce senza che i valori occupino più righe:

```bash
xan flatten -c biblioteche.csv
```

```
Row n°0
────────────────────────────────────────────────────────────────────────────────
id               1
nome             Biblioteca Nazionale Centrale
comune           Firenze
provincia        FI
indirizzo        Piazza dei Cavalleggeri 1
telefono         055 249191
email            bncf@beniculturali.it
sito_web         https://www.bncf.firenze.sbn.it
orario_lun_ven   08:15-19:15
orario_sab       08:15-13:30
orario_dom       <empty>
posti_lettura    400
sale_studio      6
wifi             sì
accesso_disabili sì
note             Deposito legale
```

## Vista per testo lungo (`-F`)

L'opzione `-F` (`--flatter`) mette il nome del campo e il valore su righe separate, con una riga vuota tra ogni campo. Torna utile quando le celle contengono testi lunghi (descrizioni, note, paragrafi) che altrimenti si sovrappongono visivamente al nome del campo:

```bash
xan flatten -F -N -l 1 biblioteche.csv
```

```
Row n°0
────────────────────────────────────────────────────────────────────────────────
id
1

nome
Biblioteca Nazionale Centrale

comune
Firenze

provincia
FI

indirizzo
Piazza dei Cavalleggeri 1

...
```

## Separatore personalizzato tra record (`--row-separator`)

Di default ogni record è preceduto da un'intestazione con il numero di riga. Con `--row-separator` puoi sostituirla con qualsiasi stringa:

```bash
xan flatten --row-separator "---" -N -l 3 biblioteche.csv
```

```
id               1
nome             Biblioteca Nazionale Centrale
comune           Firenze
...
---
id               2
nome             Biblioteca Medicea Laurenziana
...
---
id               3
nome             Biblioteca Comunale
...
```

Usando `--row-separator ''` (stringa vuota) i record si susseguono senza alcuna separazione.

## Esportare come CSV (`--csv`)

Con `--csv` l'output non è testo formattato ma un CSV con tre colonne: `row` (indice del record), `field` (nome del campo), `value` (valore). È un'operazione di unpivot — utile per elaborare ulteriormente i dati in verticale:

```bash
xan flatten --csv -l 2 biblioteche.csv
```

```csv
row,field,value
0,id,1
0,nome,Biblioteca Nazionale Centrale
0,comune,Firenze
0,provincia,FI
0,indirizzo,Piazza dei Cavalleggeri 1
0,telefono,055 249191
0,email,bncf@beniculturali.it
0,sito_web,https://www.bncf.firenze.sbn.it
0,orario_lun_ven,08:15-19:15
0,orario_sab,08:15-13:30
0,orario_dom,
0,posti_lettura,400
0,sale_studio,6
0,wifi,sì
0,accesso_disabili,sì
0,note,Deposito legale
1,id,2
1,nome,Biblioteca Medicea Laurenziana
...
```

## Evidenziare valori (`-H`)

Con `-H` puoi mettere in evidenza le celle che corrispondono a un pattern regex. Torna utile quando cerchi un valore specifico tra molti campi:

```bash
xan flatten -H "sì" -l 1 biblioteche.csv
```

Le celle che contengono `sì` vengono evidenziate in rosso nel terminale.

Puoi abbinare `-i` per rendere il pattern case-insensitive:

```bash
xan flatten -H "firenze" -i biblioteche.csv
```

## Riepilogo opzioni principali

| Opzione | Cosa fa |
|---|---|
| `-l <n>` | Legge solo le prime `n` righe |
| `-N`, `--non-empty` | Mostra solo i campi compilati |
| `-s <colonne>` | Seleziona un sottoinsieme di colonne |
| `-c`, `--condense` | Tronca valori lunghi con `…` |
| `-F`, `--flatter` | Valore su riga separata (utile per testi lunghi) |
| `--csv` | Output come CSV con colonne `row,field,value` |
| `-H <pattern>` | Evidenzia celle che corrispondono al pattern |
| `-i` | Pattern case-insensitive (da usare con `-H`) |
| `--row-separator` | Stringa separatrice tra record |
| `--color always` | Forza i colori ANSI (utile con `less -Sr`) |
