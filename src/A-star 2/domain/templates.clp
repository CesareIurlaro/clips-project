(deftemplate MAIN::state
    (slot name_1)  (slot qtyProd_TO) (slot objProd_TO) (slot qtyNeed_TO) (slot objNeed_TO)

    (slot name_4)  (slot qtyProd_GE) (slot objProd_GE) (slot qtyNeed_GE) (slot objNeed_GE)

    (multislot vehicle_8))


    ;;(deftemplate MAIN::state
    ;;    (slot name_1)  (slot qtyProd_TO) (slot objProd_TO) (slot qtyNeed_TO) (slot objNeed_TO)
    ;;    (slot name_2)  (slot qtyProd_MI) (slot objProd_MI) (slot qtyNeed_MI) (slot objNeed_MI)
    ;;    (slot name_3)  (slot qtyProd_VE) (slot objProd_VE) (slot qtyNeed_VE) (slot objNeed_VE)
    ;;    (slot name_4)  (slot qtyProd_GE) (slot objProd_GE) (slot qtyNeed_GE) (slot objNeed_GE)
    ;;    (slot name_5)  (slot qtyProd_BO) (slot objProd_BO) (slot qtyNeed_BO) (slot objNeed_BO)
    ;;    (slot name_6)  (slot qtyProd_RM) (slot objProd_RM) (slot qtyNeed_RM) (slot objNeed_RM)
    ;;    (slot name_7)  (slot qtyProd_NA) (slot objProd_NA) (slot qtyNeed_NA) (slot objNeed_NA)
    ;;    (slot name_8)  (slot qtyProd_BA) (slot objProd_BA) (slot qtyNeed_BA) (slot objNeed_BA)
    ;;    (slot name_9)  (slot qtyProd_RC) (slot objProd_RC) (slot qtyNeed_RC) (slot objNeed_RC)
    ;;    (slot name_10) (slot qtyProd_PA) (slot objProd_PA) (slot qtyNeed_PA) (slot objNeed_PA)
    ;;
    ;;    (multislot vehicle_1)
    ;;    (multislot vehicle_2)
    ;;    (multislot vehicle_3)
    ;;    (multislot vehicle_4)
    ;;    (multislot vehicle_5)
    ;;    (multislot vehicle_6)
    ;;    (multislot vehicle_7)
    ;;    (multislot vehicle_8)
    ;;    (multislot vehicle_9))

(deftemplate MAIN::status (slot ident)
    (slot subject) (multislot data))

(deftemplate MAIN::node (slot ident)
    (slot gcost) (slot fcost)  (slot father) (slot open))


(deftemplate MAIN::newnode (slot ident)
    (slot gcost) (slot fcost) (slot father))


(deftemplate MAIN::h_distance
    (slot from)
    (slot h_length)
    (slot to)
)


(deftemplate min_distance_export_to
    (slot to) (slot quantity) (slot obj) (slot length) (slot type))


(deftemplate overall_paths_costs_export_to
    (slot to) (slot obj) (slot cost))
