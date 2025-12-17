% Continentes
pais(alaska, america_del_norte).
pais(yukon, america_del_norte).
pais(territorio_del_noroeste, america_del_norte).
pais(groenlandia, america_del_norte).
pais(alberta, america_del_norte).
pais(ontario, america_del_norte).
pais(quebec, america_del_norte).
pais(nueva_york, america_del_norte).
pais(estados_unidos, america_del_norte).
pais(california, america_del_norte).
pais(mexico, america_del_norte).

pais(venezuela, america_del_sur).
pais(peru, america_del_sur).
pais(brasil, america_del_sur).
pais(argentina, america_del_sur).

pais(islandia, europa).
pais(escandinavia, europa).
pais(gran_bretana, europa).
pais(europa_del_norte, europa).
pais(europa_occidental, europa).
pais(europa_del_este, europa).

pais(africa_del_norte, africa).
pais(egipto, africa).
pais(africa_central, africa).
pais(africa_del_sur, africa).
pais(madagascar, africa).

pais(rusia, asia).
pais(oriente_medio, asia).
pais(afganistan, asia).
pais(india, asia).
pais(china, asia).
pais(mongolia, asia).
pais(siberia, asia).
pais(kamchatka, asia).
pais(japon, asia).
pais(sudeste_asiatico, asia).

pais(indonesia, oceania).
pais(nueva_guinea, oceania).
pais(australia, oceania).

% Conexiones
limita(alaska, yukon).
limita(alaska, kamchatka).
limita(alaska, territorio_del_noroeste).

limita(yukon, territorio_del_noroeste).
limita(yukon, alberta).

limita(territorio_del_noroeste, alberta).
limita(territorio_del_noroeste, groenlandia).

limita(groenlandia, quebec).
limita(groenlandia, islandia).

limita(alberta, ontario).
limita(alberta, estados_unidos).

limita(ontario, quebec).
limita(ontario, estados_unidos).
limita(ontario, nueva_york).

limita(quebec, nueva_york).

limita(nueva_york, estados_unidos).
limita(nueva_york, california).

limita(estados_unidos, california).
limita(estados_unidos, mexico).

limita(california, mexico).

limita(mexico, venezuela).

limita(venezuela, brasil).
limita(venezuela, peru).

limita(peru, brasil).
limita(peru, argentina).

limita(brasil, argentina).
limita(brasil, africa_del_norte).

limita(islandia, escandinavia).
limita(islandia, gran_bretana).

limita(escandinavia, gran_bretana).
limita(escandinavia, rusia).
limita(escandinavia, europa_del_norte).

limita(gran_bretana, europa_del_norte).
limita(gran_bretana, europa_occidental).

limita(europa_del_norte, europa_occidental).
limita(europa_del_norte, europa_del_este).

limita(europa_occidental, europa_del_este).
limita(europa_occidental, africa_del_norte).

limita(europa_del_este, rusia).
limita(europa_del_este, oriente_medio).

limita(africa_del_norte, egipto).
limita(africa_del_norte, africa_central).

limita(egipto, africa_central).
limita(egipto, oriente_medio).

limita(africa_central, africa_del_sur).

limita(africa_del_sur, madagascar).

limita(rusia, afganistan).
limita(rusia, china).
limita(rusia, mongolia).
limita(rusia, siberia).

limita(oriente_medio, afganistan).
limita(oriente_medio, india).

limita(afganistan, india).
limita(afganistan, china).

limita(india, china).
limita(india, sudeste_asiatico).

limita(china, mongolia).
limita(china, siberia).
limita(china, japon).
limita(china, sudeste_asiatico).

limita(mongolia, siberia).
limita(mongolia, japon).

limita(siberia, kamchatka).

limita(kamchatka, japon).

limita(sudeste_asiatico, indonesia).

limita(indonesia, nueva_guinea).
limita(indonesia, australia).

limita(nueva_guinea, australia).

% Lista de ocupaciÃ³n aleatoria

ocupa(rojo, alaska, 2).
ocupa(azul, yukon, 1).
ocupa(verde, territorio_del_noroeste, 3).
ocupa(amarillo, groenlandia, 1).
ocupa(negro, alberta, 2).
ocupa(blanco, ontario, 1).
ocupa(rojo, quebec, 3).
ocupa(azul, nueva_york, 2).
ocupa(verde, estados_unidos, 1).
ocupa(amarillo, california, 2).
ocupa(negro, mexico, 3).

ocupa(blanco, venezuela, 1).
ocupa(rojo, peru, 2).
ocupa(azul, brasil, 3).
ocupa(verde, argentina, 1).

ocupa(amarillo, islandia, 2).
ocupa(negro, escandinavia, 1).
ocupa(blanco, gran_bretana, 3).
ocupa(rojo, europa_del_norte, 2).
ocupa(azul, europa_occidental, 1).
ocupa(verde, europa_del_este, 3).

ocupa(amarillo, africa_del_norte, 2).
ocupa(negro, egipto, 1).
ocupa(blanco, africa_central, 3).
ocupa(rojo, africa_del_sur, 2).
ocupa(azul, madagascar, 1).

ocupa(verde, rusia, 3).
ocupa(amarillo, oriente_medio, 2).
ocupa(negro, afganistan, 1).
ocupa(blanco, india, 3).
ocupa(rojo, china, 2).
ocupa(azul, mongolia, 1).
ocupa(verde, siberia, 2).
ocupa(amarillo, kamchatka, 3).
ocupa(negro, japon, 1).
ocupa(blanco, sudeste_asiatico, 2).

ocupa(rojo, indonesia, 3).
ocupa(azul, nueva_guinea, 1).
ocupa(verde, australia, 2).

%Hacer los limites simetricos:
sonLimitrofes(P1,P2) :- limita(P1,P2).
sonLimitrofes(P1,P2) :- limita(P2,P1).

%Encontrar los paises limitrofes de otro continente:
limitrofesOtroContinente(P1,P2) :-
pais(P1,C1),
pais(P2,C2),
C1\=C2,
sonLimitrofes(P1,P2).


%Predicado que me diga los enemigos de un país, es decir sus limítrofes que no tengan el mismo color.
enemigos(P1,OtroP) :-
sonLimitrofes(P1,OtroP),
ocupa(C1,P1,_),
ocupa(C2,OtroP,_),
C1\=C2.

%Predicado complicado/1 verifica si un país está "complicado", es decir, si tiene dos países limítrofes 
%del mismo color y la suma de los ejércitos de ambos países es al menos 5.
complicado(P1) :-
sonLimitrofes(P1,OtroP),
sonLimitrofes(P1,OtroP2),
OtroP \= OtroP2, %IMPO buscar dos paises diferentes
ocupa(_,OtroP,Num1),
ocupa(_,OtroP2,Num2),
Num1+Num2>=5.

%Predicado puede_atacar/1 que determine si un país tiene más ejércitos que uno de sus países limítrofes 
%que sea de otro color.
puede_atacar(P1) :-
sonLimitrofes(P1,OtroP),
ocupa(C1,P1,Num1),
ocupa(C2,OtroP,Num2),
C1\=C2,
Num1>Num2.

%Un ejercito esFuerte/1 si ninguno de sus países está complicado.
esFuerte(Color) :-
ocupa(Color,_,_), %Para que sea ttmente inversible
not((ocupa(Color, Pais, _), complicado(Pais))).

%Otra opcion:
esFuerte(Color):-
ocupa(Color,_,_),
forall(ocupa(Color,Pais,_),not(complicado(Pais))).

%destruir ejercito amarillo

destruir(amarillo) :- forall(ocupa(C,_,_), C \= amarillo).

%conquistar asia

conquistarCont(C,Cont) :- ocupa(C,_,_),pais(_,Cont),forall(ocupa(C,P,_),pais(P,Cont)).

conquistarAsia(C) :- conquistarCont(C,asia).

%conquistar america del sur y africa

conquistarAyA(C) :- conquistarCont(C,america_del_sur),conquistarCont(C,africa).

%conquistar europa y dos paises de oceania

conquista2PaisesOceania(C):-ocupa(C,P1,_),ocupa(C,P2,_),P1\=P2,pais(P1,oceania),pais(P2,oceania).

conquistarEyO(C) :- conquistarCont(C,europa),conquista2PaisesOceania(C).

%Inventado
continenteLider(Continente):- pais(_,Continente),forall(pais(P,Continente),(ocupa(_,P,Poder),Poder >=3)).
