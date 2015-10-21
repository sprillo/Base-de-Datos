--PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;

-- entidad Provincia
CREATE TABLE provincia (
 idProvincia INTEGER NOT NULL,
 nombre VARCHAR(255) NOT NULL,
 PRIMARY KEY(idProvincia)
);
INSERT INTO "provincia" VALUES(0,'Buenos Aires');
INSERT INTO provincia VALUES(1,'Rio Negro');
INSERT INTO provincia VALUES(2,'Chaco');
INSERT INTO provincia VALUES(3,'Misiones');

-- entidad Localidad
CREATE TABLE localidad (
 idLocalidad INTEGER NOT NULL,
 nombre VARCHAR(255) DEFAULT NULL,
 idProvincia INTEGER NOT NULL,
 PRIMARY KEY(idLocalidad,idProvincia),
 FOREIGN KEY(idProvincia) REFERENCES provincia(idProvincia)
);
INSERT INTO "localidad" VALUES(0,'CABA',0);
INSERT INTO localidad VALUES(1,'Bariloche',1);
INSERT INTO localidad VALUES(3,'San Isidro',0);
INSERT INTO localidad VALUES(2,'Puerto Iguazo',3);

-- entidad Calle
CREATE TABLE calle (
 idCalle INTEGER NOT NULL,
 nombre VARCHAR(255) DEFAULT NULL,
 idLocalidad INTEGER NOT NULL,
 idProvincia INTEGER NOT NULL,
 PRIMARY KEY(idCalle,idLocalidad,idProvincia),
 FOREIGN KEY(idLocalidad,idProvincia) REFERENCES localidad(idLocalidad,idProvincia)
);
INSERT INTO "calle" VALUES(0,'Mendoza',0,0);
INSERT INTO "calle" VALUES(1,'Artilleros',0,0);
INSERT INTO "calle" VALUES(2,'Cabildo',0,0);
INSERT INTO calle VALUES(3,'Libertador',0,0);
INSERT INTO calle VALUES(4,'Bustillo',1,1);
INSERT INTO calle VALUES(5,'Pioneros',1,1);

-- entidad Direccion
CREATE TABLE direccion (
 altura INTEGER NOT NULL,
 idCalle INTEGER NOT NULL,
 idLocalidad INTEGER NOT NULL,
 idProvincia INTEGER NOT NULL,
 PRIMARY KEY(altura,idCalle,idLocalidad,idProvincia),
 FOREIGN KEY(idCalle,idLocalidad,idProvincia) REFERENCES calle(idCalle,idLocalidad,idProvincia)
);
INSERT INTO "direccion" VALUES(1200,0,0,0);
INSERT INTO "direccion" VALUES(2081,1,0,0);
INSERT INTO "direccion" VALUES(4000,2,0,0);
INSERT INTO direccion VALUES(14000,3,0,0);
INSERT INTO direccion VALUES(7625,4,1,1);
INSERT INTO direccion VALUES(5000,5,1,1);

-- entidad Tipo de Lugar
CREATE TABLE tipo_de_lugar (
 idTipoLugar INTEGER NOT NULL,
 tipo VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoLugar)
);
INSERT INTO "tipo_de_lugar" VALUES(0,'Calle');
INSERT INTO "tipo_de_lugar" VALUES(1,'Avenida');
INSERT INTO "tipo_de_lugar" VALUES(2,'Autopista');
INSERT INTO tipo_de_lugar VALUES(3,'Ruta');

-- relacion tiene, entre Calle y Tipo de Lugar
CREATE TABLE calle_tiene_tipo_de_lugar (
 idCalle INTEGER NOT NULL,
 idLocalidad INTEGER NOT NULL,
 idProvincia INTEGER NOT NULL,
 idTipoLugar INTEGER NOT NULL,
 desde INTEGER NOT NULL,
 hasta INTEGER NOT NULL,
 PRIMARY KEY(idCalle, idLocalidad, idProvincia, idTipoLugar, desde),
 FOREIGN KEY(idCalle, idLocalidad, idProvincia) REFERENCES calle(idCalle,idLocalidad,idProvincia),
 FOREIGN KEY(idTipoLugar) REFERENCES tipo_de_lugar(idTipoLugar)
);
INSERT INTO "calle_tiene_tipo_de_lugar" VALUES(0,0,0,0,0,5000);
INSERT INTO "calle_tiene_tipo_de_lugar" VALUES(1,0,0,0,0,1000);
INSERT INTO "calle_tiene_tipo_de_lugar" VALUES(2,0,0,1,0,10000);
INSERT INTO calle_tiene_tipo_de_lugar VALUES(3,0,0,1,0,20000);
INSERT INTO calle_tiene_tipo_de_lugar VALUES(4,1,1,1,0,12500);
INSERT INTO calle_tiene_tipo_de_lugar VALUES(5,1,1,1,0,20000);

-- entidad Comisaria
CREATE TABLE comisaria (
 nroComisaria INTEGER NOT NULL,
 nombre VARCHAR(255) DEFAULT NULL,
 altura INTEGER NOT NULL,
 idCalle INTEGER NOT NULL,
 idLocalidad INTEGER NOT NULL,
 idProvincia INTEGER NOT NULL,
 PRIMARY KEY(nroComisaria),
 FOREIGN KEY(altura,idCalle,idLocalidad,idProvincia) REFERENCES direccion(idDireccion,idCalle,idLocalidad,idProvincia)
);
INSERT INTO "comisaria" VALUES(51,'Comisaria 51',2081,1,0,0);
INSERT INTO comisaria VALUES(27,'Comisaria 27',5000,5,1,0);

-- entidad Denuncia
CREATE TABLE denuncia (
 nroDenuncia INTEGER NOT NULL,
 descripcion VARCHAR(255) DEFAULT NULL,
 nroComisaria INTEGER NOT NULL,
 PRIMARY KEY(nroDenuncia),
 FOREIGN KEY(nroComisaria) REFERENCES comisaria(nroComisaria)
);
INSERT INTO "denuncia" VALUES(0,'El chano rompio todo.',51);
INSERT INTO denuncia VALUES(2,'El chano volco su auto sobre Bustillo a la altura del hotel Altuen',27);

-- entidad Tipo de Colision
CREATE TABLE tipo_de_colision (
 idTipoColision INTEGER NOT NULL,
 tipo VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoColision)
);
INSERT INTO "tipo_de_colision" VALUES(0,'Vehicular');
INSERT INTO tipo_de_colision VALUES(1,'Peatonal');
INSERT INTO tipo_de_colision VALUES(2,'Animal');
INSERT INTO tipo_de_colision VALUES(3,'Edilicia');

-- entidad Modalidad
CREATE TABLE modalidad (
 idTipoModalidad INTEGER NOT NULL,
 tipo VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoModalidad)
);
INSERT INTO "modalidad" VALUES(0,'Choque');
INSERT INTO modalidad VALUES(1,'Vuelco');
INSERT INTO modalidad VALUES(2,'Incendio');
INSERT INTO modalidad VALUES(3,'Caida de Ocupante');

-- entidad Siniestro
CREATE TABLE siniestro (
 idSiniestro INTEGER NOT NULL,
 fecha DATETIME DEFAULT NULL,
 nroDenuncia INTEGER NOT NULL,
 altura INTEGER NOT NULL,
 idCalle INTEGER NOT NULL,
 idLocalidad INTEGER NOT NULL,
 idProvincia INTEGER NOT NULL,
 PRIMARY KEY(idSiniestro),
 FOREIGN KEY(nroDenuncia) REFERENCES denuncia(nroDenuncia),
 FOREIGN KEY(altura,idCalle,idLocalidad,idProvincia) REFERENCES direccion(altura,idCalle,idLocalidad,idProvincia)
);
INSERT INTO "siniestro" VALUES(0,'05/08/2015',0,1200,0,0,0);
INSERT INTO siniestro VALUES(1,'06/06/2015',1,14000,3,0,0);
INSERT INTO siniestro VALUES(2,'05/05/2014',2,7625,4,1,1);

-- relacion damnifica, entre Siniestro y Tipo de Colision
CREATE TABLE siniestro_damnifica_tipo_de_colision (
 idSiniestro INTEGER NOT NULL,
 idTipoColision INTEGER NOT NULL,
 PRIMARY KEY(idSiniestro, idTipoColision),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 FOREIGN KEY(idTipoColision) REFERENCES tipo_de_colision(idTipoColision)
);
INSERT INTO "siniestro_damnifica_tipo_de_colision" VALUES(2,0);
INSERT INTO "siniestro_damnifica_tipo_de_colision" VALUES(0,0);
INSERT INTO siniestro_damnifica_tipo_de_colision VALUES(1,0);

-- relacion formaDe, entre Siniestro y Modalidad
CREATE TABLE siniestro_forma_de_modalidad (
 idSiniestro INTEGER NOT NULL,
 idTipoModalidad INTEGER NOT NULL,
 PRIMARY KEY(idSiniestro, idTipoModalidad),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 FOREIGN KEY(idTipoModalidad) REFERENCES modalidad(idTipoModalidad)
);
INSERT INTO "siniestro_forma_de_modalidad" VALUES(0,0);
INSERT INTO siniestro_forma_de_modalidad VALUES(1,0);
INSERT INTO siniestro_forma_de_modalidad VALUES(2,1);

-- entidad Tipo de Pavimento
CREATE TABLE tipo_de_pavimento (
 idTipoPavimento INTEGER NOT NULL,
 descripcion VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoPavimento)
);
INSERT INTO "tipo_de_pavimento" VALUES(0,'Flexible');
INSERT INTO tipo_de_pavimento VALUES(1,'Rigido');
INSERT INTO tipo_de_pavimento VALUES(2,'Compuesto');

-- entidad Estudio
CREATE TABLE estudio (
 idEstudio INTEGER NOT NULL,
 causaProbable VARCHAR(255) DEFAULT NULL,
 estadoVia VARCHAR(255) DEFAULT NULL,
 estadoIluminacion VARCHAR(255) DEFAULT NULL,
 seguridadPeatonal BOOLEAN DEFAULT NULL,
 idTipoPavimento INTEGER NOT NULL,
 idSiniestro INTEGER NOT NULL,
 PRIMARY KEY (idEstudio, idSiniestro),
 FOREIGN KEY(idTipoPavimento) REFERENCES tipo_de_pavimento(idTipoPavimento),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro)
);
INSERT INTO "estudio" VALUES(0,'El Chano venia pisteando como un campeon en contramano y choco 6 autos.','Buena condicion de via.','De noche, pero buena iluminacion.',0,2,0);

-- entidad Persona
CREATE TABLE persona (
 dni INTEGER NOT NULL,
 nombre VARCHAR(255) NOT NULL,
 apellido VARCHAR(255) NOT NULL,
 nacimiento DATE NOT NULL,
 PRIMARY KEY(dni)
);
INSERT INTO "persona" VALUES(15151515,'Ana','Arias','01/01/1971');
INSERT INTO "persona" VALUES(20202020,'Tomas','Troglio','07/07/1977');
INSERT INTO "persona" VALUES(28282828,'Santiago','Moreno Charpentier','23/09/1981');
INSERT INTO persona VALUES(16161616,'Beto','Bielsa','01/01/1960');

-- relacion testigo, entre Siniestro y Persona
CREATE TABLE siniestro_testigo_persona (
 idSiniestro INTEGER NOT NULL,
 dni INTEGER NOT NULL,
 PRIMARY KEY(idSiniestro, dni),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 FOREIGN KEY(dni) REFERENCES persona(dni)
);
INSERT INTO "siniestro_testigo_persona" VALUES(0,20202020);

-- relacion cinturon, entre Estudio y Persona
CREATE TABLE estudio_cinturon_persona (
 idEstudio INTEGER NOT NULL,
 dni INTEGER NOT NULL,
 si_o_no BOOLEAN NOT NULL,
 PRIMARY KEY(idEstudio, dni),
 FOREIGN KEY(idEstudio) REFERENCES estudio(idEstudio),
 FOREIGN KEY(dni) REFERENCES persona(dni)
);
INSERT INTO "estudio_cinturon_persona" VALUES(0,28282828,0);

-- entidad Tipo de Delito
CREATE TABLE tipo_de_delito (
 idTipoDelito INTEGER NOT NULL,
 descripcion VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoDelito)
);
INSERT INTO "tipo_de_delito" VALUES(0,'Consumo Ilegal de Drogas');
INSERT INTO tipo_de_delito VALUES(1,'Robo');

-- entidad Antecedente Penal
CREATE TABLE antecedente_penal (
 idAntecedente INTEGER NOT NULL,
 fecha Date NOT NULL,
 dni INTEGER NOT NULL,
 idTipoDelito INTEGER NOT NULL,
 FOREIGN KEY(dni) REFERENCES persona(dni),
 FOREIGN KEY(idTipoDelito) REFERENCES tipo_de_delito(idTipoDelito),
 PRIMARY KEY(idAntecedente)
);
INSERT INTO "antecedente_penal" VALUES(0,'06/06/2015',28282828,0);

-- entidad Tipo de Infraccion
CREATE TABLE tipo_de_infraccion (
 idTipoInfraccion INTEGER NOT NULL,
 descripcion VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoInfraccion)
);
INSERT INTO "tipo_de_infraccion" VALUES(0,'Exceso de velocidad permitida.');
INSERT INTO tipo_de_infraccion VALUES(1,'Cruzar semaforo en rojo');
INSERT INTO tipo_de_infraccion VALUES(2,'Conducir en contramano');

-- entidad Infraccion de Transito
CREATE TABLE infraccion_de_transito (
 idInfraccion INTEGER NOT NULL,
 altura INTEGER NOT NULL,
 idCalle INTEGER NOT NULL,
 idLocalidad INTEGER NOT NULL,
 idProvincia INTEGER NOT NULL,
 idTipoInfraccion INTEGER NOT NULL,
 FOREIGN KEY(altura,idCalle,idLocalidad,idProvincia) REFERENCES direccion(idDireccion,idCalle,idLocalidad,idProvincia),
 FOREIGN KEY(idTipoInfraccion) REFERENCES tipo_infraccion(idTipoInfraccion),
 PRIMARY KEY(idInfraccion)
);
INSERT INTO "infraccion_de_transito" VALUES(0,4000,2,0,0,0);

-- entidad Persona con Licencia
CREATE TABLE persona_con_licencia (
 dni INTEGER NOT NULL,
 FOREIGN KEY(dni) REFERENCES persona(dni),
 PRIMARY KEY(dni)
);
INSERT INTO "persona_con_licencia" VALUES(28282828);
INSERT INTO "persona_con_licencia" VALUES(16161616);

-- entidad Licencia
CREATE TABLE licencia (
 nroLicencia INTEGER NOT NULL,
 dni INTEGER NOT NULL,
 expedicion DATE NOT NULL,
 expiracion DATE NOT NULL,
 FOREIGN KEY(dni) REFERENCES persona_con_licencia(dni),
 PRIMARY KEY (nroLicencia, dni)
);
INSERT INTO "licencia" VALUES(0,28282828,'01/01/2015','01/01/2016');
INSERT INTO "licencia" VALUES(1,16161616,'01/01/2015','01/01/2016');

-- entidad Compania de Seguros
CREATE TABLE compania_de_seguro (
 cuit INTEGER NOT NULL,
 nombre VARCHAR(255) NOT NULL,
 PRIMARY KEY(cuit)
);
INSERT INTO "compania_de_seguro" VALUES(306632,'La Caja');

-- entidad Tipo de Cobertura
CREATE TABLE tipo_de_cobertura (
 idTipoCobertura INTEGER NOT NULL,
 descripcion VARCHAR(255) NOT NULL,
 PRIMARY KEY(idTipoCobertura)
);
INSERT INTO "tipo_de_cobertura" VALUES(0,'cobertura total.');
INSERT INTO tipo_de_cobertura VALUES(1,'cobertura frente a robos');

-- entidad Tipo de Vehiculo
CREATE TABLE tipo_de_vehiculo (
 idTipoVehiculo INTEGER NOT NULL,
 descripcion VARCHAR(255) NOT NULL,
 PRIMARY KEY(idTipoVehiculo)
);
INSERT INTO "tipo_de_vehiculo" VALUES(0,'Auto');
INSERT INTO "tipo_de_vehiculo" VALUES(1,'Camioneta');
INSERT INTO tipo_de_vehiculo VALUES(2,'Combi');
INSERT INTO tipo_de_vehiculo VALUES(3,'Moto');

-- entidad Categoria de Coche
CREATE TABLE categoria_de_vehiculo (
 idCategoria INTEGER NOT NULL,
 descripcion VARCHAR(255) NOT NULL,
 PRIMARY KEY(idCategoria)
);
INSERT INTO "categoria_de_vehiculo" VALUES(0,'Gama media');
INSERT INTO "categoria_de_vehiculo" VALUES(1,'Gama alta');

-- entidad Vehiculo
CREATE TABLE vehiculo (
 nroPatente CHARACTER(6) NOT NULL,
 fechaFabricacion DATE NOT NULL,
 idCategoria INTEGER NOT NULL,
 idTipoVehiculo INTEGER NOT NULL,
 dni INTEGER NOT NULL,
 FOREIGN KEY(idCategoria) REFERENCES categoria_de_vehiculo(idCategoria),
 FOREIGN KEY(idTipoVehiculo) REFERENCES tipo_de_vehiculo(idTipoVehiculo),
 FOREIGN KEY(dni) REFERENCES persona(dni),
 PRIMARY KEY(nroPatente)
);
INSERT INTO "vehiculo" VALUES("CHA123",'01/01/2010',1,1,28282828);
INSERT INTO "vehiculo" VALUES("ANA123",'01/01/2009',0,0,15151515);
INSERT INTO vehiculo VALUES("CHA234",'02/02/2010',0,0,28282828);
INSERT INTO vehiculo VALUES("CHA345",'03/03/2010',0,0,28282828);
INSERT INTO vehiculo VALUES("BET789",'01/01/1998',0,0,16161616);

-- entidad Seguro
CREATE TABLE seguro (
 idSeguro INTEGER NOT NULL,
 cuit INTEGER NOT NULL,
 idTipoCobertura INTEGER NOT NULL,
 nroPatente INTEGER NOT NULL,
 FOREIGN KEY(cuit) REFERENCES compania_de_seguro(cuit),
 FOREIGN KEY(idTipoCobertura) REFERENCES cobertura(idTipoCobertura),
 FOREIGN KEY(nroPatente) REFERENCES vehiculo(nroPatente),
 PRIMARY KEY(idSeguro)
);
INSERT INTO "seguro" VALUES(0,306632,0,"ANA123");

-- relacion cedula, entre Vehiculo y Persona con Licencia
CREATE TABLE cedula (
 nroPatente CHARACTER(6) NOT NULL,
 dni INTEGER NOT NULL,
 FOREIGN KEY(nroPatente) REFERENCES vehiculo(nroPatente),
 FOREIGN KEY(dni) REFERENCES persona_con_licencia(dni),
 PRIMARY KEY(nroPatente, dni)
);
INSERT INTO "cedula" VALUES("CHA345",28282828);
INSERT INTO "cedula" VALUES("CHA234",28282828);
INSERT INTO "cedula" VALUES("CHA123",28282828);
INSERT INTO "cedula" VALUES("ANA123",15151515);

-- relacion protagoniza, entre Siniesto y Vehiculo
CREATE TABLE siniestro_protagoniza_vehiculo (
 nroPatente CHARACTER(6) NOT NULL,
 idSiniestro INTEGER NOT NULL,
 FOREIGN KEY(nroPatente) REFERENCES vehiculo(nroPatente),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 PRIMARY KEY(nroPatente, idSiniestro)
);
INSERT INTO "siniestro_protagoniza_vehiculo" VALUES("ANA123",0);

-- relacion accidente, entre Siniestro, Vehiculo y Persona
CREATE TABLE siniestro_vehiculo_persona (
 nroPatente CHARACTER(6) NOT NULL,
 idSiniestro INTEGER NOT NULL,
 dni INTEGER NOT NULL,
 culpable BOOLEAN NOT NULL,
 FOREIGN KEY(nroPatente) REFERENCES vehiculo(nroPatente),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 FOREIGN KEY(dni) REFERENCES persona(dni), 
 PRIMARY KEY(nroPatente, idSiniestro)
);
INSERT INTO "siniestro_vehiculo_persona" VALUES("CHA123",0,28282828,1);
INSERT INTO siniestro_vehiculo_persona VALUES("CHA234",1,28282828,1);
INSERT INTO siniestro_vehiculo_persona VALUES("BET789",1,16161616,0);
INSERT INTO siniestro_vehiculo_persona VALUES("CHA123",2,28282828,1);

-- relacion infraccion, entre Persona, Vehiculo e Infraccion de Transito
CREATE TABLE persona_en_vehiculo_comete_infraccion (
 nroPatente CHARACTER(6) NOT NULL,
 dni INTEGER NOT NULL,
 idInfraccion INTEGER NOT NULL,
 FOREIGN KEY(nroPatente) REFERENCES vehiculo(nroPatente),
 FOREIGN KEY(dni) REFERENCES persona(dni), 
 FOREIGN KEY(idInfraccion) REFERENCES infraccion_de_transito(idInfraccion), 
 PRIMARY KEY(nroPatente, dni, idInfraccion)
);
INSERT INTO "persona_en_vehiculo_comete_infraccion" VALUES("CHA123",28282828,0);

COMMIT;
