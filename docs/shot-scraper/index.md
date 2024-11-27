# Intro

shot-scraper è ...

## Ricette

### Fare uno screenshot di google map

```bash
shot-scraper \
  'https://www.google.com/maps/@38.1237805,13.3542721,3000m/data=!5m1!1e1?hl=it' \
  -o screenshot_google_maps.png \
  --javascript "document.querySelector('button[aria-label=\"Accetta tutto\"]').click();" \
  --wait-for 'document.querySelector(".app-center-widget-holder")'
```

Note:

- `-o screenshot_google_maps.png`
- `--javascript "document.querySelector('button[aria-label=\"Accetta tutto\"]').click();"` Questo comando esegue un clic sul pulsante "Accetta tutto" (per accettare i cookie). Il selettore utilizza l'attributo `aria-label` per individuare il bottone.
- `--wait-for 'document.querySelector(".app-center-widget-holder")'` Specifica di attendere che l'elemento con classe `.app-center-widget-holder` sia caricato prima di scattare lo screenshot.

### Scrollare per intero una pagina

```bash
shot-scraper javascript "https://gfmd.info/fundings/?reg%5B%5D=488&tf%5B%5D=12" "async () => { const delay = ms => new Promise(resolve => setTimeout(resolve, ms)); let lastHeight = 0; let newHeight = document.body.scrollHeight; while (newHeight > lastHeight) { lastHeight = newHeight; window.scrollTo(0, document.body.scrollHeight); await delay(2000); newHeight = document.body.scrollHeight; } return document.documentElement.outerHTML; }"  >output.html
```

Note:

- ciclo
  - **`lastHeight`**: Memorizza l'altezza della pagina prima dello scroll.
  - **`newHeight`**: Memorizza l'altezza della pagina dopo lo scroll.
  - Il ciclo `while` continua fino a quando non ci sono più nuovi contenuti da caricare (cioè quando `newHeight` non cambia più rispetto a `lastHeight`).
  - Dopo ogni scroll con `window.scrollTo`, lo script aspetta 2 secondi (`await delay(2000)`) per permettere il caricamento dei contenuti.
- al termine del ciclo, restituisce l'intero contenuto HTML della pagina con `document.documentElement.outerHTML`.

### Scrollar per intero una pagina e fare uno screenshot

Questa deriva dal mettere insieme le due ricette precedenti.

```bash
shot-scraper "https://gfmd.info/fundings/?reg%5B%5D=488&tf%5B%5D=12" -o gfmd.png --javascript "async () => { const delay = ms => new Promise(resolve => setTimeout(resolve, ms)); let lastHeight = 0; let newHeight = document.body.scrollHeight; while (newHeight > lastHeight) { lastHeight = newHeight; window.scrollTo(0, document.body.scrollHeight); await delay(2000); newHeight = document.body.scrollHeight; } return document.documentElement.outerHTML; }"
```
