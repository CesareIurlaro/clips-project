(deffunction MAIN::travel_cost_evaluation(?type ?length)
    (bind ?result 0)
    (if (eq (str-compare ?type "van") 0)
    then (bind ?result ?length))

    (if (eq (str-compare ?type "ship") 0)
    then (bind ?result (div (* 2 ?length) 3)))

    (if (eq (str-compare ?type "plane") 0)
    then (bind ?result (+ ?length (div (* 25 ?length) 100))))

    (return ?result))

(deffunction MAIN::find_heuristic_costs()
    (bind ?total_travel_cost 0)
    (do-for-all-facts ((?f computed_heuristic_travel_cost)) TRUE
        (bind ?total_travel_cost (+ ?total_travel_cost ?f:cost))
        (retract ?f))

    (bind ?total_wares_cost 0)
    (do-for-all-facts ((?f computed_heuristic_wares_cost)) TRUE
        (bind ?total_wares_cost (+ ?total_wares_cost ?f:cost))
        (retract ?f))

    (bind ?total_cost (+ ?total_wares_cost ?total_travel_cost))
    (return ?total_cost))



(deffunction MAIN::string_comparator (?a ?b)
    (< (str-compare ?a ?b) 0))


(deffunction MAIN::prepare_string (?id)
    (bind ?s_facts "")
    (do-for-all-facts ((?f status)) (eq ?f:ident ?id)
        (bind ?s_facts (sort string_comparator ?s_facts ?f:subject (implode$ ?f:data))))

    (assert (dummy_string (ident ?id) (string (implode$ ?s_facts))))
)
