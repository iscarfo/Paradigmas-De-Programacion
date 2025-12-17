%apareceEn( Personaje, Episodio, Lado de la luz).
apareceEn( luke, unaNuevaEsperanza, luminoso).
apareceEn( luke, elImperioContrataca, luminoso).
apareceEn( vader, unaNuevaEsperanza, oscuro).
apareceEn( vader, laVenganzaDeLosSith, luminoso).
apareceEn( vader, laAmenazaFantasma, luminoso).
apareceEn( c3po, laAmenazaFantasma, luminoso).
apareceEn( c3po, unaNuevaEsperanza, luminoso).
apareceEn( c3po, elImperioContrataca, luminoso).
apareceEn( chewbacca, elImperioContrataca, luminoso).
apareceEn( yoda, elAtaqueDeLosClones, luminoso).
apareceEn( yoda, laAmenazaFantasma, luminoso).

%Maestro(Personaje)
maestro(luke).
maestro(leia).
maestro(vader).
maestro(yoda).
maestro(rey).
maestro(duku).

%caracterizacion(Personaje,Aspecto).
%aspectos:
% ser(Especie,Tamaño)
% humano
% robot(Forma)
caracterizacion(chewbacca,ser(wookiee,10)).
caracterizacion(luke,humano).
caracterizacion(vader,humano).
caracterizacion(yoda,ser(desconocido,5)).
caracterizacion(jabba,ser(hutt,20)).
caracterizacion(c3po,robot(humanoide)).
caracterizacion(bb8,robot(esfera)).
caracterizacion(r2d2,robot(secarropas)).

%elementosPresentes(Episodio, Dispositivos)
elementosPresentes(laAmenazaFantasma, [sableLaser]).
elementosPresentes(elAtaqueDeLosClones, [sableLaser, clon]).
elementosPresentes(laVenganzaDeLosSith, [sableLaser, mascara, estrellaMuerte]).
elementosPresentes(unaNuevaEsperanza, [estrellaMuerte, sableLaser, halconMilenario]).
elementosPresentes(elImperioContrataca, [mapaEstelar, estrellaMuerte] ).

%precede(EpisodioAnterior,EpisodioSiguiente)
precedeA(laAmenazaFantasma,elAtaqueDeLosClones).
precedeA(elAtaqueDeLosClones,laVenganzaDeLosSith).
precedeA(laVenganzaDeLosSith,unaNuevaEsperanza).
precedeA(unaNuevaEsperanza,elImperioContrataca).

nuevoEpisodio(Heroe, Villano, Extra, Dispositivo):-
todosAparecen(Heroe,Villano,Extra),
esJedi(Heroe),
villanoAmbiguo(Villano),
esExotico(Extra),
vinculoEstrecho(Extra,Villano,Heroe),
esReconocible(Dispositivo).

todosAparecen(Heroe,Villano,Extra):-
apareceEn(Heroe,_,_),
apareceEn(Villano,_,_),
Heroe\=Villano,
apareceEn(Extra,_,_),
Extra\=Heroe, Extra\=Villano.

esJedi(Heroe):-
apareceEn(Heroe,_,luminoso),
not(apareceEn(Heroe,_,oscuro)).

villanoAmbiguo(Villano):-
apareceEn(Villano,Epi1,_),
apareceEn(Villano,Epi2,_),
Epi1\=Epi2,
apareceEn(Villano,Episodio,luminoso),
apareceEn(Villano,Episodio2,oscuro),
esMismoODespues(Episodio,Episodio2).

esMismoODespues(Epi1,Epi1).
esMismoODespues(Epi1,Epi2):-precedeA(Epi1,Epi2).
esMismoODespues(Epi1,Epi2):-precedeA(Epi1,Int),esMismoODespues(Int,Epi2).

esExotico(Extra):-
caracterizacion(Extra,_),
not(caracterizacion(Extra,robot(esfera))).

esExotico(Extra):-
caracterizacion(Extra,ser(_,Tam)),
Tam>15.

esExotico(Extra):-
caracterizacion(Extra,ser(desconocido,_)).

vinculoEstrecho(Extra,Heroe,_):-
apareceEn(Extra,_,_),
apareceEn(Heroe,_,_),
Extra\=Heroe,
forall(apareceEn(Extra,Epi,_),apareceEn(Heroe,Epi,_)).

vinculoEstrecho(Extra,_,Villano):-
apareceEn(Extra,_,_),
apareceEn(Villano,_,_),
Extra\=Villano,
forall(apareceEn(Extra,Epi,_),apareceEn(Villano,Epi,_)).

esReconocible(Dispositivo):-
findall(Ep, (elementosPresentes(Ep,ListaElementos), member(Dispositivo,ListaElementos)), Episodios),
list_to_set(Episodios, EpisodiosUnicos),
length(EpisodiosUnicos, N),
N >= 3.

esReconocible(Dispositivo):-
findall(Episodio,(elementosPresentes(Episodio,ListaElementos),member(Dispositivo,ListaElementos)),Episodios),
length(Episodios,N),N>=3.



