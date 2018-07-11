(deffacts MAIN::init_cities
    (status 0 city MI 30 A 0 A)
    (status 0 city VE 0 A 30 A)
)

(deffacts MAIN::init_transports
    (status 0 transport van 10 MI vehicle8)
)


(deffacts MAIN::init_distances
    (distance MI  276 VE)
    (distance VE  276 MI)
)


(deffacts MAIN::goal
    (goal city MI 0 A 0 A)
    (goal city VE 0 A 0 A)
)
