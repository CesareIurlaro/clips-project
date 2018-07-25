(defrule MAIN::find_heuristic_wares_cost  (declare (salience 200))

    (find_heuristic_wares_costs)
    (current ?curr)
    (status (ident ?curr) (subject city) (data ?city  ?qtyProd  ?objProd  ?qtyNeed  ?objNeed ?qtyStore  ?objStore))

=>

    (bind ?sum (+ ?qtyNeed ?qtyProd ?qtyStore))
    (assert (computed_heuristic_wares_cost (city ?city) (cost ?sum))))


(defrule MAIN::find_heuristic_travel_costs (declare (salience 170))

    (find_heuristic_travel_costs)
    (current ?curr)
    (status (ident ?curr) (subject transport) (data ?type ?capacity ?location ?vehicle_id))
    (status (ident ?curr) (subject city) (data ?location  ?qtyProd&:(> ?qtyProd 0) ?objProd ?qtyNeed ?objNeed ?qtyStore  ?objStore))

    (goal (subject city) (data ?goal_location $?goal_data))
    (status (ident ?curr) (subject city) (data ?goal_location ?qtyProd_goal ?objProd_goal ?qtyNeed_goal&:(> ?qtyNeed_goal 0) ?objNeed_goal ?qtyStore_goal ?objStore_goal))
    (h_distance (from ?location) (h_length ?h_distance) (to ?goal_location))

    (test (eq ?objProd ?objNeed_goal))

=>

    (assert (computed_heuristic_travel_cost (cost ?h_distance))))


;; ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~


(defrule EXPAND::find_heuristic_wares_cost  (declare (salience 200))

    (find_heuristic_wares_costs)
    (current ?curr)
    (status (ident ?curr) (subject city) (data ?city  ?qtyProd  ?objProd  ?qtyNeed  ?objNeed ?qtyStore  ?objStore))

=>

    (bind ?sum (+ ?qtyNeed ?qtyProd ?qtyStore))
    (assert (computed_heuristic_wares_cost (city ?city) (cost ?sum))))



(defrule EXPAND::find_heuristic_travel_costs (declare (salience 170))

    (find_heuristic_travel_costs)
    (current ?curr)
    (status (ident ?curr) (subject transport) (data ?type ?capacity ?location ?vehicle_id))
    (status (ident ?curr) (subject city) (data ?location  ?qtyProd&:(> ?qtyProd 0) ?objProd ?qtyNeed ?objNeed ?qtyStore  ?objStore))

    (goal (subject city) (data ?goal_location $?goal_data))
    (status (ident ?curr) (subject city) (data ?goal_location ?qtyProd_goal ?objProd_goal ?qtyNeed_goal&:(> ?qtyNeed_goal 0) ?objNeed_goal ?qtyStore_goal ?objStore_goal))
    (h_distance (from ?location) (h_length ?h_distance) (to ?goal_location))

    (test (eq ?objProd ?objNeed_goal))

=>

    (assert (computed_heuristic_travel_cost (cost ?h_distance))))
