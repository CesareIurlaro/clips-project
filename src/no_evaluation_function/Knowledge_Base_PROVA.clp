(deffacts MAIN::init_cities
    (status 0 city MI 30 A 0 A)
    (status 0 city VE 0 A 30 A)
)

(deffacts MAIN::init_transports
    (status 0 transport plane 10 MI vehicle8)
)

(deffacts MAIN::goal
    (goal city MI 0 A 0 A)
    (goal city VE 0 A 0 A)
)
