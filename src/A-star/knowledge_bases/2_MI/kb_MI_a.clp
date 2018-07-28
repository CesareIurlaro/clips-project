;; Sottografo con tre città: Roma (RM), Napoli (NA) e Reggio Calabria (RC).
;; Soddisfiamo le necessità di MI attraverso l'utilizzo di tre sottoobiettivi:
;; 1. Trasferimento delle merci di tipo A da RC verso NA,
;; 2. Trasferimento parziale di 10 A verso MI,
;; 3. Trasferimento delle rimanenti 20 A verso MI.

(deffacts MAIN::state
    (state
        (name_6 RM)  (qtyProd_RM 0) (objProd_RM A) (qtyNeed_RM 5 ) (objNeed_RM C) (qtyStore_RM 0) (objStore_RM B)
        (name_7 NA)  (qtyProd_NA 5 ) (objProd_NA B) (qtyNeed_NA 5 ) (objNeed_NA C) (qtyStore_NA 0) (objStore_NA A)
        (name_9 RC)  (qtyProd_RC 20) (objProd_RC A) (qtyNeed_RC 5) (objNeed_RC B) (qtyStore_RC 0) (objStore_RC C)


        (vehicle_4 van 4 RM 4)
        (vehicle_5 van 4 RM 5))

        (open-worse 0)
        (open-better 0)
        (alreadyclosed 0)
        (numberofnodes 0))




(deffacts MAIN::goal
    (goal (subject city) (data NA 5 B 5 C 20 A))
)
