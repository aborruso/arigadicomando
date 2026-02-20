# Join con xan: casi base, fuzzy, regex e URL

Questa pagina mostra i casi principali di join con esempi minimi.

Nota compatibilità:

- documentazione ufficiale recente: `xan join`, `xan regex-join`, `xan url-join`;
- test locale eseguito qui con `xan 0.56.0`, dove gli equivalenti sono:
  - `xan fuzzy-join -r` (equivalente a `regex-join`);
  - `xan fuzzy-join -u` (equivalente a `url-join`).

## File di esempio (download raw)

- `persone.csv`: <https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/persone.csv>
- `ordini.csv`: <https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/ordini.csv>
- `lettere.csv`: <https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/lettere.csv>
- `numeri.csv`: <https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/numeri.csv>
- `testi.csv`: <https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/testi.csv>
- `pattern.csv`: <https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/pattern.csv>
- `pattern_fuzzy.csv`: <https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/pattern_fuzzy.csv>
- `link.csv`: <https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/link.csv>
- `sorgenti_url.csv`: <https://raw.githubusercontent.com/aborruso/arigadicomando/master/docs/xan/risorse/join/sorgenti_url.csv>

## 1) Join standard (`xan join`)

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

```bash
xan fuzzy-join -i testo testi.csv needle pattern_fuzzy.csv
```

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

Output (estratto):

```csv
id,testo,tema,needle
1,Il Comune di Roma annuncia nuovi cantieri sulla mobilità urbana.,,
2,Bando scuola digitale per laboratori e formazione docenti a Milano.,scuola,scuola
3,Nuovo parco urbano con 300 alberi nel quartiere nord.,verde,parco
```

## 3) Regex join

Comando ufficiale (documentazione recente):

```bash
xan regex-join -i testo testi.csv pattern pattern.csv
```

Equivalente testato localmente (`xan 0.56.0`):

```bash
xan fuzzy-join -r -i testo testi.csv pattern pattern.csv
```

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

## 4) URL join

Comando ufficiale (documentazione recente):

```bash
xan url-join -S link link.csv url sorgenti_url.csv
```

Equivalente testato localmente (`xan 0.56.0`):

```bash
xan fuzzy-join -u -S link link.csv url sorgenti_url.csv
```

Output (estratto):

```csv
link,fonte,url
https://www.comune.roma.it/notizie/mobilita,comune-roma,comune.roma.it
https://dati.regione.lombardia.it/dataset/trasporti,regione-lombardia,dati.regione.lombardia.it
```

Quando usarlo:

- devi attribuire URL completi a domini/prefissi noti;
- vuoi arricchire rapidamente liste di link con fonte/editore/categoria.
