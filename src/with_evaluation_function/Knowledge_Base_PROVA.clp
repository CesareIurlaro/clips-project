(deffacts MAIN::init_cities
    (status 0 city MI 10 A 0 A)
    (status 0 city RM 0 C 10 C)
    (status 0 city BA 0 A 10 A)
)

(deffacts MAIN::init_transports
    (status 0 transport van 10 MI vehicle8)
)


(deffacts MAIN::init_distances
    (distance MI 564 RM van)
    (distance RM 412 BA van)
    ;; (distance MI 711 BA plane)
)


(deffacts MAIN::goal
    (goal city MI 0 A 0 A)
    (goal city BA 0 A 0 A)
)
