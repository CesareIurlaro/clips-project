(deftemplate MAIN::computed_heuristic_travel_cost (slot cost))

(deftemplate MAIN::computed_heuristic_wares_cost  (slot city) (slot cost))

(deftemplate MAIN::state
    (slot name_1)  (slot qtyProd_TO) (slot objProd_TO) (slot qtyNeed_TO) (slot objNeed_TO) (slot qtyStore_TO) (slot objStore_TO)
    (slot name_2)  (slot qtyProd_MI) (slot objProd_MI) (slot qtyNeed_MI) (slot objNeed_MI) (slot qtyStore_MI) (slot objStore_MI)
    (slot name_3)  (slot qtyProd_VE) (slot objProd_VE) (slot qtyNeed_VE) (slot objNeed_VE) (slot qtyStore_VE) (slot objStore_VE)
    (slot name_4)  (slot qtyProd_GE) (slot objProd_GE) (slot qtyNeed_GE) (slot objNeed_GE) (slot qtyStore_GE) (slot objStore_GE)
    (slot name_5)  (slot qtyProd_BO) (slot objProd_BO) (slot qtyNeed_BO) (slot objNeed_BO) (slot qtyStore_BO) (slot objStore_BO)
    (slot name_6)  (slot qtyProd_RM) (slot objProd_RM) (slot qtyNeed_RM) (slot objNeed_RM) (slot qtyStore_RM) (slot objStore_RM)
    (slot name_7)  (slot qtyProd_NA) (slot objProd_NA) (slot qtyNeed_NA) (slot objNeed_NA) (slot qtyStore_NA) (slot objStore_NA)
    (slot name_8)  (slot qtyProd_BA) (slot objProd_BA) (slot qtyNeed_BA) (slot objNeed_BA) (slot qtyStore_BA) (slot objStore_BA)
    (slot name_9)  (slot qtyProd_RC) (slot objProd_RC) (slot qtyNeed_RC) (slot objNeed_RC) (slot qtyStore_RC) (slot objStore_RC)
    (slot name_10) (slot qtyProd_PA) (slot objProd_PA) (slot qtyNeed_PA) (slot objNeed_PA) (slot qtyStore_PA) (slot objStore_PA)
    (slot name_11) (slot qtyProd_FI) (slot objProd_FI) (slot qtyNeed_FI) (slot objNeed_FI) (slot qtyStore_FI) (slot objStore_FI)

    (multislot vehicle_1)
    (multislot vehicle_2)
    (multislot vehicle_3)
    (multislot vehicle_4)
    (multislot vehicle_5)
    (multislot vehicle_6)
    (multislot vehicle_7)
    (multislot vehicle_8)
    (multislot vehicle_9))

(deftemplate MAIN::status (slot ident)
    (slot subject) (multislot data))


(deftemplate MAIN::goal
    (slot subject) (multislot data))


(deftemplate MAIN::node (slot ident)
    (slot gcost) (slot fcost)  (slot father) (slot open))


(deftemplate MAIN::newnode (slot ident)
    (slot gcost) (slot fcost) (slot father))


(deftemplate MAIN::prev_next (slot ident))


(deftemplate MAIN::dummy_string (slot ident)
    (multislot string))


(deftemplate MAIN::h_distance
    (slot from)
    (slot h_length)
    (slot to)
)

(deftemplate MAIN::file_total_cost
    (slot f_total_cost))


(deftemplate min_distance_export_to
    (slot to) (slot quantity) (slot obj) (slot length) (slot type))


(deftemplate overall_paths_costs_export_to
    (slot to) (slot obj) (slot cost))
