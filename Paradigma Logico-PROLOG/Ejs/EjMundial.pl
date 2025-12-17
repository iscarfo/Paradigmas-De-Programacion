%Punto 1:
accion(dibu,atajadaPartido(122)).
accion(dibu,atajadaPenal(2)).
accion(messi,golPartido(108)).
accion(messi,golPartido(23)).
accion(messi,golPenales(1)).
accion(montiel,golPenales(5)).

%Punto 2:
sumaPuntos(atajadaPenal(Min),Puntaje):- Puntaje is 15*Min.
sumaPuntos(atajadaPartido(Min),Puntaje):- Puntaje is Min+10.
sumaPuntos(golPartido(Min),Puntaje):- Puntaje is Min+20.
sumaPuntos(golPenales(1),45).
sumaPuntos(golPenales(5),80).

calcularPuntaje(Jugador,Puntaje):-
accion(Jugador,Accion),
sumaPuntos(Accion,Puntaje).

cuantosPuntosSuma(Jugador,Cant):-
accion(Jugador,_),
findall(Puntaje,calcularPuntaje(Jugador,Puntaje),ListaPuntos),
sum_list(ListaPuntos, Cant).

%Punto 3:
puntosTotales(Jugadores, Puntos):- 
findall(Puntos, (member(Jugador, Jugadores), cuantosPuntosSuma(Jugador, Puntos)), Puntajes),
sum_list(Puntajes, Puntos).

