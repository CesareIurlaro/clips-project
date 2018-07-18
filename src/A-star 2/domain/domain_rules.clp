(defrule EXPAND::load
    "Se un mezzo con capienza > 0 transita da una città
     che ha prodotti da esportare, allora il mezzo li carica"
    (declare (salience 50))

    (current ?curr)
    (node (ident ?curr) (open yes))

    (status (ident ?curr) (subject transport) (data ?type ?capacity&:(> ?capacity 0) ?location ?id))
    (status (ident ?curr) (subject city) (data ?location ?quantity&:(> ?quantity 0) ?obj $?y))

=>

    (assert
        (apply ?curr load
            transport ?type ?capacity ?location ?id     ;; ?t = mezzo ?c = capienza ?id = id del veicolo
            city ?location ?quantity ?obj $?y           ;; ?l = location ?q = quantità ?obj = oggetto
        )                                               ;; (?q e ?obj si riferiscono alla produzione della città,
    ))


(defrule EXPAND::apply-load (declare (salience 50))
    (current ?curr)

    ?f <- (apply ?curr load
           transport ?type ?capacity ?location ?id     ;; ?t = mezzo ?c = capienza ?id = id del veicolo
           city ?location ?quantityP ?objP ?quantityN ?objN)          ;; ?l = location ?q = quantità ?obj = oggetto


    (node (ident ?curr) (gcost ?g))

    (goal city ?name $?goal)

    (status (ident ?curr) (subject city) (data ?name ?quantityProd ?objProd ?quantityNeed ?objNeed))
    (h_distance (from ?location) (h_length ?h_length) (to ?name))

 =>

    (retract ?f)

    (bind ?new (gensym*))
    (bind $?transportData (str-cat ?type " " ?capacity " " ?location " " ?id))
    (bind $?cityData (str-cat ?location " " ?quantityP " " ?objP " " ?quantityN " " ?objN))

    (do-for-all-facts ((?f status))
        (and
            (eq(str-compare ?f:ident ?curr) 0)
            (not
                (or
                    (and (eq(str-compare ?f:subject transport) 0) (eq(str-compare (implode$ ?f:data) $?transportData) 0))
                    (and (eq(str-compare ?f:subject city) 0) (eq(str-compare (implode$ ?f:data)  $?cityData) 0) )
                )
            )
        )
        (assert (status (ident ?new) (subject ?f:subject) (data ?f:data)))
    )


    (bind ?gcost 0)

    (if (>= ?quantityP ?capacity)
    then
        (bind ?gcost (+ ?gcost (* 10 ?capacity)))
        (assert (status (ident ?new) (subject transport) (data ?type 0 ?location ?id)))
        (assert (status (ident ?new) (subject city) (data ?location (- ?quantityP ?capacity) ?objP ?quantityN ?objN)))
        (assert (status (ident ?new) (subject carries) (data ?id ?capacity ?objP)))
    else
        (bind ?gcost (+ ?gcost (* 10 ?quantityP)))

        (assert (status (ident ?new) (subject transport) (data ?type (- ?capacity ?quantityP) ?location ?id)))
        (assert (status (ident ?new) (subject city) (data ?location 0 ?objP ?quantityN ?objN)))
        (assert (status (ident ?new) (subject carries) (data ?id ?quantityP ?objP)))
    )

    (bind ?travel_cost (travel_cost_evaluation ?type ?h_length))

    (if (eq(str-compare ?objP ?objNeed) 0)
    then
        (bind ?wares_cost (* 10 (abs(- ?quantityP ?quantityNeed))))
    else
        (bind ?wares_cost (* 10 (abs ?quantityNeed))))

    (bind ?fcost (+ ?travel_cost ?wares_cost))

    (assert (exec ?curr ?new load
             transport ?type ?capacity ?location ?id
             city ?location ?quantityP ?objP ?quantityN ?objN)
            (newnode
                (ident ?new)
                (gcost (+ ?g ?gcost))
                (fcost (+ ?gcost ?fcost))
                (father ?curr)))
)


;; ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~

;; Scaricare roba in posti a cui non serve
(defrule EXPAND::unload
    "Se un mezzo che trasporta un oggetto transita da una città
     che lo importa, allora il mezzo lo scarica"
    (declare (salience 50))

    (current ?curr)
    (node (ident ?curr) (open yes))


    (status (ident ?curr) (subject transport) (data ?type ?capacity ?location ?id))
    (status (ident ?curr) (subject city) (data ?location $?x ?quantity1 ?obj))
    (status (ident ?curr) (subject carries) (data ?id ?quantity2 ?obj))

=>

    (assert
        (apply ?curr unload
            transport ?type ?capacity ?location ?id
            city ?location $?x ?quantity1 ?obj
            carries ?id ?quantity2 ?obj
        )
    )
)


(defrule EXPAND::apply-unload (declare (salience 50))

    (current ?curr)

    ?f <- (apply ?curr unload
           transport ?type ?capacity ?location ?id
           city ?location $?x ?quantity1 ?obj
           carries ?id ?quantity2 ?obj
    )

    (node (ident ?curr) (gcost ?g))

    (goal city ?name $?goal)
    (status (ident ?curr) (subject city) (data ?name ?quantityProd ?objProd ?quantityNeed ?objNeed))

=>

   (retract ?f)

   (bind ?new (gensym*))

   (bind ?gcost 0)

   (if (> ?quantity2 ?quantity1)
   then
        (bind ?gcost (+ ?gcost (* 10 ?quantity1)))
        (bind ?unloadedWares ?quantity1)
        (assert (status (ident ?new) (subject transport) (data ?type (+ ?capacity ?quantity1) ?location ?id)))
        (assert (status (ident ?new) (subject city) (data ?location $?x 0 ?obj)))
        (assert (status (ident ?new) (subject carries) (data ?id (- ?quantity2 ?quantity1) ?obj)))
    )

    (if (< ?quantity2 ?quantity1)
    then
        (bind ?gcost (+ ?gcost (* 10 ?quantity2)))
        (bind ?unloadedWares ?quantity2)
        (assert (status (ident ?new) (subject transport) (data ?type (+ ?capacity ?quantity2) ?location ?id)))
        (assert (status (ident ?new) (subject city) (data ?location $?x (- ?quantity1 ?quantity2) ?obj)))
    ) ;; no carries

    (if (= ?quantity2 ?quantity1)
    then
        (bind ?gcost (+ ?gcost (* 10 ?quantity1)))
        (bind ?unloadedWares ?quantity1)
        (assert (status (ident ?new) (subject transport) (data ?type (+ ?capacity ?quantity1) ?location ?id)))
        (assert (status (ident ?new) (subject city) (data ?location $?x 0 ?obj)))
    ) ;; no carries

    (bind ?travel_cost 0)
    (bind ?wares_cost 0)

    (do-for-all-facts ((?f h_distance)) (and (eq(str-compare ?f:from ?location) 0) (eq(str-compare ?f:to ?name) 0)) ;; non corrisponde all'obiettivo
        (bind ?travel_cost (+ ?travel_cost (travel_cost_evaluation ?type ?f:h_length)))
        (bind ?wares_cost  (+ ?wares_cost (* 10 ?quantityNeed)))
    )

    (bind ?wares_cost  (+ ?wares_cost (* 10 (- ?quantityNeed ?unloadedWares))))

    (bind ?fcost (+ ?travel_cost ?wares_cost))

    (assert (exec ?curr ?new unload
             transport ?type ?capacity ?location ?id
             city ?location $?x ?quantity1 ?obj
             carries ?id ?quantity2 ?obj)
            (newnode
                (ident ?new)
                (gcost (+ ?g ?gcost))
                (fcost (+ ?gcost ?fcost))
                (father ?curr)))
)


;; ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~

(defrule EXPAND::shift (declare (salience 50))

    (current ?curr)
    (node (ident ?curr) (open yes))

    (status (ident ?curr) (subject transport) (data ?type ?capacity ?location1 ?id))
    (status (ident ?curr) (subject city) (data ?location1 $?x))
    (status (ident ?curr) (subject city) (data ?location2 $?y))
    (test (neq(str-compare ?location1 ?location2) 0))
    (distance ?location1 ?length ?location2 ?type)

=>

    (assert
        (apply ?curr shift
            transport ?type ?capacity ?location1 ?id
            city ?location1 $?x
            city ?location2 $?y
            distance ?location1 ?length ?location2 ?type
        )
    )
)


(defrule EXPAND::apply-shift (declare (salience 50))

    (current ?curr)

    ?f <- (apply ?curr shift
           transport ?type ?capacity ?location1 ?id
           city ?location1 $?x
           city ?location2 $?y
           distance ?location1 ?length ?location2 ?type
    )

    (node (ident ?curr) (gcost ?g))

    (goal city ?name $?goal)
    (status (ident ?curr) (subject city) (data ?name ?quantityProd ?objProd ?quantityNeed ?objNeed))

=>

    (retract ?f)

    (bind ?new (gensym*))

    (bind ?gcost (travel_cost_evaluation ?type ?length))

    (bind ?travel_cost 0)
    (bind ?wares_cost (* 10 ?quantityNeed))

    (do-for-all-facts ((?f h_distance)) (and (eq(str-compare ?f:from ?location2) 0) (eq(str-compare ?f:to ?name) 0));; non corrisponde all'obiettivo
        (bind ?travel_cost (+ ?travel_cost (travel_cost_evaluation ?type ?f:h_length)))
    )

    (bind ?fcost (+ ?travel_cost ?wares_cost))

    (assert (exec ?curr ?new shift
             transport ?type ?capacity ?location1 ?id
             city ?location1 $?x
             city ?location2 $?y
             )
             (status (ident ?new) (subject transport) (data ?type ?capacity ?location2 ?id))
             (newnode
                 (ident ?new)
                 (gcost (+ ?g ?gcost))
                 (fcost (+ ?gcost ?fcost))
                 (father ?curr)))
)
