---
tags:
  - tree
  - json
  - list
  - file
title: Lista file e cartelle in JSON
hide:
#  - navigation
  - toc
---

# Esportare la lista di file e cartelle in formato JSON

Si può usare l'*utility* [`tree`](../../utilities/#tree):

```bash
tree -Jhfpug /myPC/myFolder
```

In output (è un esempio):

```json
[
  {"type":"directory","name":".","contents":[
    {"type":"file","name":"./converti.md","mode":"0744","prot":"-rwxr--r--","user":"username","group":"groupname","size":"11"},
    {"type":"file","name":"./descrivi.md","mode":"0744","prot":"-rwxr--r--","user":"username","group":"groupname","size":"0"},
    {"type":"file","name":"./esplora.md","mode":"0744","prot":"-rwxr--r--","user":"username","group":"groupname","size":"16K"},
    {"type":"file","name":"./index.md","mode":"0744","prot":"-rwxr--r--","user":"username","group":"groupname","size":"1"},
    {"type":"file","name":"./tmp.csv","mode":"0644","prot":"-rw-r--r--","user":"username","group":"groupname","size":"568K"},
    {"type":"file","name":"./trasforma.md","mode":"0744","prot":"-rwxr--r--","user":"username","group":"groupname","size":"671"}
  ]},
  {"type":"report","directories":0,"files":6}
]
```

!!! note "Nota"

    Se non inserisci alcun *path*, il comando verrà eseguito per file e cartelle contenuti nella cartella corrente

---

Fonte: <https://twitter.com/climagic/status/1268900527561113600>
