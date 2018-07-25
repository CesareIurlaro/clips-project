(defmodule CHECK (import EXPAND ?ALL)(export ?ALL))

(defrule goal-not-yet (declare (salience 50))
    (newnode (ident ?id))

    (goal (subject city) (data $?eqL))
    (not (status (ident ?id) (subject city) (data $?eqL)))

=>

    (focus NEW))


(defrule solution-exist (declare (salience 25))
    ?f <- (newnode (ident ?id) (father ?father))
    (node (ident ?father)  (gcost ?g))
    (goal (subject city) (data $?eqL))
    (status (ident ?id) (subject city) (data $?eqL))

=>

    (assert (node
            (ident ?id) (father ?father) (gcost ?g) (fcost 0) (open no)))
    (assert (total_cost 0))
    (assert (stampa ?id))
    (retract ?f)
    (pop-focus)
    (pop-focus))
