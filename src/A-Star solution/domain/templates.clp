(deftemplate MAIN::city
    (slot name)
    (slot A (type INTEGER)) (slot B (type INTEGER)) (slot C (type INTEGER)))

(deftemplate MAIN::transport
    (slot type) (slot capacity (type INTEGER)) (slot location) (slot id))

(deftemplate MAIN::node (slot ident)
    (slot gcost) (slot fcost)  (slot father) (slot open))

(deftemplate MAIN::newnode (slot ident)
    (slot gcost) (slot fcost) (slot father))


(deftemplate MAIN::state
    (slot A_TO) (slot B_TO) (slot C_TO)
    (slot A_MI) (slot B_MI) (slot C_MI)
    (slot A_VE) (slot B_VE) (slot C_VE)
    (slot A_GE) (slot B_GE) (slot C_GE)
    (slot A_BO) (slot B_BO) (slot C_BO)
    (slot A_RM) (slot B_RM) (slot C_RM)
    (slot A_NA) (slot B_NA) (slot C_NA)
    (slot A_BA) (slot B_BA) (slot C_BA)
    (slot A_RC) (slot B_RC) (slot C_RC)
    (slot A_PA) (slot B_PA) (slot C_PA)

    (multislot transport_1)
    (multislot transport_2)
    (multislot transport_3)
    (multislot transport_4)
    (multislot transport_5)
    (multislot transport_6)
    (multislot transport_7)
    (multislot transport_8))


(deftemplate MAIN::status
    (slot id)
    (slot A_TO) (slot B_TO) (slot C_TO)
    (slot A_MI) (slot B_MI) (slot C_MI)
    (slot A_VE) (slot B_VE) (slot C_VE)
    (slot A_GE) (slot B_GE) (slot C_GE)
    (slot A_BO) (slot B_BO) (slot C_BO)
    (slot A_RM) (slot B_RM) (slot C_RM)
    (slot A_NA) (slot B_NA) (slot C_NA)
    (slot A_BA) (slot B_BA) (slot C_BA)
    (slot A_RC) (slot B_RC) (slot C_RC)
    (slot A_PA) (slot B_PA) (slot C_PA)

    (slot type_1) (slot capacity_1) (slot location_1)
    (slot type_2) (slot capacity_2) (slot location_2)
    (slot type_3) (slot capacity_3) (slot location_3)
    (slot type_4) (slot capacity_4) (slot location_4)
    (slot type_5) (slot capacity_5) (slot location_5)
    (slot type_6) (slot capacity_6) (slot location_6)
    (slot type_7) (slot capacity_7) (slot location_7)
    (slot type_8) (slot capacity_8) (slot location_8))


(deftemplate MAIN::apply
    (multislot id)
    (slot location_1) (slot length1) (slot to_1) (slot type_1)
    (slot location_2) (slot length2) (slot to_2) (slot type_2)
    (slot location_3) (slot length3) (slot to_3) (slot type_3)
    (slot location_4) (slot length4) (slot to_4) (slot type_4)
    (slot location_5) (slot length5) (slot to_5) (slot type_5)
    (slot location_6) (slot length6) (slot to_6) (slot type_6)
    (slot location_7) (slot length7) (slot to_7) (slot type_7)
    (slot location_8) (slot length8) (slot to_8) (slot type_8))


(deftemplate MAIN::exec
    (multislot id)
    (multislot infos_1)
    (multislot infos_2)
    (multislot infos_3)
    (multislot infos_4)
    (multislot infos_5)
    (multislot infos_6)
    (multislot infos_7)
    (multislot infos_8))


(deftemplate MAIN::goal
    (slot A_TO) (slot B_TO) (slot C_TO)
    (slot A_MI) (slot B_MI) (slot C_MI)
    (slot A_VE) (slot B_VE) (slot C_VE)
    (slot A_GE) (slot B_GE) (slot C_GE)
    (slot A_BO) (slot B_BO) (slot C_BO)
    (slot A_RM) (slot B_RM) (slot C_RM)
    (slot A_NA) (slot B_NA) (slot C_NA)
    (slot A_BA) (slot B_BA) (slot C_BA)
    (slot A_RC) (slot B_RC) (slot C_RC)
    (slot A_PA) (slot B_PA) (slot C_PA)

    (slot type_1) (slot capacity_1) (slot location_1)
    (slot type_2) (slot capacity_2) (slot location_2)
    (slot type_3) (slot capacity_3) (slot location_3)
    (slot type_4) (slot capacity_4) (slot location_4)
    (slot type_5) (slot capacity_5) (slot location_5)
    (slot type_6) (slot capacity_6) (slot location_6)
    (slot type_7) (slot capacity_7) (slot location_7)
    (slot type_8) (slot capacity_8) (slot location_8))



(deftemplate min_distance_export_to
    (slot to) (slot quantity) (slot obj) (slot length) (slot type))

(deftemplate overall_paths_costs_export_to
    (slot to) (slot obj) (slot cost))


;; (deftemplate distance
;;      (slot from) (slot length (type INTEGER)) (slot to))
