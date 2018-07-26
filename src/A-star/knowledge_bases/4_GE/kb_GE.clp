(deffacts MAIN::state
    (state
        (name_1 TO)  (qtyProd_TO 10) (objProd_TO B) (qtyNeed_TO 0) (objNeed_TO A) (qtyStore_TO 0) (objStore_TO C)
        (name_4 GE)  (qtyProd_GE 10) (objProd_GE C) (qtyNeed_GE 5 ) (objNeed_GE B) (qtyStore_GE 0) (objStore_GE A)
        (name_5 BO)  (qtyProd_BO 10) (objProd_BO B) (qtyNeed_BO 10) (objNeed_BO C) (qtyStore_BO 0) (objStore_BO A)
        (name_11 FI) (qtyProd_FI 0 ) (objProd_FI B) (qtyNeed_FI 0 ) (objNeed_FI C) (qtyStore_FI 0) (objStore_FI A)

        (vehicle_1 van 4 BO 1)
    )


        (open-worse 0)
        (open-better 0)
        (alreadyclosed 0)
        (numberofnodes 0))


(deffacts MAIN::goal
  (goal (subject city) (data GE 10 C 0 B 0 A))
)
