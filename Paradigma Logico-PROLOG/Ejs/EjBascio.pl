tieneTitulo(mateo,doctor).
tieneTitulo(tomas,abogado).
tieneTitulo(agustin,ingeniero).

manejaIdioma(mateo,ingles).
manejaIdioma(tomas,nada).
manejaIdioma(agustin,italiano).

esImpo(italiano).
esImpo(chino).

manejaIdiomaImpo(Alguien):-manejaIdioma(Alguien,ingles).
manejaIdiomaImpo(Alguien):-manejaIdioma(Alguien,Idioma), esImpo(Idioma).

fondos(mateo,100000000,bancoGalicia).
fondos(tomas,2,bancoNacion).
fondos(agustin,10000000,guardados).

esBuenIngeniero(Alguien):-
tieneTitulo(Alguien,ingeniero),
manejaIdiomaImpo(Alguien),
fondos(Alguien,Dinero,_),
Dinero>1000000.

conocimientos(platon,3,4,5).
conocimientos(dario,0,0,101).


sabeMuchaCiencia(Alguien):-conocimientos(Alguien,_,_,Ciencia),
Ciencia>100.

sabeAlgoMatematico(Alguien):-conocimientos(Alguien,Matematica,_,_),
Matematica>1.

pais(platon,grecia).
pais(dario,albania).

esGriego(Alguien):-pais(Alguien,grecia).

esDiscipulo(aristoteles,Discipulo):-sabeMuchaCiencia(Discipulo).
esDiscipulo(pitagoras,Discipulo):-sabeAlgoMatematico(Discipulo),
esGriego(Alguien).

