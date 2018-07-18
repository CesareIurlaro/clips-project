(defrule MAIN::find_cities_needs (declare (salience 20))

    ?f <- (state
            (name_1 ?city_1)   (qtyProd_TO ?qtyProd_1)  (objProd_TO ?objProd_1)  (qtyNeed_TO ?qtyNeed_1)  (objNeed_TO ?objNeed_1)
            (name_4 ?city_4)   (qtyProd_GE ?qtyProd_4)  (objProd_GE ?objProd_4)  (qtyNeed_GE ?qtyNeed_4)  (objNeed_GE ?objNeed_4)
            (vehicle_8 ?type_8 ?capacity_8 ?location_8))

    ;;?f<- (state
    ;;        (name_1 ?TO)  (qtyProd_TO ?qtyProd_TO) (objProd_TO ?objProd_TO) (qtyNeed_TO ?qtyNeed_TO) (objNeed_TO ?objNeed_TO)
    ;;        (name_2 ?MI)  (qtyProd_MI ?qtyProd_MI) (objProd_MI ?objProd_MI) (qtyNeed_MI ?qtyNeed_MI) (objNeed_MI ?objNeed_MI)
    ;;        (name_3 ?VE)  (qtyProd_VE ?qtyProd_VE) (objProd_VE ?objProd_VE) (qtyNeed_VE ?qtyNeed_VE) (objNeed_VE ?objNeed_VE)
    ;;        (name_4 ?GE)  (qtyProd_GE ?qtyProd_GE) (objProd_GE ?objProd_GE) (qtyNeed_GE ?qtyNeed_GE) (objNeed_GE ?objNeed_GE)
    ;;        (name_5 ?BO)  (qtyProd_BO ?qtyProd_BO) (objProd_BO ?objProd_BO) (qtyNeed_BO ?qtyNeed_BO) (objNeed_BO ?objNeed_BO)
    ;;        (name_6 ?RM)  (qtyProd_RM ?qtyProd_RM) (objProd_RM ?objProd_RM) (qtyNeed_RM ?qtyNeed_RM) (objNeed_RM ?objNeed_RM)
    ;;        (name_7 ?NA)  (qtyProd_NA ?qtyProd_NA) (objProd_NA ?objProd_NA) (qtyNeed_NA ?qtyNeed_NA) (objNeed_NA ?objNeed_NA)
    ;;        (name_8 ?BA)  (qtyProd_BA ?qtyProd_BA) (objProd_BA ?objProd_BA) (qtyNeed_BA ?qtyNeed_BA) (objNeed_BA ?objNeed_BA)
    ;;        (name_9 ?RC)  (qtyProd_RC ?qtyProd_RC) (objProd_RC ?objProd_RC) (qtyNeed_RC ?qtyNeed_RC) (objNeed_RC ?objNeed_RC)
    ;;        (name_10 ?PA) (qtyProd_PA ?qtyProd_PA) (objProd_PA ?objProd_PA) (qtyNeed_PA ?qtyNeed_PA) (objNeed_PA ?objNeed_PA)

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

    (foreach ?city (create$ TO GE)
        (bind ?quantityProduction (fact-slot-value ?f (sym-cat qtyProd _ ?city)))
        (bind ?objProduction (fact-slot-value ?f (sym-cat objProd _ ?city)))

        (bind ?quantityNeeded (fact-slot-value ?f (sym-cat qtyNeed _ ?city)))
        (bind ?objNeeded (fact-slot-value ?f (sym-cat objNeed _ ?city)))

        (if (> ?quantityProduction 0)
        then (assert (exports ?city ?quantityProduction ?objProduction)))
        (if (> ?quantityNeeded 0)
        then (assert (imports ?city ?quantityNeeded ?objNeeded)))))

    ;;(foreach ?city (create$ TO MI VE GE BO RM NA BA RC PA)
    ;;    (bind ?quantityProduction (fact-slot-value ?f (sym-cat qtyProd _ ?city)))
    ;;    (bind ?objProduction (fact-slot-value ?f (sym-cat objProd _ ?city)))

    ;;    (bind ?quantityNeeded (fact-slot-value ?f (sym-cat qtyNeed _ ?city)))
    ;;    (bind ?objNeeded (fact-slot-value ?f (sym-cat objNeed _ ?city)))

    ;;    (if (> ?quantityProduction 0)
    ;;    then (assert (exports ?city ?quantityProduction ?objProduction)))
    ;;    (if (> ?quantityNeeded 0)
    ;;    then (assert (imports ?city ?quantityNeeded ?objNeeded)))))



(defrule MAIN::find_min_path_needed (declare (salience 15))

    ?f1 <- (exports ?from1 ?quantity_a ?obj)
    ?f2 <- (imports ?to ?quantity_b ?obj)
    (distance ?from1 ?length1 ?to ?type1)
    (not (and
        (exports ?from2 ? ?obj)
        (imports ?to ? ?obj)
        (distance ?from2 ?length2&:(< ?length2 ?length1) ?to ?type2)))

=>

 ;; la minima distanza tra una città che deve importare e più città che esportano lo stesso oggetto è length1, la quantità dell'oggetto cambia a seconda di chi ne ha di più
    (if (>= ?quantity_a ?quantity_b)
    then (assert (min_distance_export_to
            (to ?to) (quantity ?quantity_b) (obj ?obj) (length ?length1) (type ?type1))))
    (if (< ?quantity_a ?quantity_b)
    then (assert (min_distance_export_to
            (to ?to) (quantity ?quantity_a) (obj ?obj) (length ?length1) (type ?type1))))

    (retract ?f1 ?f2))
