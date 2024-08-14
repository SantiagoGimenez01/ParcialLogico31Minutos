% Cancion, Compositores, Reproducciones
cancion(bailanSinCesar, [pabloIlabaca, rodrigoSalinas], 10600177).
cancion(yoOpino, [alvaroDiaz, carlosEspinoza, rodrigoSalinas], 5209110).
cancion(equilibrioEspiritual, [danielCastro, alvaroDiaz, pabloIlabaca, pedroPeirano, rodrigoSalinas], 12052254).
cancion(tangananicaTanganana, [danielCastro, pabloIlabaca, pedroPeirano], 5516191).
cancion(dienteBlanco, [danielCastro, pabloIlabaca, pedroPeirano], 5872927).
cancion(lala, [pabloIlabaca, pedroPeirano], 5100530).
cancion(meCortaronMalElPelo, [danielCastro, alvaroDiaz, pabloIlabaca, rodrigoSalinas], 3428854).

% Mes, Puesto, Cancion
rankingTop3(febrero, 1, lala).
rankingTop3(febrero, 2, tangananicaTanganana).
rankingTop3(febrero, 3, meCortaronMalElPelo).
rankingTop3(marzo, 1, meCortaronMalElPelo).
rankingTop3(marzo, 2, tangananicaTanganana).
rankingTop3(marzo, 3, lala).
rankingTop3(abril, 1, tangananicaTanganana).
rankingTop3(abril, 2, dienteBlanco).
rankingTop3(abril, 3, equilibrioEspiritual).
rankingTop3(mayo, 1, meCortaronMalElPelo).
rankingTop3(mayo, 2, dienteBlanco).
rankingTop3(mayo, 3, equilibrioEspiritual).
rankingTop3(junio, 1, dienteBlanco).
rankingTop3(junio, 2, tangananicaTanganana).
rankingTop3(junio, 3, lala).

% Punto 1
% Saber si una canción es un hit, lo cual ocurre si aparece en el ranking top 3 de todos los meses.
% Ejemplo: No hay ningún hit actualmente. Por ejemplo, a Tangananica Tanganana le falta estar en mayo y a Lala le falta abril y mayo.
esUnHit(Cancion):-
    cancion(Cancion, _, _),
    apareceTodosLosMeses(Cancion).
apareceTodosLosMeses(Cancion):-
    forall(rankingTop3(Mes, _, _), rankingTop3(Mes, _, Cancion)).

% Punto 2
% Saber si una canción no es reconocida por los críticos, lo cual ocurre si tiene muchas reproducciones y nunca estuvo en el ranking. 
% Una canción tiene muchas reproducciones si tiene más de 7000000 reproducciones
tieneMuchasReproducciones(Cancion):-
    cancion(Cancion, _, Reproducciones),
    Reproducciones > 7000000.
noEsReconocidaPorCriticos(Cancion):-
    tieneMuchasReproducciones(Cancion),
    not(rankingTop3(_, _, Cancion)).

% Punto 3
% Saber si dos compositores son colaboradores, lo cual ocurre si compusieron alguna canción juntos.
sonColaboradores(UnCompositor, OtroCompositor):-
    cancion(_, Compositores, _),
    member(UnCompositor, Compositores),
    member(OtroCompositor, Compositores),
    UnCompositor \= OtroCompositor.

% En el noticiero 31 Minutos cada trabajador puede tener múltiples trabajos. Algunos de los tipos de trabajos que existen son:
% ● Los conductores, de los cuales nos interesa sus años de experiencia.
% ● Los periodistas, de los cuales nos interesa sus años de experiencia y su título, el cual puede ser licenciatura o posgrado.
% ● Los reporteros, de los cuales nos interesa sus años de experiencia y la cantidad de notas que hicieron a lo largo de su carrera.

% conductor(Experiencia)
% periodista(Experiencia, Titulo),
% reportero(Experiencia, Notas).

% Punto 4
% Modelar en la solución a los siguientes trabajadores:
% a. Tulio, conductor con 5 años de experiencia.
% b. Bodoque, periodista con 2 años de experiencia con un título de licenciatura, y también reportero con 5 años de experiencia y 300 notas realizadas.
% c. Mario Hugo, periodista con 10 años de experiencia con un posgrado.
% d. Juanin, que es un conductor que recién empieza así que no tiene años de experiencia.

% esTrabajador(Nombre, Profesion)
esTrabajador(tulio, conductor(5)).
esTrabajador(bodoque, periodista(2, licenciatura)).
esTrabajador(bodoque, reportero(5, 300)).
esTrabajador(marioHugo, periodista(10, posgrado)).
esTrabajador(juanin, conductor(0)).

% Punto 5
% Conocer el sueldo total de una persona, el cual está dado por la suma de los sueldos de cada uno de sus trabajos. 
% El sueldo de cada trabajo se calcula de la siguiente forma:
% a. El sueldo de un conductor es de 10000 por cada año de experiencia
% b. El sueldo de un reportero también es 10000 por cada año de experiencia más 100 por cada nota que haya hecho en su carrera.
% c. Los periodistas, por cada año de experiencia reciben 5000, pero se les aplica un porcentaje de incremento del 20% cuando tienen una licenciatura o 
% del 35% si tienen un posgrado.

sueldoTrabajador(Persona, SueldoTotal):-
    esTrabajador(Persona, _),
    findall(Sueldo, (esTrabajador(Persona, Trabajo), sueldoPorTrabajo(Trabajo, Sueldo)), Sueldos),
    sumlist(Sueldos, SueldoTotal).
        
sueldoPorTrabajo(conductor(Experiencia), Sueldo):-
    Sueldo is (Experiencia * 10000).
sueldoPorTrabajo(reportero(Experiencia, Notas), Sueldo):-
    Sueldo is (Experiencia * 10000 + Notas * 100).
sueldoPorTrabajo(periodista(Experiencia, licenciatura), Sueldo):-
    Sueldo is (Experiencia * 5000 * 1.2).
sueldoPorTrabajo(periodista(Experiencia, posgrado), Sueldo):-
    Sueldo is (Experiencia * 5000 * 1.35).

% Punto 6
% Agregar un nuevo trabajador que tenga otro tipo de trabajo nuevo distinto a los anteriores. Agregar una forma de calcular el sueldo para el nuevo 
% trabajo agregado
% camarografo(Experiencia, NotasFilmadas) -> El sueldo se calcula multiplicando los años de experiencia por las notasFilmadas y sumando 10000 a ese monto
esTrabajador(santiago, camarografo(8, 350)).
sueldoPorTrabajo(camarografo(Experiencia, Filmaciones), Sueldo):-
    Sueldo is Experiencia * Filmaciones + 10000.

% ¿Qué concepto de la materia se puede relacionar a esto?

% Puedo relacionarlo con el concepto de escalabilidad, el cual permite que el codigo pueda escalar, es decir se puedan agregar cosas sin tener que
% cambiar muchas cosas, manteniendo las funciones creadas previamente, a mayor escalabilidad mas facil va a ser agregar informacion sin tener que cambiar
% cosas hechas antes de los agregados