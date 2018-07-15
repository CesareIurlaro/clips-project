(defmodule CHECK (import EXPAND ?ALL)(export ?ALL))

(defrule goal-not-yet (declare (salience 50))
    (newnode (ident ?id))
    (goal
        (A_TO ?A_TO) (B_TO ?B_TO) (C_TO ?C_TO)
        (A_MI ?A_MI) (B_MI ?B_MI) (C_MI ?C_MI)
        (A_VE ?A_VE) (B_VE ?B_VE) (C_VE ?C_VE)
        (A_GE ?A_GE) (B_GE ?B_GE) (C_GE ?C_GE)
        (A_BO ?A_BO) (B_BO ?B_BO) (C_BO ?C_BO)
        (A_RM ?A_RM) (B_RM ?B_RM) (C_RM ?C_RM)
        (A_NA ?A_NA) (B_NA ?B_NA) (C_NA ?C_NA)
        (A_BA ?A_BA) (B_BA ?B_BA) (C_BA ?C_BA)
        (A_RC ?A_RC) (B_RC ?B_RC) (C_RC ?C_RC)
        (A_PA ?A_PA) (B_PA ?B_PA) (C_PA ?C_PA))

    (not (status
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
        (A_PA ?A_PA) (B_PA ?B_PA) (C_PA ?C_PA)))
=>
    (focus NEW))


(defrule solution-exist (declare (salience 25))
    ?f <-(newnode (ident ?id) (father ?father))
    (node (ident ?father)  (gcost ?g))

    (goal
        (A_TO ?A_TO) (B_TO ?B_TO) (C_TO ?C_TO)
        (A_MI ?A_MI) (B_MI ?B_MI) (C_MI ?C_MI)
        (A_VE ?A_VE) (B_VE ?B_VE) (C_VE ?C_VE)
        (A_GE ?A_GE) (B_GE ?B_GE) (C_GE ?C_GE)
        (A_BO ?A_BO) (B_BO ?B_BO) (C_BO ?C_BO)
        (A_RM ?A_RM) (B_RM ?B_RM) (C_RM ?C_RM)
        (A_NA ?A_NA) (B_NA ?B_NA) (C_NA ?C_NA)
        (A_BA ?A_BA) (B_BA ?B_BA) (C_BA ?C_BA)
        (A_RC ?A_RC) (B_RC ?B_RC) (C_RC ?C_RC)
        (A_PA ?A_PA) (B_PA ?B_PA) (C_PA ?C_PA))

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
        (A_PA ?A_PA) (B_PA ?B_PA) (C_PA ?C_PA))
=>
    (assert (node
        (ident ?id) (father ?father) (gcost (+ ?g +1)) (fcost 0) (open no)))
    (printout t " Esiste soluzione con costo " (+ ?g  1) crlf)
    (assert (stampa ?id))
    (retract ?f)
    (pop-focus)
    (pop-focus))
