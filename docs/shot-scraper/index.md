---
search:
  exclude: true
---

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

### Fare uno screenshot rimuovendo il popup di cookie

```bash
shot-scraper -h 2300 'https://www.corriere.it' -o po-pup_hide.png --javascript "document.querySelectorAll('.privacy-cp-wall').forEach(el => el.style.display = 'none')"
```

### Fare uno screenshot di una pagina di un account instagram

```bash
shot-scraper \
  'https://www.instagram.com/aborruso' \
  -o screenshot_i.png \
  --javascript "(async () => {
    // clicchiamo il bottone
    Array.from(document.querySelectorAll('button'))
      .find(b => b.textContent.includes('Allow all cookies'))
      .click();

    // attendiamo 2 secondi
    await new Promise((resolve) => setTimeout(resolve, 2000));

    // click sulle coordinate (10,10)
    const elemento = document.elementFromPoint(10, 10);
    if (elemento) {
      elemento.dispatchEvent(
        new MouseEvent('click', {
          bubbles: true,
          cancelable: true,
          view: window,
          clientX: 10,
          clientY: 10
        })
      );
    }
  })()" \
  --wait 4000
```
