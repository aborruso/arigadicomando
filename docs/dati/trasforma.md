# Trasforma

!!! warning "Attenzione"

    Questa pagina è una bozza, è ancora quasi tutta da scrivere.

## Stuttura
### Da wide a long

### Da long a wide

### Pivot
## Encoding

Tante volte è necessario trasformare i file da una codifica di caratteri a un'altra. Un caso classico è quello di un lavoro in cui la gran parte dei dati è in `UTF-8`, ma alcuni file "esterni" sono in `Windows-1252` e sono da uniformare ai precedenti.

È disponibile l'*utility* [`iconv`](../utilities/index.md#iconv), che si occupa proprio di questo. Ad esempio per trasformare un file da `Windows-1252` a `UTF-8`, il comando è:

```
iconv -f Windows-1252 -t UTF-8 input >output
```
