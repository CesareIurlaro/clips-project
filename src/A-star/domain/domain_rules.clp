(defrule EXPAND::apply-load-prod
    "Se un mezzo con capienza > 0 transita da una città
     che ha prodotti da esportare, allora il mezzo li carica"
    (declare (salience 50))

    (current ?curr)
    (node (ident ?curr) (open yes))

    (status (ident ?curr) (subject transport) (data ?type ?capacity&:(> ?capacity 0) ?location ?id))
    (status (ident ?curr) (subject city) (data ?location ?quantity&:(> ?quantity 0) ?obj $?y))

=>

    (assert
        (apply ?curr load-prod
            transport ?type ?capacity ?location ?id
            city ?location ?quantity ?obj $?y)))


(defrule EXPAND::exec-load-prod (declare (salience 50))
    (current ?curr)
    (node (ident ?curr) (gcost ?g))

    ?f <- (apply ?curr load-prod
           transport ?type ?capacity ?location ?id
           city ?location ?quantityP ?objP ?quantityN ?objN ?quantityS ?objS)

    (goal (subject city) (data ?name $?goal))
    (status (ident ?curr) (subject city) (data ?name ?quantityProd ?objProd ?quantityNeed ?objNeed ?quantityStore ?objStore))
    (h_distance (from ?location) (h_length ?h_length) (to ?name))

 =>

    (retract ?f)

    (bind ?new (gensym*))
    (bind $?transportData (implode$ (create$ ?type ?capacity ?location ?id)))
    (bind $?cityData (implode$ (create$ ?location ?quantityP ?objP ?quantityN ?objN ?quantityS ?objS)))

    (do-for-all-facts ((?f status))
        (and
            (eq ?f:ident ?curr)
            (not (or (and (eq ?f:subject transport) (eq (implode$ ?f:data) $?transportData))
                     (and (eq ?f:subject city)      (eq (implode$ ?f:data) $?cityData ) ))))
        (assert (status (ident ?new) (subject ?f:subject) (data ?f:data))))

    (if (>= ?quantityP ?capacity)
    then
        (bind ?gcost (* 10 ?capacity))
        (assert (status (ident ?new) (subject transport) (data ?type 0 ?location ?id)))
        (assert (status (ident ?new) (subject city)      (data ?location (- ?quantityP ?capacity) ?objP ?quantityN ?objN ?quantityS ?objS)))
        (assert (status (ident ?new) (subject carries)   (data ?id ?capacity ?objP)))
    else
        (bind ?gcost (* 10 ?quantityP))
        (assert (status (ident ?new) (subject transport) (data ?type (- ?capacity ?quantityP) ?location ?id)))
        (assert (status (ident ?new) (subject city)      (data ?location 0 ?objP ?quantityN ?objN ?quantityS ?objS)))
        (assert (status (ident ?new) (subject carries)   (data ?id ?quantityP ?objP))))

    (assert (gcost ?gcost) (old_gcost ?g) (new ?new) (find_heuristic_wares_costs) (find_heuristic_travel_costs) (load-prod))
    (assert (exec ?curr ?new load-prod ?gcost
             transport ?type ?capacity ?location ?id
             city ?location ?quantityP ?objP ?quantityN ?objN ?quantityS ?objS)
            (prev_next (ident ?curr))
            (prev_next (ident ?new))))


(defrule EXPAND::load-prod_newnode (declare (salience 50))
    (current ?curr)
    ?dummy <- (load-prod)
    ?h_w <- (computed_heuristic_wares_cost (cost ?wcost))
    ?h_t <- (find_heuristic_travel_costs)
    ?h_fw <- (find_heuristic_wares_costs)
    ?n <- (new ?new)
    ?m <- (gcost ?gcost)
    ?o <- (old_gcost ?g)

=>
    (retract ?h_w ?h_t ?h_fw ?dummy)
    (retract ?n ?m ?o)
    (bind ?tcost (find_heuristic_costs))
    (bind ?fcost (+ ?wcost ?tcost))
    (assert (newnode
                (ident ?new)
                (gcost (+ ?g ?gcost))
                (fcost (+ ?g ?gcost ?fcost))
                (father ?curr))))

;; ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~

(defrule EXPAND::apply-load-store
    "Se un mezzo con capienza > 0 transita da una città
     che ha prodotti immaganizzati, allora il mezzo li carica"
    (declare (salience 50))

    (current ?curr)
    (node (ident ?curr) (open yes))

    (status (ident ?curr) (subject transport) (data ?type ?capacity&:(> ?capacity 0) ?location ?id))
    (status (ident ?curr) (subject city) (data ?location $?y ?quantity&:(> ?quantity 0) ?obj))

=>

    (assert
        (apply ?curr load-store
            transport ?type ?capacity ?location ?id
            city ?location $?y ?quantity ?obj)))


(defrule EXPAND::exec-load-store (declare (salience 50))
    (current ?curr)
    (node (ident ?curr) (gcost ?g))

    ?f <- (apply ?curr load-store
           transport ?type ?capacity ?location ?id
           city ?location ?quantityP ?objP ?quantityN ?objN ?quantityS ?objS)

    (goal (subject city) (data ?name $?goal))
    (status (ident ?curr) (subject city) (data ?name ?quantityProd ?objProd ?quantityNeed ?objNeed ?quantityStore ?objStore))
    (h_distance (from ?location) (h_length ?h_length) (to ?name))

 =>

    (retract ?f)

    (bind ?new (gensym*))
    (bind $?transportData (implode$ (create$ ?type ?capacity ?location ?id)))
    (bind $?cityData (implode$ (create$ ?location ?quantityP ?objP ?quantityN ?objN ?quantityS ?objS)))

    (do-for-all-facts ((?f status))
        (and
            (eq ?f:ident ?curr)
            (not (or (and (eq ?f:subject transport) (eq (implode$ ?f:data) $?transportData))
                     (and (eq ?f:subject city)      (eq (implode$ ?f:data) $?cityData ) ))))
        (assert (status (ident ?new) (subject ?f:subject) (data ?f:data))))


    (if (>= ?quantityS ?capacity)
    then
        (bind ?gcost (* 10 ?capacity))
        (assert (status (ident ?new) (subject transport) (data ?type 0 ?location ?id)))
        (assert (status (ident ?new) (subject city) (data ?location ?quantityP ?objP ?quantityN ?objN (- ?quantityS ?capacity) ?objS)))
        (assert (status (ident ?new) (subject carries) (data ?id ?capacity ?objS)))
    else
        (bind ?gcost (* 10 ?quantityS))
        (assert (status (ident ?new) (subject transport) (data ?type (- ?capacity ?quantityS) ?location ?id)))
        (assert (status (ident ?new) (subject city) (data ?location ?quantityP ?objP ?quantityN ?objN 0 ?objS)))
        (assert (status (ident ?new) (subject carries) (data ?id ?quantityS ?objS))))    ;; può essere messo fuori

    (assert (gcost ?gcost) (old_gcost ?g) (new ?new) (find_heuristic_wares_costs) (find_heuristic_travel_costs) (load-store))
    (assert (exec ?curr ?new load-store ?gcost
             transport ?type ?capacity ?location ?id
             city ?location ?quantityP ?objP ?quantityN ?objN ?quantityS ?objS)
             (prev_next (ident ?curr))
             (prev_next (ident ?new)))
)


(defrule EXPAND::load-store_newnode (declare (salience 50))
    (current ?curr)
    ?dummy <- (load-store)
    ?h_fw <- (find_heuristic_wares_costs)
    ?h_w <- (computed_heuristic_wares_cost  (cost ?wcost))
    ?h_t <- (find_heuristic_travel_costs)
    ?n <- (new ?new)
    ?m <- (gcost ?gcost)
    ?o <- (old_gcost ?g)

=>

    (retract ?h_w ?h_t ?h_fw ?dummy)
    (retract ?n ?m ?o)
    (bind ?tcost (find_heuristic_costs))
    (bind ?fcost (+ ?wcost ?tcost))
    (assert (newnode
                (ident ?new)
                (gcost (+ ?g ?gcost))
                (fcost (+ ?g ?gcost ?fcost))
                (father ?curr))))

;; ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~

(defrule EXPAND::apply-unload-need
    "Se un mezzo che trasporta un oggetto transita da una città
     che lo importa, allora il mezzo lo scarica"
    (declare (salience 50))

    (current ?curr)
    (node (ident ?curr) (open yes))

    (status (ident ?curr) (subject transport) (data ?type ?capacity ?location ?id))
    (status (ident ?curr) (subject city)      (data ?location ?quantityP ?objP ?quantityN1&:(> ?quantityN1 0) ?objN ?quantityS ?objS))
    (status (ident ?curr) (subject carries)   (data ?id ?quantityN2 ?objN))

=>

    (assert
        (apply ?curr unload-need
            transport ?type ?capacity ?location ?id
            city ?location ?quantityP ?objP ?quantityN1 ?objN ?quantityS ?objS
            carries ?id ?quantityN2 ?objN)))


(defrule EXPAND::exec-unload-need (declare (salience 50))

    (current ?curr)
    (node (ident ?curr) (gcost ?g))

    ?f <- (apply ?curr unload-need
           transport ?type ?capacity ?location ?id
           city ?location ?quantityP ?objP ?quantityN1 ?objN ?quantityS ?objS
           carries ?id ?quantityN2 ?objN)

    (goal (subject city) (data ?name $?goal))
    (status (ident ?curr) (subject city) (data ?name ?quantityProd ?objProd ?quantityNeed ?objNeed ?quantityStore ?objStore))

=>

   (retract ?f)

   (bind ?new (gensym*))

   (bind $?transportData (implode$ (create$ ?type ?capacity ?location ?id)))
   (bind $?cityData      (implode$ (create$ ?location ?quantityP ?objP ?quantityN1 ?objN ?quantityS ?objS)))
   (bind $?carriesData   (implode$ (create$ ?id ?quantityN2 ?objN)))

   (do-for-all-facts ((?f status))
       (and
           (eq ?f:ident ?curr)
           (not (or (and (eq ?f:subject transport) (eq (implode$ ?f:data) $?transportData))
                    (and (eq ?f:subject city)      (eq (implode$ ?f:data) $?cityData ) )
                    (and (eq ?f:subject carries)   (eq (implode$ ?f:data) $?carriesData) ))))
       (assert (status (ident ?new) (subject ?f:subject) (data ?f:data))))


   (if (> ?quantityN2 ?quantityN1)
   then
        (bind ?gcost (* 10 ?quantityN1))
        (assert (status (ident ?new) (subject transport) (data ?type (+ ?capacity ?quantityN1) ?location ?id)))
        (assert (status (ident ?new) (subject city)      (data ?location ?quantityP ?objP 0 ?objN ?quantityS ?objS)))
        (assert (status (ident ?new) (subject carries)   (data ?id (- ?quantityN2 ?quantityN1) ?objN)))
    )

    (if (< ?quantityN2 ?quantityN1)
    then
        (bind ?gcost (* 10 ?quantityN2))
        (assert (status (ident ?new) (subject transport) (data ?type (+ ?capacity ?quantityN2) ?location ?id)))
        (assert (status (ident ?new) (subject city)      (data ?location ?quantityP ?objP (- ?quantityN1 ?quantityN2) ?objN ?quantityS ?objS)))
    ) ;; no carries

    (if (= ?quantityN2 ?quantityN1)
    then
        (bind ?gcost (* 10 ?quantityN1))
        (assert (status (ident ?new) (subject transport) (data ?type (+ ?capacity ?quantityN1) ?location ?id)))
        (assert (status (ident ?new) (subject city)      (data ?location ?quantityP ?objP 0 ?objN ?quantityS ?objS)))
    ) ;; no carries


    (assert (gcost ?gcost) (old_gcost ?g) (new ?new) (find_heuristic_wares_costs) (find_heuristic_travel_costs) (unload-need))
    (assert (exec ?curr ?new unload-need ?gcost
             transport ?type ?capacity ?location ?id
             city ?location ?quantityP ?objP ?quantityN1 ?objN ?quantityS ?objS
             carries ?id ?quantityN2 ?objN)
             (prev_next (ident ?curr))
             (prev_next (ident ?new))))



(defrule EXPAND::unload-need_newnode (declare (salience 50))
    (current ?curr)
    ?dummy <- (unload-need)
    ?h_w <- (computed_heuristic_wares_cost  (cost ?wcost))
    ?h_t <- (find_heuristic_travel_costs)
    ?h_fw <- (find_heuristic_wares_costs)
    ?n <- (new ?new)
    ?m <- (gcost ?gcost)
    ?o <- (old_gcost ?g)

=>
    (retract ?h_w ?h_t ?h_fw ?dummy)
    (retract ?n ?m ?o)

    (bind ?tcost (find_heuristic_costs))
    (bind ?fcost (+ ?wcost ?tcost))
    (assert (newnode
        (ident ?new)
        (gcost (+ ?g ?gcost))
        (fcost (+ ?g ?gcost ?fcost))
        (father ?curr))))


;; ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~

(defrule EXPAND::apply-unload-store
    "Se un mezzo che trasporta un oggetto transita da una città
     che lo immagazzina, allora il mezzo lo scarica"
    (declare (salience 50))

    (current ?curr)
    (node (ident ?curr) (open yes))

    (status (ident ?curr) (subject transport) (data ?type ?capacity ?location ?id))
    (status (ident ?curr) (subject city)      (data ?location $?x ?quantity1 ?obj))
    (status (ident ?curr) (subject carries)   (data ?id ?quantity2 ?obj))

=>

    (assert
        (apply ?curr unload-store
            transport ?type ?capacity ?location ?id
            city ?location $?x ?quantity1 ?obj
            carries ?id ?quantity2 ?obj)))


(defrule EXPAND::exec-unload-store (declare (salience 50))

    (current ?curr)
    (node (ident ?curr) (gcost ?g))

    ?f <- (apply ?curr unload-store
           transport ?type ?capacity ?location ?id
           city ?location ?quantityP ?objP ?quantityN ?objN ?quantityS1 ?objS
           carries ?id ?quantityS2 ?objS)

    (goal (subject city) (data ?name $?goal))
    (status (ident ?curr) (subject city) (data ?name ?quantityProd ?objProd ?quantityNeed ?objNeed ?quantityStore ?objStore))

=>

    (retract ?f)

    (bind ?new (gensym*))

    (bind $?transportData (implode$ (create$ ?type ?capacity ?location ?id)))
    (bind $?cityData      (implode$ (create$ ?location ?quantityP ?objP ?quantityN ?objN ?quantityS1 ?objS)))
    (bind $?carriesData   (implode$ (create$ ?id ?quantityS2 ?objS)))

    (do-for-all-facts ((?f status))
      (and
          (eq ?f:ident ?curr)
          (not (or (and (eq ?f:subject transport) (eq (implode$ ?f:data) $?transportData))
                   (and (eq ?f:subject city)      (eq (implode$ ?f:data) $?cityData ) )
                   (and (eq ?f:subject carries)   (eq (implode$ ?f:data) $?carriesData) ))))
      (assert (status (ident ?new) (subject ?f:subject) (data ?f:data))))

    (bind ?gcost (* 10 ?quantityS2))

    (assert (gcost ?gcost) (old_gcost ?g) (new ?new) (find_heuristic_wares_costs) (find_heuristic_travel_costs) (unload-store))
    (assert (exec ?curr ?new unload-store ?gcost
             transport ?type ?capacity ?location ?id
             city ?location ?quantityP ?objP ?quantityN ?objN ?quantityS1 ?objS
             carries ?id ?quantityS2 ?objN)
            (status (ident ?new) (subject transport) (data ?type (+ ?capacity ?quantityS2) ?location ?id))
            (status (ident ?new) (subject city) (data ?location ?quantityP ?objP ?quantityN ?objN (+ ?quantityS1 ?quantityS2) ?objS))
            (prev_next (ident ?curr))
            (prev_next (ident ?new))))



(defrule EXPAND::unload-store_newnode (declare (salience 50))
    (current ?curr)
    ?dummy <- (unload-store)
    ?h_w <- (computed_heuristic_wares_cost (cost ?wcost))
    ?h_t <- (find_heuristic_travel_costs)
    ?h_fw <- (find_heuristic_wares_costs)
    ?n <- (new ?new)
    ?m <- (gcost ?gcost)
    ?o <- (old_gcost ?g)

=>
    (retract ?h_w ?h_t ?h_fw ?dummy)
    (retract ?n ?m ?o)
    (bind ?tcost (find_heuristic_costs))
    (bind ?fcost (+ ?wcost ?tcost))
    (assert (newnode
        (ident ?new)
        (gcost (+ ?g ?gcost))
        (fcost (+ ?g ?gcost ?fcost))
        (father ?curr))))


;; ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~

(defrule EXPAND::apply-shift (declare (salience 50))

    (current ?curr)
    (node (ident ?curr) (open yes))

    (status (ident ?curr) (subject transport) (data ?type ?capacity ?location1 ?id))
    (status (ident ?curr) (subject city) (data ?location1 $?x))
    (status (ident ?curr) (subject city) (data ?location2 $?y))

    (test (neq ?location1 ?location2))
    (distance ?location1 ?length ?location2 ?type)

=>

    (assert
        (apply ?curr shift
            transport ?type ?capacity ?location1 ?id
            city ?location1 $?x
            city ?location2 $?y
            distance ?location1 ?length ?location2 ?type)))


(defrule EXPAND::exec-shift (declare (salience 50))

    (current ?curr)
    (node (ident ?curr) (gcost ?g))

    ?f <- (apply ?curr shift
           transport ?type ?capacity ?location1 ?id
           city ?location1 $?x
           city ?location2 $?y
           distance ?location1 ?length ?location2 ?type)

    (or
      (and
        (goal (subject city) (data ?name $?goal))
        (status (ident ?curr) (subject city) (data ?name ?quantityProd ?objProd ?quantityNeed ?objNeed ?quantityS ?objS))
      )

      (and
        (goal (subject transport) (data ?typeTransport $?goalTransport))
        (status (ident ?curr) (subject transport) (data ?typeTransport ?capacityTransport ?locationTransport ?idTransport))
      )
    )

=>

    (retract ?f)

    (bind ?new (gensym*))

    (bind $?transportData (implode$ (create$ ?type ?capacity ?location1 ?id)))

    (do-for-all-facts ((?f status))
        (and
            (eq ?f:ident ?curr)
            (not (and (eq ?f:subject transport) (eq (implode$ ?f:data) $?transportData))))
        (assert (status (ident ?new) (subject ?f:subject) (data ?f:data))))

    (bind ?gcost (travel_cost_evaluation ?type ?length))

    (assert (gcost ?gcost) (old_gcost ?g) (new ?new) (find_heuristic_wares_costs) (find_heuristic_travel_costs) (shift))
    (assert (exec ?curr ?new shift ?gcost
             transport ?type ?capacity ?location1 ?id
             city ?location1 $?x
             city ?location2 $?y)
             (status (ident ?new) (subject transport) (data ?type ?capacity ?location2 ?id))
             (prev_next (ident ?curr))
             (prev_next (ident ?new))))

(defrule EXPAND::shift_newnode (declare (salience 50))

    (current ?curr)
    ?dummy <- (shift)
    ?h_fw <- (find_heuristic_wares_costs)
    ?h_w <- (computed_heuristic_wares_cost  (cost ?wcost))
    ?h_t <- (find_heuristic_travel_costs)
    ?n <- (new ?new)
    ?m <- (gcost ?gcost)
    ?o <- (old_gcost ?g)

=>
    (retract ?h_w ?h_t ?h_fw ?dummy)
    (retract ?n ?m ?o)
    (bind ?tcost (find_heuristic_costs))
    (bind ?fcost (+ ?wcost ?tcost))
    (assert (newnode
        (ident ?new)
        (gcost (+ ?g ?gcost))
        (fcost (+ ?g ?gcost ?fcost))
        (father ?curr))))
