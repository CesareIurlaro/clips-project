;; Sottografo con due città: Venezia (VE) e Bologna (BO).
;; Soddisfiamo le necessità di BO attraverso l'obiettivo che prevede l'utilizzo
;; di un van (vehicle_2) fermo a VE per il trasporto delle merci di tipo C

(deffacts MAIN::state
    (state
      (name_3 VE)  (qtyProd_VE 10) (objProd_VE C) (qtyNeed_VE 0) (objNeed_VE B) (qtyStore_VE 0) (objStore_VE A)
      (name_5 BO)  (qtyProd_BO 0) (objProd_BO B) (qtyNeed_BO 10) (objNeed_BO C) (qtyStore_BO 0) (objStore_BO A)

      (vehicle_2 van 4 VE 2)
    )


        (open-worse 0)
        (open-better 0)
        (alreadyclosed 0)
        (numberofnodes 0))


(deffacts MAIN::goal
  (goal (subject city) (data BO 0 B 0 C 0 A))
)
