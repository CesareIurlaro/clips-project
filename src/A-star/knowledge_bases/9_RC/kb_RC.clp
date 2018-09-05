;; Sottografo con due città: Napoli (NA) e Reggio Calabria (RC).
;; Soddisfiamo le necessità di RC attraverso l'obiettivo che prevede l'utilizzo
;; di un van (vehicle_5) fermo a NA per il trasporto delle merci di tipo B

(deffacts MAIN::state
    (state
        (name_7 NA)  (qtyProd_NA 5 ) (objProd_NA B) (qtyNeed_NA 5 ) (objNeed_NA C) (qtyStore_NA 0) (objStore_NA A)
        (name_9 RC)  (qtyProd_RC 0) (objProd_RC A) (qtyNeed_RC 5) (objNeed_RC B) (qtyStore_RC 0) (objStore_RC C)

        (vehicle_5 van 4 NA 5)
    )


        (open-worse 0)
        (open-better 0)
        (alreadyclosed 0)
        (numberofnodes 0))


(deffacts MAIN::goal
  (goal (subject city) (data RC 0 A 0 B 0 C))
)
