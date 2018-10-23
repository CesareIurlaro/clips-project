(deftemplate MAIN::computed_heuristic_travel_cost (slot cost))

(deftemplate MAIN::computed_heuristic_wares_cost  (slot city) (slot cost))

(deftemplate MAIN::city_state
  (slot name)  (slot qtyProd) (slot objProd) (slot qtyNeed) (slot objNeed) (slot qtyStore) (slot objStore)
)
(deftemplate MAIN::vehicle_state
  (slot type) (slot capacity) (slot location) (slot id)
)

(deftemplate MAIN::status (slot ident)
    (slot subject) (multislot data))


(deftemplate MAIN::goal
    (slot subject) (multislot data))


(deftemplate MAIN::node (slot ident)
    (slot gcost) (slot fcost)  (slot father) (slot open))


(deftemplate MAIN::newnode (slot ident)
    (slot gcost) (slot fcost) (slot father))


(deftemplate MAIN::prev_next (slot ident))


(deftemplate MAIN::dummy_string (slot ident)
    (multislot string))


(deftemplate MAIN::h_distance
    (slot from)
    (slot h_length)
    (slot to)
)

(deftemplate MAIN::file_total_cost
    (slot f_total_cost))


(deftemplate min_distance_export_to
    (slot to) (slot quantity) (slot obj) (slot length) (slot type))


(deftemplate overall_paths_costs_export_to
    (slot to) (slot obj) (slot cost))

(deftemplate different
    (slot id1) (slot id2))

(deftemplate solved_goal
      (slot subject) (multislot data))
