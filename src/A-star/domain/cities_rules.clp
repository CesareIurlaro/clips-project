(defrule MAIN::start_TO (declare (salience 5))

?f <- (state
     (name_1 ?city_1)   (qtyProd_TO ?qtyProd_1)  (objProd_TO ?objProd_1)  (qtyNeed_TO ?qtyNeed_1)  (objNeed_TO ?objNeed_1)  (qtyStore_TO ?qtyStore_1)  (objStore_TO ?objStore_1)
     (name_6 ?city_6)   (qtyProd_RM ?qtyProd_6)  (objProd_RM ?objProd_6)  (qtyNeed_RM ?qtyNeed_6)  (objNeed_RM ?objNeed_6)  (qtyStore_RM ?qtyStore_6)  (objStore_RM ?objStore_6)
     (name_10 ?city_10) (qtyProd_PA ?qtyProd_10) (objProd_PA ?objProd_10) (qtyNeed_PA ?qtyNeed_10) (objNeed_PA ?objNeed_10) (qtyStore_PA ?qtyStore_10) (objStore_PA ?objStore_10)

     (vehicle_6 ?type_6 ?capacity_6 ?location_6 ?id6))

?f1 <- (TO)

=>
    (retract ?f)
    (bind ?id (gensym*))
    (assert
        (find_heuristic_wares_costs) (find_heuristic_travel_costs)

        (status (ident ?id) (subject city) (data ?city_1  ?qtyProd_1  ?objProd_1  ?qtyNeed_1  ?objNeed_1  ?qtyStore_1  ?objStore_1))
        (status (ident ?id) (subject city) (data ?city_6  ?qtyProd_6  ?objProd_6  ?qtyNeed_6  ?objNeed_6  ?qtyStore_6  ?objStore_6))
        (status (ident ?id) (subject city) (data ?city_10 ?qtyProd_10 ?objProd_10 ?qtyNeed_10 ?objNeed_10 ?qtyStore_10 ?objStore_10))

        (status (ident ?id) (subject transport) (data ?type_6 ?capacity_6 ?location_6 ?id6))

        (current ?id))
)

(defrule MAIN::start_MI_a (declare (salience 5))

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

(defrule MAIN::start_MI_b (declare (salience 5))

?f <- (state
     (name_2 ?city_2)  (qtyProd_MI ?qtyProd_2)  (objProd_MI ?objProd_2)  (qtyNeed_MI ?qtyNeed_2)  (objNeed_MI ?objNeed_2)  (qtyStore_MI ?qtyStore_2)  (objStore_MI ?objStore_2)
     (name_7 ?city_7)  (qtyProd_NA ?qtyProd_7)  (objProd_NA ?objProd_7)  (qtyNeed_NA ?qtyNeed_7)  (objNeed_NA ?objNeed_7)  (qtyStore_NA ?qtyStore_7)  (objStore_NA ?objStore_7)
     (name_8 ?city_8)  (qtyProd_BA ?qtyProd_8)  (objProd_BA ?objProd_8)  (qtyNeed_BA ?qtyNeed_8)  (objNeed_BA ?objNeed_8)  (qtyStore_BA ?qtyStore_8)  (objStore_BA ?objStore_8)

     (vehicle_7 ?type_7 ?capacity_7 ?location_7 ?id7))

?f1 <- (MI_b)

=>
    (retract ?f ?f1)
    (bind ?id (gensym*))
    (assert
        (find_heuristic_wares_costs) (find_heuristic_travel_costs)

        (status (ident ?id) (subject city) (data ?city_2 ?qtyProd_2 ?objProd_2 ?qtyNeed_2 ?objNeed_2 ?qtyStore_2 ?objStore_2))
        (status (ident ?id) (subject city) (data ?city_7 ?qtyProd_7 ?objProd_7 ?qtyNeed_7 ?objNeed_7 ?qtyStore_7 ?objStore_7))
        (status (ident ?id) (subject city) (data ?city_8 ?qtyProd_8 ?objProd_8 ?qtyNeed_8 ?objNeed_8 ?qtyStore_8 ?objStore_8))

        (status (ident ?id) (subject transport) (data ?type_7 ?capacity_7 ?location_7 ?id7))

        (current ?id))
)

(defrule MAIN::start_MI_c (declare (salience 5))

?f <- (state
     (name_7 ?city_7) (qtyProd_NA ?qtyProd_7) (objProd_NA ?objProd_7) (qtyNeed_NA ?qtyNeed_7) (objNeed_NA ?objNeed_7) (qtyStore_NA ?qtyStore_7) (objStore_NA ?objStore_7)
     (name_2 ?city_2) (qtyProd_MI ?qtyProd_2) (objProd_MI ?objProd_2) (qtyNeed_MI ?qtyNeed_2) (objNeed_MI ?objNeed_2) (qtyStore_MI ?qtyStore_2) (objStore_MI ?objStore_2)

     (vehicle_7 ?type_7 ?capacity_7 ?location_7 ?id7))

?f1 <- (MI_c)

=>
    (retract ?f ?f1)
    (bind ?id (gensym*))
    (assert
        (find_heuristic_wares_costs) (find_heuristic_travel_costs)

        (status (ident ?id) (subject city) (data ?city_2 ?qtyProd_2 ?objProd_2 ?qtyNeed_2 ?objNeed_2 ?qtyStore_2 ?objStore_2))
        (status (ident ?id) (subject city) (data ?city_7 ?qtyProd_7 ?objProd_7 ?qtyNeed_7 ?objNeed_7 ?qtyStore_7 ?objStore_7))

        (status (ident ?id) (subject transport) (data ?type_7 ?capacity_7 ?location_7 ?id7))

        (current ?id))
)


(defrule MAIN::start_VE (declare (salience 5))

?f <- (state
     (name_3 ?city_3) (qtyProd_VE ?qtyProd_3) (objProd_VE ?objProd_3) (qtyNeed_VE ?qtyNeed_3) (objNeed_VE ?objNeed_3) (qtyStore_VE ?qtyStore_3) (objStore_VE ?objStore_3)
     (name_5 ?city_5) (qtyProd_BO ?qtyProd_5) (objProd_BO ?objProd_5) (qtyNeed_BO ?qtyNeed_5) (objNeed_BO ?objNeed_5) (qtyStore_BO ?qtyStore_5) (objStore_BO ?objStore_5)

     (vehicle_2 ?type_2 ?capacity_2 ?location_2 ?id2))

?f1 <- (VE)

=>
    (retract ?f ?f1)
    (bind ?id (gensym*))
    (assert
        (find_heuristic_wares_costs) (find_heuristic_travel_costs)

        (status (ident ?id) (subject city) (data ?city_3 ?qtyProd_3 ?objProd_3 ?qtyNeed_3 ?objNeed_3 ?qtyStore_3 ?objStore_3))
        (status (ident ?id) (subject city) (data ?city_5 ?qtyProd_5 ?objProd_5 ?qtyNeed_5 ?objNeed_5 ?qtyStore_5 ?objStore_5))

        (status (ident ?id) (subject transport) (data ?type_2 ?capacity_2 ?location_2 ?id2))

        (current ?id))
)


(defrule start_GE_a (declare (salience 5))

?f <- (state
     (name_1 ?city_1) (qtyProd_TO ?qtyProd_1) (objProd_TO ?objProd_1) (qtyNeed_TO ?qtyNeed_1) (objNeed_TO ?objNeed_1) (qtyStore_TO ?qtyStore_1) (objStore_TO ?objStore_1)
     (name_2 ?city_2) (qtyProd_MI ?qtyProd_2) (objProd_MI ?objProd_2) (qtyNeed_MI ?qtyNeed_2) (objNeed_MI ?objNeed_2) (qtyStore_MI ?qtyStore_2) (objStore_MI ?objStore_2)
     (name_5 ?city_5) (qtyProd_BO ?qtyProd_5) (objProd_BO ?objProd_5) (qtyNeed_BO ?qtyNeed_5) (objNeed_BO ?objNeed_5) (qtyStore_BO ?qtyStore_5) (objStore_BO ?objStore_5)


     (vehicle_1 ?type_1 ?capacity_1 ?location_1 ?id1))

?f1 <- (GE_a)

=>
    (retract ?f ?f1)
    (bind ?id (gensym*))
    (assert
        (find_heuristic_wares_costs) (find_heuristic_travel_costs)

        (status (ident ?id) (subject city) (data ?city_1 ?qtyProd_1 ?objProd_1 ?qtyNeed_1 ?objNeed_1 ?qtyStore_1 ?objStore_1))
        (status (ident ?id) (subject city) (data ?city_2 ?qtyProd_2 ?objProd_2 ?qtyNeed_2 ?objNeed_2 ?qtyStore_2 ?objStore_2))
        (status (ident ?id) (subject city) (data ?city_5 ?qtyProd_5 ?objProd_5 ?qtyNeed_5 ?objNeed_5 ?qtyStore_5 ?objStore_5))

        (status (ident ?id) (subject transport) (data ?type_1 ?capacity_1 ?location_1 ?id1))

        (current ?id))
)

(defrule MAIN::start_GE_b (declare (salience 5))

?f <- (state
     (name_1 ?city_1) (qtyProd_TO ?qtyProd_1) (objProd_TO ?objProd_1) (qtyNeed_TO ?qtyNeed_1) (objNeed_TO ?objNeed_1) (qtyStore_TO ?qtyStore_1) (objStore_TO ?objStore_1)
     (name_4 ?city_4) (qtyProd_GE ?qtyProd_4) (objProd_GE ?objProd_4) (qtyNeed_GE ?qtyNeed_4) (objNeed_GE ?objNeed_4) (qtyStore_GE ?qtyStore_4) (objStore_GE ?objStore_4)

     (vehicle_1 ?type_1 ?capacity_1 ?location_1 ?id1))

?f1 <- (GE_b)

=>
    (retract ?f ?f1)
    (bind ?id (gensym*))
    (assert
        (find_heuristic_wares_costs) (find_heuristic_travel_costs)

        (status (ident ?id) (subject city) (data ?city_1 ?qtyProd_1 ?objProd_1 ?qtyNeed_1 ?objNeed_1 ?qtyStore_1 ?objStore_1))
        (status (ident ?id) (subject city) (data ?city_4 ?qtyProd_4 ?objProd_4 ?qtyNeed_4 ?objNeed_4 ?qtyStore_4 ?objStore_4))

        (status (ident ?id) (subject transport) (data ?type_1 ?capacity_1 ?location_1 ?id1))

        (current ?id))
)

(defrule MAIN::start_BA_a (declare (salience 5))

?f <- (state
      (name_2 ?city_2) (qtyProd_MI ?qtyProd_2) (objProd_MI ?objProd_2) (qtyNeed_MI ?qtyNeed_2) (objNeed_MI ?objNeed_2) (qtyStore_MI ?qtyStore_2) (objStore_MI ?objStore_2)
      (name_5 ?city_5) (qtyProd_BO ?qtyProd_5) (objProd_BO ?objProd_5) (qtyNeed_BO ?qtyNeed_5) (objNeed_BO ?objNeed_5) (qtyStore_BO ?qtyStore_5) (objStore_BO ?objStore_5)
      (name_8 ?city_8) (qtyProd_BA ?qtyProd_8) (objProd_BA ?objProd_8) (qtyNeed_BA ?qtyNeed_8) (objNeed_BA ?objNeed_8) (qtyStore_BA ?qtyStore_8) (objStore_BA ?objStore_8)

      (vehicle_3 ?type_3 ?capacity_3 ?location_3 ?id3))

?f1 <- (BA_a)

=>
    (retract ?f ?f1)
    (bind ?id (gensym*))
    (assert
        (find_heuristic_wares_costs) (find_heuristic_travel_costs)

        (status (ident ?id) (subject city) (data ?city_2 ?qtyProd_2 ?objProd_2 ?qtyNeed_2 ?objNeed_2 ?qtyStore_2 ?objStore_2))
        (status (ident ?id) (subject city) (data ?city_5 ?qtyProd_5 ?objProd_5 ?qtyNeed_5 ?objNeed_5 ?qtyStore_5 ?objStore_5))
        (status (ident ?id) (subject city) (data ?city_8 ?qtyProd_8 ?objProd_8 ?qtyNeed_8 ?objNeed_8 ?qtyStore_8 ?objStore_8))

        (status (ident ?id) (subject transport) (data ?type_3 ?capacity_3 ?location_3 ?id3))

        (current ?id))
)


(defrule MAIN::start_BA_b (declare (salience 5))

?f <- (state
      (name_2 ?city_2) (qtyProd_MI ?qtyProd_2) (objProd_MI ?objProd_2) (qtyNeed_MI ?qtyNeed_2) (objNeed_MI ?objNeed_2) (qtyStore_MI ?qtyStore_2) (objStore_MI ?objStore_2)
      (name_8 ?city_8) (qtyProd_BA ?qtyProd_8) (objProd_BA ?objProd_8) (qtyNeed_BA ?qtyNeed_8) (objNeed_BA ?objNeed_8) (qtyStore_BA ?qtyStore_8) (objStore_BA ?objStore_8)

      (vehicle_7 ?type_7 ?capacity_7 ?location_7 ?id7))

?f1 <- (BA_b)

=>
    (retract ?f ?f1)
    (bind ?id (gensym*))
    (assert
        (find_heuristic_wares_costs) (find_heuristic_travel_costs)

        (status (ident ?id) (subject city) (data ?city_2 ?qtyProd_2 ?objProd_2 ?qtyNeed_2 ?objNeed_2 ?qtyStore_2 ?objStore_2))
        (status (ident ?id) (subject city) (data ?city_8 ?qtyProd_8 ?objProd_8 ?qtyNeed_8 ?objNeed_8 ?qtyStore_8 ?objStore_8))

        (status (ident ?id) (subject transport) (data ?type_7 ?capacity_7 ?location_7 ?id7))

        (current ?id))
)


(defrule MAIN::start_RC (declare (salience 5))

?f <- (state
     (name_7 ?city_7) (qtyProd_NA ?qtyProd_7) (objProd_NA ?objProd_7) (qtyNeed_NA ?qtyNeed_7) (objNeed_NA ?objNeed_7) (qtyStore_NA ?qtyStore_7) (objStore_NA ?objStore_7)
     (name_9 ?city_9) (qtyProd_RC ?qtyProd_9) (objProd_RC ?objProd_9) (qtyNeed_RC ?qtyNeed_9) (objNeed_RC ?objNeed_9) (qtyStore_RC ?qtyStore_9) (objStore_RC ?objStore_9)

     (vehicle_5 ?type_5 ?capacity_5 ?location_5 ?id5))

=>
    (retract ?f)
    (bind ?id (gensym*))
    (assert
        (find_heuristic_wares_costs) (find_heuristic_travel_costs)

        (status (ident ?id) (subject city) (data ?city_7 ?qtyProd_7 ?objProd_7 ?qtyNeed_7 ?objNeed_7 ?qtyStore_7 ?objStore_7))
        (status (ident ?id) (subject city) (data ?city_9 ?qtyProd_9 ?objProd_9 ?qtyNeed_9 ?objNeed_9 ?qtyStore_9 ?objStore_9))

        (status (ident ?id) (subject transport) (data ?type_5 ?capacity_5 ?location_5 ?id5))

        (current ?id))
)


(defrule MAIN::start_NA_PA (declare (salience 5))

?f <- (state
     (name_4 ?city_4) (qtyProd_GE ?qtyProd_4) (objProd_GE ?objProd_4) (qtyNeed_GE ?qtyNeed_4) (objNeed_GE ?objNeed_4) (qtyStore_GE ?qtyStore_4) (objStore_GE ?objStore_4)
     (name_7 ?city_7) (qtyProd_NA ?qtyProd_7) (objProd_NA ?objProd_7) (qtyNeed_NA ?qtyNeed_7) (objNeed_NA ?objNeed_7) (qtyStore_NA ?qtyStore_7) (objStore_NA ?objStore_7)
     (name_10 ?city_10) (qtyProd_PA ?qtyProd_10) (objProd_PA ?objProd_10) (qtyNeed_PA ?qtyNeed_10) (objNeed_PA ?objNeed_10) (qtyStore_PA ?qtyStore_10) (objStore_PA ?objStore_10)

     (vehicle_8 ?type_8 ?capacity_8 ?location_8 ?id8))

=>
    (retract ?f)
    (bind ?id (gensym*))
    (assert
        (find_heuristic_wares_costs) (find_heuristic_travel_costs)

        (status (ident ?id) (subject city) (data ?city_4 ?qtyProd_4 ?objProd_4 ?qtyNeed_4 ?objNeed_4 ?qtyStore_4 ?objStore_4))
        (status (ident ?id) (subject city) (data ?city_7 ?qtyProd_7 ?objProd_7 ?qtyNeed_7 ?objNeed_7 ?qtyStore_7 ?objStore_7))
        (status (ident ?id) (subject city) (data ?city_10 ?qtyProd_10 ?objProd_10 ?qtyNeed_10 ?objNeed_10 ?qtyStore_10 ?objStore_10))

        (status (ident ?id) (subject transport) (data ?type_8 ?capacity_8 ?location_8 ?id8))

        (current ?id))
)


(defrule MAIN::start_RM_a (declare (salience 5))

?f <- (state
      (name_1 ?city_1)   (qtyProd_TO ?qtyProd_1)  (objProd_TO ?objProd_1)  (qtyNeed_TO ?qtyNeed_1)  (objNeed_TO ?objNeed_1)  (qtyStore_TO ?qtyStore_1)  (objStore_TO ?objStore_1)
      (name_2 ?city_2) (qtyProd_MI ?qtyProd_2) (objProd_MI ?objProd_2) (qtyNeed_MI ?qtyNeed_2) (objNeed_MI ?objNeed_2) (qtyStore_MI ?qtyStore_2) (objStore_MI ?objStore_2)


      (vehicle_3 ?type_3 ?capacity_3 ?location_3 ?id3))

=>
    (retract ?f)
    (bind ?id (gensym*))
    (assert
        (find_heuristic_wares_costs) (find_heuristic_travel_costs)

        (status (ident ?id) (subject city) (data ?city_1 ?qtyProd_1 ?objProd_1 ?qtyNeed_1 ?objNeed_1 ?qtyStore_1 ?objStore_1))
        (status (ident ?id) (subject city) (data ?city_2 ?qtyProd_2 ?objProd_2 ?qtyNeed_2 ?objNeed_2 ?qtyStore_2 ?objStore_2))

        (status (ident ?id) (subject transport) (data ?type_3 ?capacity_3 ?location_3 ?id3))

        (current ?id))
)

(defrule MAIN::start_RM_b (declare (salience 5))

?f <- (state
      (name_1 ?city_1)   (qtyProd_TO ?qtyProd_1)  (objProd_TO ?objProd_1)  (qtyNeed_TO ?qtyNeed_1)  (objNeed_TO ?objNeed_1)  (qtyStore_TO ?qtyStore_1)  (objStore_TO ?objStore_1)
      (name_6 ?city_6)   (qtyProd_RM ?qtyProd_6)  (objProd_RM ?objProd_6)  (qtyNeed_RM ?qtyNeed_6)  (objNeed_RM ?objNeed_6)  (qtyStore_RM ?qtyStore_6)  (objStore_RM ?objStore_6)

      (vehicle_6 ?type_6 ?capacity_6 ?location_6 ?id6))

?f1 <- (RM)

=>
    (retract ?f ?f1)
    (bind ?id (gensym*))
    (assert
        (find_heuristic_wares_costs) (find_heuristic_travel_costs)

        (status (ident ?id) (subject city) (data ?city_1 ?qtyProd_1 ?objProd_1 ?qtyNeed_1 ?objNeed_1 ?qtyStore_1 ?objStore_1))
        (status (ident ?id) (subject city) (data ?city_6 ?qtyProd_6 ?objProd_6 ?qtyNeed_6 ?objNeed_6 ?qtyStore_6 ?objStore_6))

        (status (ident ?id) (subject transport) (data ?type_6 ?capacity_6 ?location_6 ?id6))

        (current ?id))
)

(defrule MAIN::start_BO (declare (salience 5))

?f <- (state
        (name_3 ?city_3) (qtyProd_VE ?qtyProd_3) (objProd_VE ?objProd_3) (qtyNeed_VE ?qtyNeed_3) (objNeed_VE ?objNeed_3) (qtyStore_VE ?qtyStore_3) (objStore_VE ?objStore_3)
        (name_5 ?city_5) (qtyProd_BO ?qtyProd_5) (objProd_BO ?objProd_5) (qtyNeed_BO ?qtyNeed_5) (objNeed_BO ?objNeed_5) (qtyStore_BO ?qtyStore_5) (objStore_BO ?objStore_5)

        (vehicle_2 ?type_2 ?capacity_2 ?location_2 ?id2))


=>
    (retract ?f)
    (bind ?id (gensym*))
    (assert
        (find_heuristic_wares_costs) (find_heuristic_travel_costs)

        (status (ident ?id) (subject city) (data ?city_3 ?qtyProd_3 ?objProd_3 ?qtyNeed_3 ?objNeed_3 ?qtyStore_3 ?objStore_3))
        (status (ident ?id) (subject city) (data ?city_5 ?qtyProd_5 ?objProd_5 ?qtyNeed_5 ?objNeed_5 ?qtyStore_5 ?objStore_5))

        (status (ident ?id) (subject transport) (data ?type_2 ?capacity_2 ?location_2 ?id2))

        (current ?id))
)
