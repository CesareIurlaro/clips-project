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

(deffacts MAIN::init_paths
    (path ship VE BA) (path ship BA VE)
    (path ship NA PA) (path ship PA NA)
    (path ship GE PA) (path ship PA GE)

    (path plane TO RM) (path plane RM TO)
    (path plane TO PA) (path plane PA TO)
    (path plane MI BA) (path plane BA MI)
    (path plane MI NA) (path plane NA MI)

    (path van TO MI) (path van MI TO)
    (path van TO GE) (path van GE TO)
    (path van MI VE) (path van VE MI)
    (path van MI BO) (path van BO MI)
    (path van VE BO) (path van BO VE)
    (path van GE FI) (path van FI GE)
    (path van BO FI) (path van FI BO)
    (path van FI RM) (path van RM FI)
    (path van RM NA) (path van NA RM)
    (path van NA BA) (path van BA NA)
    (path van NA RC) (path van RC NA)
)


(deffacts MAIN::goal
    (goal city MI 0 A 0 A)
    (goal city VE 0 A 0 A)
)
