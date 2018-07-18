(deffunction MAIN::travel_cost_evaluation(?type ?length)
    (bind ?result 0)
    (if (eq (str-compare ?type "van") 0)
    then (bind ?result ?length))

    (if (eq (str-compare ?type "ship") 0)
    then (bind ?result (div (* 2 ?length) 3)))

    (if (eq (str-compare ?type "plane") 0)
    then (bind ?result (+ ?length (div (* 25 ?length) 100))))

    (return ?result))

(deffunction MAIN::find_overall_costs()
;; somma dei costi di tutte le distanze minime di export
    (bind ?travel_cost 0)
    (bind ?wares_cost 0)
    (do-for-all-facts ((?f min_distance_export_to)) TRUE
        (bind ?travel_cost (+ ?travel_cost (travel_cost_evaluation ?f:type ?f:length)))
        (bind ?wares_cost  (+ ?wares_cost(* 2 (* 10 ?f:quantity))))
        (retract ?f)) ;;; forse errore?

    (return (+ ?travel_cost ?wares_cost)))
