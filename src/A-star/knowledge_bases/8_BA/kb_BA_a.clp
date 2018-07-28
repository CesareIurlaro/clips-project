;; Sottografo con tre città: Milano (MI), Bologna (BO) e Bari (BA).
;; Soddisfiamo le necessità di BA attraverso l'utilizzo di due sottoobiettivi:
;; 1. Trasferimento delle merci di tipo A da BO verso MI con l'utilizzo
;;    di un van (vehicle_3) fermo a BO,
;; 2. Trasferimento delle merci precedentemente trattate verso BA con l'utilizzo
;;    di un van (vehicle_7) fermo a MI,


(deffacts MAIN::state
    (state
      (name_2 MI)  (qtyProd_MI 5 ) (objProd_MI C) (qtyNeed_MI 0) (objNeed_MI A) (qtyStore_MI 0) (objStore_MI B)
      (name_5 BO)  (qtyProd_BO 5) (objProd_BO B) (qtyNeed_BO 10) (objNeed_BO C) (qtyStore_BO 0) (objStore_BO A)
      (name_8 BA)  (qtyProd_BA 0) (objProd_BA A) (qtyNeed_BA 5 ) (objNeed_BA B) (qtyStore_BA 0) (objStore_BA C)

      (vehicle_3 van 4 BO 3)
    )

        (BA_a)
        (open-worse 0)
        (open-better 0)
        (alreadyclosed 0)
        (numberofnodes 0))


(deffacts MAIN::goal
  (goal (subject city) (data MI 5 C 0 A 5 B))
)
