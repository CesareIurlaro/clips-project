(deffacts MAIN::state
    (state
      (name_2 MI)  (qtyProd_MI 5 ) (objProd_MI C) (qtyNeed_MI 0) (objNeed_MI A) (qtyStore_MI 5) (objStore_MI B)
      (name_8 BA)  (qtyProd_BA 0) (objProd_BA A) (qtyNeed_BA 5 ) (objNeed_BA B) (qtyStore_BA 0) (objStore_BA C)

      (vehicle_7 plane 7 MI 7)
    )

        (BA_b)
        (open-worse 0)
        (open-better 0)
        (alreadyclosed 0)
        (numberofnodes 0))


(deffacts MAIN::goal
  (goal (subject city) (data BA 0 A 0 B 0 C))
)
