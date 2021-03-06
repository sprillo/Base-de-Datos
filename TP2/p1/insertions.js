/*
------------------------------- EMPLEADOS --------------------------------
empleados : {
	nro_legajo : INTEGER
	nombre : STRING
	clientes_atendidos : [{dni : STRING, edad : INTEGER, fecha : DATETIME}]
	sectores_donde_trabaja : [{cod_sector : INTEGER, id_tarea : INTEGER}]
}
*/

db.empleados.insert({
	nro_legajo : 1,
	nombre : "empleado1",
	clientes_atendidos : [	{dni : "11111111", edad : 18, fecha : "01/01/2015"},
							{dni : "22222222", edad : 17, fecha : "01/02/2015"}],
	sectores_donde_trabaja : [{cod_sector : 1, id_tarea : 1} , 	{cod_sector : 2, cod_tarea : 1}]
})

db.empleados.insert({
	nro_legajo : 2,
	nombre : "empleado2",
	clientes_atendidos : [ {dni : "22222222", edad : 17, fecha : "02/02/2015"} ],
	sectores_donde_trabaja : [{cod_sector : 1, id_tarea : 1}, 	{cod_sector : 2, cod_tarea : 1}]
})

db.empleados.insert({
	nro_legajo : 3,
	nombre : "empleado3",
	clientes_atendidos : [{dni : "33333333", edad : 19, fecha : "01/03/2015"}],
	sectores_donde_trabaja : [{cod_sector : 1, id_tarea : 1}, 	{cod_sector : 2, cod_tarea : 1}]
})

db.empleados.insert({
	nro_legajo : 4,
	nombre : "empleado4",
	clientes_atendidos : [],
	sectores_donde_trabaja : [{cod_sector : 1, id_tarea : 1}]
})

/*
------------------------------- ARTICULOS --------------------------------
articulos{
	codigo : STRING
	nombre : STRING
	ventas : [{dni : STRING}]
}
*/

db.articulos.insert({
	codigo : "1",
	nombre : "articulo1",
	ventas : [{dni :	 "11111111"}, {dni : "22222222"}]
})

db.articulos.insert({
	codigo : "2",
	nombre : "articulo2",
	ventas : [{dni : "11111111"}, {dni : "33333333"}]
})

db.articulos.insert({
	codigo : "3",
	nombre : "articulo3",
	ventas : [{dni : "33333333"}]
})

/*
------------------------------- SECTORES --------------------------------
sectores{
	cod_sector : INTEGER
	articulos : [{codigo : STRING}]
	trabaja : [{nro_legajo : INTEGER, id_tarea : INTEGER}]
}
*/

db.sectores.insert({
	cod_sector : 1,
	articulos : [{codigo : "1"}],
	trabaja : [	{nro_legajo : 1, id_tarea : 1},
				{nro_legajo : 2, id_tarea : 1},
				{nro_legajo : 3, id_tarea : 1},
				{nro_legajo : 4, id_tarea : 1}]
})

db.sectores.insert({
	cod_sector : 2,
	articulos : [{codigo : "2"}],
	trabaja : [	{nro_legajo : 1, id_tarea : 1},
				{nro_legajo : 2, id_tarea : 1},
				{nro_legajo : 3, id_tarea : 1}]
})

/*
------------------------------- CLIENTES --------------------------------
clientes{
	dni : STRING
	nombre : STRING,
	edad : INTEGER,
	atendido_por : [{nro_legajo : INTEGER, fecha : DATETIME}],
	compro_articulos : [{codigo : INTEGER}]
}
*/

db.clientes.insert({
	dni : "11111111",
	nombre : "cliente1",
	edad : 18,
	atendido_por : [{nro_legajo : 1, fecha : "01/01/2015"}],
	compro_articulos : [{codigo : "1"} , {codigo : "2"}]
})

db.clientes.insert({
	dni : "22222222",
	nombre : "cliente2",
	edad : 17,
	atendido_por : [{nro_legajo : 1, fecha : "01/02/2015"} , {nro_legajo : 2, fecha : "02/02/2015"}],
	compro_articulos : [{codigo : "1"}]
})

db.clientes.insert({
	dni : "33333333",
	nombre : "cliente3",
	edad : 19,
	atendido_por : [{nro_legajo : 1, fecha : "01/03/2015"}],
	compro_articulos : [{codigo : "2"} , {codigo : "3"}]
})