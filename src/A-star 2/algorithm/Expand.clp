(defmodule EXPAND (import MAIN ?ALL) (export ?ALL))


(defrule next-phase (declare (salience 100))
	(newnode (ident ?new))
=>
	(focus CHECK))


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
