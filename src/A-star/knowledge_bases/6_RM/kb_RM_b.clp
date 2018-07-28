(deffacts MAIN::state
    (state
      (name_1 TO)  (qtyProd_TO 0) (objProd_TO B) (qtyNeed_TO 0) (objNeed_TO A) (qtyStore_TO 5) (objStore_TO C)
      (name_6 RM)  (qtyProd_RM 0) (objProd_RM A) (qtyNeed_RM 5) (objNeed_RM C) (qtyStore_RM 0) (objStore_RM B)

      (vehicle_6 plane 7 TO 6))

        (RM)
        (open-worse 0)
        (open-better 0)
        (alreadyclosed 0)
        (numberofnodes 0))


(deffacts MAIN::goal
  (goal (subject city) (data RM 0 A 0 C 0 B))
)
