%Punto 1: Destinos
destinos(dodain,pehuenia).
destinos(dodain,sanMartinAndes).
destinos(dodain,esquel).
destinos(dodain,sarmiento).
destinos(dodain,camarones).
destinos(dodain,playasDoradas).

destinos(alf,bariloche).
destinos(alf,sanMartinAndes).
destinos(alf,bolson).

destinos(nico,mdq). %Mar Del Plata

destinos(vale,calafate).
destinos(vale,bolson).

destinos(martu,Destino):-
destinos(alf,Destino).

destinos(martu,Destino):-
destinos(nico,Destino).


%Punto 2:
atracciones(esquel,parqueNacional(losAlcerces)).
atracciones(esquel,excursion(trevelin)).
atracciones(esquel,excursion(trochita)).

atracciones(pehuenia,cerro(bateaMahuida,2000)).
atracciones(pehuenia,cuerpoAgua(moquehue,si,14)).
atracciones(pehuenia,cuerpoAgua(alumine,si,19)).

%playa: atracciones(Ciudad,playa(DifMareaBajayAlta)).

vacacionesCopadas(Jugador):-
destinos(Jugador,Destino),
esCopado(Destino).

%Opciones de alguna atraccion copada:
esCopado(Destino):-
atracciones(Destino,cerro(_,Altura)),
Altura>2000.

esCopado(Destino):-
atracciones(Destino,cuerpoAgua(_,si,_)).

esCopado(Destino):-
atracciones(Destino,cuerpoAgua(_,_,Temp)),
Temp>20.

esCopado(Destino):-
atracciones(Destino,playa(DifMarea)),
DifMarea<5.

esCopado(Destino):-
atracciones(Destino,excursion([Nombre])),
length(Nombre,Long),
Long>7.

esCopado(Destino):-
atracciones(Destino,parqueNacional(_)).

%Punto 3:
noSeCruzaron(Jugador1,Jugador2):-
destinos(Jugador1,_),
destinos(Jugador2,_),
%forall((destinos(Jugador1,Destino1),destinos(Jugador2,Destino2)),Destino1\=Destino2).
not((destinos(Jugador1,Destino),destinos(Jugador2,Destino))).

%Punto 4:
costoVida(sarmiento,100).
costoVida(esquel,150).
costoVida(pehuenia,180).
costoVida(sanMartinAndes,150).
costoVida(camarones,135).
costoVida(playasDoradas,170).
costoVida(bariloche,140).
costoVida(calafate,240).
costoVida(bolson,145).
costoVida(mdq,140).

destinoGasolero(Destino):- costoVida(Destino,Costo),Costo<160.
vacasGasoleras(Jugador):- destinos(Jugador,_),forall(destinos(Jugador,Destino),destinoGasolero(Destino)).

%Punto 5:
%posibilidadesItinerario(Jugador,Lista):-
%findall(Destino,destinos(Jugador,Destino),Destinos),
%permutation(Destinos, Lista).

posibilidadesItinerario(Jugador, Lista) :-
    findall(Destino,destinos(Jugador,Destino),Destinos),
    permutaciones(Destinos, Lista).

% Caso base: la permutación de una lista vacía es una lista vacía
permutaciones([], []).

% Caso recursivo: insertar cada elemento en cada posición posible
permutaciones(Destinos, [H|T]) :-
    seleccionar(H, Destinos, Resto),
    permutaciones(Resto, T).

% Regla para seleccionar un elemento de una lista
seleccionar(E, [E|Resto], Resto).
seleccionar(E, [H|T], [H|Resto]) :-
    seleccionar(E, T, Resto).




