;; Sottografo con due città: Torino (TO), Milano (MI) e Roma (RM).
;; Soddisfiamo le necessità di RM attraverso l'utilizzo di due sotto-obiettivi:
;; 1. Trasferimento delle merci di tipo C da MI verso TO con l'utilizzo
;;    di un van (vehicle_3) fermo a MI,
;; 2. Trasferimento delle merci precedentemente trattate verso RM con l'utilizzo
;;    di un plane (vehicle_6) fermo a TO,
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
