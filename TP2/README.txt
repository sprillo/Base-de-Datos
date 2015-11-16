Ejecutar el archivo de inseriones
=================================
Desde mongo, ejecutar:
	load("p1/insertions.js")

Ejecutar cada una de las consultas No-SQL
=========================================
Copiar cada query desde el archivo queries_p1.txt, pegarla en la consola de mongo y ejecutarla.

Cargar los JSON para hacerles MapReduce
=======================================
En la consola (fuera de mongo) ejecutar:
	mongoimport --jsonArray -d test -c disposiciones < disposiciones_2012.json
	mongoimport --jsonArray -d test -c disposiciones < disposiciones_2013.json
	mongoimport --jsonArray -d test -c disposiciones < disposiciones_2014.json

Ejecutar las consultas MapReduce
================================
Desde mongo, ejecutar:
	load("p2/mapreds.js")

Luego, copiar cada query del archivo queries_p2.txt en la consola de mongo, y ejecutarla.