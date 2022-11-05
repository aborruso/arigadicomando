---
hide:
  - toc
---

# Nushell

!!! warning "Attenzione"

    La sezione per Nushell non è ancora pronta. È possibile fare riferimento al [sito ufficiale](https://www.nushell.sh/).

[**Nushell**](https://www.nushell.sh/) è una shell che vede un po' tutto in forma di dataset, tabelle, liste, ecc..

Se si lancia ad esempio `ls`, il tipico comando per avere la lista dei contenuti di una directory, si ha indietro questa rappresentazione tabellare:

|name|type|size|modified|
|-|-|-|-|
|index.md|file|184 B|Mon, 24 Oct 2022 18:31:43 +0200 (2 weeks ago)|
|ricette.md|file|3.0 KiB|Sun, 30 Oct 2022 17:41:53 +0100 (5 days ago)|

E si possono applicare comandi tipici del mondo dei dati.<br>
Ad esempio per avere in lista soltanto i file con dimensioni maggiori di 2kB, il comando sarà:

```bash
ls | where size > 2kB
```

---

Alcune [ricette](ricette.md).
