;; Sottografo con tre città: Genova (GE), Napoli (NA) e Palermo (PA).
;; Soddisfiamo le necessità di NA e PA attraverso l'utilizzo di una nave
;; (vehicle_8).

(deffacts MAIN::state
    (state
      (name_4 GE)  (qtyProd_GE 10) (objProd_GE C) (qtyNeed_GE 0) (objNeed_GE B) (qtyStore_GE 0) (objStore_GE A)
      (name_7 NA)  (qtyProd_NA 0) (objProd_NA B) (qtyNeed_NA 5 ) (objNeed_NA C) (qtyStore_NA 0) (objStore_NA A)
      (name_10 PA) (qtyProd_PA 0) (objProd_PA A) (qtyNeed_PA 5 ) (objNeed_PA C) (qtyStore_PA 0) (objStore_PA B)

      (vehicle_8 ship 11 GE 8)
    )


        (open-worse 0)
        (open-better 0)
        (alreadyclosed 0)
        (numberofnodes 0))


(deffacts MAIN::goal
    (goal (subject city) (data NA 0 B 0 C 0 A))
    (goal (subject city) (data PA 0 A 0 C 0 B))
)
