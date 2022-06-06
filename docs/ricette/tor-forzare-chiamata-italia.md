---
tags:
  - tor
  - hacking
  - curl
  - scraping
title: Come forzare la chiamata tor da un determinato paese
hide:
#  - navigation
  - toc
---

# Come forzare la chiamata tor da un determinato paese

In alcuni casi è impossibile raggiungere alcuni siti da alcuni paesi. Facciamo l'ipotesi che un sito sia soltanto raggiungibile da IP italiani.

`tor` si installa con `sudo apt install tor`.

Una volta installato bisogna modificare il file di configurazione `/etc/tor/torrc` aggiungere dei parametri di configurazione, e riavviare il servizio.


```bash
sudo sh -c "echo 'SOCKSPort 9050 # Default' >> /etc/tor/torrc"
sudo sh -c "echo 'ExitNodes {it} StrictNodes 1' >> /etc/tor/torrc"
sudo systemctl start tor
sudo service tor stop
sudo service tor start
```

A cose fatte si potrà lanciare la chiamata, e l'IP assegnato sarà "italiano".

```
curl --socks5-hostname localhost:9050  ifconfig.me
```

!!! note "Nota"

    In questa modalità si rischia di perdere l'anonimizzazione. Quindi usarla soltanto se non quest'ultima non è un requisito.
