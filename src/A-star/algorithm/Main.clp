(defmodule MAIN (export ?ALL))

(defrule start_TO (declare (salience 5))

?f <- (state
     (name_1 ?city_1) (qtyProd_TO ?qtyProd_1) (objProd_TO ?objProd_1) (qtyNeed_TO ?qtyNeed_1) (objNeed_TO ?objNeed_1) (qtyStore_TO ?qtyStore_1) (objStore_TO ?objStore_1)
     (name_6 ?city_6) (qtyProd_RM ?qtyProd_6) (objProd_RM ?objProd_6) (qtyNeed_RM ?qtyNeed_6) (objNeed_RM ?objNeed_6) (qtyStore_RM ?qtyStore_6) (objStore_RM ?objStore_6)
     (name_10 ?city_10) (qtyProd_PA ?qtyProd_10) (objProd_PA ?objProd_10) (qtyNeed_PA ?qtyNeed_10) (objNeed_PA ?objNeed_10) (qtyStore_PA ?qtyStore_10) (objStore_PA ?objStore_10)

     (vehicle_6 ?type_6 ?capacity_6 ?location_6 ?id6))

=>
    (retract ?f)
    (bind ?id (gensym*))
    (assert
        (find_heuristic_wares_costs) (find_heuristic_travel_costs)

        (status (ident ?id) (subject city) (data ?city_1  ?qtyProd_1  ?objProd_1  ?qtyNeed_1  ?objNeed_1 ?qtyStore_1  ?objStore_1))
        (status (ident ?id) (subject city) (data ?city_6  ?qtyProd_6  ?objProd_6  ?qtyNeed_6  ?objNeed_6 ?qtyStore_6  ?objStore_6))
        (status (ident ?id) (subject city) (data ?city_10  ?qtyProd_10  ?objProd_10  ?qtyNeed_10  ?objNeed_10 ?qtyStore_10  ?objStore_10))
        (status (ident ?id) (subject transport) (data ?type_6 ?capacity_6 ?location_6 ?id6))

        (current ?id))
)

(defrule start_MI_a (declare (salience 5))

?f <- (state
     (name_6 ?city_6)  (qtyProd_RM ?qtyProd_6)  (objProd_RM ?objProd_6)  (qtyNeed_RM ?qtyNeed_6)  (objNeed_RM ?objNeed_6)  (qtyStore_RM ?qtyStore_6)  (objStore_RM ?objStore_6)
     (name_7 ?city_7)  (qtyProd_NA ?qtyProd_7)  (objProd_NA ?objProd_7)  (qtyNeed_NA ?qtyNeed_7)  (objNeed_NA ?objNeed_7)  (qtyStore_NA ?qtyStore_7)  (objStore_NA ?objStore_7)
     (name_9 ?city_9)  (qtyProd_RC ?qtyProd_9)  (objProd_RC ?objProd_9)  (qtyNeed_RC ?qtyNeed_9)  (objNeed_RC ?objNeed_9)  (qtyStore_RC ?qtyStore_9)  (objStore_RC ?objStore_9)

     (vehicle_4 ?type_4 ?capacity_4 ?location_4 ?id4)
     (vehicle_5 ?type_5 ?capacity_5 ?location_5 ?id5))

=>
    (retract ?f)
    (bind ?id (gensym*))
    (assert
        (find_heuristic_wares_costs) (find_heuristic_travel_costs)

        (status (ident ?id) (subject city) (data ?city_6 ?qtyProd_6 ?objProd_6 ?qtyNeed_6 ?objNeed_6 ?qtyStore_6 ?objStore_6))
        (status (ident ?id) (subject city) (data ?city_7 ?qtyProd_7 ?objProd_7 ?qtyNeed_7 ?objNeed_7 ?qtyStore_7 ?objStore_7))
        (status (ident ?id) (subject city) (data ?city_9 ?qtyProd_9 ?objProd_9 ?qtyNeed_9 ?objNeed_9 ?qtyStore_9 ?objStore_9))

        (status (ident ?id) (subject transport) (data ?type_4 ?capacity_4 ?location_4 ?id4))
        (status (ident ?id) (subject transport) (data ?type_5 ?capacity_5 ?location_5 ?id5))

        (current ?id))
)

(defrule start_MI_b (declare (salience 5))

?f <- (state
     (name_2 ?city_2)  (qtyProd_MI ?qtyProd_2)  (objProd_MI ?objProd_2)  (qtyNeed_MI ?qtyNeed_2)  (objNeed_MI ?objNeed_2)  (qtyStore_MI ?qtyStore_2)  (objStore_MI ?objStore_2)
     (name_7 ?city_7)  (qtyProd_NA ?qtyProd_7)  (objProd_NA ?objProd_7)  (qtyNeed_NA ?qtyNeed_7)  (objNeed_NA ?objNeed_7)  (qtyStore_NA ?qtyStore_7)  (objStore_NA ?objStore_7)
     ;;(name_8 ?city_8)  (qtyProd_BA ?qtyProd_8)  (objProd_BA ?objProd_8)  (qtyNeed_BA ?qtyNeed_8)  (objNeed_BA ?objNeed_8)  (qtyStore_BA ?qtyStore_8)  (objStore_BA ?objStore_8)

     (vehicle_7 ?type_7 ?capacity_7 ?location_7 ?id7))

=>
    (retract ?f)
    (bind ?id (gensym*))
    (assert
        (find_heuristic_wares_costs) (find_heuristic_travel_costs)

        (status (ident ?id) (subject city) (data ?city_2 ?qtyProd_2 ?objProd_2 ?qtyNeed_2 ?objNeed_2 ?qtyStore_2 ?objStore_2))
        (status (ident ?id) (subject city) (data ?city_7 ?qtyProd_7 ?objProd_7 ?qtyNeed_7 ?objNeed_7 ?qtyStore_7 ?objStore_7))
        ;;(status (ident ?id) (subject city) (data ?city_8 ?qtyProd_8 ?objProd_8 ?qtyNeed_8 ?objNeed_8 ?qtyStore_8 ?objStore_8))

        (status (ident ?id) (subject transport) (data ?type_7 ?capacity_7 ?location_7 ?id7))

        (current ?id))
)


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
    (printout t crlf " ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~ " crlf "Esiste soluzione con costo " ?c crlf)
    (printout t crlf " stati espansi " ?n crlf)
    (printout t " stati generati gia` in closed " ?closed crlf)
    (printout t " stati generati gia` in (open-worse) " ?worse crlf)
    (printout t " stati generati gia` in (open-better) " ?better crlf)
    (halt))
