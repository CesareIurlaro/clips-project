(deffacts MAIN::state
    (state
      (name_1 TO)  (qtyProd_TO 0) (objProd_TO B) (qtyNeed_TO 0) (objNeed_TO A) (qtyStore_TO 0) (objStore_TO C)
      (name_2 MI)  (qtyProd_MI 5 ) (objProd_MI C) (qtyNeed_MI 0) (objNeed_MI A) (qtyStore_MI 0) (objStore_MI B)

      (vehicle_3 van 4 MI 3)
    )


        (open-worse 0)
        (open-better 0)
        (alreadyclosed 0)
        (numberofnodes 0))


(deffacts MAIN::goal
  (goal (subject city) (data TO 0 B 0 A 5 C))
)
