(defmodule MAIN (export ?ALL))

(defrule start
    ?f<- (state
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

        (transport_1 ?type_1 ?capacity_1 ?location_1)
        (transport_2 ?type_2 ?capacity_2 ?location_2)
        (transport_3 ?type_3 ?capacity_3 ?location_3)
        (transport_4 ?type_4 ?capacity_4 ?location_4)
        (transport_5 ?type_5 ?capacity_5 ?location_5)
        (transport_6 ?type_6 ?capacity_6 ?location_6)
        (transport_7 ?type_7 ?capacity_7 ?location_7)
        (transport_8 ?type_8 ?capacity_8 ?location_8))
    ;;(overall_paths_costs_export_to ?name ?obj ?length ?type)
=>
     (bind ?fcost (find_overall_costs))

     ;; (bind ?wares_cost  (* -10 (fact-slot-value ?f (sym-cat ?obj _ ?name))))
     ;; (bind ?travel_cost (travel_cost_evaluation ?type ?length))
     ;; (bind ?fcost (+ ?wares_cost ?travel_cost))

     (bind ?id (gensym*))
     (assert
        (node (ident ?id)
            (gcost 0) (fcost ?fcost)
            (father NA) (open yes))
        (status
            (id ?id)
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
        (current ?id))
    (focus EXPAND))



(defrule stampaSol (declare (salience 101))
    ?f<-(stampa ?id)
    (node (ident ?id) (father ?anc&~NA))
    (exec (id ?anc) (infos_1 $?e))
=>
    (printout t " Eseguo azione " $?e crlf)
    (assert (stampa ?anc))
    (retract ?f))



(defrule stampa-fine (declare (salience 102))
    (stampa ?id)
    (node (ident ?id) (father ?anc&NA))
    (open-worse ?worse)
    (open-better ?better)
    (alreadyclosed ?closed)
    (numberofnodes ?n )
=>
    (printout t " stati espansi " ?n crlf)
    (printout t " stati generati gia` in closed " ?closed crlf)
    (printout t " stati generati gia` in open (open-worse) " ?worse crlf)
    (printout t " stati generati gia` in open (open-better) " ?better crlf)
    (halt))
