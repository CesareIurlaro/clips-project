
(defmodule NEW (import CHECK ?ALL) (export ?ALL))

(defrule check-closed (declare (salience 50))

    ?f1 <- (newnode (ident ?id))
    ?f2 <- (alreadyclosed ?a)
    (node (ident ?old) (open no))

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

    (status
        (id ?old)
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
   (assert (alreadyclosed (+ ?a 1)))
   (retract ?f1 ?f2)
   (pop-focus)
   (pop-focus))



(defrule check-open-worse (declare (salience 50))

    ?f1 <- (newnode (ident ?id) (gcost ?g) (father ?anc))
    ?f2 <- (open-worse ?a)
    (node (ident ?old) (gcost ?g-old) (open yes))

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

    (status
        (id ?old)
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

    (test (or (> ?g ?g-old) (= ?g-old ?g)))
=>
   (assert (open-worse (+ ?a 1)))
   (retract ?f1)
   (retract ?f2)
   (pop-focus))



(defrule check-open-better (declare (salience 50))
    ?f1 <- (newnode
            (ident ?id) (gcost ?g) (fcost ?f) (father ?anc))

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

    ?f2 <-  (status
                (id ?old)
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

    ?f3 <- (node (ident ?old) (gcost ?g-old) (open yes))
    ?f4 <- (open-better ?a)
    (test (<  ?g ?g-old))


=>

  (assert (node (ident ?id) (gcost ?g) (fcost ?f) (father ?anc) (open yes)))
  (assert (open-better (+ ?a 1)))
  (retract ?f1 ?f2 ?f3 ?f4)
  (pop-focus)
  (pop-focus))



(defrule add-open (declare (salience 25))

    ?f1 <- (newnode (ident ?id) (gcost ?g) (fcost ?f)(father ?anc))
    ?f2 <- (numberofnodes ?a)

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

   (assert (node (ident ?id) (gcost ?g) (fcost ?f)(father ?anc) (open yes)))
   (assert (numberofnodes (+ ?a 1)))
   (retract ?f1 ?f2)
   (pop-focus)
   (pop-focus))
