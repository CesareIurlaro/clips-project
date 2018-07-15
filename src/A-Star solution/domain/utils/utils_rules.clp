(defrule MAIN::find_cities_needs (declare (salience 20))
    ?f <- (state
        (A_TO ?A_TO) (B_TO ?B_TO) (C_TO ?C_TO)
        (A_MI ?A_MI) (B_MI ?B_MI) (C_MI ?C_MI)
        (A_VE ?A_VE) (B_VE ?B_VE) (C_VE ?C_VE)
        (A_GE ?A_GE) (B_GE ?B_GE) (C_GE ?C_GE)
        (A_BO ?A_BO) (B_BO ?B_BO) (C_BO ?C_BO)
        (A_RM ?A_RM) (B_RM ?B_RM) (C_RM ?C_RM)
        (A_NA ?A_NA) (B_NA ?B_NA) (C_NA ?C_NA)
        (A_BA ?A_BA) (B_BA ?B_BA) (C_BA ?C_BA)
        (A_RC ?A_RC) (B_RC ?B_RC) (C_RC ?C_RC)
        (A_PA ?A_PA) (B_PA ?B_PA) (C_PA ?C_PA)

        (transport_1 ?type_1, ?capacity_1, ?location_1)
        (transport_2 ?type_2, ?capacity_2, ?location_2)
        (transport_3 ?type_3, ?capacity_3, ?location_3)
        (transport_4 ?type_4, ?capacity_4, ?location_4)
        (transport_5 ?type_5, ?capacity_5, ?location_5)
        (transport_6 ?type_6, ?capacity_6, ?location_6)
        (transport_7 ?type_7, ?capacity_7, ?location_7)
        (transport_8 ?type_8, ?capacity_8, ?location_8))

=>

    (foreach ?city (create$ TO MI VE GE BO RM NA BA RC PA)
        (foreach ?obj (create$ A B C)
            (bind ?quantity (fact-slot-value ?f (sym-cat ?obj _ ?city)))
            (if (> ?quantity 0)
            then (assert (exports ?city ?quantity ?obj)))
            (if (< ?quantity 0)
            then (assert (imports ?city ?quantity ?obj))))))



(defrule MAIN::find_min_path_needed (declare (salience 15))

    ?f1 <- (exports ?from1 ?quantity_a ?obj)
    ?f2 <- (imports ?to ?quantity_b ?obj)
    ?f3 <- (distance ?from1 ?length1 ?to ?type1)
    (not (and
        (exports ?from2 ? ?obj)
        (imports ?to ? ?obj)
        (distance ?from2 ?length2&:(< ?length2 ?length1) ?to ?type2)))
=>
 ;; la minima distanza tra una città che deve importare e più città che esportano lo stesso oggetto è length1, la quantità dell'oggetto cambia a seconda di chi ne ha di più
    (if (> ?quantity_a ?quantity_b)
    then (assert (min_distance_export_to
            (to ?to) (quantity ?quantity_b) (obj ?obj) (length ?length1) (type ?type1))))
    (if (< ?quantity_a ?quantity_b)
    then (assert (min_distance_export_to
            (to ?to) (quantity ?quantity_a) (obj ?obj) (length ?length1) (type ?type1))))

    (retract ?f1) (retract ?f2) (retract ?f3))



;;(defrule MAIN::find_overall_paths_costs (declare (salience 10))
;; somma dei costi di tutte le distanze minime di export
;;=>
;;    (bind ?sum 0)
;;    (do-for-all-facts ((?f min_distance_export_to)) TRUE
;;        (bind ?sum (+ ?sum (travel_cost_evaluation ?f:type ?f:length))))

    ;;(assert (overall_paths_costs_export_to (to ?to) (obj ?f:obj) (sum ?sum)))
;;)
