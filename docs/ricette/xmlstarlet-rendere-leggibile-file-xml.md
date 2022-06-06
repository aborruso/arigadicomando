---
tags:
  - xmlstarlet
  - xml
  - indentazione
  - leggibilità
title: Come rendere più leggibile un file XML
hide:
#  - navigation
  - toc
---

# Come rendere più leggibile un file XML

Alle volte può essere utile applicare a un file `XML` un'indentazione che ne renda più leggibile la struttura.

Si può usare l'*utility* [`xmlstarlet`](../../utilities/#xmlstarlet) e applicare ad esempio a questo input (è su una sola riga, scorrerlo tutto verso destra per farsi un'idea)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<legge190:pubblicazione xsi:schemaLocation="legge190_1_0 http://dati.anticorruzione.it/schema/datasetAppaltiL190.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:legge190="legge190_1_0"><metadata><titolo>Comune di Novara</titolo><abstract/><dataPubblicazioneDataset>2020-01-29+01:00</dataPubblicazioneDataset><entePubblicatore>Comune di Novara</entePubblicatore><dataUltimoAggiornamentoDataset>2020-03-10+01:00</dataUltimoAggiornamentoDataset><annoRiferimento>2019</annoRiferimento><urlFile>http://llpp.comune.novara.it/PortaleAppalti/resources/appaltiavcp/2019/Z00199663A.xml</urlFile><licenza xsi:type="xs:string" xmlns:xs="http://www.w3.org/2001/XMLSchema">IODL</licenza></metadata><data><lotto><cig>Z00199663A</cig><strutturaProponente><codiceFiscaleProp>00125680033</codiceFiscaleProp><denominazione>Comune di Novara</denominazione></strutturaProponente><oggetto>Assistenza tecnica fotocopiatori Ricoh periodo maggio-giugno 2016</oggetto><sceltaContraente>23-AFFIDAMENTO DIRETTO</sceltaContraente><partecipanti><partecipante><codiceFiscale>00748490158</codiceFiscale><ragioneSociale>Ricoh Italia Srl</ragioneSociale></partecipante></partecipanti><aggiudicatari><aggiudicatario><codiceFiscale>00748490158</codiceFiscale><ragioneSociale>Ricoh Italia Srl</ragioneSociale></aggiudicatario></aggiudicatari><importoAggiudicazione>1500.0</importoAggiudicazione><tempiCompletamento><dataInizio>2016-04-27+02:00</dataInizio></tempiCompletamento><importoSommeLiquidate>1024.22</importoSommeLiquidate></lotto></data></legge190:pubblicazione>
```

il comando

```bash
xmlstarlet format --indent-tab input.xml
```

per avere questa versione molto più leggibile dall'uomo:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<legge190:pubblicazione xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:legge190="legge190_1_0" xsi:schemaLocation="legge190_1_0 http://dati.anticorruzione.it/schema/datasetAppaltiL190.xsd">
        <metadata>
                <titolo>Comune di Novara</titolo>
                <abstract/>
                <dataPubblicazioneDataset>2020-01-29+01:00</dataPubblicazioneDataset>
                <entePubblicatore>Comune di Novara</entePubblicatore>
                <dataUltimoAggiornamentoDataset>2020-03-10+01:00</dataUltimoAggiornamentoDataset>
                <annoRiferimento>2019</annoRiferimento>
                <urlFile>http://llpp.comune.novara.it/PortaleAppalti/resources/appaltiavcp/2019/Z00199663A.xml</urlFile>
                <licenza xmlns:xs="http://www.w3.org/2001/XMLSchema" xsi:type="xs:string">IODL</licenza>
        </metadata>
        <data>
                <lotto>
                        <cig>Z00199663A</cig>
                        <strutturaProponente>
                                <codiceFiscaleProp>00125680033</codiceFiscaleProp>
                                <denominazione>Comune di Novara</denominazione>
                        </strutturaProponente>
                        <oggetto>Assistenza tecnica fotocopiatori Ricoh periodo maggio-giugno 2016</oggetto>
                        <sceltaContraente>23-AFFIDAMENTO DIRETTO</sceltaContraente>
                        <partecipanti>
                                <partecipante>
                                        <codiceFiscale>00748490158</codiceFiscale>
                                        <ragioneSociale>Ricoh Italia Srl</ragioneSociale>
                                </partecipante>
                        </partecipanti>
                        <aggiudicatari>
                                <aggiudicatario>
                                        <codiceFiscale>00748490158</codiceFiscale>
                                        <ragioneSociale>Ricoh Italia Srl</ragioneSociale>
                                </aggiudicatario>
                        </aggiudicatari>
                        <importoAggiudicazione>1500.0</importoAggiudicazione>
                        <tempiCompletamento>
                                <dataInizio>2016-04-27+02:00</dataInizio>
                        </tempiCompletamento>
                        <importoSommeLiquidate>1024.22</importoSommeLiquidate>
                </lotto>
        </data>
</legge190:pubblicazione>
```
