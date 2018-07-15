
(defmodule EXPAND (import MAIN ?ALL) (export ?ALL))


(defrule shift-apply (declare (salience 50))
    (current ?curr)
    (node (ident ?curr) (open yes))
    (status
        (id ?curr)
        (A_TO ?A_TO) (B_TO ?B_TO) (C_TO ?C_TO)
        (A_MI ?A_MI) (B_MI ?B_MI) (C_MI ?C_MI)
        (A_VE ?A_VE) (B_VE ?B_VE) (C_VE ?C_VE)
        (A_GE ?A_GE) (B_GE ?B_GE) (C_GE ?C_GE)
        (A_BO ?A_BO) (B_BO ?B_BO) (C_BO ?C_BO)
        (A_RM ?A_RM) (B_RM ?B_RM) (C_RM ?C_RM)
        (A_NA ?A_NA) (B_NA ?B_NA) (C_NA ?C_NA)
        (A_BA ?A_BA) (B_BA ?B_BA) (C_BA ?C_BA)
        (A_RC ?A_RC) (B_RC ?B_RC) (C_RC ?C_RC)
        (A_PA ?A_PA) (B_PA ?B_PA) (C_PA ?C_PA)

        (type_1 ?type_1) (capacity_1 ?capacity_1) (location_1 ?location_1)    ;; transport_1
        (type_2 ?type_2) (capacity_2 ?capacity_2) (location_2 ?location_2)    ;; transport_2
        (type_3 ?type_3) (capacity_3 ?capacity_3) (location_3 ?location_3)    ;; transport_3
        (type_4 ?type_4) (capacity_4 ?capacity_4) (location_4 ?location_4)    ;; transport_4
        (type_5 ?type_5) (capacity_5 ?capacity_5) (location_5 ?location_5)    ;; transport_5
        (type_6 ?type_6) (capacity_6 ?capacity_6) (location_6 ?location_6)    ;; transport_6
        (type_7 ?type_7) (capacity_7 ?capacity_7) (location_7 ?location_7)    ;; transport_7
        (type_8 ?type_8) (capacity_8 ?capacity_8) (location_8 ?location_8))   ;; transport_8

   (distance ?location_1 ?length1 ?to1 ?type_1)
   (distance ?location_2 ?length2 ?to2 ?type_2)
   (distance ?location_3 ?length3 ?to3 ?type_3)
   (distance ?location_4 ?length4 ?to4 ?type_4)
   (distance ?location_5 ?length5 ?to5 ?type_5)
   (distance ?location_6 ?length6 ?to6 ?type_6)
   (distance ?location_7 ?length7 ?to7 ?type_7)
   (distance ?location_8 ?length8 ?to8 ?type_8)

=>
    (bind ?shift shift)
    (assert
        (apply
            (id ?curr ?shift)
            (location_1 ?location_1) (length1 ?length1) (to_1 ?to1) (type_1 ?type_1)
            (location_2 ?location_2) (length2 ?length2) (to_2 ?to2) (type_2 ?type_2)
            (location_3 ?location_3) (length3 ?length3) (to_3 ?to3) (type_3 ?type_3)
            (location_4 ?location_4) (length4 ?length4) (to_4 ?to4) (type_4 ?type_4)
            (location_5 ?location_5) (length5 ?length5) (to_5 ?to5) (type_5 ?type_5)
            (location_6 ?location_6) (length6 ?length6) (to_6 ?to6) (type_6 ?type_6)
            (location_7 ?location_7) (length7 ?length7) (to_7 ?to7) (type_7 ?type_7)
            (location_8 ?location_8) (length8 ?length8) (to_8 ?to8) (type_8 ?type_8))))



(defrule shift-exec (declare (salience 50))

    ?f1<- (apply
        (id ?curr ?shift)
        (location_1 ?location_1) (length1 ?length1) (to_1 ?to1) (type_1 ?type_1)
        (location_2 ?location_2) (length2 ?length2) (to_2 ?to2) (type_2 ?type_2)
        (location_3 ?location_3) (length3 ?length3) (to_3 ?to3) (type_3 ?type_3)
        (location_4 ?location_4) (length4 ?length4) (to_4 ?to4) (type_4 ?type_4)
        (location_5 ?location_5) (length5 ?length5) (to_5 ?to5) (type_5 ?type_5)
        (location_6 ?location_6) (length6 ?length6) (to_6 ?to6) (type_6 ?type_6)
        (location_7 ?location_7) (length7 ?length7) (to_7 ?to7) (type_7 ?type_7)
        (location_8 ?location_8) (length8 ?length8) (to_8 ?to8) (type_8 ?type_8))

    ?f2 <- (status
        (id ?curr)
        (A_TO ?A_TO) (B_TO ?B_TO) (C_TO ?C_TO)
        (A_MI ?A_MI) (B_MI ?B_MI) (C_MI ?C_MI)
        (A_VE ?A_VE) (B_VE ?B_VE) (C_VE ?C_VE)
        (A_GE ?A_GE) (B_GE ?B_GE) (C_GE ?C_GE)
        (A_BO ?A_BO) (B_BO ?B_BO) (C_BO ?C_BO)
        (A_RM ?A_RM) (B_RM ?B_RM) (C_RM ?C_RM)
        (A_NA ?A_NA) (B_NA ?B_NA) (C_NA ?C_NA)
        (A_BA ?A_BA) (B_BA ?B_BA) (C_BA ?C_BA)
        (A_RC ?A_RC) (B_RC ?B_RC) (C_RC ?C_RC)
        (A_PA ?A_PA) (B_PA ?B_PA) (C_PA ?C_PA)

        (type_1 ?type_1) (capacity_1 ?capacity_1) (location_1 ?location_1)
        (type_2 ?type_2) (capacity_2 ?capacity_2) (location_2 ?location_2)
        (type_3 ?type_3) (capacity_3 ?capacity_3) (location_3 ?location_3)
        (type_4 ?type_4) (capacity_4 ?capacity_4) (location_4 ?location_4)
        (type_5 ?type_5) (capacity_5 ?capacity_5) (location_5 ?location_5)
        (type_6 ?type_6) (capacity_6 ?capacity_6) (location_6 ?location_6)
        (type_7 ?type_7) (capacity_7 ?capacity_7) (location_7 ?location_7)
        (type_8 ?type_8) (capacity_8 ?capacity_8) (location_8 ?location_8))

    (current ?curr)
    (node (ident ?curr) (gcost ?g))
    ;; (goal ?goal 0 ?goal_obj)    ;; forse inutile

=>
   (bind ?new (gensym*))

   (bind ?gcost 0)
   (foreach ?index (create$ 1 2 3 4 5 6 7 8)
        (bind ?length (fact-slot-value ?f1 (sym-cat length ?index)))
        (bind ?type   (fact-slot-value ?f1 (sym-cat type _ ?index)))
        (bind ?cost_evaluation (travel_cost_evaluation ?type ?length))
        (bind ?gcost  (+ ?gcost ?cost_evaluation)))

    (bind ?fcost (find_overall_costs)) ;; da aggiornare, rifà i calcoli fatti prima
 ;;  (bind ?wares_cost  (* -10 (fact-slot-value ?f2 (sym-cat ?goal_obj _ ?name)))) ;; da migliorare
 ;;  (bind ?travel_cost (travel_cost_evaluation ?type ?length))
 ;;  (bind ?fcost       (+ ?wares_cost ?travel_cost))

    (assert
        (exec
            (id ?curr ?new ?shift)
            (infos_1 ?location_1 ?length1 ?to1 ?type_1)
            (infos_2 ?location_2 ?length2 ?to2 ?type_2)
            (infos_3 ?location_3 ?length3 ?to3 ?type_3)
            (infos_4 ?location_4 ?length4 ?to4 ?type_4)
            (infos_5 ?location_5 ?length5 ?to5 ?type_5)
            (infos_6 ?location_6 ?length6 ?to6 ?type_6)
            (infos_7 ?location_7 ?length7 ?to7 ?type_7)
            (infos_8 ?location_8 ?length8 ?to8 ?type_8))
        (status
            (id ?new)
            (A_TO ?A_TO) (B_TO ?B_TO) (C_TO ?C_TO)
            (A_MI ?A_MI) (B_MI ?B_MI) (C_MI ?C_MI)
            (A_VE ?A_VE) (B_VE ?B_VE) (C_VE ?C_VE)
            (A_GE ?A_GE) (B_GE ?B_GE) (C_GE ?C_GE)
            (A_BO ?A_BO) (B_BO ?B_BO) (C_BO ?C_BO)
            (A_RM ?A_RM) (B_RM ?B_RM) (C_RM ?C_RM)
            (A_NA ?A_NA) (B_NA ?B_NA) (C_NA ?C_NA)
            (A_BA ?A_BA) (B_BA ?B_BA) (C_BA ?C_BA)
            (A_RC ?A_RC) (B_RC ?B_RC) (C_RC ?C_RC)
            (A_PA ?A_PA) (B_PA ?B_PA) (C_PA ?C_PA)

           (type_1 ?type_1) (capacity_1 ?capacity_1) (location_1 ?to1) ;; modificare capacità?
           (type_2 ?type_2) (capacity_2 ?capacity_2) (location_2 ?to2)
           (type_3 ?type_3) (capacity_3 ?capacity_3) (location_3 ?to3)
           (type_4 ?type_4) (capacity_4 ?capacity_4) (location_4 ?to4)
           (type_5 ?type_5) (capacity_5 ?capacity_5) (location_5 ?to5)
           (type_6 ?type_6) (capacity_6 ?capacity_6) (location_6 ?to6)
           (type_7 ?type_7) (capacity_7 ?capacity_7) (location_7 ?to7)
           (type_8 ?type_8) (capacity_8 ?capacity_8) (location_8 ?to8))



        (newnode
            (ident ?new)
            (gcost (+ ?g ?gcost))
            (fcost (+ ?gcost ?fcost))
            (father ?curr)))
        (retract ?f1)
)


(defrule next-phase (declare (salience 100))
	(newnode (ident ?new))
=>
	(focus CHECK)
)


(defrule change-current (declare (salience 25))
    ?f1 <-(current ?curr)
    ?f2 <-(node (ident ?curr))
    (node (ident ?best&:(neq ?best ?curr)) (fcost ?bestcost) (open yes))
    (not (node
        (ident ?id&:(neq ?id ?curr)) (fcost ?gg&:(< ?gg ?bestcost)) (open yes)))
=>
    (assert (current ?best))
    (retract ?f1)
    (modify ?f2 (open no)))





(defrule open-empty (declare (salience 25))

    ?f1 <- (current ?curr)
    ?f2 <- (node (ident ?curr))
    (not (node
        (ident ?id&:(neq ?id ?curr)) (open yes)))

 =>

    (retract ?f1)
    (modify ?f2 (open no))
    (printout t " fail (last  node expanded " ?curr ")" crlf)
    (halt))
