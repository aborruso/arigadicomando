---
hide:
  - navigation
  - toc
---

# La CLI

La **riga di comando** - in inglese **CLI**, la *Command Line Intereface* - è un'interfaccia di dialogo **testuale** tra utente e *computer*, ed anche un programma, che interpreta i comandi inseriti da tastiera e li esegue.

![](./images/cli_00.png)

Esistono decine di interfacce a riga di comando, per tutti i sistemi operativi. Qui si farà riferimento a una generica CLI in un sistema operativo Linux.<br>
È possibile attivarla in tutti i sistemi operativi: Linux (ovviamente), Mac OS (che è basato su un sistema operativo Unix), Windows (il modo consigliato per Win è [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10)), ChromeOS, ecc..

La CLI (chiamata anche `shell`) può intimorire inizialmente un po', ma può essere un'ancora di salvezza per tantissime operazioni/elaborazioni.

Esistono diverse sistemi di shell (distinti ma ampiamente compatibili tra loro), tra i quali il più popolare è Bash, acronimo di "Bourne again shell". Bash è sia una raccolta di *utility* (come `grep`, un potente strumento per fare ricerche di testo), che un linguaggio di programmazione, con i suoi `for loop` per ripetere opeazioni su più file.<!-- .slide: data-fullscreen -->

Molte discipline computazionali, come la bioinformatica, fanno affidamento sulla riga di comando. Ma tutte le persone che utilizzano un *personal computer* possono trarne vantaggio, perché il mouse non è scalabile, mentre con tastiera si può sollevare il mondo 🙃.

Alcuni esempi.

## Operazioni su più file in blocco

Forse la caratteristica più potente della *shell* è la capacità di ripetere semplici processi su più *file*. Una persona potrebbe, ad esempio, rinominare sistematicamente i propri file ed aggiungere al loro nome la data, o convertirli da un formato all'altro.

Una necessità potrebbe essere quella di aprire centinaia di immagini presenti in una cartella, invertirne i colori e modificarne anche luminosità, saturazione e tonalità. Operazioni di questo tipo, con un mouse, possono durare ore. Se si trasforma in un processo a riga di comando, sfruttando una *utility* dedicata alle immagini come la fantastica [ImageMagick](https://imagemagick.org/), è cosa da poco:

```bash
for file in *.png; do
  convert $file -channel RGB -negate -modulate 100,100,200 out_$file
done
```
