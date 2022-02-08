# Contributi

Da quando abbiamo iniziato a usare Miller alcuni anni fa, abbiamo aperto diverse *issue* nel *repository* ufficiale, con idee, domande, proposte e segnalazioni di bug.<br>
Alcune sono diventate nuove caratteristiche di Miller e ci fa un particolare piacere tenerne nota.

Tutto questo è possibile grazie al suo straordinario autore, John Kerl, che cura in modo esemplare il rapporto con la comunità che utilizza questa applicazione.


### 2022-02-08 | Aggiunto il natural sorting

È possibile usare il *natural sorting*[^1], sia per il verbo [`sort`](verbi.md#sort), che per la [funzione DSL `sort`](https://miller.readthedocs.io/en/latest/reference-dsl-builtin-functions/index.html#sort). Grazie a [Salvatore Fiandaca](https://twitter.com/totofiandaca) per [l'ispirazione](https://gis.stackexchange.com/q/421166/466).

Vedi [`#874`](https://github.com/johnkerl/miller/issues/874) e [`#872`](https://github.com/johnkerl/miller/discussions/872#discussioncomment-1977161).

[^1]: https://blog.codinghorror.com/sorting-for-humans-natural-sort-order/
### 2022-02-07 | Espansa sintassi di strptime

Prima non era possibile utilizzare `%j`.

Vedi [`#914`](https://github.com/johnkerl/miller/issues/914#issuecomment-1031510453).
### 2022-02-06 | Supporto più rigoroso al formato TSV

Prima era gestito come uno speciale `CSV`, in realtà sono formati differenti.

Vedi [`#922`](https://github.com/johnkerl/miller/issues/922) e [`#923`](https://github.com/johnkerl/miller/pull/923#issue-1125106948).

### 2022-01-09 | Supporto al formato JSON Lines

Prima non era supportato. Vedi [`#755`](https://github.com/johnkerl/miller/discussions/755#discussioncomment-1935634) e [`#844`](https://github.com/johnkerl/miller/pull/844).

### 2022-01-09 | JSON di output corretto

Prima non era supportato di *default*. Vedi [`#755`](https://github.com/johnkerl/miller/discussions/755#discussioncomment-1935634) e [`#844`](https://github.com/johnkerl/miller/pull/844).


### 2021-10-10 | Gestione corretta del carattere pipe nella creazione di Markdown

Prima un carettere `|` in una cella di input, faceva produrre Markdown di output scorretti.

Vedi [`#610`](https://github.com/johnkerl/miller/issues/610).
