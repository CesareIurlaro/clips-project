;; Sottografo con tre città: Torino (TO), Roma (RM) e Palermo (PA).
;; Soddisfiamo le necessità di TO attraverso l'obiettivo che prevede l'utilizzo
;; di un aereo (vehicle_6) fermo a PA per il trasporto delle merci di tipo A

(deffacts MAIN::state
    (city_state (name TO)  (qtyProd 10) (objProd B) (qtyNeed 20) (objNeed A) (qtyStore 0) (objStore C))
    (city_state (name MI)  (qtyProd 5)  (objProd C) (qtyNeed 30) (objNeed A) (qtyStore 0) (objStore B))
    (city_state (name VE)  (qtyProd 10) (objProd C) (qtyNeed 5)  (objNeed B) (qtyStore 0) (objStore A))
    (city_state (name GE)  (qtyProd 10) (objProd C) (qtyNeed 5)  (objNeed B) (qtyStore 0) (objStore A))
    (city_state (name BO)  (qtyProd 10) (objProd B) (qtyNeed 10) (objNeed C) (qtyStore 0) (objStore A))
    (city_state (name RM)  (qtyProd 10) (objProd A) (qtyNeed 5)  (objNeed C) (qtyStore 0) (objStore B))
    (city_state (name NA)  (qtyProd 5)  (objProd B) (qtyNeed 5)  (objNeed C) (qtyStore 0) (objStore A))
    (city_state (name BA)  (qtyProd 10) (objProd A) (qtyNeed 5)  (objNeed B) (qtyStore 0) (objStore C))
    (city_state (name RC)  (qtyProd 20) (objProd A) (qtyNeed 5)  (objNeed B) (qtyStore 0) (objStore C))
    (city_state (name PA)  (qtyProd 10) (objProd A) (qtyNeed 5)  (objNeed C) (qtyStore 0) (objStore B))

    (vehicle_state (type van) (capacity 4) (location BO) (id 1))
    (vehicle_state (type van) (capacity 4) (location BO) (id 2))
    (vehicle_state (type van) (capacity 4) (location BO) (id 3))
    (vehicle_state (type van) (capacity 4) (location RM) (id 4))
    (vehicle_state (type van) (capacity 4) (location RM) (id 5))
    (vehicle_state (type plane) (capacity 7) (location PA) (id 6))
    (vehicle_state (type plane) (capacity 7) (location MI) (id 7))
    (vehicle_state (type ship) (capacity 11) (location GE) (id 8))
    (vehicle_state (type ship) (capacity 11) (location VE) (id 9))

    (open-worse 0)
    (open-better 0)
    (alreadyclosed 0)
    (numberofnodes 0))


(deffacts MAIN::goal
    (goal (subject city) (data TO 10 B 0 A 0 C))
)
