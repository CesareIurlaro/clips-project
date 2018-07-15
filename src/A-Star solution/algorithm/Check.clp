(defmodule CHECK (import EXPAND ?ALL)(export ?ALL))

(defrule goal-not-yet (declare (salience 50))
    (newnode (ident ?id))
    (goal $?goal)
    (not (status ?id $?goal))
=>
    (focus NEW)
)


(defrule solution-exist (declare (salience 25))
    ?f <-(newnode (ident ?id) (father ?father))
    (goal $?goal)
    (node (ident ?father)  (gcost ?g))
    (status ?id $?goal)
=>
    (assert (node
        (ident ?id) (father ?father) (gcost (+ ?g +1)) (fcost 0) (open no)))
    (printout t " Esiste soluzione con costo " (+ ?g  1) crlf)
    (assert (stampa ?id))
    (retract ?f)
    (pop-focus)
    (pop-focus))
