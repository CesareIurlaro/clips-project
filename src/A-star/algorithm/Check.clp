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

;;    (node (ident ?rnd) (gcost ?new_gcost) (father ?anc))
;;    (node (ident ?anc)  (father NA))

    (goal (subject city) (data $?eqL))
    (status (ident ?id) (subject city) (data $?eqL))

=>

(assert (node
        (ident ?id) (father ?father) (gcost ?g) (fcost 0) (open no)))
(assert (total_cost 0))
;; (printout t "new_gcost: " ?new_gcost crlf)
(assert (stampa ?id))
(retract ?f)
(pop-focus)
(pop-focus)) 


    ;;(bind ?goal_facts "")
    ;;(do-for-all-facts ((?f goal)) TRUE
    ;;    (bind ?goal_facts (sort string_comparator ?goal_facts ?f:subject (implode$ ?f:data))))

    ;;(bind ?status_facts "")
    ;;(do-for-all-facts ((?f status))
    ;;    (and (eq ?f:ident ?id) (eq ?f:subject city) )
    ;;    (bind ?status_facts (sort string_comparator ?status_facts ?f:subject (implode$ ?f:data))))


    ;;(if (eq (implode$ ?goal_facts) (implode$ ?status_facts))
    ;;then
    ;;    (assert (node
    ;;            (ident ?id) (father ?father) (gcost ?g) (fcost 0) (open no)))
    ;;    (assert (total_cost 0))
    ;;    ;; (printout t "new_gcost: " ?new_gcost crlf)
    ;;    (assert (stampa ?id))
    ;;    (retract ?f)
    ;;    (pop-focus)
    ;;    (pop-focus)) )
