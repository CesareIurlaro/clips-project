(defmodule NEW (import CHECK ?ALL) (export ?ALL))

(defrule check-closed (declare (salience 50))

    ?f1 <- (newnode (ident ?id))
    ?f2 <- (alreadyclosed ?a)

    (status (ident ?id) (subject ?subject) (data $?eqL))
    (status (ident ?id) (subject ?subject) (data $?eqL))
    (node (ident ?old) (open no))
=>
   (assert (alreadyclosed (+ ?a 1)))
   (retract ?f1 ?f2)
   (pop-focus)
   (pop-focus))



(defrule check-open-worse (declare (salience 50))

    ?f1 <- (newnode (ident ?id) (gcost ?g) (father ?anc))

    (status (ident ?id) (subject ?subject) (data $?eqL))
    (status (ident ?old) (subject ?subject) (data $?eqL))
    (node (ident ?old) (gcost ?g-old) (open yes))

    (test (or (> ?g ?g-old) (= ?g-old ?g)))

    ?f2 <- (open-worse ?a)
=>
   (assert (open-worse (+ ?a 1)))
   (retract ?f1)
   (retract ?f2)
   (pop-focus))



(defrule check-open-better (declare (salience 50))
    ?f1 <- (newnode (ident ?id) (gcost ?g) (fcost ?f) (father ?anc))

           (status (ident ?id) (subject ?subject) (data $?eqL))
    ?f2 <- (status (ident ?old) (subject ?subject) (data $?eqL))

    ?f3 <- (node (ident ?old) (gcost ?g-old) (open yes))

    (test (<  ?g ?g-old))

    ?f4 <- (open-better ?a)

=>

  (assert (node (ident ?id) (gcost ?g) (fcost ?f) (father ?anc) (open yes)))
  (assert (open-better (+ ?a 1)))
  (retract ?f1 ?f2 ?f3 ?f4)
  (pop-focus)
  (pop-focus))



(defrule add-open (declare (salience 25))

    ?f1 <- (newnode (ident ?id) (gcost ?g) (fcost ?f)(father ?anc))
    ?f2 <- (numberofnodes ?a)

    (status (ident ?id) (subject ?subject) (data $?eqL))

=>

   (assert (node (ident ?id) (gcost ?g) (fcost ?f)(father ?anc) (open yes)))
   (assert (numberofnodes (+ ?a 1)))
   (retract ?f1 ?f2)
   (pop-focus)
   (pop-focus))
