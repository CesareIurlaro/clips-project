# CLIPS-project
This CLIPS project has been written for the exam of Artificial Intelligence Laboratory at the University of Turin.

# Traccia progetto
Il progetto consiste nel cercare di soddisfare le necessità di varie città italiane che producono ed utilizzano alcune
merci (tipo A, B, C). Per semplicità è assunto che ognuna delle città produca e consumi un solo tipo di prodotto.

Riportiamo le modalità di produzione e consumo di ogni città: 
<p align="center">
  <img src="https://github.com/CesareIurlaro/clips-project/blob/master/stuff/initCIties.PNG"/>
</p>

A disposizione abbiamo vari veicoli di cui: 5 furgoni con capacità 4,
2 aerei con capacità 7 e due navi con capacità 11 (dove capacità è il numero massimo di merci trasportabili da ciascun veicolo).

Ogni mezzo è posizionato in una locazione nota a priori: 3 furgoni sono a Bologna, 2 sono a Roma, 1 nave è a Genova e l'altra è a Venezia.
Un aereo è fermo a Palermo, l'altro a Milano.

Ciascuno dei mezzi può compiere tre azioni basilari: load (prendere merce), unload (droppare merce) e shift (muoversi tra città).
Ciascuna di queste azioni possiede un costo dipendente da uno o più parametri; nel caso di load ed unload il parametro è la quantità
di merce che viene trattata dall'azione scelta mentre il costo della shift dipende dal mezzo che la compie (van 1/1, ship 2/3, plane 5/4) e dalla distanza tra le due città tra cui viene applicata. Alcuni tragitti non sono percorribili da tutti i mezzi di trasporto e perciò non tutte le città 
sono collegate direttamente tra loro.
Di seguito i tragitti percorribili con i vari tipi di veicoli (presenti nella legenda):
<p align="center">
  <img src="https://raw.githubusercontent.com/CesareIurlaro/clips-project/master/stuff/route.png"/>
</p>

Sono note le distanze in linea d'aria tra le diverse città prese in esame: 
<p align="center">
  <img src="https://raw.githubusercontent.com/CesareIurlaro/clips-project/master/stuff/crow_flies_distances.png"/>
</p>

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
L'implementazione di A* nel linguaggio CLIPS è stata effettuata tramite la suddivione
in moduli:
- Main che si occupa di instanziare il nodo iniziale e di stampare il costo totale
  e i costi delle singole azioni della soluzione 
- Expand che si assicura della aciclicità del grafo ovvero che non vi siano
più percorsi che portino a stati uguali tra loro. Nel caso in cui ciò non fosse 
rispettato allora il nodo del percorso più costoso viene chiuso.
- Check che si occupa di verificare se all'interno dei vari fatti 'status'
sia contenuto il goal desiderato
- New che si occupa sia di aggiornare le statistiche (closed, worse, better) relative
all'algoritmo sia di aggiungere nodi al percorso preso in esame.

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
stati. 

Una prima suddivisione è stata quella di produrre un numero di 
sottobiettivi pari al numero di città menzionate nella traccia del problema (eccetto
Firenze). Successivamente, per necessità e comodità, si è deciso di apportare un'
ulteriore suddivisione ad alcune basi di conoscenza.

## Sottobiettivi
I sottobiettivi prodotti sono:
- ;; Sottografo con tre città: Torino (TO), Roma (RM) e Palermo (PA).
;; Soddisfiamo le necessità di TO attraverso l'obiettivo che prevede l'utilizzo
;; di un aereo (vehicle_6) fermo a PA per il trasporto delle merci di tipo A

- ;; Sottografo con tre città: Roma (RM), Napoli (NA) e Reggio Calabria (RC).
;; Soddisfiamo le necessità di MI attraverso l'utilizzo di tre sotto-obiettivi:
;; 1. Trasferimento delle merci di tipo A da RC verso NA,
;; 2. Trasferimento parziale di 10 A verso MI,
;; 3. Trasferimento delle rimanenti 20 A verso MI.


- ;; Sottografo con due città: Venezia (VE) e Bologna (BO).
;; Soddisfiamo le necessità di VE attraverso l'obiettivo che prevede l'utilizzo
;; di un van (vehicle_2) fermo a BO per il trasporto delle merci di tipo B.

- ;; Sottografo con tre città: Torino (TO), Milano (MI) e Bologna (BO).
;; Soddisfiamo le necessità di GE attraverso l'utilizzo di due sottoobiettivi:
;; 1. Trasferimento di un van (vehicle_1) da BO a TO,
;; 2. Trasferimento delle merci di tipo B con l'utilizzo del van (vehicle_1) da
;;    TO verso GE.

- ;; Sottografo con due città: Venezia (VE) e Bologna (BO).
;; Soddisfiamo le necessità di BO attraverso l'obiettivo che prevede l'utilizzo
;; di un van (vehicle_2) fermo a VE per il trasporto delle merci di tipo C

- ;; Sottografo con due città: Torino (TO), Milano (MI) e Roma (RM).
;; Soddisfiamo le necessità di RM attraverso l'utilizzo di due sotto-obiettivi:
;; 1. Trasferimento delle merci di tipo C da MI verso TO con l'utilizzo
;;    di un van (vehicle_3) fermo a MI,
;; 2. Trasferimento delle merci precedentemente trattate verso RM con l'utilizzo
;;    di un plane (vehicle_6) fermo a TO,

- ;; Sottografo con tre città: Genova (GE), Napoli (NA) e Palermo (PA).
;; Soddisfiamo le necessità di NA e PA attraverso l'utilizzo di una nave
;; (vehicle_8).

- ;; Sottografo con tre città: Milano (MI), Bologna (BO) e Bari (BA).
;; Soddisfiamo le necessità di BA attraverso l'utilizzo di due sottoobiettivi:
;; 1. Trasferimento delle merci di tipo A da BO verso MI con l'utilizzo
;;    di un van (vehicle_3) fermo a BO,
;; 2. Trasferimento delle merci precedentemente trattate verso BA con l'utilizzo
;;    di un van (vehicle_7) fermo a MI,

- ;; Sottografo con duce città: Napoli (NA) e Reggio Calabria (RC).
;; Soddisfiamo le necessità di RC attraverso l'obiettivo che prevede l'utilizzo
;; di un van (vehicle_5) fermo a NA per il trasporto delle merci di tipo B

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
Contenute all'interno della cartella 'utils'.

Le funzioni utilizzate sono contenute all'interno del file 'functions.clp'.
Esse sono:
- travel_cost_evaluation che calcola, dato il mezzo di trasporto e la distanza da 
percorrere, il costo dello spostamento
- find_heuristic_costs che si occupa di calcolare il valore dell'euristica utilizzata
- string_comparator utilizzata per confrontare due stringhe passate come parametro
- prepare_string utilizzata per produrre una stringa che concatena tutti gli 
'status' aventi lo stesso valore dello slot 'ident'. La stringa risultante è
rappresentativa della configurazione di quello stato.
- sum_up_costs che si occupa di calcolare il costo totale della soluzione dati 
i costi delle soluzioni dei sottobiettivi.

Le regole utilizzate sono contenute all'interno del file 'rules.clp'.
Queste producono fatti ed eseguono calcoli di supporto al calcolo dell'euristica.

Infine, il file 'cf_distances.clp' contiene:
- 'h_distance', fatto ordinato, che rappresenta la distanza in linea d'aria utilizzata
per il calcolo dell'euristica
- 'distance', fatto non ordinato, che rappresenta la distanza in linea d'aria
dei tragitti possibili dai mezzi di trasporto utilizzati nel problema.

# Conclusioni

## Authors

* **Cesare Iurlaro** - [CesareIurlaro](https://github.com/CesareIurlaro)
* **Giuseppe Gabbia**  - [beppe95](https://github.com/beppe95)
* **Lamberto Basti**  - [lamba92](https://github.com/lamba92)
