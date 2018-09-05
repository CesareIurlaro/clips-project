(defmodule NEW (import CHECK ?ALL) (export ?ALL))

(defrule check-closed (declare (salience 50))

    ?f1 <- (newnode (ident ?id))
    ?f2 <- (alreadyclosed ?a)

    (status (ident ?id) (subject ?subject) (data $?eqL))
    (status (ident ?old) (subject ?subject) (data $?eqL))
    (node (ident ?old) (open no))

    ?d1 <- (dummy_string (ident ?id) (string $?string))
    ?d2 <- (dummy_string (ident ?old) (string $?string))

=>

    (assert (alreadyclosed (+ ?a 1)))
    (retract ?f1 ?f2)
    (pop-focus)
    (pop-focus)
)


(defrule check-open-worse (declare (salience 50))

    ?f1 <- (newnode (ident ?id) (gcost ?g) (father ?anc))

    (status (ident ?id) (subject ?subject) (data $?eqL))
    (status (ident ?old) (subject ?subject) (data $?eqL))
    (node (ident ?old) (gcost ?g-old) (open yes))

    (test (or (> ?g ?g-old) (= ?g-old ?g)))

    ?f2 <- (open-worse ?a)

    ?d1 <- (dummy_string (ident ?id) (string $?string))
    ?d2 <- (dummy_string (ident ?old) (string $?string))

=>

    (assert (open-worse (+ ?a 1)))
    (retract ?f1)
    (retract ?f2)
    (pop-focus)
)


(defrule check-open-better (declare (salience 50))
    ?f1 <- (newnode (ident ?id) (gcost ?g) (fcost ?f) (father ?anc))

           (status (ident ?id) (subject ?subject) (data $?eqL))
    ?f2 <- (status (ident ?old) (subject ?subject) (data $?eqL))

    ?f3 <- (node (ident ?old) (gcost ?g-old) (open yes))

    (test (< ?g ?g-old))

    ?f4 <- (open-better ?a)

    ?d1 <- (dummy_string (ident ?id) (string $?string))
    ?d2 <- (dummy_string (ident ?old) (string $?string))

=>

    (assert (node (ident ?id) (gcost ?g) (fcost ?f) (father ?anc) (open yes)))
    (assert (open-better (+ ?a 1)))
    (retract ?f1 ?f2 ?f3 ?f4)
    (pop-focus)
    (pop-focus)
    )


(defrule add-open (declare (salience 25))

    ?f1 <- (newnode (ident ?id) (gcost ?g) (fcost ?f)(father ?anc))
    ?f2 <- (numberofnodes ?a)

    (status (ident ?id) (subject ?subject) (data $?))

=>
    (assert (node (ident ?id) (gcost ?g) (fcost ?f)(father ?anc) (open yes)))
    (assert (numberofnodes (+ ?a 1)))
    (retract ?f1 ?f2)
    (pop-focus)
    (pop-focus))



(defrule remove_prev_next (declare (salience 100))

    ?f <- (prev_next (ident ?id))

=>
    (retract ?f)
    (prepare_string ?id)
)
