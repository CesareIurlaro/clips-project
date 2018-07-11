(deffunction EXPAND::salience_value(?type ?d)
    (if (eq (str-compare ?type "van") 0)
    then
        (bind ?*shift* (* -1 ?d))
    )

    (if (eq (str-compare ?type "ship") 0)
    then
        (bind ?*shift* (* -1 (div (* 2 ?d) 3)))
    )

    (if (eq (str-compare ?type "plane") 0)
    then
        (bind ?*shift* (* -1 (+ ?d (div (* 25 ?d) 100))))
    )
)

(defrule EXPAND::load
    "Se un mezzo con capienza > 0 transita da una città
     che ha prodotti da esportare, allora il mezzo li carica"
    (declare (salience ?*load*))
    ?f1 <- (status ?s transport ?t ?c&:(> ?c 0) ?l ?id)
    (status ?s city ?l ?q&:(> ?q 0) ?obj $?y)
=>

    (if (eq ?*load* 2)
    then
        (if (>= ?q ?c)
        then
            (bind ?*load* (* -10 ?c))
        else
            (bind ?*load* (* -10 ?q))
        )
        (retract ?f1)
        (assert (status ?s transport ?t ?c ?l ?id))
    else
        (assert
            (apply ?s load
                transport ?t ?c ?l ?id
                city ?l ?q ?obj $?y
        ))
        (bind ?*load* 2)
    )
)


(defrule EXPAND::apply-load (declare (salience 3000))
    ?f <- (apply ?s load
            transport ?t ?c ?l ?id
            city ?l ?q ?obj $?y
          )
 =>
    (retract ?f)
    (assert (delete (+ ?s 1) transport ?t ?c ?l ?id))
    (assert (delete (+ ?s 1) city ?l ?q ?obj $?y))

    (if (>= ?q ?c)
    then
        (assert (status (+ ?s 1) transport ?t 0 ?l ?id))
        (assert (status (+ ?s 1) city ?l (- ?q ?c) ?obj $?y))
        (assert (status (+ ?s 1) carries ?id ?c ?obj))
    else
        (assert (status (+ ?s 1) transport ?t (- ?c ?q) ?l ?id))
        (assert (status (+ ?s 1) city ?l 0 ?obj $?y))
        (assert (status (+ ?s 1) carries ?id ?q ?obj))
    )   ;?id porta con sè una quantità ?q dell'oggetto ?obj

    (assert (current ?s))
    (assert (news (+ ?s 1)))
    (assert
        (exec ?s load
            transport ?t ?c ?l ?id
            city ?l ?q ?obj $?y
        )
    )
    ;; (printout t "exec " ?s " load: "
    ;; ?t " " ?id " city " ?l " " ?q " " ?obj crlf)
)



;; ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~

(defrule EXPAND::unload
    "Se un mezzo che trasporta un oggetto transita da una città
     che lo importa, allora il mezzo lo scarica"
    (declare (salience ?*unload*))
    ?f1 <- (status ?s transport ?t ?c ?l ?id)
    (status ?s city ?l $?x ?q1 ?obj)
    (status ?s carries ?id ?q2 ?obj)
=>
    (if (eq ?*unload* 2)
    then
        (bind ?*unload* (* -10 ?q2))
        (retract ?f1)
        (assert (status ?s transport ?t ?c ?l ?id))
    else
        (assert
            (apply ?s unload
                transport ?t ?c ?l ?id
                city ?l $?x ?q1 ?obj
                carries ?id ?q2 ?obj
        ))
        (bind ?*unload* 2)
    )
)

(defrule EXPAND::apply-unload (declare (salience 3000))
    ?f <- (apply ?s unload
            transport ?t ?c ?l ?id
            city ?l $?x ?q1 ?obj
            carries ?id ?q2 ?obj
        )
=>
   (retract ?f)
   (assert (delete (+ ?s 1) transport ?t ?c ?l ?id))
   (assert (delete (+ ?s 1) city ?l $?x ?q1 ?obj))
   (assert (delete (+ ?s 1) carries ?id ?q2 ?obj))

   (if (> ?q2 ?q1)
   then
        (assert (status (+ ?s 1) transport ?t (+ ?c ?q1) ?l ?id))
        (assert (status (+ ?s 1) city ?l $?x 0 ?obj))
        (assert (status (+ ?s 1) carries ?id (- ?q2 ?q1) ?obj ))
    )

    (if (> ?q1 ?q2)
    then
        (assert (status (+ ?s 1) transport ?t (+ ?c ?q2) ?l ?id))
        (assert (status (+ ?s 1) city ?l $?x (- ?q1 ?q2) ?obj))
    ) ;; no carries

    (if (= ?q1 ?q2)
    then
        (assert (status (+ ?s 1) transport ?t (+ ?c ?q1) ?l ?id))
        (assert (status (+ ?s 1) city ?l $?x 0 ?obj))
    ) ;; no carries

   (assert (current ?s))
   (assert (news (+ ?s 1)))
   (assert
       (exec ?s unload
           transport ?t ?c ?l ?id
           city ?l $?x ?q1 ?obj
           carries ?id ?q2 ?obj
       )
   )
   ;; (printout t "exec " ?s " unload: "
   ;; ?t " " ?id " city " ?l " " ?q2 " " ?obj crlf)
)


;; ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~

(defrule EXPAND::shift
    "Se un mezzo si trova in una città, può transitare in un'altra diversa."
    (declare (salience ?*shift*))
    (status ?s transport ?t ?c ?l ?id)
    (status ?s city ?l  $?x)
    (status ?s city ?l2 $?y)
    (path ?t ?l ?l2)
    (test (neq (str-compare ?l ?l2) 0))
    ?f1 <- (distance ?l ?d ?l2)
    ;;(distance ?l2 ?q ?l)
=>

    (if (eq ?*shift* 2)
    then
        (salience_value ?t ?d)
        (retract ?f1)
        (assert (distance ?l  ?d ?l2))
    else
        (assert
            (apply ?s shift
                transport ?t ?c ?l ?id
                city ?l $?x
                city ?l2 $?y
        ))
        (bind ?*shift* 2)
    )
)

(defrule EXPAND::apply-shift (declare (salience 3000))
    ?f <- (apply ?s shift
            transport ?t ?c ?l ?id
            city ?l  $?x
            city ?l2 $?y
        )
=>
   (retract ?f)
   (assert (delete (+ ?s 1) transport ?t ?c ?l ?id))

   (assert (status (+ ?s 1) transport ?t ?c ?l2 ?id))

   (assert (current ?s))
   (assert (news (+ ?s 1)))
   (assert
       (exec ?s shift
           transport ?t ?c ?l ?id
           city ?l  $?x
           city ?l2 $?y
       )
   )
   ;; (printout t "exec " ?s " shift: "
   ;; t " " ?id " city " ?l " to " ?l2 crlf)
)
