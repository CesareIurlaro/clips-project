(deffacts MAIN::init_cities
    (status 0 city TO 10 B 20 A)
    (status 0 city MI 5  C 30 A)
    (status 0 city VE 10 C 5  B)
    (status 0 city GE 10 C 5  B)
    (status 0 city BO 10 B 10 C)
    (status 0 city RM 10 A 5  C)
    (status 0 city NA 5  B 5  C)
    (status 0 city BA 10 A 5  B)
    (status 0 city RC 20 A 10 B)
    (status 0 city PA 10 A 5  C)
)

(deffacts MAIN::init_transports
    (status 0 transport van 4 BO vehicle0)
    (status 0 transport van 4 BO vehicle1)
    (status 0 transport van 4 BO vehicle2)

    (status 0 transport van 4 RM vehicle3)
    (status 0 transport van 4 RM vehicle4)

    (status 0 transport ship 11 GE vehicle5)
    (status 0 transport ship 11 VE vehicle6)

    (status 0 transport plane 7 PA vehicle7)
    (status 0 transport plane 7 MI vehicle8)
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


(deffacts MAIN::init_distances
    (distance BA 1026 BO) (distance BO 1026 BA)
    (distance BA  662 FI) (distance FI  662 BA)
    (distance BA  407 GE) (distance GE  407 BA)
    (distance BA  711 MI) (distance MI  711 BA)
    (distance BA  255 NA) (distance NA  255 BA)
    (distance BA  762 PA) (distance PA  762 BA)
    (distance BA  439 RC) (distance RC  439 BA)
    (distance BA  412 RM) (distance RM  412 BA)
    (distance BA  998 TO) (distance TO  998 BA)
    (distance BA  754 VE) (distance VE  754 BA)

    (distance BO  101 FI) (distance FI  101 BO)
    (distance BO  393 GE) (distance GE  393 BO)
    (distance BO  206 MI) (distance MI  206 BO)
    (distance BO  570 NA) (distance NA  570 BO)
    (distance BO 1288 PA) (distance PA 1288 BO)
    (distance BO 1014 RC) (distance RC 1014 BO)
    (distance BO  370 RM) (distance RM  370 BO)
    (distance BO  327 TO) (distance TO  327 BO)
    (distance BO  158 VE) (distance VE  158 BO)

    (distance FI  230 GE) (distance GE  230 FI)
    (distance FI  295 MI) (distance MI  295 FI)
    (distance FI  468 NA) (distance NA  468 FI)
    (distance FI 1185 PA) (distance PA 1185 FI)
    (distance FI  912 RC) (distance RC  912 FI)
    (distance FI  400 TO) (distance TO  400 FI)
    (distance FI  258 VE) (distance VE  258 FI)

    (distance GE  253 MI) (distance MI  253 GE)
    (distance GE  707 NA) (distance NA  707 GE)
    (distance GE 1412 PA) (distance PA 1412 GE)
    (distance GE 1150 RC) (distance RC 1150 GE)
    (distance GE  507 RM) (distance RM  507 GE)
    (distance GE  170 TO) (distance TO  170 GE)
    (distance GE  402 VE) (distance VE  402 GE)

    (distance MI  764 NA) (distance NA  764 MI)
    (distance MI 1476 PA) (distance PA 1476 MI)
    (distance MI 1208 RC) (distance RC 1208 MI)
    (distance MI  564 RM) (distance RM  564 MI)
    (distance MI  138 TO) (distance TO  138 MI)
    (distance MI  276 VE) (distance VE  276 MI)

    (distance NA  740 PA) (distance PA  740 NA)
    (distance NA  462 RC) (distance RC  462 NA)
    (distance NA  219 RM) (distance RM  219 NA)
    (distance NA  869 TO) (distance TO  869 NA)
    (distance NA  727 VE) (distance VE  727 NA)

    (distance PA  257 RC) (distance RC  257 PA)
    (distance PA  932 RM) (distance RM  932 PA)
    (distance PA 1596 TO) (distance TO 1596 PA)
    (distance PA 1431 VE) (distance VE 1431 PA)

    (distance RC  662 RM) (distance RM  662 RC)
    (distance RC 1312 TO) (distance TO 1312 RC)
    (distance RC 1171 VE) (distance VE 1171 RC)

    (distance RM  669 TO) (distance TO  669 RM)
    (distance RM  527 VE) (distance VE  527 RM)

    (distance TO  405 VE) (distance VE  405 TO)
)


(deffacts MAIN::goal
    (goal TO 0 B 0 A)
    (goal MI 0 C 0 A)
    (goal VE 0 C 0 B)
    (goal GE 0 C 0 B)
    (goal BO 0 B 0 C)
    (goal RM 0 A 0 C)
    (goal NA 0 B 0 C)
    (goal BA 0 A 0 B)
    (goal RC 0 A 0 B)
    (goal PA 0 A 0 C)
)
