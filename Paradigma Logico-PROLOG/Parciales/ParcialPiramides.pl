%Punto 1:

%Nivel 1:
necesidad(respiracion,fisiologico).
necesidad(alimentacion,fisiologico).
necesidad(descanso,fisiologico).
necesidad(reproduccion,fisiologico).

%Nivel 2:
necesidad(intFisica,seguridad).
necesidad(empleo,seguridad).
necesidad(salud,seguridad).

%Nivel 3:
necesidad(amistad,social).
necesidad(afecto,social).
necesidad(intimidad,social).
necesidad(amor,social).

%Nivel 4:
necesidad(confianza,reconocimiento).
necesidad(respeto,reconocimiento).
necesidad(exito,reconocimiento).
necesidad(autoestima,reconocimiento).

%Nivel 5:
necesidad(logros,autorrealizacion).
necesidad(metas,autorrealizacion).

%Dependencias:
nivelSuperior(autorrealizacion,reconocimiento).
nivelSuperior(reconocimiento,social).
nivelSuperior(social,seguridad).
nivelSuperior(seguridad,fisiologico).

%Punto 2:
separacionNiveles(Necesidad1,Necesidad2,Cant):-
necesidad(Necesidad1,Nivel),
necesidad(Necesidad2,Nivel2),
cuantosNiveles(Nivel,Nivel2,Cant).
separacionNiveles(Necesidad1,Necesidad2,Cant):-
necesidad(Necesidad1,Nivel),
necesidad(Necesidad2,Nivel2),
cuantosNiveles(Nivel2,Nivel,Cant).

cuantosNiveles(Nivel,Nivel,0).
cuantosNiveles(Nivel,Nivel2,1):-nivelSuperior(Nivel,Nivel2).
cuantosNiveles(Nivel,Nivel2,CantF):-
nivelSuperior(Nivel,Int),
cuantosNiveles(Int,Nivel2,Cant),
CantF is Cant+1.

%Punto 3:
necesidades(carla,alimentacion).
necesidades(carla,descanso).
necesidades(carla,empleo).

necesidades(juan,afecto).
necesidades(juan,exito).

necesidades(roberto,amistad).

necesidades(manuel,intFisica).

necesidades(charly,amor).

%Punto 4:
necesidadMasJeraquica(Persona,Necesidad):-
necesidades(Persona,Necesidad),
forall((necesidades(Persona,Necesidad2),Necesidad\=Necesidad2),esSup(Necesidad,Necesidad2)).

esSup(Necesidad,Necesidad2):-
necesidad(Necesidad,Nivel),
necesidad(Necesidad2,Nivel2),
nivelSuperior(Nivel,Nivel2).

esSup(Necesidad,Necesidad2):-
necesidad(Necesidad,Nivel),
necesidad(Necesidad2,Nivel2),
not(nivelSuperior(Nivel,Nivel2)),
nivelSuperior(Nivel,Intermediario),
esSup(Intermediario,Nivel2).

%Punto 5:
pudoSatisfacerNivel(Persona,Nivel):-
necesidad(_,Nivel),
necesidades(Persona,_),
not((necesidades(Persona,Necesidad),necesidad(Necesidad,Nivel))).

%Punto 6:
teoriaMaslowPersona(Persona):-
necesidades(Persona,Necesidad1),
necesidades(Persona,Necesidad2),
Necesidad1\=Necesidad2,
necesidad(Necesidad1,Nivel1),
necesidad(Necesidad1,Nivel2),
not(Nivel1\=Nivel2).

teoriaMaslowTodos:-
forall(necesidades(Persona,_),teoriaMaslowPersona(Persona)).

teoriaMaslowMayoria:-
findall(Persona1,teoriaMaslowPersona(Persona1),ListaSi),
findall(Persona2,not(teoriaMaslowPersona(Persona2)),ListaNo),
length(ListaSi, N),
length(ListaNo, N2),
N>N2.

%Punto 7:
riqueza(Persona):- pocasCarencias(Persona).

pocasCarencias(Persona):-
findall(Carencia,carencias(Persona,Carencia),ListaCarencias),
length(ListaCarencias,N),
N<3.

persona(juan).
persona(daniela).
persona(manuela).

cosas(dinero(_)).
cosas(casa(_,_)).
cosas(amor(_)).

posesion(juan,casa(recoleta,10000)).
posesion(juan,amor(manuela)).
posesion(daniela,dinero(10000)).

carencias(Persona,Carencia):- 
persona(Persona),
cosas(Carencia),
not(posesion(Persona,Carencia)).




