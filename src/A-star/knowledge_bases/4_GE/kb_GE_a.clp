;; Sottografo con tre città: Torino (TO), Milano (MI) e Bologna (BO).
;; Soddisfiamo le necessità di GE attraverso l'utilizzo di due sottoobiettivi:
;; 1. Trasferimento di un van (vehicle_1) da BO a TO,
;; 2. Trasferimento delle merci di tipo B con l'utilizzo del van (vehicle_1) da
;;    TO verso GE.

(deffacts MAIN::state
    (state
        (name_1 TO)  (qtyProd_TO 10) (objProd_TO B) (qtyNeed_TO 0) (objNeed_TO A) (qtyStore_TO 0) (objStore_TO C)
        (name_2 MI)  (qtyProd_MI 5 ) (objProd_MI C) (qtyNeed_MI 0) (objNeed_MI A) (qtyStore_MI 0) (objStore_MI B)
        (name_5 BO)  (qtyProd_BO 5) (objProd_BO B) (qtyNeed_BO 10) (objNeed_BO C) (qtyStore_BO 0) (objStore_BO A)

        (vehicle_1 van 4 BO 1)
    )


        (open-worse 0)
        (open-better 0)
        (alreadyclosed 0)
        (numberofnodes 0))


(deffacts MAIN::goal
  (goal (subject transport) (data van 4 BO 1))
)
