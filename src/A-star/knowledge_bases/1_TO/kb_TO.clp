;; Sottografo con tre città: Torino (TO), Roma (RM) e Palermo (PA).
;; Soddisfiamo le necessità di TO attraverso l'obiettivo che prevede l'utilizzo
;; di un aereo (vehicle_6) fermo a PA per il trasporto delle merci di tipo A

(deffacts MAIN::state
    (state
        (name_1 TO)  (qtyProd_TO 10) (objProd_TO B) (qtyNeed_TO 20) (objNeed_TO A) (qtyStore_TO 0) (objStore_TO C)
        (name_6 RM)  (qtyProd_RM 10) (objProd_RM A) (qtyNeed_RM 5 ) (objNeed_RM C) (qtyStore_RM 0) (objStore_RM B)
        (name_10 PA) (qtyProd_PA 10) (objProd_PA A) (qtyNeed_PA 5 ) (objNeed_PA C) (qtyStore_PA 0) (objStore_PA B)

        (vehicle_6 plane 7 PA 6))


        (open-worse 0)
        (open-better 0)
        (alreadyclosed 0)
        (numberofnodes 0))


(deffacts MAIN::goal
    (goal (subject city) (data TO 10 B 0 A 0 C))
)
