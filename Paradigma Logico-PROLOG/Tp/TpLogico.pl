%Punto 1:
%Jugadores
jugador(ana).
jugador(beto).
jugador(carola).
jugador(dimitri).

%civilizaciones:
civilizacion(ana,romanos).
civilizacion(beto,incas).
civilizacion(carola,romanos).
civilizacion(dimitri,romanos).

%tecnologias: 
tecnoJugador(ana,herreria).
tecnoJugador(ana,forja).
tecnoJugador(ana,laminas).
tecnoJugador(ana,emplumado).
tecnoJugador(beto,herreria).
tecnoJugador(beto,forja).
tecnoJugador(beto,fundicion).
tecnoJugador(carola,herreria).
tecnoJugador(dimitri,herreria).
tecnoJugador(dimitri,fundicion).

%Punto 2:
expertoEnMetales(Jugador):-
    tecnoJugador(Jugador,herreria),
    tecnoJugador(Jugador,forja),
    tecnoJugador(Jugador,fundicion).

expertoEnMetales(Jugador):-
    tecnoJugador(Jugador,herreria),
    tecnoJugador(Jugador,forja),
    civilizacion(Jugador,romanos).

%Punto 3:
civilizacionPopular(Civilizacion):-
    civilizacion(Jugador,Civilizacion),
    civilizacion(Jugador2,Civilizacion),
    Jugador\=Jugador2.

%Punto 4:
alcanceGlobal(Tecnologia):-
tecnoJugador(_,Tecnologia),
not((tecnoJugador(Jugador,_),not(tecnoJugador(Jugador,Tecnologia)))).

%Punto 5:
esLider(Civilizacion):-
civilizacion(_,Civilizacion),
forall((tecnoJugador(_,Tecnologia),civilizacion(_,Civilizacion2),Civilizacion\=Civilizacion2),(tecnoJugador(Jugador,Tecnologia),civilizacion(Jugador,Civilizacion))).

%Punto 6:
unidades(ana,jinete(caballo)).
unidades(ana,piquero(con_escudo,1)).
unidades(ana,piquero(sin_escudo,2)).

unidades(beto,campeon(100)).
unidades(beto,campeon(80)).
unidades(beto,piquero(con_escudo,1)).
unidades(beto,jinete(camello)).

unidades(carola,piquero(sin_escudo,3)).
unidades(carola,piquero(con_escudo,2)).

%Punto 7:
vidaUnidad(jinete(camello),80).
vidaUnidad(jinete(caballo),90).
vidaUnidad(campeon(Vida),Vida).
vidaUnidad(piquero(sin_escudo,1),50).
vidaUnidad(piquero(sin_escudo,2),65).
vidaUnidad(piquero(sin_escudo,3),70).

vidaUnidad(piquero(con_escudo,Nivel),Vida):-
vidaUnidad(piquero(sin_escudo,Nivel),Vida2),
Vida is Vida2 * 1.1.

unidadConMasVida(Jugador,Unidad):-
unidades(Jugador,Unidad),
vidaUnidad(Unidad,V1),
forall((unidades(Jugador,Unidad2),Unidad2\=Unidad,vidaUnidad(Unidad2,V2)),V1>V2).

%Punto 8:
tieneVentaja(jinete(_),campeon(_)).
tieneVentaja(campeon(_),piquero(_,_)).
tieneVentaja(piquero(_,_),jinete(_)).
tieneVentaja(jinete(camello),jinete(caballo)).

leGana(Unidad1,Unidad2):-
tieneVentaja(Unidad1,Unidad2).

leGana(Unidad1,Unidad2):-
unidades(_,Unidad1),
unidades(_,Unidad2),
not(tieneVentaja(Unidad2,Unidad1)),
tieneMasVida(Unidad1,Unidad2).

tieneMasVida(Unidad1,Unidad2):-
vidaUnidad(Unidad1,V1),
vidaUnidad(Unidad2,V2),
V1>V2.

%Punto 9:
listaPiquero(Jugador,Unidad,Cantidad):-
findall(_,unidades(Jugador,Unidad),Lista),
length(Lista, Cantidad).
    
sobreviveAsedio(Jugador):-
unidades(Jugador,_),
listaPiquero(Jugador,piquero(con_escudo,_),CantCon),
listaPiquero(Jugador,piquero(sin_escudo,_),CantSin),
CantCon>CantSin.

%Punto 10:
dependencia(emplumado,herreria).
dependencia(punzon,emplumado).
dependencia(forja,herreria).
dependencia(fundicion,forja).
dependencia(horno,fundicion).
dependencia(laminas,herreria).
dependencia(malla,laminas).
dependencia(placas,malla).

dependencia(collera,molino).
dependencia(arado,collera).

puedeDesarrollar(Jugador,Tecnologia):-
unidades(Jugador,_),
tecnoJugador(_,Tecnologia),
not(tecnoJugador(Jugador,Tecnologia)),
alcanzable(Jugador,Tecnologia).

alcanzable(_,Tecnologia):-
not(dependencia(Tecnologia,_)).

alcanzable(Jugador,Tecnologia):-
dependencia(Tecnologia,Dependencia),
tecnoJugador(Jugador,Dependencia).

alcanzable(Jugador,Tecnologia):-
dependencia(Tecnologia,Dependencia),
alcanzable(Jugador,Dependencia).

%Punto 11:
orden_valido(Jugador, Orden) :-
findall(Tecnologia, tecnoJugador(Jugador, Tecnologia), Tecnologias),
orden_valido_aux(Jugador, Tecnologias, [], Orden).

% Caso base: cuando no quedan tecnologías por procesar, el orden generado es el orden final.
orden_valido_aux(_, [], Orden, Orden).

% Caso recursivo: seleccionamos una tecnología cuya dependencia ya haya sido procesada y la añadimos al orden.
orden_valido_aux(Jugador, Tecnologias, Parcial, Orden) :-
    select(Tecnologia, Tecnologias, RestoTecnologias),
    (not(dependencia(Tecnologia, _)); % Si la tecnología no depende de ninguna otra
     (dependencia(Tecnologia, Dependencia), member(Dependencia, Parcial))), % O si su dependencia ya está en el orden parcial
    orden_valido_aux(Jugador, RestoTecnologias, [Tecnologia | Parcial], Orden).



