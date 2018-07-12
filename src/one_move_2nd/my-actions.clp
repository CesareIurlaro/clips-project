(defrule EXPAND::load
    "Se un mezzo con capienza > 0 transita da una città
     che ha prodotti da esportare, allora il mezzo li carica"
    (declare (salience ?*load*))
    (status ?s transport ?t1 ?c1&:(> ?c1 0) ?l1 ?id1)
    (status ?s transport ?t2 ?c2&:(> ?c2 0) ?l2 ?id2)
    (test (neq (str-compare ?id1 ?id2) 0))
    (status ?s city ?l1 ?q1&:(> ?q1 0) ?obj1 $?y1)
    (status ?s city ?l2 ?q2&:(> ?q2 0) ?obj2 $?y2)
=>
    (assert (apply ?s load
            transport ?t1 ?c1 ?l1 ?id1
            city ?l1 ?q1 ?obj1 $?y1))

    (assert (apply ?s load
            transport ?t2 ?c2 ?l2 ?id2
            city ?l2 ?q2 ?obj2 $?y2))
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
)



;; ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~

(defrule EXPAND::unload
    "Se un mezzo che trasporta un oggetto transita da una città
     che lo importa, allora il mezzo lo scarica"
    (declare (salience ?*unload*))
    (status ?s transport ?t1 ?c1 ?l1 ?id1)
    (status ?s transport ?t2 ?c2 ?l2 ?id2)
    (test (neq (str-compare ?id1 ?id2) 0))

    (status ?s city ?l1 $?x1 ?qa_1 ?obj1)
    (status ?s carries ?id1 ?qa_2 ?obj1)

    (status ?s city ?l2 $?x2 ?qb_1 ?obj2)
    (status ?s carries ?id2 ?qb_2 ?obj2)
=>
    (assert (apply ?s unload
             transport ?t1 ?c1 ?l1 ?id1
             city ?l1 $?x1 ?qa_1 ?obj1
             carries ?id1 ?qa_2 ?obj1))

    (assert (apply ?s unload
             transport ?t2 ?c2 ?l2 ?id2
             city ?l2 $?x2 ?qb_1 ?obj2
             carries ?id2 ?qb_2 ?obj2))
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
)


;; ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~  ~~~~~~~~~~

(defrule EXPAND::shift
    "Se un mezzo si trova in una città, può transitare in un'altra diversa."
    (declare (salience ?*shift*))
    (status ?s transport ?t1 ?c1 ?l1 ?id1)
        (status ?s city ?la_1 $?x1)
        (status ?s city ?lb_1 $?y1)
        (test (neq (str-compare ?la_1 ?lb_1) 0))
        (distance ?la_1 ?d1 ?lb_1 ?t1)

    (status ?s transport ?t2 ?c2 ?l2 ?id2)
        (status ?s city ?la_2 $?x2)
        (status ?s city ?lb_2 $?y2)
        (test (neq (str-compare ?la_2 ?lb_2) 0))
        (distance ?la_2 ?d2 ?lb_2 ?t2)

    (test (neq (str-compare ?id1 ?id2) 0))


=>
    (assert (apply ?s shift
             transport ?t1 ?c1 ?l1 ?id1
             city ?la_1 $?x1
             city ?lb_1 $?y1))

    (assert (apply ?s shift
             transport ?t2 ?c2 ?l2 ?id2
             city ?la_2 $?x2
             city ?lb_2 $?y2))
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
)
