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

    (deffunction remove_file_total_cost ()
      (do-for-all-facts ((?f file_total_cost)) TRUE
        (retract ?f)
      )
    )

(deffunction sum_up_costs ()
  (load-facts "projectCosts.fct")
  (bind ?tc 0)
  (do-for-all-facts ((?f file_total_cost)) TRUE
    (bind ?tc (+ ?tc ?f:f_total_cost))
  )
  (printout t crlf " Il costo totale è : " ?tc crlf)
)

(deffunction remove_diff ()
  (do-for-all-facts ((?d different)) TRUE
    (retract ?d)
  )
)

(deffunction delete_old_status (?lastIDStatus)
  (do-for-all-facts ((?s status)) (neq ?s:ident ?lastIDStatus)
    (retract ?s)
  )
)
