;; Sottografo con quattro città: Torino (TO), Genova (GE), Bologna (Bo) e
;; Firenze (FI).
;; Soddisfiamo le necessità di GE attraverso l'obiettivo che prevede l'utilizzo
;; di un van (vehicle_1) fermo a BO per il trasporto delle merci di tipo B.


(deffacts MAIN::state
    (state
        (name_1 TO)  (qtyProd_TO 5) (objProd_TO B) (qtyNeed_TO 0) (objNeed_TO A) (qtyStore_TO 0) (objStore_TO C)
        (name_4 GE)  (qtyProd_GE 10) (objProd_GE C) (qtyNeed_GE 5) (objNeed_GE B) (qtyStore_GE 0) (objStore_GE A)

        (vehicle_1 van 4 TO 1)
    )

    (GE_b)

        (open-worse 0)
        (open-better 0)
        (alreadyclosed 0)
        (numberofnodes 0))


(deffacts MAIN::goal
  (goal (subject city) (data GE 10 C 0 B 0 A))
)
