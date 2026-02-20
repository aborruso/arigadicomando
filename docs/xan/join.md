# Join con xan: casi base, fuzzy, regex e URL

Questa pagina mostra i casi principali di join con esempi minimi.

Questa guida è scritta per il comportamento di `xan 0.56.0` o superiore:

- join classici con `xan join`;
- join fuzzy/regex/url con `xan fuzzy-join` (`-r` per regex, `-u` per URL prefix).

## File di esempio (download raw)

- [`dati_a.csv`](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/dati_a.csv)
- [`dati_b.csv`](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/dati_b.csv)
- [`persone.csv`](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/persone.csv)
- [`ordini.csv`](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/ordini.csv)
- [`lettere.csv`](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/lettere.csv)
- [`numeri.csv`](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/numeri.csv)
- [`testi.csv`](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/testi.csv)
- [`pattern.csv`](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/pattern.csv)
- [`pattern_fuzzy.csv`](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/pattern_fuzzy.csv)
- [`link.csv`](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/link.csv)
- [`sorgenti_url.csv`](https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/sorgenti_url.csv)

Per eseguire i comandi così come sono scritti sotto, posizionati nella cartella:

```bash
cd docs/xan/risorse/join
```

## 1) Join standard (`xan join`)

Sintassi base:

```bash
xan join [opzioni] <campi_sx> <file_sx.csv> <campi_dx> <file_dx.csv>
```

Parametri chiave:

- `<campi_sx>`: una o più colonne chiave del file di sinistra (es. `id` oppure più campi separati da virgola `anno,comune`);
- `<file_sx.csv>`: CSV di sinistra;
- `<campi_dx>`: una o più colonne chiave del file di destra, nello stesso ordine di `<campi_sx>`;
- `<file_dx.csv>`: CSV di destra.

Regola pratica:

- puoi fare join su **un campo** (`id`);
- puoi fare join su **più campi** (`anno,comune`), ma il numero dei campi deve coincidere a sinistra e a destra.

Esempio multi-colonna:

`dati_a.csv`

```csv
anno,comune,valore_a
2024,Roma,10
2024,Milano,20
2025,Roma,30
```

`dati_b.csv`

```csv
anno,comune,valore_b
2024,Roma,100
2025,Roma,300
2025,Torino,400
```

```bash
xan join anno,comune dati_a.csv anno,comune dati_b.csv
```

Output (estratto):

```csv
anno,comune,valore_a,valore_b
2024,Roma,10,100
2025,Roma,30,300
```

Input usati negli esempi:

`persone.csv`

```csv
id,nome,citta
1,Ada,Roma
2,Luca,Milano
3,Sara,Torino
```

`ordini.csv`

```csv
id,ordine,valore
1,Penna,5
2,Taccuino,8
4,Zaino,35
```

### Inner join (default)

```bash
xan join id persone.csv id ordini.csv
```

Output (estratto):

```csv
id,nome,citta,ordine,valore
1,Ada,Roma,Penna,5
2,Luca,Milano,Taccuino,8
```

### Left join

```bash
xan join --left id persone.csv id ordini.csv
```

Output (estratto):

```csv
id,nome,citta,ordine,valore
1,Ada,Roma,Penna,5
2,Luca,Milano,Taccuino,8
3,Sara,Torino,,
```

### Right join

```bash
xan join --right id persone.csv id ordini.csv
```

Output (estratto):

```csv
nome,citta,id,ordine,valore
Ada,Roma,1,Penna,5
Luca,Milano,2,Taccuino,8
,,4,Zaino,35
```

### Full join

```bash
xan join --full id persone.csv id ordini.csv
```

Output (estratto):

```csv
id,nome,citta,ordine,valore
1,Ada,Roma,Penna,5
2,Luca,Milano,Taccuino,8
,,,Zaino,35
3,Sara,Torino,,
```

### Cross join

Input usati:

`lettere.csv`

```csv
lettera
A
B
```

`numeri.csv`

```csv
numero
1
2
```

```bash
xan join --cross lettere.csv numeri.csv
```

Output:

```csv
lettera,numero
A,1
A,2
B,1
B,2
```

## 2) Fuzzy join (substring)

Esempio classico: hai una lista di parole/etichette e vuoi agganciare i testi dove compaiono.

Sintassi usata:

```bash
xan fuzzy-join [opzioni] <colonna_testo> <file_testi.csv> <colonna_pattern> <file_pattern.csv>
```

Parametri chiave:

- `-i`: confronto case-insensitive (ignora maiuscole/minuscole);
- `--left`: mantiene tutte le righe del file testi anche quando non c'è match;
- `<colonna_testo>`: colonna in cui cercare (qui `testo`);
- `<file_testi.csv>`: file dove cercare (qui `testi.csv`);
- `<colonna_pattern>`: colonna con le stringhe/pattern da cercare (qui `needle`);
- `<file_pattern.csv>`: file che contiene i pattern (qui `pattern_fuzzy.csv`).

Input usati:

`testi.csv`

```csv
id,testo
1,"Il Comune di Roma annuncia nuovi cantieri sulla mobilità urbana."
2,"Bando scuola digitale per laboratori e formazione docenti a Milano."
3,"Nuovo parco urbano con 300 alberi nel quartiere nord."
```

`pattern_fuzzy.csv`

```csv
tema,needle
scuola,scuola
mobilita,mobilita
verde,parco
```

```bash
xan fuzzy-join -i testo testi.csv needle pattern_fuzzy.csv
```

Lettura rapida del comando:

- cerca in `testo` (dentro `testi.csv`) i valori di `needle` (dentro `pattern_fuzzy.csv`);
- con `-i` trova match anche se cambia il maiuscolo/minuscolo.

Output (estratto):

```csv
id,testo,tema,needle
2,Bando scuola digitale per laboratori e formazione docenti a Milano.,scuola,scuola
3,Nuovo parco urbano con 300 alberi nel quartiere nord.,verde,parco
```

Versione left (mantiene tutte le righe dei testi):

```bash
xan fuzzy-join -i --left testo testi.csv needle pattern_fuzzy.csv
```

Differenza rispetto al comando precedente:

- con `--left` ottieni anche le righe senza match, con colonne pattern vuote.

Output (estratto):

```csv
id,testo,tema,needle
1,Il Comune di Roma annuncia nuovi cantieri sulla mobilità urbana.,,
2,Bando scuola digitale per laboratori e formazione docenti a Milano.,scuola,scuola
3,Nuovo parco urbano con 300 alberi nel quartiere nord.,verde,parco
```

## 3) Regex join (nel tuo ambiente)

Sintassi usata:

```bash
xan fuzzy-join -r [opzioni] <colonna_testo> <file_testi.csv> <colonna_regex> <file_regex.csv>
```

Parametri chiave:

- `-r`: attiva il matching via espressioni regolari;
- `-i`: rende il matching case-insensitive;
- `<colonna_testo>`: colonna in cui cercare (qui `testo`);
- `<file_testi.csv>`: file da analizzare (qui `testi.csv`);
- `<colonna_regex>`: colonna con i pattern regex (qui `pattern`);
- `<file_regex.csv>`: file che contiene i regex pattern (qui `pattern.csv`).

Input aggiuntivo usato:

`pattern.csv`

```csv
tema,pattern
scuola,scuola
mobilita,mobilit[aà]
verde,parco|alberi
```

```bash
xan fuzzy-join -r -i testo testi.csv pattern pattern.csv
```

Lettura rapida del comando:

- cerca in `testo` i pattern regex definiti nella colonna `pattern`;
- con `-r` interpreta i pattern come regex, non come semplice sottostringa.

Output (estratto):

```csv
id,testo,tema,pattern
1,Il Comune di Roma annuncia nuovi cantieri sulla mobilità urbana.,mobilita,mobilit[aà]
2,Bando scuola digitale per laboratori e formazione docenti a Milano.,scuola,scuola
3,Nuovo parco urbano con 300 alberi nel quartiere nord.,verde,parco|alberi
```

Quando usarlo:

- hai una tabella di pattern (keyword o regex);
- vuoi etichettare automaticamente testi con tema/categoria.

## 4) URL join (nel tuo ambiente)

Sintassi usata:

```bash
xan fuzzy-join -u [opzioni] <colonna_url> <file_link.csv> <colonna_prefisso> <file_sorgenti.csv>
```

Parametri chiave:

- `-u`: attiva il matching per prefisso URL;
- `-S`: semplifica gli URL prima del confronto (schema, `www`, ecc.);
- `<colonna_url>`: colonna con gli URL da classificare (qui `link`);
- `<file_link.csv>`: file con gli URL completi (qui `link.csv`);
- `<colonna_prefisso>`: colonna con i prefissi/domini da usare come riferimento (qui `url`);
- `<file_sorgenti.csv>`: file con la mappatura sorgenti (qui `sorgenti_url.csv`).

Input usati:

`link.csv`

```csv
link
https://www.comune.roma.it/notizie/mobilita
https://dati.regione.lombardia.it/dataset/trasporti
https://example.org/post/1
```

`sorgenti_url.csv`

```csv
fonte,url
comune-roma,comune.roma.it
regione-lombardia,dati.regione.lombardia.it
```

```bash
xan fuzzy-join -u -S link link.csv url sorgenti_url.csv
```

Lettura rapida del comando:

- confronta ogni valore di `link` con i prefissi presenti in `url`;
- con `-S` aumenta i match utili anche se gli URL hanno forme diverse.

Output (estratto):

```csv
link,fonte,url
https://www.comune.roma.it/notizie/mobilita,comune-roma,comune.roma.it
https://dati.regione.lombardia.it/dataset/trasporti,regione-lombardia,dati.regione.lombardia.it
```

Quando usarlo:

- devi attribuire URL completi a domini/prefissi noti;
- vuoi arricchire rapidamente liste di link con fonte/editore/categoria.
