(defmodule MAIN (export ?ALL))


(deftemplate solution (slot value (default no)))
(deftemplate maxdepth (slot max))
(deffacts parameters
       (solution (value no))
       (maxdepth (max 0))
)

(defrule got-solution
    (declare (salience 100))
    (solution (value yes))
    (maxdepth (max ?n))
=>
	(assert (stampa (- ?n 1)))
)



(defrule stampaSol
(declare (salience 101))
    ?f<-(stampa ?n)
    (exec ?n $?e)
=>
    (printout t "PASSO: " ?n $?e crlf)
    (assert (stampa (- ?n 1)))
    (retract ?f)
)

(defrule stampaSol0
    (declare (salience 102))
    (stampa -1)
=>
    (halt)
)



(defrule no-solution (declare (salience -1))
    (solution (value no))
    (goal $?s)
    (not (status 0 $?s))
    ?f <-  (maxdepth (max ?d))
 =>
    (reset)
    (assert (resetted ?d))
)

(defrule resetted
    ?f <- (resetted ?d)
    ?m <- (maxdepth (max ?))
=>
    (modify ?m (max (+ ?d 1)))
    (printout t " fail with Maxdepth:" ?d crlf)
    (focus EXPAND)
    (retract ?f)
)

(defrule s0Sol (declare (salience -2))
   ?f<-(solution (value no))
=>
    (printout t " PASSO: 0 do nothing" crlf)
    (modify ?f (value yes))
)

(defrule dummy-rule (declare (salience 2))
       ?f1 <- (delete -1 $x?)
       ?f2 <- (news -1)
       ?f3 <- (goal $y?)
       ?f4 <- (status -1 $y?)
=>
	(retract ?f1 ?f2 ?f3 ?f4)
)


(defmodule EXPAND (import MAIN ?ALL) (export ?ALL))

(defrule backtrack-0 (declare (salience 4000))
	?f<- (apply ?s $?y)
   	(maxdepth (max ?d))
   	(test (>= ?s ?d))
=>
	(retract ?f)
)

(defrule backtrack-1 (declare (salience 4000))
	(apply ?s $?)
	(not (current ?))
    ?f1 <-	(status ?t&:(> ?t ?s) $?)
=>
    (retract ?f1)
)

(defrule backtrack-2 (declare (salience 4000))
	(apply ?s $?)
	(not (current ?))
    ?f2 <-	(exec ?t&:(>= ?t ?s) $?)
=>
    (retract ?f2)
)


(defrule pass-to-check (declare (salience 5000))
	(current ?s)
=>
	(focus CHECK)
)

(defmodule CHECK (import EXPAND ?ALL) (export ?ALL))

(defrule persistency
    (declare (salience 100))
    (current ?s)
    (status ?s $?y)
    (not (delete ?t&:(eq ?t (+ ?s 1)) $?y))
 =>
    (assert (status (+ ?s 1) $?y))
)

(defrule goal-not-yet
    (declare (salience 50))
    (news ?s)
    (goal $?y)
    (not (status ?s $?y))
=>
    (assert (task go-on))
    (assert (ancestor (- ?s 1)))
    (focus NEW)
 )

(defrule solution-exist
    ?f <-  (solution (value no))
=>
    (modify ?f (value yes))
    (pop-focus)
    (pop-focus)
)

(defmodule NEW  (import CHECK ?ALL) (export ?ALL))

(defrule check-ancestor
    (declare (salience 50))
    ?f1 <- (ancestor ?a)
    (or (test (> ?a 0)) (test (= ?a 0)))
    (news ?s)
    (status ?s $?y)
    (not (status ?a $?y))
=>
    (assert (ancestor (- ?a 1)))
    (retract ?f1)
    (assert (diff ?a)))

(defrule all-checked
    (declare (salience 25))
    (diff 0)
    ?f2 <- (news ?n)
    ?f3 <- (task go-on)
=>
    (retract ?f2)
    (retract ?f3)
    (focus DEL))

(defrule already-exist
    ?f <- (task go-on)
=>
    (retract ?f)
    (assert (remove newstate))
    (focus DEL))

(defmodule DEL (import NEW ?ALL))

(defrule del1
    (declare (salience 50))
    ?f <- (delete $?)
=>
    (retract ?f))

(defrule del2
    (declare (salience 100))
    ?f <- (diff ?)
=>
    (retract ?f))

(defrule del3
    (declare (salience 25))
    (remove newstate)
    (news ?n)
    ?f <- (status ?n $?)
=>
    (retract ?f))

(defrule del4
    (declare (salience 10))
    ?f1 <- (remove newstate)
    ?f2 <- (news ?n)
=>
    (retract ?f1)
    (retract ?f2))

(defrule done
    ?f <- (current ?x)
=>
    (retract ?f)
    (pop-focus)
    (pop-focus)
    (pop-focus)
)
