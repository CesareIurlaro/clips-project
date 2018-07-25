(defmodule MAIN (export ?ALL))

(defrule start_00 (declare (salience 5))

?f <- (state
     (name_1 ?city_1) (qtyProd_TO ?qtyProd_1) (objProd_TO ?objProd_1) (qtyNeed_TO ?qtyNeed_1) (objNeed_TO ?objNeed_1) (qtyStore_TO ?qtyStore_1) (objStore_TO ?objStore_1)
     (name_6 ?city_6) (qtyProd_RM ?qtyProd_6) (objProd_RM ?objProd_6) (qtyNeed_RM ?qtyNeed_6) (objNeed_RM ?objNeed_6) (qtyStore_RM ?qtyStore_6) (objStore_RM ?objStore_6)
     (name_10 ?city_10) (qtyProd_PA ?qtyProd_10) (objProd_PA ?objProd_10) (qtyNeed_PA ?qtyNeed_10) (objNeed_PA ?objNeed_10) (qtyStore_PA ?qtyStore_10) (objStore_PA ?objStore_10)

     (vehicle_6 ?type_6 ?capacity_6 ?location_6 ?id6))

=>
    (retract ?f)
    (bind ?id (gensym*))
    (assert
        (find_heuristic_wares_cost)

        (status (ident ?id) (subject city) (data ?city_1  ?qtyProd_1  ?objProd_1  ?qtyNeed_1  ?objNeed_1 ?qtyStore_1  ?objStore_1))
        (status (ident ?id) (subject city) (data ?city_6  ?qtyProd_6  ?objProd_6  ?qtyNeed_6  ?objNeed_6 ?qtyStore_6  ?objStore_6))
        (status (ident ?id) (subject city) (data ?city_10  ?qtyProd_10  ?objProd_10  ?qtyNeed_10  ?objNeed_10 ?qtyStore_10  ?objStore_10))
        (status (ident ?id) (subject transport) (data ?type_6 ?capacity_6 ?location_6 ?id6))

        (current ?id))
)

(defrule start_01
    ?h_w <- (computed_heuristic_wares_cost ?wcost)
    ?h_t <- (find_heuristic_travel_costs)
    (current ?id)

=>
    (retract ?h_w ?h_t)
    (bind ?tcost (find_overall_travel_costs))
    (bind ?fcost (+ ?wcost ?tcost))

    (assert
       (node (ident ?id)
           (gcost 0) (fcost ?fcost)
           (father NA) (open yes)))

    (do-for-all-facts ((?f computed_heuristic_travel_cost)) TRUE
        (retract ?f))

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
    (printout t crlf " ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~ " crlf "Esiste soluzione con costo " ?c crlf)
    (printout t crlf " stati espansi " ?n crlf)
    (printout t " stati generati gia` in closed " ?closed crlf)
    (printout t " stati generati gia` in (open-worse) " ?worse crlf)
    (printout t " stati generati gia` in (open-better) " ?better crlf)
    (halt))
