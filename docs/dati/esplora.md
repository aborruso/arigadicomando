# Esplora

In questo spazio facciamo riferimento a dati che sono archiviati come testo. È la modalità in cui molto spesso sono archiviati file di dati (JSON, XML, CSV, TTL, YAML, ecc.) e per i quali gli strumenti a riga di comando hanno supporto nativo, perché si aspettano stringhe di testo come `input`.

Tanti strumenti di base e nativi della **riga di comando** sono impareggiabili nell'esplorare file di testo, in termini di rapidità, opzioni e modalità per farlo.<br>
Sono sicuramente più adatti della gran parte di quelli con interfaccia grafica.

## Informazioni sui file

L'utility di base, preinstallata in tutti i sistemi Linux è `file`, che è utile per avere informazioni sul tipo di file.

!!! comando "file base_category.csv"

    ```
    base_category.csv: CSV text
    ```

Con l'opzione `-i` si ottengono informazioni sull'[*encoding*](#encoding).

## Le misure

Questa guida fa riferimento principalmente a file di testo. Per questa ragione alcune misure di base sono quelle legate al numero di righe, di caratteri, di parole, ecc..<br>
Il comando disponibile è `wc`.

Per avere il numero di linee del file `base_category.csv`, che sono 6, il comando è:

!!! comando "wc --lines <base_category.csv"

    ```
    6
    ```

## Visualizzare

L'*utility* tipica è [`cat`](https://tldr.ostera.io/cat) che "stampa" uno o più file (in questo caso concatena e stampa).


## Encoding

Conoscere la codifica dei caratteri è un elemento chiave per la loro lettura. Specie con formati di testo come il `CSV`, in cui le informazioni sull'*encoding* non sono scritte all'interno del *file* (se va bene sono riportate in un testo che descrive il *file*).


