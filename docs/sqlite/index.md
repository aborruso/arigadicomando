# sqlite

È uno straordinario [*database* relazionale *open source*](https://www.sqlite.org/index.html), che può funzionare anche a riga di comando.

## Ricette

### Eseguire una query

```bash
sqlite3 nomeDb 'select * from nomeTabella;"'
```

Con [questo file di esempio](../data/sqlite.db):

```
sqlite3 sqlite.db 'SELECT "color", "shape"
FROM "colored-shapes"
limit 5;'
```

L'*output* standard è un testo senza intestazione, separato da `|`:

```
yellow|triangle
red|square
red|circle
red|square
purple|triangle
```

### Avere l'output di una query in CSV

Si aggiungono le opzioni `-header -csv`, per impostare il formato di output e avere anche la riga di intestazione.

```
sqlite3  -header -csv sqlite.db 'SELECT "color", "shape"
FROM "colored-shapes"
limit 5;'
```

In output

```
color,shape
yellow,triangle
red,square
red,circle
red,square
purple,triangle
```
