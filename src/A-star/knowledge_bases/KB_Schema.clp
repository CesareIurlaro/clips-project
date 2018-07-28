(deffacts MAIN::state
    (state
        (name_1 TO)  (qtyProd_TO 10) (objProd_TO B) (qtyNeed_TO 20) (objNeed_TO A) (qtyStore_TO 0) (objStore_TO C)
        (name_2 MI)  (qtyProd_MI 5 ) (objProd_MI C) (qtyNeed_MI 30) (objNeed_MI A) (qtyStore_MI 0) (objStore_MI B)
        (name_3 VE)  (qtyProd_VE 10) (objProd_VE C) (qtyNeed_VE 5 ) (objNeed_VE B) (qtyStore_VE 0) (objStore_VE A)
        (name_4 GE)  (qtyProd_GE 10) (objProd_GE C) (qtyNeed_GE 5 ) (objNeed_GE B) (qtyStore_GE 0) (objStore_GE A)
        (name_5 BO)  (qtyProd_BO 10) (objProd_BO B) (qtyNeed_BO 10) (objNeed_BO C) (qtyStore_BO 0) (objStore_BO A)
        (name_6 RM)  (qtyProd_RM 10) (objProd_RM A) (qtyNeed_RM 5 ) (objNeed_RM C) (qtyStore_RM 0) (objStore_RM B)
        (name_7 NA)  (qtyProd_NA 5 ) (objProd_NA B) (qtyNeed_NA 5 ) (objNeed_NA C) (qtyStore_NA 0) (objStore_NA A)
        (name_8 BA)  (qtyProd_BA 10) (objProd_BA A) (qtyNeed_BA 5 ) (objNeed_BA B) (qtyStore_BA 0) (objStore_BA C)
        (name_9 RC)  (qtyProd_RC 20) (objProd_RC A) (qtyNeed_RC 10) (objNeed_RC B) (qtyStore_RC 0) (objStore_RC C)
        (name_10 PA) (qtyProd_PA 10) (objProd_PA A) (qtyNeed_PA 5 ) (objNeed_PA C) (qtyStore_PA 0) (objStore_PA B)

        (name_11 FI) (qtyProd_FI 0 ) (objProd_FI B) (qtyNeed_FI 0 ) (objNeed_FI C) (qtyStore_FI 0) (objStore_FI A)

        ;; (vehicle_1 van 4 BO)
        ;; (vehicle_2 van 4 BO)
        ;; (vehicle_3 van 4 BO)
        ;; (vehicle_4 van 4 RM)
        ;; (vehicle_5 van 4 RM)

        (vehicle_6 plane 7 PA 6))
        ;; (vehicle_7 plane 7 MI)

        ;; (vehicle_8 ship 11 GE)
        ;; (vehicle_9 ship 11 VE))

        (open-worse 0)
        (open-better 0)
        (alreadyclosed 0)
        (numberofnodes 0))




(deffacts MAIN::goal
    (goal (subject city) (data TO 10 B 0 A 0 C))
    ;; (goal (subject city) (data MI 0 C 0 A 0 B))
    ;; (goal (subject city) (data VE 0 C 0 B 0 A))
    ;; (goal (subject city) (data GE 0 C 0 B 0 A))
    ;; (goal (subject city) (data BO 0 B 0 C 0 A))
    ;; (goal (subject city) (data RM 0 A 5 C 0 B))
    ;; (goal (subject city) (data NA 0 B 0 C 0 A))
    ;; (goal (subject city) (data BA 0 A 0 B 0 C))
    ;; (goal (subject city) (data RC 0 A 0 B 0 C))
    ;; (goal (subject city) (data PA 0 A 5 C 0 B))
    ;; (goal (subject city) (data FI 0 B 0 C 0 A))
)
