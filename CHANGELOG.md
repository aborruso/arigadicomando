# 2026-02-22

- aggiunta `xan` nella pagina [Utility](https://arigadicomando.it/utilities/) in ordine alfabetico, con link alla pagina dedicata e alla documentazione ufficiale

# 2026-02-21

- aggiunto nuovo post blog in bozza su Miller 6.17.0 con taglio divulgativo e struttura narrativa, inclusi esempi "Prima/Dopo" per le novità principali (`docs/blog/posts/miller617/index.md`)
- aggiunto nel post Miller 6.17.0 un esempio YAML minimo con creazione di campo derivato (`full_name`) tramite `mlr put`
- aggiornato l'esempio YAML del post Miller 6.17.0 usando `mlr --yaml` e output reale verificato
- estesi tutti gli esempi del post Miller 6.17.0 con blocchi espliciti di input e output
- aggiunta nota personale festosa nel blocco YAML del post, con link all'issue originale `#614` aperta da `aborruso`
- chiarita la sezione DCF del post Miller 6.17.0 spiegando cos'è il formato oltre alla struttura
- rimossa la numerazione dai sottocapitoli del post Miller 6.17.0
- corretti e verificati i comandi/output del post Miller 6.17.0 (flag CSV espliciti, output YAML e `nest/split` allineati al comportamento reale)
- allineato l'input dell'esempio `reorder -r` nel post Miller 6.17.0 per ottenere l'ordine output atteso (`YYY_*` prima di `XXX_*`)
- aggiunta una premessa narrativa nel post Miller 6.17.0 per spiegare come leggere i comandi e migliorato l'esempio `nest -r` con differenza concreta rispetto a `-f`
- aggiunta nota personale festosa anche nella sezione `nest -r` del post Miller 6.17.0, con link all'issue originale `#381`
- resa più esplicita la chiusura della sezione `nest -r` con una frase concreta sul vantaggio operativo delle regex
- aggiunte in ogni sezione del post Miller 6.17.0 le righe "Verbi correlati" con link alla guida ufficiale Miller
- chiarita la sezione `split --folder` del post Miller 6.17.0: novità spiegata come miglioramento di semantica/chiarezza del comando, non dell'output
- generata immagine Open Graph del post Miller 6.17.0 con Nanobanana (Gemini 3), copiata in `docs/blog/posts/miller617/images/` come `miller617-og.jpg` e inserita nel post
- aggiunta nel front matter del post Miller 6.17.0 la configurazione `social.cards_layout_options.background_image` per usare l'immagine nel social card (Open Graph/Twitter)
- aggiunta `description` nel front matter del post Miller 6.17.0 per migliorare snippet e anteprima social
- post Miller 6.17.0 impostato pubblicabile (`draft: false`)
- rese in grassetto le due frasi "Nota personale" nel post Miller 6.17.0
- aggiornato il post Miller 6.17.0 con link diretto alla release in apertura e nota finale su bugfix/altre modifiche incluse nella release
- aggiornato il titolo del post Miller 6.17.0 in "YAML finalmente supportato (e non solo)"
- rimosso dal front matter del post Miller 6.17.0 il blocco `social.cards_layout_options` per ripristinare la generazione corretta di Open Graph/Twitter card
- aggiornato il titolo del post Miller 6.17.0 in "YAML finalmente supportato"

# 2026-02-20

- aggiunta monografia introduttiva su [xan](https://arigadicomando.it/xan/) con pagina iniziale "cos'è"
- aggiornata la sezione Monografie con link a xan (`docs/monografie.md` e `mkdocs.yml`)
- aggiornata la regola operativa in `AGENTS.md` e `CLAUDE.md`: usare sempre MCP DeepWiki come fonte ufficiale per risposte e verifiche dei contenuti
- aggiunta sottosezione introduttiva "Dalle frasi agli insight: tokenize + vocab" in `docs/xan/index.md` con esempio pratico e CSV demo (`docs/xan/risorse/testi-mini.csv`)
- aggiunta mini tabella con output reale (`vocab token`) per rendere immediata la lettura dei segnali lessicali
- sezione `xsv` e relative sottopagine spostate in bozza: rimosse dalla navigazione e escluse dalla build (`exclude_docs`) senza cancellare i file
- "Dalle frasi agli insight: tokenize + vocab" trasformata in subpagina di xan (`docs/xan/dalle-frasi-agli-insight.md`) e collegata in navigazione
- normalizzato in stile italiano (sentence case) il titolo della pagina e la voce di navigazione xan
- aggiunti nella subpagina xan i link al CSV demo (pagina repository + download diretto raw)
- riscritta la subpagina xan in formato step-by-step: per 4 comandi mostrati input, porzioni di output reale e guida di lettura
- chiarito nello Step 1 di xan che `words testo` tokenizza per parole solo la colonna `testo`
- aggiunte spiegazioni dei parametri chiave anche negli altri step (`-T`, `--doc`, `--token`, `--implode`)
- corretta la definizione di `doc_count` nella guida xan: numero di documenti unici identificati da `--doc`
- aggiunta nello Step 4 la spiegazione delle colonne output: `id`, `token`, `tf`, `expected_tf`, `tfidf`, `bm25`, `chi2`
- aggiunta in fondo alla pagina xan la sezione "Perché ti potrebbe essere utile" con 3 casi d'uso sintetici
- resi più concreti e orientati a data journalism/analisi i 3 casi d'uso finali della pagina xan
- aggiunta premessa alla sezione finale xan: esempi ad alto livello per orientare analisi più complesse, con xan come tool di accompagnamento
- aggiunto nuovo capitolo xan sui join (`docs/xan/join.md`) con esempi piccoli per `join` (inner/left/right/full/cross), fuzzy join, regex join e URL join
- aggiunti CSV demo dedicati ai join in `docs/xan/risorse/join/` con link di download `raw`
- testati in locale i join con `xan` prima della pubblicazione (versione locale: `fuzzy-join` come equivalente di `regex-join`/`url-join`)
- allineata la pagina join al comportamento locale dell'utente: regex e URL documentati direttamente con `xan fuzzy-join`
- aggiunti in pagina gli estratti dei CSV `persone.csv` e `ordini.csv` usati nei join standard
- aggiunta spiegazione esplicita dei parametri di `xan join` (join su uno o più campi, ordine e sintassi)
- aggiunte anteprime dei CSV mancanti nella guida join (`lettere`, `numeri`, `testi`, `pattern_fuzzy`, `pattern`, `link`, `sorgenti_url`) senza duplicare quelle già presenti
- migliorata la leggibilità dei link raw nella guida join: URL nascosti dietro hyperlink con nome file
- resa coerente la guida join su tutti gli esempi: aggiunti `dati_a.csv`/`dati_b.csv` per il caso multi-colonna e nota sulla cartella da cui eseguire i comandi
- aggiunta nella sezione fuzzy-join la spiegazione esplicita dei parametri (`-i`, `--left`, colonne e file)
- estesa la spiegazione parametri anche a regex join e URL join (`-r`, `-u`, `-S`, colonne e file)
- rimossi dalla guida join i riferimenti "nel tuo ambiente" per mantenere la pagina valida in modo generale
- chiarito nella guida join che lato testi `fuzzy-join` accetta selezione multi-colonna (es. `titolo,testo`)
- rimossi i numeri dai titoli delle sezioni nella guida join per migliorarne la manutenibilità
- rimossi i numeri anche dai titoli della pagina `docs/xan/dalle-frasi-agli-insight.md`

# 2026-02-17

- aggiunta pagina [MCP consigliati](https://arigadicomando.it/ai/mcp-consigliati/) nella sezione AI con due voci curate: DeepWiki MCP (prima voce) ed Exa MCP
- aggiornata la navigazione AI in `mkdocs.yml` con il link diretto a "MCP consigliati"

# 2026-02-15

- aggiunta sezione [Ollama](https://arigadicomando.it/ai/ollama/) con installazione Linux, uso base e avvio coding CLI con `ollama launch`
- aggiunta documentazione [skills.sh](https://arigadicomando.it/ai/altri-tool/skills-sh/) in AI > Altri strumenti
- aggiornata la navigazione AI per includere Ollama e skills.sh
- aggiunta regola operativa in `AGENTS.md` e `CLAUDE.md`: non eseguire `mkdocs build`/`mkdocs serve` salvo richiesta esplicita dell'utente
- ottimizzata la SEO del repository GitHub: descrizione, topic e README aggiornati
- esplicitata la licenza dei contenuti come **CC BY 4.0** in `README.md` e aggiunto file `LICENSE`

# 2026-02-11

- aggiunto esempio CLI per server MCP globale in Claude Code

# 2026-02-08

- ristrutturata la documentazione di Claude Code
- aggiunta sezione Codex CLI con configurazione

# 2025-12-09

- aggiunta sezione [qsv](https://arigadicomando.it/qsv/)

# 2025-07-12

- aggiunta documentazione [MarkItDown](https://arigadicomando.it/ai/altri-tool/markitdown/)

# 2025-07-11

- aggiunta sezione [uv](https://arigadicomando.it/uv/)

# 2025-06-04

- aggiunta sezione [ttok](https://arigadicomando.it/ai/ttok/)

# 2025-06-03

- aggiunta sezione [AI](https://arigadicomando.it/ai/) dedicata agli strumenti per LLM a riga di comando
- aggiunta sezione [LLM CLI](https://arigadicomando.it/ai/llm_cli/)
- aggiunta sezione [Estrarre testo da pagine web](https://arigadicomando.it/ai/estrarre-pagine-web/)

# 2023-09-03

- aggiunta sezione [Blog](https://arigadicomando.it/blog/)

# 2022-11-05

- aggiunta sezione [Nushell](https://arigadicomando.it/nushell/)

# 2022-10-24

- aggiunta sezione [GDAL/OGR](https://arigadicomando.it/gdal-ogr/)

# 2022-08-16

- aggiunta sezione [ckanapi cli](https://arigadicomando.it/ckanapi/)

# 2022-08-08

- aggiunta sezione [frictionless data](https://arigadicomando.it/frictionless/)

# 2022-06-05

- aggiunta la sezione generica di ricette <https://arigadicomando.it/ricette>
- aggiunti i tag <https://arigadicomando.it/tags/>
