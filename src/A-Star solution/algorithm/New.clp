
(defmodule NEW (import CHECK ?ALL) (export ?ALL))

(defrule check-closed (declare (salience 50))

    ?f1 <- (newnode (ident ?id))
    ?f2 <- (alreadyclosed ?a)

    (status ?id $?status)
    (status ?old $?status)
    (node (ident ?old) (open no))
=>
   (assert (alreadyclosed (+ ?a 1)))
   (retract ?f1 ?f2)
   (pop-focus)
   (pop-focus))



(defrule check-open-worse (declare (salience 50))

    ?f1 <- (newnode (ident ?id) (gcost ?g) (father ?anc))
    ?f2 <- (open-worse ?a)
    (status ?id $?status)
    (status ?old $?status)
    (node (ident ?old) (gcost ?g-old) (open yes))

    (test (or (> ?g ?g-old) (= ?g-old ?g)))
=>
   (assert (open-worse (+ ?a 1)))
   (retract ?f1)
   (retract ?f2)
   (pop-focus))



(defrule check-open-better (declare (salience 50))
    (status ?id $?status)
    ?f1 <- (newnode (ident ?id) (gcost ?g) (fcost ?f) (father ?anc))
    ?f2 <- (status ?old $?status)
    ?f3 <- (node (ident ?old) (gcost ?g-old) (open yes))
    ?f4 <- (open-better ?a)
    (test (<  ?g ?g-old))
=>
  (assert (node (ident ?id) (gcost ?g) (fcost ?f) (father ?anc) (open yes)))
  (assert (open-better (+ ?a 1)))
  (retract ?f1 ?f2 ?f3 ?f4)
  (pop-focus)
  (pop-focus)
)



(defrule add-open (declare (salience 25))
    (status ?id $?status)
    ?f1 <- (newnode (ident ?id) (gcost ?g) (fcost ?f)(father ?anc))
    ?f2 <- (numberofnodes ?a)
=>
   (assert (node (ident ?id) (gcost ?g) (fcost ?f)(father ?anc) (open yes)))
   (assert (numberofnodes (+ ?a 1)))
   (retract ?f1 ?f2)
   (pop-focus)
   (pop-focus)
)
