(deffacts MAIN::state
    (state;;    A         B         C
        (A_TO -20) (B_TO 10) (C_TO  0)   ;; TO
        (A_MI -30) (B_MI  0) (C_MI  5)   ;; MI
        (A_VE  0)  (B_VE -5) (C_VE  10)  ;; VE
        (A_GE  0)  (B_GE -5) (C_GE  10)  ;; GE
        (A_BO  0)  (B_BO 10) (C_BO -10)  ;; BO
        (A_RM 10)  (B_RM  0) (C_RM -5)   ;; RM
        (A_NA  0)  (B_NA  5) (C_NA -5)   ;; NA
        (A_BA 10)  (B_BA -5) (C_BA  0)   ;; BA
        (A_RC 20)  (B_RC -5) (C_RC  0)   ;; RC
        (A_PA 10)  (B_PA  0) (C_PA -5)   ;; PA

        (transport_1 van 4 BO)
        (transport_2 van 4 BO)
        (transport_3 van 4 BO)
        (transport_4 van 4 BO)
        (transport_5 ship 11 GE)
        (transport_6 ship 11 VE)
        (transport_7 plane 7 PA)
        (transport_8 plane 7 MI))

    (open-worse 0)
    (open-better 0)
    (alreadyclosed 0)
    (numberofnodes 0))



(deffacts MAIN::init_distances
    (distance BA  711 MI plane) (distance MI  711 BA plane)
    (distance BA  255 NA van  ) (distance NA  255 BA van  )
    (distance BA  754 VE ship ) (distance VE  754 BA ship )

    (distance BO  101 FI van  ) (distance FI  101 BO van  )
    (distance BO  206 MI van  ) (distance MI  206 BO van  )
    (distance BO  158 VE van  ) (distance VE  158 BO van  )

    (distance FI  230 GE van  ) (distance GE  230 FI van  )
    (distance FI  268 RM van  ) (distance RM  268 FI van  )

    (distance GE 1412 PA ship ) (distance PA 1412 GE ship )
    (distance GE  170 TO van  ) (distance TO  170 GE van  )

    (distance MI  764 NA plane) (distance NA  764 MI plane)

    (distance MI  138 TO van  ) (distance TO  138 MI van  )
    (distance MI  276 VE van  ) (distance VE  276 MI van  )

    (distance NA  740 PA ship ) (distance PA  740 NA ship )
    (distance NA  462 RC van  ) (distance RC  462 NA van  )
    (distance NA  219 RM van  ) (distance RM  219 NA van  )

    (distance PA 1596 TO plane) (distance TO 1596 PA plane)

    (distance RM  669 TO plane) (distance TO  669 RM plane))


(deffacts MAIN::goal
    (goal;;     A         B         C
        (A_TO   0) (B_TO 10) (C_TO  0)   ;; TO
        (A_MI -30) (B_MI  0) (C_MI  5)   ;; MI
        (A_VE  0)  (B_VE -5) (C_VE  10)  ;; VE
        (A_GE  0)  (B_GE -5) (C_GE  10)  ;; GE
        (A_BO  0)  (B_BO 10) (C_BO -10)  ;; BO
        (A_RM 10)  (B_RM  0) (C_RM -5)   ;; RM
        (A_NA  0)  (B_NA  5) (C_NA -5)   ;; NA
        (A_BA 10)  (B_BA -5) (C_BA  0)   ;; BA
        (A_RC  0)  (B_RC -5) (C_RC  0)   ;; RC
        (A_PA 10)  (B_PA  0) (C_PA -5))) ;; PA
        
;;       (type_1 van  ) (capacity_1  4) (location_1 BO)
;;       (type_2 van  ) (capacity_2  4) (location_2 BO)
;;       (type_3 van  ) (capacity_3  4) (location_3 BO)
;;       (type_4 van  ) (capacity_4  4) (location_4 BO)
;;       (type_5 ship ) (capacity_5 11) (location_5 GE)
;;       (type_6 ship ) (capacity_6 11) (location_6 VE)
;;       (type_7 plane) (capacity_7  7) (location_7 PA)
;;       (type_8 plane) (capacity_8  7) (location_8 MI)


;; (goal MI 0 C 0 A)
;; (goal VE 0 C 0 B)
;; (goal GE 0 C 0 B)
;; (goal BO 0 B 0 C)
;; (goal RM 0 A 0 C)
;; (goal NA 0 B 0 C)
;; (goal BA 0 A 0 B)
;; (goal RC 0 A 0 B)
;; (goal PA 0 A 0 C)


;; (distance BA 1026 BO) (distance BO 1026 BA)
;; (distance BA  662 FI) (distance FI  662 BA)
;; (distance BA  407 GE) (distance GE  407 BA)
;; (distance BA  762 PA) (distance PA  762 BA)
;; (distance BA  439 RC) (distance RC  439 BA)
;; (distance BA  412 RM) (distance RM  412 BA)
;; (distance BA  998 TO) (distance TO  998 BA)

;; (distance FI  295 MI) (distance MI  295 FI)
;; (distance FI  468 NA) (distance NA  468 FI)
;; (distance FI 1185 PA) (distance PA 1185 FI)
;; (distance FI  912 RC) (distance RC  912 FI)
;; (distance FI  400 TO) (distance TO  400 FI)
;; (distance FI  258 VE) (distance VE  258 FI)

;; (distance GE  253 MI) (distance MI  253 GE)
;; (distance GE  707 NA) (distance NA  707 GE)
;; (distance GE 1150 RC) (distance RC 1150 GE)
;; (distance GE  507 RM) (distance RM  507 GE)
;; (distance GE  402 VE) (distance VE  402 GE)

;; (distance BO  393 GE) (distance GE  393 BO)
;; (distance BO  570 NA) (distance NA  570 BO)
;; (distance BO 1288 PA) (distance PA 1288 BO)
;; (distance BO 1014 RC) (distance RC 1014 BO)
;; (distance BO  370 RM) (distance RM  370 BO)
;; (distance BO  327 TO) (distance TO  327 BO)

;; (distance MI 1476 PA) (distance PA 1476 MI)
;; (distance MI 1208 RC) (distance RC 1208 MI)
;; (distance MI  564 RM) (distance RM  564 MI)

;; (distance NA  869 TO) (distance TO  869 NA)
;; (distance NA  727 VE) (distance VE  727 NA)

;; (distance PA  257 RC) (distance RC  257 PA)
;; (distance PA  932 RM) (distance RM  932 PA)
;; (distance PA 1431 VE) (distance VE 1431 PA)

;; (distance RC  662 RM) (distance RM  662 RC)
;; (distance RC 1312 TO) (distance TO 1312 RC)
;; (distance RC 1171 VE) (distance VE 1171 RC)
;; (distance RM  527 VE) (distance VE  527 RM)

;; (distance TO  405 VE) (distance VE  405 TO)
