import random

#CANTIDAD_DE_TANDAS = 25
#TAMANIO_DE_TANDA = 20000

CANTIDAD_DE_TANDAS = 25
TAMANIO_DE_TANDA = 20000

def fecha():
	dia = random.randrange(28) + 1
	mes = random.randrange(12) + 1
	anio = random.randrange(2) + 2014
	return str(dia) + "/" + str(mes) + "/" + str(anio)

def generate_document():
	doc = '{\n' + \
		   ' "nombre" : ' + '"persona_' + str(random.randrange(100000000)) + '",\n' + \
		   ' "password" : "' + ''.join([str(random.randrange(10)) for i in range(random.randrange(10) + 1)]) + '",\n' + \
		   ' "codigo_postal" : ' + str(random.randrange(1000000)) + ',\n' + \
		   ' "genero" : "' + ["m","f"][random.randrange(2)] + '",\n' + \
		   ' "edad" : ' + str(random.randrange(1,100)) + ',\n' + \
		   ' "fecha_creacion" : "' + fecha() + '"\n' + \
		  '}'
	return doc

for i in range(CANTIDAD_DE_TANDAS):
	f = open('personas' + str(i) + '.json','w')
	f.write('[\n')
	for j in range(TAMANIO_DE_TANDA):
		if j > 0:
			f.write(',\n')
		doc = generate_document()
		f.write(doc)
	f.write('\n]')
	f.close()


