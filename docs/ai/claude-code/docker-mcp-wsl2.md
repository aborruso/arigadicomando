---
title: Docker MCP Toolkit da WSL2
---

# Docker MCP Toolkit da WSL2

Il **Docker MCP Toolkit** è un catalogo di server MCP gestiti da Docker: ogni server gira in un container isolato, parte on-demand e si spegne subito dopo l'uso. Il vantaggio principale è avere **Docker come nodo centralizzato** per tutti i tuoi server MCP — invece di installare e configurare decine di strumenti nel sistema, li attivi dinamicamente dalla chat con un solo gateway. Niente dipendenze sparse, niente ambienti da mantenere: tutto è containerizzato, isolato e aggiornabile in modo uniforme.

Chi lavora su **Windows + WSL2** si trova però davanti a un problema: Docker Desktop configura automaticamente `MCP_DOCKER` solo nell'ambiente Windows, non in quello Linux di WSL2. La guida qui sotto risolve questa situazione installando il binary standalone del gateway e configurando Claude Code in WSL2.

---

## Prerequisiti

- Windows con **Docker Desktop** installato e in esecuzione
- **WSL2** attivo con integrazione Docker Desktop abilitata
  (`Docker Desktop → Settings → Resources → WSL Integration`)
- **Claude Code CLI** installato in WSL2
- Docker MCP Toolkit abilitato in Docker Desktop
  (`Settings → Beta features → Enable Docker MCP Toolkit`)

---

## Il problema

Quando Docker Desktop è in esecuzione su Windows, configura automaticamente
`MCP_DOCKER` nel Claude Code **di Windows**, ma non in quello di WSL2.

Se da WSL2 esegui `claude mcp list`, `MCP_DOCKER` non compare — oppure compare
con stato `✗ Failed to connect`, perché il binary bundled con Docker Desktop
cerca un socket (`/run/host-services/tools.sock`) che non esiste nel filesystem
Linux di WSL2.

---

## Soluzione

### 1. Installa il binary standalone di `docker-mcp`

Il binary incluso in Docker Desktop controlla la presenza di Docker Desktop
tramite socket locali che non sono disponibili in WSL2. Il binary **standalone**
da GitHub risolve il problema con la variabile d'ambiente `DOCKER_MCP_IN_CONTAINER`.

```bash
# Scarica l'ultima release (verifica la versione su github.com/docker/mcp-gateway)
curl -Lo /tmp/docker-mcp.tar.gz \
  https://github.com/docker/mcp-gateway/releases/download/v0.40.2/docker-mcp-linux-amd64.tar.gz

tar -xzf /tmp/docker-mcp.tar.gz -C /tmp/

mkdir -p ~/.docker/cli-plugins
cp /tmp/docker-mcp ~/.docker/cli-plugins/docker-mcp
chmod +x ~/.docker/cli-plugins/docker-mcp
```

Verifica:

```bash
docker mcp version
# v0.40.2
```

### 2. Aggiungi MCP_DOCKER a Claude Code

```bash
claude mcp add MCP_DOCKER -s user -e DOCKER_MCP_IN_CONTAINER=1 -- docker mcp gateway run
```

La variabile `DOCKER_MCP_IN_CONTAINER=1` dice al gateway di non cercare
Docker Desktop tramite socket locali, bypassando il controllo che causava
l'errore `Docker Desktop is not running`.

### 3. Verifica

```bash
claude mcp list
# ...
# MCP_DOCKER: docker mcp gateway run - ✓ Connected
```

---

## Usare i server MCP dal catalogo Docker

Il gateway parte senza server abilitati, ma espone strumenti interni per
gestirli dinamicamente direttamente dalla chat:

| Tool interno     | Cosa fa                                    |
|------------------|--------------------------------------------|
| `mcp-find`       | Cerca server nel catalogo Docker           |
| `mcp-add`        | Aggiunge e attiva un server nella sessione |
| `mcp-remove`     | Rimuove un server                          |
| `mcp-config-set` | Configura parametri di un server           |

**Esempio**: in una sessione Claude Code, puoi scrivere:

> "Cerca nel catalogo Docker un server per i transcript YouTube e abilitalo"

Claude userà `mcp-find` e `mcp-add` in autonomia.

---

## Note

- I container Docker per i server MCP **partono on-demand** e si spengono
  subito dopo l'uso — non girano in background.
- I **secrets** (API key, token) si gestiscono con `docker mcp secret set`.
- Il profilo MCP configurato in Docker Desktop su Windows **non viene condiviso**
  automaticamente con WSL2: la configurazione WSL2 è indipendente.
- Il binary `~/.docker/cli-plugins/docker-mcp` **sovrascrive** quello bundled
  con Docker Desktop. In caso di aggiornamento di Docker Desktop, potrebbe
  essere necessario aggiornare anche questo binary.
