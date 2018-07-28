;; Sottografo con due città: Venezia (VE) e Bologna (BO).
;; Soddisfiamo le necessità di VE attraverso l'obiettivo che prevede l'utilizzo
;; di un van (vehicle_2) fermo a BO per il trasporto delle merci di tipo B.


(deffacts MAIN::state
    (state
      (name_3 VE) (qtyProd_VE 10) (objProd_VE C) (qtyNeed_VE 5 ) (objNeed_VE B) (qtyStore_VE 0) (objStore_VE A)
      (name_5 BO)  (qtyProd_BO 10) (objProd_BO B) (qtyNeed_BO 10) (objNeed_BO C) (qtyStore_BO 0) (objStore_BO A)

      (vehicle_2 van 4 BO 2)
    )

        (VE)
        (open-worse 0)
        (open-better 0)
        (alreadyclosed 0)
        (numberofnodes 0))


(deffacts MAIN::goal
  (goal (subject city) (data VE 10 C 0 B 0 A))
)
