# CLIPS-project
This CLIPS project has been written for the exam of Artificial Intelligence Laboratory at the University of Turin.

# Traccia progetto
Il progetto consiste nel cercare di soddisfare le necessità di varie città italiane che producono ed utilizzano alcune
merci (tipo A, B, C). Per semplicità è assunto che ognuna delle città produca e consumi un solo tipo di prodotto.

Riportiamo le modalità di produzione e consumo di ogni città: metti img.

A disposizione abbiamo vari veicoli di cui: 5 furgoni con capacità 4,
2 aerei con capacità 7 e due navi con capacità 11 (dove capacità è il numero massimo di merci trasportabili da ciascun veicolo).

Ogni mezzo è posizionato in una locazione nota a priori: 3 furgoni sono a Bologna, 2 sono a Roma, 1 nave è a Genova e l'altra è a Venezia.
Un aereo è fermo a Palermo, l'altro a Milano.

Ciascuno dei mezzi può compiere tre azioni basilari: load (prendere merce), unload (droppare merce) e shift (muoversi tra città).
Ciascuna di queste azioni possiede un costo dipendente da uno o più parametri; nel caso di load ed unload il parametro è la quantità
di merce che viene trattata dall'azione scelta mentre il costo della shift dipende dal mezzo che la compie (van 1/1, ship 2/3, plane 5/4)
e dalla distanza tra le due città tra cui viene
applicata. Alcuni tragitti non sono percorribili da tutti i mezzi di trasporto e perciò non tutte le città 
sono collegate direttamente tra loro.

Sono note le distanze in linea d'aria tra le diverse città prese in esame: metti img.

# Gestione file
Il progetto, contenuto all'interno della cartella 'A-star', è stato suddiviso in tre parti principali:
- alghorithm che contiene tutti i moduli CLIPS relativi all'algoritmo utilizzato,
- domain che contiene funzioni, fatti, regole e template utilizzati appositamente per il dominio in questione,
- knowledge_bases che contiene le basi di conoscenza utilizzate per il progetto.

Sono anche contenuti altri tre file necessari per la corretta esecuzione del programma. 
Essi sono: 'loads' che contiene le istruzioni necessarie per configurare l'ambiente d'esecuzione, 'projectCosts' su cui vengono salvati
progressivamente i costi parziali della soluzione e 'run' utilizzato per aprire la shell dove eseguire il programma.

To run the program open 'run.bat' file (or use CLIPSIDE) and type '(batch loads)' command .

# Algoritimi di pianificazione
Gli algoritmi consigliati per la risoluzione del problema sono stati Iterative 
Deepening ed A*. Entrambi sono stati implementati ed applicati per effettuare 
la ricerca su grafo nello spazio degli stati.

Iterative Deepening: l'algoritmo si è dimostrato non adatto alla risoluzione del
problema in quanto incapace di trovare una soluzione in tempi ragionevoli. É stato
possibile però fare alcune osservazioni: riducendo drasticamente la
dimensione del problema era possibile concludere la computazione in tempi brevi.
Tuttavia, l'aggiunta anche di solo pochi fatti alla base di conoscenza peggiorava
di molto le prestazioni. Esso è contenuto all'interno della cartella 'no_evaluation'.

In virtù di ciò abbiamo optato per l'implementazione dell'algoritmo A*.
Quest'ultimo ha un comportamento migliore rispetto al precedente algoritmo sia
alla complessità spaziale lineare nella profondità della più profonda soluzione ottima
sia poichè affiancato da un euristica. 
Se l'euristica è ammissibile l'algoritmo allora risulta ottimo.

Nonostante ciò, nemmeno A* riesce a trovare una soluzione in tempi brevi.

## Euristiche
Abbiamo implementato un'euristica ammissibile, ossia che non sbaglia mai per eccesso 
e che sia consistente (o monotona) per applicazioni di ricerca su grafo.

La nostra euristica associa ad ogni nodo un costo che dipende dalla somma di:
- costo delle operazioni (load o unload) sulle merci,
- costo del viaggio in linea d'aria nel caso di uno spostamento.

L'algoritmo sceglierà sulla base di questa euristica il percorso ottimo.

## Suddivisione in sottoproblemi
Per risolvere il problema della mancata terminazione dovuta alla grande complessità
del problema, è stato necessario suddividerlo in svariati sottoproblemi ognuno dei quali
si occupa di soddisfare una delle città precedentemente menzionate.

Il numero di sottobiettivi in cui è stato suddiviso il problema originario risulta essere
pari al numero di città da soddisfare; alcuni di essi sono stati ulteriormente
suddivisi in modo tale da contenere il 'branching factor'.

Questo ha precluso la possibilità di trovare la soluzione ottima
dell'intero problema ma ci garantisce l'ottimalità delle sottosoluzioni.
Perciò la soluzione da noi proposta risulta essere SUBOTTIMA.


# Modellazione del problema
Il problema è stato modellato utilizzando, in combinazione, sia fatti ordinati che
fatti non ordinati, contenuti all'interno del file 'templates.clp', con prevalenza
dei primi. La motivazione di ciò è da ricercarsi allo svariato numero di costrutti messi a disposizione da CLIPS stesso
utilizzabili solamente con fatti ordinati. Ove non siano stati ritenuti necessari
tali costrutti sono stati utilizzati fatti non ordinati.

## Implementazione A* CLIPS
Per la creazione delle strutture dati di base per l'implementazione 
dell'algoritmo A* sono stati utilizzati dei fatti ordinati. Essi sono:
- 'node' utilizzato per rappresentare il nodo corrente preso in esame,
- 'newnode' utilizzato per espandere, dopo aver effettuato una mossa, i nuovi nodi,
- 'state' utilizzato per configurare l'ambiente tramite le basi di conoscenza a priori e
- 'status' utilizzato per mantere le informazioni relative a città e mezzi di trasporto. Una precisa configurazione dello spazio degli stati è rappresentata dall'insieme dei fatti ordinati 'status' 
aventi lo stesso valore dello slot 'ident'.

Per la modellazione dei goal è stato utilizzato un fatto ordinato denominato 'goal'.
Per necessità sono stati modellati, nelle varie azioni, due goal: uno riguardante 
le città e l'altro riguardante i mezzi di trasporto.

## Basi di conoscenza 
Le basi di conoscenza contengono le città ed i veicoli necessari al soddisfacimento
dei vari sottobiettivi. Esse risultano contenute, come descritto in precedenza, in un fatto ordinato chiamato 'state'
che rappresenta la radice del grafo su cui effettuiamo la ricerca nello spazio degli
stati. Il fatto denominato 'state' fa scattare una delle regole contenute all'interno di
'cities_rules.clp' che produrrà gli 'status' iniziali su cui il nostro programma
"girerà".

Una prima suddivisione è stata quella di produrre un numero di 
sottobiettivi pari al numero di città menzionate nella traccia del problema (eccetto
Firenze). Successivamente, per necessità e comodità, si è deciso di apportare un'
ulteriore suddivisione ad alcune basi di conoscenza.

## Azioni del dominio
Le azioni del dominio, contenute nel file 'domain_rules.clp', sono state modellate
utilizzando come soggetto i mezzi di trasporto a nostra disposizione. Esse sono:
- apply-load-prod
- exec-load-prod 
- load-prod_newnode

- apply-load-store
- exec-load-store
- load-store_newnode

- apply-unload-need
- exec-unload-need 
- unload-need_newnode

- apply-unload-store
- exec-unload-store
- unload-store_newnode

- apply-shift 
- exec-shift
- shift_newnode 

# Funzioni e utils

# Conclusioni

## Authors

* **Cesare Iurlaro** - [CesareIurlaro](https://github.com/CesareIurlaro)
* **Giuseppe Gabbia**  - [beppe95](https://github.com/beppe95)
* **Lamberto Basti**  - [lamba92](https://github.com/lamba92)
