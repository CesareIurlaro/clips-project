(defmodule NEW (import CHECK ?ALL) (export ?ALL))

(defrule dummy_rule (declare (salience 100))

    ?f <- (prev_next (ident ?id))

    =>

    (retract ?f)
    (prepare_string ?id)
)

(defrule check-closed (declare (salience 50))

    ?f1 <- (newnode (ident ?id))
    ?f2 <- (alreadyclosed ?a)

    (status (ident ?id) (subject ?subject) (data $?eqL))
    (status (ident ?old) (subject ?subject) (data $?eqL))
    (node (ident ?old) (open no))

    ?d1 <- (dummy_string (ident ?id) (string $?string))
    ?d2 <- (dummy_string (ident ?old) (string $?string))

=>
    ;;(printout t "check-closed " crlf ?s1_facts crlf ?s2_facts crlf "-----" crlf)

        (assert (alreadyclosed (+ ?a 1)))
        (retract ?f1 ?f2)

        ;;(printout t "open-close" crlf)
        (pop-focus)
        (pop-focus) ;; prima erano fuori
)


(defrule check-open-worse (declare (salience 50))

    ?f1 <- (newnode (ident ?id) (gcost ?g) (father ?anc))

    (status (ident ?id) (subject ?subject) (data $?eqL))
    (status (ident ?old) (subject ?subject) (data $?eqL))
    (node (ident ?old) (gcost ?g-old) (open yes))

    (test (or (> ?g ?g-old) (= ?g-old ?g)))

    ?f2 <- (open-worse ?a)

    (bind ?s1_facts "") (bind ?s2_facts "")

    ?d1 <- (dummy_string (ident ?id) (string $?string))
    ?d2 <- (dummy_string (ident ?old) (string $?string))

=>
    ;;(printout t "open-worse " crlf ?s1_facts crlf ?s2_facts crlf "-----" crlf)

    (assert (open-worse (+ ?a 1)))
    (retract ?f1)
    (retract ?f2)
    ;;(printout t "open-worse" crlf)
    (pop-focus) ;; prima era fuori
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
    ;;(printout t "open-better" crlf)
    (pop-focus)
    (pop-focus) ;; prima erano fuori
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
