(defmodule MAIN (export ?ALL))

(defrule run
    ?h_w <- (find_heuristic_wares_costs)
    ?h_t <- (find_heuristic_travel_costs)
    (current ?id)

=>
    (retract ?h_w ?h_t)

    (bind ?o_cost (find_heuristic_costs))
    (bind ?fcost ?o_cost)
    (assert
       (node (ident ?id)
           (gcost 0) (fcost ?fcost)
           (father NA) (open yes)))

    (focus EXPAND))



(defrule stampaSol (declare (salience 101))
    ?f <- (stampa ?id)
    (node (ident ?id) (father ?anc&~NA))
    (exec ?anc ?id ?op ?cost $?e)

    ?f2 <-(total_cost ?c)
=>
    (printout t " Eseguo azione " ?op " con costo " ?cost " " $?e crlf)
    (assert (stampa ?anc))
    (assert (total_cost (+ ?c ?cost)))
    (retract ?f ?f2))


(defrule stampa-fine (declare (salience 102))
    (stampa ?id)
    (node (ident ?id) (father ?anc&NA))
    (open-worse ?worse)
    (open-better ?better)
    (alreadyclosed ?closed)
    (numberofnodes ?n)
    (total_cost ?c)
=>
    (load-facts "projectCosts.fct")
    (assert (file_total_cost (f_total_cost ?c)))
    (save-facts "projectCosts.fct" visible file_total_cost)
    (printout t crlf " ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~ " crlf " Esiste soluzione con costo " ?c crlf)
    (printout t crlf " stati espansi " ?n crlf)
    (printout t " stati generati gia` in closed " ?closed crlf)
    (printout t " stati generati gia` in (open-worse) " ?worse crlf)
    (printout t " stati generati gia` in (open-better) " ?better crlf)
)

(defrule make_new_city_state_configuration (declare (salience 99))
 ?f <- (city_state
          (name     ?name)
          (qtyProd  ?qtyProd)
          (objProd  ?objProd)
          (qtyNeed  ?qtyNeed)
          (objNeed  ?objNeed)
          (qtyStore ?qtyStore)
          (objStore ?objStore)
      )

      (status (ident ?ident) (subject city)
              (data ?name ?status_qtyProd ?status_objProd
                                 ?status_qtyNeed ?status_objNeed
                                 ?status_qtyStore ?status_objStore))
 =>
   (modify ?f
     (qtyProd  ?status_qtyProd)
     (objProd  ?status_objProd)
     (qtyNeed  ?status_qtyNeed)
     (objNeed  ?status_objNeed)
     (qtyStore ?status_qtyStore)
     (objStore ?status_objStore)
   )

)

(defrule make_vehicle_state_configuration (declare (salience 99))
 ?f <- (vehicle_state
         (type ?type)
         (capacity ?capacity)
         (location ?location)
         (id ?id)
      )

      (status (ident ?ident) (subject transport) (data ?status_type ?status_capacity ?status_location ?id))
 =>
   (modify ?f
     (type ?status_type) (capacity ?status_capacity) (location ?status_location)
   )

)
