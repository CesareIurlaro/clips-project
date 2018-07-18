(defmodule MAIN (export ?ALL))

(defrule start
    ?f <- (state
            (name_1 ?city_1)   (qtyProd_TO ?qtyProd_1)  (objProd_TO ?objProd_1)  (qtyNeed_TO ?qtyNeed_1)  (objNeed_TO ?objNeed_1)
            (name_4 ?city_4)   (qtyProd_GE ?qtyProd_4)  (objProd_GE ?objProd_4)  (qtyNeed_GE ?qtyNeed_4)  (objNeed_GE ?objNeed_4)

            (vehicle_8 ?type_8 ?capacity_8 ?location_8))

    ;;?f <- (state
    ;;        (name_1 ?city_1)   (qtyProd_TO ?qtyProd_1)  (objProd_TO ?objProd_1)  (qtyNeed_TO ?qtyNeed_1)  (objNeed_TO ?objNeed_1)
    ;;        (name_2 ?city_2)   (qtyProd_MI ?qtyProd_2)  (objProd_MI ?objProd_2)  (qtyNeed_MI ?qtyNeed_2)  (objNeed_MI ?objNeed_2)
    ;;        (name_3 ?city_3)   (qtyProd_VE ?qtyProd_3)  (objProd_VE ?objProd_3)  (qtyNeed_VE ?qtyNeed_3)  (objNeed_VE ?objNeed_3)
    ;;        (name_4 ?city_4)   (qtyProd_GE ?qtyProd_4)  (objProd_GE ?objProd_4)  (qtyNeed_GE ?qtyNeed_4)  (objNeed_GE ?objNeed_4)
    ;;        (name_5 ?city_5)   (qtyProd_BO ?qtyProd_5)  (objProd_BO ?objProd_5)  (qtyNeed_BO ?qtyNeed_5)  (objNeed_BO ?objNeed_5)
    ;;        (name_6 ?city_6)   (qtyProd_RM ?qtyProd_6)  (objProd_RM ?objProd_6)  (qtyNeed_RM ?qtyNeed_6)  (objNeed_RM ?objNeed_6)
    ;;        (name_7 ?city_7)   (qtyProd_NA ?qtyProd_7)  (objProd_NA ?objProd_7)  (qtyNeed_NA ?qtyNeed_7)  (objNeed_NA ?objNeed_7)
    ;;        (name_8 ?city_8)   (qtyProd_BA ?qtyProd_8)  (objProd_BA ?objProd_8)  (qtyNeed_BA ?qtyNeed_8)  (objNeed_BA ?objNeed_8)
    ;;        (name_9 ?city_9)   (qtyProd_RC ?qtyProd_9)  (objProd_RC ?objProd_9)  (qtyNeed_RC ?qtyNeed_9)  (objNeed_RC ?objNeed_9)
    ;;        (name_10 ?city_10) (qtyProd_PA ?qtyProd_10) (objProd_PA ?objProd_10) (qtyNeed_PA ?qtyNeed_10) (objNeed_PA ?objNeed_10)

    ;;        (vehicle_1 ?type_1 ?capacity_1 ?location_1)
    ;;        (vehicle_2 ?type_2 ?capacity_2 ?location_2)
    ;;        (vehicle_3 ?type_3 ?capacity_3 ?location_3)
    ;;        (vehicle_4 ?type_4 ?capacity_4 ?location_4)
    ;;        (vehicle_5 ?type_5 ?capacity_5 ?location_5)

    ;;        (vehicle_6 ?type_6 ?capacity_6 ?location_6)
    ;;        (vehicle_7 ?type_7 ?capacity_7 ?location_7)

    ;;        (vehicle_8 ?type_8 ?capacity_8 ?location_8)
    ;;        (vehicle_9 ?type_9 ?capacity_9 ?location_9))

=>

     (bind ?fcost (find_overall_costs))

     ;; (bind ?wares_cost  (* -10 (fact-slot-value ?f (sym-cat ?obj _ ?name))))
     ;; (bind ?travel_cost (travel_cost_evaluation ?type ?length))
     ;; (bind ?fcost (+ ?wares_cost ?travel_cost))

     (bind ?id (gensym*))
     (assert
        (node (ident ?id)
            (gcost 0) (fcost ?fcost)
            (father NA) (open yes))

        (status (ident ?id) (subject city) (data ?city_1  ?qtyProd_1  ?objProd_1  ?qtyNeed_1  ?objNeed_1))
        (status (ident ?id) (subject city) (data ?city_4  ?qtyProd_4  ?objProd_4  ?qtyNeed_4  ?objNeed_4))
        (status (ident ?id) (subject transport) (data ?type_8 ?capacity_8 ?location_8 8))

        ;;(status ?id city ?city_1  ?qtyProd_1  ?objProd_1  ?qtyNeed_1  ?objNeed_1)
        ;;(status ?id city ?city_2  ?qtyProd_2  ?objProd_2  ?qtyNeed_2  ?objNeed_2)
        ;;(status ?id city ?city_3  ?qtyProd_3  ?objProd_3  ?qtyNeed_3  ?objNeed_3)
        ;;(status ?id city ?city_4  ?qtyProd_4  ?objProd_4  ?qtyNeed_4  ?objNeed_4)
        ;;(status ?id city ?city_5  ?qtyProd_5  ?objProd_5  ?qtyNeed_5  ?objNeed_5)
        ;;(status ?id city ?city_6  ?qtyProd_6  ?objProd_6  ?qtyNeed_6  ?objNeed_6)
        ;;(status ?id city ?city_7  ?qtyProd_7  ?objProd_7  ?qtyNeed_7  ?objNeed_7)
        ;;(status ?id city ?city_8  ?qtyProd_8  ?objProd_8  ?qtyNeed_8  ?objNeed_8)
        ;;(status ?id city ?city_9  ?qtyProd_9  ?objProd_9  ?qtyNeed_9  ?objNeed_9)
        ;;(status ?id city ?city_10 ?qtyProd_10 ?objProd_10 ?qtyNeed_10 ?objNeed_10)

        ;;(status ?id transport ?type_1 ?capacity_1 ?location_1 1)
        ;;(status ?id transport ?type_2 ?capacity_2 ?location_2 2)
        ;;(status ?id transport ?type_3 ?capacity_3 ?location_3 3)
        ;;(status ?id transport ?type_4 ?capacity_4 ?location_4 4)
        ;;(status ?id transport ?type_5 ?capacity_5 ?location_5 5)
        ;;(status ?id transport ?type_6 ?capacity_6 ?location_6 6)
        ;;(status ?id transport ?type_7 ?capacity_7 ?location_7 7)
        ;;(status ?id transport ?type_8 ?capacity_8 ?location_8 8)
        ;;(status ?id transport ?type_9 ?capacity_9 ?location_9 9)

        (current ?id))
    (focus EXPAND))



(defrule stampaSol (declare (salience 101))
    ?f <- (stampa ?id)
    (node (ident ?id) (father ?anc&~NA))
    (exec ?anc $?e)
=>
    (printout t " Eseguo azione " $?e crlf)
    (assert (stampa ?anc))
    (retract ?f))



(defrule stampa-fine (declare (salience 102))
    (stampa ?id)
    (node (ident ?id) (father ?anc&NA))
    (open-worse ?worse)
    (open-better ?better)
    (alreadyclosed ?closed)
    (numberofnodes ?n)
=>
    (printout t " stati espansi " ?n crlf)
    (printout t " stati generati gia` in closed " ?closed crlf)
    (printout t " stati generati gia` in open (open-worse) " ?worse crlf)
    (printout t " stati generati gia` in open (open-better) " ?better crlf)
    (halt))
