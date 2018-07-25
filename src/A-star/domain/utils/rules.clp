(defrule MAIN::find_heuristic_wares_cost  (declare (salience 200))

    ?h <- (find_heuristic_wares_cost)
    (current ?curr)
    (status (ident ?curr) (subject city) (data ?city_1  ?qtyProd_1  ?objProd_1  ?qtyNeed_1  ?objNeed_1 ?qtyStore_1  ?objStore_1))
    (status (ident ?curr) (subject city) (data ?city_2  ?qtyProd_2  ?objProd_2  ?qtyNeed_2  ?objNeed_2 ?qtyStore_2  ?objStore_2))
    (status (ident ?curr) (subject city) (data ?city_3  ?qtyProd_3  ?objProd_3  ?qtyNeed_3  ?objNeed_3 ?qtyStore_3  ?objStore_3))


    (test (neq ?city_1 ?city_2))
    (test (neq ?city_1 ?city_3))
    ;; (test (neq ?city_1 ?city_8))

    (test (neq ?city_2 ?city_3))
    ;;(test (neq ?city_2 ?city_8))


    ;;(test (neq ?city_3 ?city_8))

=>

    (retract ?h)

    ;;(bind ?quantityNeed (+ ?qtyNeed_1 ?qtyNeed_2 ?qtyNeed_3 ?qtyNeed_8))
    ;;(bind ?quantityProd (+ ?qtyProd_1 ?qtyProd_2 ?qtyProd_3 ?qtyProd_8))

    (bind ?quantityNeed (+ ?qtyNeed_1 ?qtyNeed_2 ?qtyNeed_3))
    (bind ?quantityProd (+ ?qtyProd_1 ?qtyProd_2 ?qtyProd_3))
    (bind ?tot (+ ?quantityNeed ?quantityProd))

    (assert (computed_heuristic_wares_cost ?tot))
    (assert (find_heuristic_travel_costs)))


(defrule MAIN::find_heuristic_travel_costs (declare (salience 170))

    (find_heuristic_travel_costs)
    (current ?curr)
    (status (ident ?curr) (subject transport) (data ?type ?capacity ?location ?vehicle_id))
    (status (ident ?curr) (subject city) (data ?location  ?qtyProd&:(> ?qtyProd 0) ?objProd ?qtyNeed ?objNeed ?qtyStore  ?objStore))

    (goal (subject city) (data ?goal_location $?goal_data))
    (status (ident ?curr) (subject city) (data ?goal_location ?qtyProd_goal ?objProd_goal ?qtyNeed_goal&:(> ?qtyNeed_goal 0) ?objNeed_goal ?qtyStore_goal ?objStore_goal))
    (h_distance (from ?location) (h_length ?h_distance) (to ?goal_location))

    (test (eq ?objProd ?objNeed_goal)) ;; si può fare con Store facendo un'altra regola con un test diverso

=>

    (assert (computed_heuristic_travel_cost (cost ?h_distance))))




;; ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~



(defrule EXPAND::find_heuristic_wares_cost  (declare (salience 200))

    ?h <- (find_heuristic_wares_cost)
    (current ?curr)
    (status (ident ?curr) (subject city) (data ?city_1  ?qtyProd_1  ?objProd_1  ?qtyNeed_1  ?objNeed_1 ?qtyStore_1  ?objStore_1))
    (status (ident ?curr) (subject city) (data ?city_2  ?qtyProd_2  ?objProd_2  ?qtyNeed_2  ?objNeed_2 ?qtyStore_2  ?objStore_2))
    (status (ident ?curr) (subject city) (data ?city_3  ?qtyProd_3  ?objProd_3  ?qtyNeed_3  ?objNeed_3 ?qtyStore_3  ?objStore_3))

    (test (neq ?city_1 ?city_2))
    (test (neq ?city_1 ?city_3))
    ;; (test (neq ?city_1 ?city_8))

    (test (neq ?city_2 ?city_3))
    ;;(test (neq ?city_2 ?city_8))

    ;;(test (neq ?city_3 ?city_8))

=>

    (retract ?h)

    ;(bind ?quantityNeed (+ ?qtyNeed_1 ?qtyNeed_2 ?qtyNeed_3 ?qtyNeed_8))
    ;(bind ?quantityProd (+ ?qtyProd_1 ?qtyProd_2 ?qtyProd_3 ?qtyProd_8))

    (bind ?quantityNeed (+ ?qtyNeed_1 ?qtyNeed_2 ?qtyNeed_3))
    (bind ?quantityProd (+ ?qtyProd_1 ?qtyProd_2 ?qtyProd_3))
    (bind ?tot (+ ?quantityNeed ?quantityProd))

    (assert (computed_heuristic_wares_cost ?tot))
    (assert (find_heuristic_travel_costs)))



(defrule EXPAND::find_heuristic_travel_costs(declare (salience 170))

    (find_heuristic_travel_costs)
    (current ?curr)
    (status (ident ?curr) (subject transport) (data ?type ?capacity ?location ?vehicle_id))
    (status (ident ?curr) (subject city) (data ?location  ?qtyProd&:(> ?qtyProd 0) ?objProd ?qtyNeed ?objNeed ?qtyStore  ?objStore))

    (goal (subject city) (data ?goal_location $?goal_data))
    (status (ident ?curr) (subject city) (data ?goal_location ?qtyProd_goal ?objProd_goal ?qtyNeed_goal&:(> ?qtyNeed_goal 0) ?objNeed_goal ?qtyStore_goal ?objStore_goal))
    (h_distance (from ?location) (h_length ?h_distance) (to ?goal_location))

    (test (eq ?objProd ?objNeed_goal)) ;; si può fare con Store facendo un'altra regola con un test diverso

=>

    (assert (computed_heuristic_travel_cost (cost ?h_distance))))
