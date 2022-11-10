---
tags:
  - html
  - scraping
title: Salvare una pagina web in unico file autoconsitente
hide:
#  - navigation
  - toc
---

## Monolith

Uno strumento ottimo per farlo è [**monolith**](https://github.com/Y2Z/monolith).

Un comando tipo è questo:

```bash
monolith https://lyrics.github.io/db/P/Portishead/Dummy/Roads/ -o portishead-roads-lyrics.html
```

In output un solo file, che contiene al suo interno i CSS, i javascript, le immagini, i font, ecc., autoconsistente.

### Se la pagina ha contenuti JS-driven (AJAX)

In questi casi, la pagina sorgente non ha i contenuti al suo interno. Si può usare la versione *headless* di un browser per scaricare la pagina con tutti i contenuti e poi passare l'output a monolith:

```
chromium --headless --disable-gpu --dump-dom "https://www.agenas.gov.it/covid19/web/index.php?r=site%2Ftab2" | monolith - -b "https://www.agenas.gov.it/covid19/web/index.php?r=site%2Ftab2" -o output.html
```

In ambiente debian l'eseguibile di `chromium` si chiama `google-chrome-stable`.
