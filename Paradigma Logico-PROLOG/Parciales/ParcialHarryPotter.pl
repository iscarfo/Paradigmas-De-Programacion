%Parte 1:
sangre(harry,mestiza).
sangre(draco,pura).
sangre(hermione,impura).

cualidades(harry,corajudo).
cualidades(harry,amistoso).
cualidades(harry,orgulloso).
cualidades(harry,inteligente).
cualidades(draco,inteligente).
cualidades(draco,orgulloso).
cualidades(hermione,inteligente).
cualidades(hermione,orgulloso).
cualidades(hermione,responsable).

odiaria(harry,slytherin).
odiaria(draco,hufflepuff).

caracteristicasSombrero(gryffindor,corajudo).
caracteristicasSombrero(slytherin,orgulloso).
caracteristicasSombrero(slytherin,inteligente).
caracteristicasSombrero(ravenclaw,inteligencia).
caracteristicasSombrero(ravenclaw,responsable).
caracteristicasSombrero(hufflepuff,amistoso).

%1:
permiteEntrarMago(Casa,_):-Casa\=slytherin.
permiteEntrarMago(slytherin,Mago):-sangre(Mago,Tipo),Tipo\=impura.

%2
tieneElCaracter(Mago,Casa):-
sangre(Mago,_),
caracteristicasSombrero(Casa,_),
forall(caracteristicasSombrero(Casa,Caract),cualidades(Mago,Caract)).

%3
podriaQuedar(Mago,Casa):-
permiteEntrarMago(Casa,Mago),
tieneElCaracter(Mago,Casa),
not(odiaria(Mago,Casa)).

podriaQuedar(hermione,gryffindor).

%4
cadenaAmistades(ListaMagos):-
forall(member(Mago,ListaMagos),cualidades(Mago,amistoso)),
estariaEnLaCasa(ListaMagos).

estariaEnLaCasa([]).
estariaEnLaCasa([_]).
estariaEnLaCasa([Mago1,Mago2|Resto]):-
podriaQuedar(Mago1,Casa),
podriaQuedar(Mago2,Casa),
estariaEnLaCasa([Mago2|Resto]).

%Parte 2:
malasAciones(fueraDeCama(_)).
malasAcciones(lugarProhibido(_)).

acciones(harry,fueraDeCama,-50).
acciones(hermione,lugarProhibido(tercerPiso),-75).
acciones(hermione,lugarProhibido(biblioteca),-10).
acciones(harry,lugarProhibido(bosque),-50).
acciones(harry,lugarProhibido(tercerPiso),-75).
acciones(ron,ajedrezMagico,50).
acciones(hermione,salvarAmigos,50).
acciones(harry,ganarVoldemort,60).



esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

%1a
esBuenAlumno(Mago):-
acciones(Mago,_,_),
not((acciones(Mago,Accion,_),malasAcciones(Accion))).

%1b
esRecurrente(Accion):-
acciones(Mago1,Accion,_),
acciones(Mago2,Accion,_),
Mago1\=Mago2.

%2
puntajeTotal(Casa,Puntaje):-
esDe(_,Casa),
findall(Puntos,(esDe(Mago,Casa),acciones(Mago,_,Puntos)),ListaMagos),
sum_list(ListaMagos,Puntaje).


%3 (no se si falta inversibilidad)
casaGanadora(Casa):-
puntajeTotal(Casa,Puntaje),
forall((puntajeTotal(Casa2,Puntaje2),Casa\=Casa2),Puntaje>Puntaje2).

%4
acciones(_,preguntasClase(_,Dificultad,Profe),Puntos):-
Profe\=snape,
Puntos is Dificultad.

acciones(_,preguntasClase(_,Dificultad,snape),Puntos):-
Puntos is Dificultad/2.





