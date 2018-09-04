(defmodule MAIN (export ?ALL))

(defrule run
    ?h_w <- (find_heuristic_wares_costs)
    ?h_t <- (find_heuristic_travel_costs)
    (current ?id)

=>
    (retract ?h_w ?h_t)

    (bind ?o_cost (find_heuristic_costs))
    (bind ?fcost ?o_cost)

    (assert
       (node (ident ?id)
           (gcost 0) (fcost ?fcost)
           (father NA) (open yes)))

    (focus EXPAND))



(defrule stampaSol (declare (salience 101))
    ?f <- (stampa ?id)
    (node (ident ?id) (father ?anc&~NA))
    (exec ?anc ?id ?op ?cost $?e)

    ?f2 <-(total_cost ?c)
=>
    (printout t " Eseguo azione " ?op " con costo " ?cost " " $?e crlf)
    (assert (stampa ?anc))
    (assert (total_cost (+ ?c ?cost)))
    (retract ?f ?f2))


(defrule stampa-fine (declare (salience 102))
    (stampa ?id)
    (node (ident ?id) (father ?anc&NA))
    (open-worse ?worse)
    (open-better ?better)
    (alreadyclosed ?closed)
    (numberofnodes ?n)
    (total_cost ?c)
=>
    (load-facts "projectCosts.fct")
    (assert (file_total_cost (f_total_cost ?c)))
    (save-facts "projectCosts.fct" visible file_total_cost)
    (printout t crlf " ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~ " crlf " Esiste soluzione con costo " ?c crlf)
    (printout t crlf " stati espansi " ?n crlf)
    (printout t " stati generati gia` in closed " ?closed crlf)
    (printout t " stati generati gia` in (open-worse) " ?worse crlf)
    (printout t " stati generati gia` in (open-better) " ?better crlf)
    (halt))
