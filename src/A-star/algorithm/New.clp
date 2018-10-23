(defmodule NEW (import CHECK ?ALL) (export ?ALL))

(defrule check-nodes (declare (salience 100))

    (newnode (ident ?id))
    (node (ident ?old))

    (status (ident ?id) (subject ?subject) (data $?eqL))
    (not (status (ident ?old) (subject ?subject) (data $?eqL)))

=> (assert (different (id1 ?old) (id2 ?id)))
)


(defrule check-closed (declare (salience 50))

    ?f1 <- (newnode (ident ?id))
           (node (ident ?old) (open no))

    ?f2 <- (alreadyclosed ?a)

    (not (different (id1 ?old) (id2 ?id)) )

=>

    (assert (alreadyclosed (+ ?a 1)))
    (retract ?f1 ?f2)
    (pop-focus)
    (pop-focus)
)


(defrule check-open-worse (declare (salience 50))

    ?f1 <- (newnode (ident ?id) (gcost ?g) (father ?anc))
           (node (ident ?old) (gcost ?g-old) (open yes))

    (not (different (id1 ?old) (id2 ?id)) )
    (test (or (> ?g ?g-old) (= ?g-old ?g)))

    ?f2 <- (open-worse ?a)

=>

    (assert (open-worse (+ ?a 1)))
    (retract ?f1)
    (retract ?f2)
    (pop-focus)
)


(defrule check-open-better (declare (salience 50))
    ?f1 <- (newnode (ident ?id) (gcost ?g) (fcost ?f) (father ?anc))
    ?f2 <- (node (ident ?old) (gcost ?g-old) (open yes))

    (not (different (id1 ?old) (id2 ?id)) )
    (test (< ?g ?g-old))
    ?f4 <- (open-better ?a)

=>

    (assert (node (ident ?id) (gcost ?g) (fcost ?f) (father ?anc) (open yes)))
    (assert (open-better (+ ?a 1)))
    (retract ?f1 ?f2 ?f4)
    (pop-focus)
    (pop-focus))


(defrule add-open (declare (salience 25))

    ?f1 <- (newnode (ident ?id) (gcost ?g) (fcost ?f)(father ?anc))
           (node (ident ?old) (gcost ?g-old) (open yes))

    ?f2 <- (numberofnodes ?a)

    (status (ident ?id) (subject ?subject) (data $?))

=>
    (assert (node (ident ?id) (gcost ?g) (fcost ?f)(father ?anc) (open yes)))
    (assert (numberofnodes (+ ?a 1)))
    (retract ?f1 ?f2)
    (pop-focus)
    (pop-focus))
