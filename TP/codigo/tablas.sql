PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;

CREATE TABLE provincia (
 idProvincia INTEGER NOT NULL,
 nombre VARCHAR(255) NOT NULL,
 PRIMARY KEY(idProvincia)
);
INSERT INTO "provincia" VALUES(0,'Buenos Aires');

CREATE TABLE localidad (
 idLocalidad INTEGER NOT NULL,
 nombre VARCHAR(255) DEFAULT NULL,
 idProvincia INTEGER NOT NULL,
 PRIMARY KEY(idLocalidad),
 FOREIGN KEY(idProvincia) REFERENCES provincia(idProvincia)
);
INSERT INTO "localidad" VALUES(0,'CABA',0);

CREATE TABLE calle (
 idCalle INTEGER NOT NULL,
 nombre VARCHAR(255) DEFAULT NULL,
 idLocalidad INTEGER NOT NULL,
 PRIMARY KEY(idCalle),
 FOREIGN KEY(idLocalidad) REFERENCES localidad(idLocalidad)
);
INSERT INTO "calle" VALUES(0,'Mendoza',0);
INSERT INTO "calle" VALUES(1,'Artilleros',0);
INSERT INTO "calle" VALUES(2,'Cabildo',0);

CREATE TABLE direccion (
 idDireccion INTEGER NOT NULL,
 altura INTEGER NOT NULL,
 idCalle INTEGER NOT NULL,
 PRIMARY KEY(idDireccion),
 FOREIGN KEY(idCalle) REFERENCES calle(idCalle)
);
INSERT INTO "direccion" VALUES(0,1200,0);
INSERT INTO "direccion" VALUES(1,2081,1);
INSERT INTO "direccion" VALUES(2,4000,2);

CREATE TABLE tipo_de_lugar (
 idTipoLugar INTEGER NOT NULL,
 tipo VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoLugar)
);
INSERT INTO "tipo_de_lugar" VALUES(0,'Calle');
INSERT INTO "tipo_de_lugar" VALUES(1,'Avenida');
INSERT INTO "tipo_de_lugar" VALUES(2,'Autopista');

CREATE TABLE calle_tiene_tipo_de_lugar (
 idCalle INTEGER NOT NULL,
 idTipoLugar INTEGER NOT NULL,
 desde INTEGER NOT NULL,
 hasta INTEGER NOT NULL,
 PRIMARY KEY(idCalle, idTipoLugar, desde),
 FOREIGN KEY(idCalle) REFERENCES calle(idCalle),
 FOREIGN KEY(idTipoLugar) REFERENCES tipo_de_lugar(idTipoLugar)
);
INSERT INTO "calle_tiene_tipo_de_lugar" VALUES(0,0,0,5000);
INSERT INTO "calle_tiene_tipo_de_lugar" VALUES(1,0,0,1000);
INSERT INTO "calle_tiene_tipo_de_lugar" VALUES(2,1,0,10000);

CREATE TABLE comisaria (
 nroComisaria INTEGER NOT NULL,
 nombre VARCHAR(255) DEFAULT NULL,
 idDireccion INTEGER NOT NULL,
 PRIMARY KEY(nroComisaria),
 FOREIGN KEY(idDireccion) REFERENCES direccion(idDireccion)
);
INSERT INTO "comisaria" VALUES(51,'Comisaria 51',1);

CREATE TABLE denuncia (
 nroDenuncia INTEGER NOT NULL,
 descripcion VARCHAR(255) DEFAULT NULL,
 nroComisaria INTEGER NOT NULL,
 PRIMARY KEY(nroDenuncia),
 FOREIGN KEY(nroComisaria) REFERENCES comisaria(nroComisaria)
);
INSERT INTO "denuncia" VALUES(0,'El chano rompio todo.',51);

CREATE TABLE tipo_de_colision (
 idTipoColision INTEGER NOT NULL,
 tipo VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoColision)
);
INSERT INTO "tipo_de_colision" VALUES(0,'Vehicular');

CREATE TABLE modalidad (
 idTipoModalidad INTEGER NOT NULL,
 tipo VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoModalidad)
);
INSERT INTO "modalidad" VALUES(0,'Choque');

CREATE TABLE siniestro (
 idSiniestro INTEGER NOT NULL,
 fecha DATETIME DEFAULT NULL,
 nroDenuncia INTEGER NOT NULL,
 idDireccion INTEGER NOT NULL,
 PRIMARY KEY(idSiniestro),
 FOREIGN KEY(nroDenuncia) REFERENCES denuncia(nroDenuncia),
 FOREIGN KEY(idDireccion) REFERENCES direccion(idDireccion)
);
INSERT INTO "siniestro" VALUES(0,'05/08/2015',0,0);

CREATE TABLE siniestro_damnifica_tipo_de_colision (
 idSiniestro INTEGER NOT NULL,
 idTipoColision INTEGER NOT NULL,
 PRIMARY KEY(idSiniestro, idTipoColision),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 FOREIGN KEY(idTipoColision) REFERENCES tipo_de_colision(idTipoColision)
);
INSERT INTO "siniestro_damnifica_tipo_de_colision" VALUES(0,0);

CREATE TABLE siniestro_forma_de_modalidad (
 idSiniestro INTEGER NOT NULL,
 idTipoModalidad INTEGER NOT NULL,
 PRIMARY KEY(idSiniestro, idTipoModalidad),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 FOREIGN KEY(idTipoModalidad) REFERENCES modalidad(idTipoModalidad)
);
INSERT INTO "siniestro_forma_de_modalidad" VALUES(0,0);

CREATE TABLE pavimento (
 idPavimento INTEGER NOT NULL,
 descripcion VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idPavimento)
);
INSERT INTO "pavimento" VALUES(0,'pavimento normal');

CREATE TABLE estudio (
 idEstudio INTEGER NOT NULL,
 causaProbable VARCHAR(255) DEFAULT NULL,
 estadoVia VARCHAR(255) DEFAULT NULL,
 estadoIluminacion VARCHAR(255) DEFAULT NULL,
 seguridadPeatonal BOOLEAN DEFAULT NULL,
 idTipoPavimento INTEGER NOT NULL,
 idSiniestro INTEGER NOT NULL,
 PRIMARY KEY (idEstudio, idSiniestro),
 FOREIGN KEY(idTipoPavimento) REFERENCES pavimento(idTipoPavimento),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro)
);
INSERT INTO "estudio" VALUES(0,'El Chano venia pisteando como un campeon en contramano y choco 6 autos.','Buena condicion de via.','De noche, pero buena iluminacion.',0,0,0);

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

CREATE TABLE siniestro_testigo_persona (
 idSiniestro INTEGER NOT NULL,
 dni INTEGER NOT NULL,
 PRIMARY KEY(idSiniestro, dni),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 FOREIGN KEY(dni) REFERENCES persona(dni)
);
INSERT INTO "siniestro_testigo_persona" VALUES(0,20202020);

CREATE TABLE estudio_cinturon_persona (
 idEstudio INTEGER NOT NULL,
 dni INTEGER NOT NULL,
 si_o_no BOOLEAN NOT NULL,
 PRIMARY KEY(idEstudio, dni),
 FOREIGN KEY(idEstudio) REFERENCES estudio(idEstudio),
 FOREIGN KEY(dni) REFERENCES persona(dni)
);
INSERT INTO "estudio_cinturon_persona" VALUES(0,28282828,0);

CREATE TABLE tipo_de_delito (
 idTipoDelito INTEGER NOT NULL,
 descripcion VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoDelito)
);
INSERT INTO "tipo_de_delito" VALUES(0,'Consumo Ilegal de Drogas');

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

CREATE TABLE tipo_de_infraccion (
 idTipoInfraccion INTEGER NOT NULL,
 descripcion VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoInfraccion)
);
INSERT INTO "tipo_de_infraccion" VALUES(0,'Exceso de velocidad permitida.');

CREATE TABLE infraccion_de_transito (
 idInfraccion INTEGER NOT NULL,
 idDireccion INTEGER NOT NULL,
 idTipoInfraccion INTEGER NOT NULL,
 FOREIGN KEY(idDireccion) REFERENCES direccion(idDireccion),
 FOREIGN KEY(idTipoInfraccion) REFERENCES tipo_infraccion(idTipoInfraccion),
 PRIMARY KEY(idInfraccion)
);
INSERT INTO "infraccion_de_transito" VALUES(0,2,0);

CREATE TABLE persona_con_licencia (
 dni INTEGER NOT NULL,
 FOREIGN KEY(dni) REFERENCES persona(dni),
 PRIMARY KEY(dni)
);
INSERT INTO "persona_con_licencia" VALUES(28282828);

CREATE TABLE licencia (
 nroLicencia INTEGER NOT NULL,
 dni INTEGER NOT NULL,
 expedicion DATE NOT NULL,
 expiracion DATE NOT NULL,
 FOREIGN KEY(dni) REFERENCES persona_con_licencia(dni),
 PRIMARY KEY (nroLicencia, dni)
);
INSERT INTO "licencia" VALUES(0,28282828,'01/01/2015','01/01/2016');

CREATE TABLE compania_de_seguro (
 cuit INTEGER NOT NULL,
 nombre VARCHAR(255) NOT NULL,
 PRIMARY KEY(cuit)
);
INSERT INTO "compania_de_seguro" VALUES(30663205621,'La Caja');

CREATE TABLE tipo_de_cobertura (
 idTipoCobertura INTEGER NOT NULL,
 descripcion VARCHAR(255) NOT NULL,
 PRIMARY KEY(idTipoCobertura)
);
INSERT INTO "tipo_de_cobertura" VALUES(0,'cobertura total.');

CREATE TABLE tipo_de_vehiculo (
 idTipoVehiculo INTEGER NOT NULL,
 descripcion VARCHAR(255) NOT NULL,
 PRIMARY KEY(idTipoVehiculo)
);
INSERT INTO "tipo_de_vehiculo" VALUES(0,'Auto');
INSERT INTO "tipo_de_vehiculo" VALUES(1,'Camioneta');

CREATE TABLE categoria_de_vehiculo (
 idCategoria INTEGER NOT NULL,
 descripcion VARCHAR(255) NOT NULL,
 PRIMARY KEY(idCategoria)
);
INSERT INTO "categoria_de_vehiculo" VALUES(0,'Gama media');
INSERT INTO "categoria_de_vehiculo" VALUES(1,'Gama alta');

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
INSERT INTO "seguro" VALUES(0,30663205621,0,"ANA123");

CREATE TABLE cedula (
 nroPatente CHARACTER(6) NOT NULL,
 dni INTEGER NOT NULL,
 FOREIGN KEY(nroPatente) REFERENCES vehiculo(nroPatente),
 FOREIGN KEY(dni) REFERENCES persona_con_licencia(dni),
 PRIMARY KEY(nroPatente, dni)
);
INSERT INTO "cedula" VALUES("CHA123",28282828);
INSERT INTO "cedula" VALUES("ANA123",15151515);

CREATE TABLE siniestro_protagoniza_vehiculo (
 nroPatente CHARACTER(6) NOT NULL,
 idSiniestro INTEGER NOT NULL,
 FOREIGN KEY(nroPatente) REFERENCES vehiculo(nroPatente),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 PRIMARY KEY(nroPatente, idSiniestro)
);
INSERT INTO "siniestro_protagoniza_vehiculo" VALUES("ANA123",0);

CREATE TABLE siniestro_vehiculo_persona (
 nroPatente CHARACTER(6) NOT NULL,
 idSiniestro INTEGER NOT NULL,
 dni INTEGER NOT NULL,
 FOREIGN KEY(nroPatente) REFERENCES vehiculo(nroPatente),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 FOREIGN KEY(dni) REFERENCES persona(dni), 
 PRIMARY KEY(nroPatente, idSiniestro)
);
INSERT INTO "siniestro_vehiculo_persona" VALUES("CHA123",0,28282828);

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
