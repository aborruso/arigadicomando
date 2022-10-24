
## Fare il reverse geocoding

File di input

```
citta
Palermo
Roma
Cagliari
Bari
```

Comando

```
qsv fetch --report d --jql '[0]."lat",[0]."lon"' input.csv -c output --url-template "https://nominatim.openstreetmap.org/search?q={citta}&country=Italy&format=json"
```

- `--report d`, per creare un file di report dell'operazione di fetch;
- `--jql '[0]."lat",[0]."lon"'`, per estrarre i campi del JSON dall'output dell'API;
- `input.csv`, il file di input;
- `-c output`, la nuova colonna dove inserire i valori estratti da `jql`;
- `--url-template "https://nominatim.openstreetmap.org/search?q={citta}&country=Italy&format=json"`, l'URL delle API, con i nomi delle colonne come variabili (qui è la sola `città`).
