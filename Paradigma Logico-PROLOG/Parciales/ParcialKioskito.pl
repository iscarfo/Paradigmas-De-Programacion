%Modelado:

trabaja(dodain,lunes,9,15).
trabaja(dodain,miercoles,9,15).
trabaja(dodain,viernes,9,15).

trabaja(lucas,martes,10,20).

trabaja(juanC,sabado,18,22).
trabaja(juanC,domingo,18,22).

trabaja(juanFdS,jueves,10,20).
trabaja(juanFdS,viernes,12,20).

trabaja(leoC,lunes,14,18).
trabaja(leoC,miercoles,14,18).

trabaja(martu,miercoles,23,24).

%Punto 1:
trabaja(vale, Dia, HoraInicio, HoraFin) :- trabaja(dodain, Dia, HoraInicio, HoraFin).

trabaja(vale, Dia, HoraInicio, HoraFin) :- trabaja(juanC, Dia, HoraInicio, HoraFin).

%Punto 2:
quienAtiendeKiosko(Persona,Dia,Hora):-
trabaja(Persona,Dia,HoraInicio,HoraFin),
between(HoraInicio, HoraFin, Hora).

%Punto 3:
foreverAlone(Persona,Dia,Hora):-
quienAtiendeKiosko(Persona,Dia,Hora),
not((quienAtiendeKiosko(OtraPersona,Dia,Hora),OtraPersona\=Persona)).

/* o tambien: 
foreverAlone(Persona,Dia,Hora):-
quienAtiendeKiosko(Persona,Dia,Hora),
forall((trabaja(OtraPersona,_,_,_),OtraPersona\=Persona),not(quienAtiendeKiosko(OtraPersona,Dia,Hora))). */

%Punto 4:
atiendenUnDia(Dia,Opciones):-
    findall(Persona,quienAtiendeKiosko(Persona,Dia,_),PersonasPosibles),
    list_to_set(PersonasPosibles,Personas),
    sublistas(Personas,Opciones).

sublistas([],[]).
sublistas([_|Posibles],Personas):-
    sublistas(Posibles,Personas).
sublistas([Posible|Posibles],[Posible|Personas]):-
    sublistas(Posibles,Personas).


%Punto 5:
ventas(dodain,fecha(10,8),[golosinas(1200),cigarrillos([jockey]),golosinas(50)]).

ventas(lucas,fecha(11,8),[golosinas(600)]).

ventas(dodain,fecha(12,8),[bebidas(si,8),bebidas(no,1),golosinas(10)]).

ventas(martu,fecha(12,8),[golosinas(1000),cigarrillos([chesterfield,parissiene,colorado])]).

ventas(lucas,fecha(18,8),[bebidas(no,2),cigarrillos([derby])]).

esSuertudo(Persona):-
ventas(Persona,_,_),
forall(ventas(Persona,_,[Venta|_]),esImpo(Venta)).

esImpo(golosinas(Precio)):- Precio>100.

esImpo(cigarrillos([Marcas])):-length(Marcas, Cantidad), Cantidad > 2.

esImpo(bebidas(si,_)).

esImpo(bebidas(_,Cant)):- Cant>5.








