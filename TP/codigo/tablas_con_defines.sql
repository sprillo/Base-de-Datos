PRAGMA foreign_keys=ON;
BEGIN TRANSACTION;

-- entidad Provincia
CREATE TABLE provincia (
 idProvincia INTEGER NOT NULL,
 nombre VARCHAR(255) NOT NULL,
 PRIMARY KEY(idProvincia)
);
INSERT INTO "provincia" VALUES(idProvinciaBuenosAires,'Buenos Aires');
INSERT INTO provincia VALUES(idProvinciaRioNegro,'Rio Negro');
INSERT INTO provincia VALUES(idProvinciaChaco,'Chaco');
INSERT INTO provincia VALUES(idProvinciaMisiones,'Misiones');

-- entidad Localidad
CREATE TABLE localidad (
 idLocalidad INTEGER NOT NULL,
 nombre VARCHAR(255) DEFAULT NULL,
 idProvincia INTEGER NOT NULL,
 PRIMARY KEY(idLocalidad,idProvincia),
 FOREIGN KEY(idProvincia) REFERENCES provincia(idProvincia)
);
INSERT INTO "localidad" VALUES(idLocalidadCABA,'CABA',idProvinciaBuenosAires);
INSERT INTO localidad VALUES(idLocalidadBariloche,'Bariloche',idProvinciaRioNegro);
INSERT INTO localidad VALUES(idLocalidadSanIsidro,'San Isidro',idProvinciaBuenosAires);
INSERT INTO localidad VALUES(idLocalidadPuertoIguazu,'Puerto Iguazo',idProvinciaMisiones);

-- entidad Calle
CREATE TABLE calle (
 idCalle INTEGER NOT NULL,
 nombre VARCHAR(255) DEFAULT NULL,
 idLocalidad INTEGER NOT NULL,
 idProvincia INTEGER NOT NULL,
 PRIMARY KEY(idCalle,idLocalidad,idProvincia),
 FOREIGN KEY(idLocalidad,idProvincia) REFERENCES localidad(idLocalidad,idProvincia)
);
INSERT INTO "calle" VALUES(idCalleMendoza,'Mendoza',idLocalidadCABA,idProvinciaBuenosAires);
INSERT INTO "calle" VALUES(idCalleArtilleros,'Artilleros',idLocalidadCABA,idProvinciaBuenosAires);
INSERT INTO "calle" VALUES(idCalleCabildo,'Cabildo',idLocalidadCABA,idProvinciaBuenosAires);
INSERT INTO calle VALUES(idCalleLibertador,'Libertador',idLocalidadCABA,idProvinciaBuenosAires);
INSERT INTO calle VALUES(idCalleBustillo,'Bustillo',idLocalidadBariloche,idProvinciaRioNegro);
INSERT INTO calle VALUES(idCallePioneros,'Pioneros',idLocalidadBariloche,idProvinciaRioNegro);

-- entidad Direccion
CREATE TABLE direccion (
 altura INTEGER NOT NULL,
 idCalle INTEGER NOT NULL,
 idLocalidad INTEGER NOT NULL,
 idProvincia INTEGER NOT NULL,
 PRIMARY KEY(altura,idCalle,idLocalidad,idProvincia),
 FOREIGN KEY(idCalle,idLocalidad,idProvincia) REFERENCES calle(idCalle,idLocalidad,idProvincia)
);
INSERT INTO "direccion" VALUES(alturaMendoza,idCalleMendoza,idLocalidadCABA,idProvinciaBuenosAires);
INSERT INTO "direccion" VALUES(alturaArtilleros,idCalleArtilleros,idLocalidadCABA,idProvinciaBuenosAires);
INSERT INTO "direccion" VALUES(alturaCabildo,idCalleCabildo,idLocalidadCABA,idProvinciaBuenosAires);
INSERT INTO direccion VALUES(alturaLibertador,idCalleLibertador,idLocalidadCABA,idProvinciaBuenosAires);
INSERT INTO direccion VALUES(alturaBustillo,idCalleBustillo,idLocalidadBariloche,idProvinciaRioNegro);
INSERT INTO direccion VALUES(alturaPioneros,idCallePioneros,idLocalidadBariloche,idProvinciaRioNegro);

-- entidad Tipo de Lugar
CREATE TABLE tipo_de_lugar (
 idTipoLugar INTEGER NOT NULL,
 tipo VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoLugar)
);
INSERT INTO "tipo_de_lugar" VALUES(idTipoLugarCalle,'Calle');
INSERT INTO "tipo_de_lugar" VALUES(idTipoLugarAvenida,'Avenida');
INSERT INTO "tipo_de_lugar" VALUES(idTipoLugarAutopista,'Autopista');
INSERT INTO tipo_de_lugar VALUES(idTipoLugarRuta,'Ruta');

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
INSERT INTO "calle_tiene_tipo_de_lugar" VALUES(idCalleMendoza,idLocalidadCABA,idProvinciaBuenosAires,idTipoLugarCalle,0,longitudMendoza);
INSERT INTO "calle_tiene_tipo_de_lugar" VALUES(idCalleArtilleros,idLocalidadCABA,idProvinciaBuenosAires,idTipoLugarCalle,0,longitudArtilleros);
INSERT INTO "calle_tiene_tipo_de_lugar" VALUES(idCalleCabildo,idLocalidadCABA,idProvinciaBuenosAires,idTipoLugarAvenida,0,longitudCabildo);
INSERT INTO calle_tiene_tipo_de_lugar VALUES(idCalleLibertador,idLocalidadCABA,idProvinciaBuenosAires,idTipoLugarAvenida,0,longitudLibertador);
INSERT INTO calle_tiene_tipo_de_lugar VALUES(idCalleBustillo,idLocalidadBariloche,idProvinciaRioNegro,idTipoLugarAvenida,0,longitudBustillo);
INSERT INTO calle_tiene_tipo_de_lugar VALUES(idCallePioneros,idLocalidadBariloche,idProvinciaRioNegro,idTipoLugarAvenida,0,longitudPioneros);

-- entidad Comisaria
CREATE TABLE comisaria (
 nroComisaria INTEGER NOT NULL,
 nombre VARCHAR(255) DEFAULT NULL,
 altura INTEGER NOT NULL,
 idCalle INTEGER NOT NULL,
 idLocalidad INTEGER NOT NULL,
 idProvincia INTEGER NOT NULL,
 PRIMARY KEY(nroComisaria),
 FOREIGN KEY(altura,idCalle,idLocalidad,idProvincia) REFERENCES direccion(altura,idCalle,idLocalidad,idProvincia)
);
INSERT INTO "comisaria" VALUES(nroComisariaComisaria51,'Comisaria 51',alturaArtilleros,idCalleArtilleros,idLocalidadCABA,idProvinciaBuenosAires);
INSERT INTO comisaria VALUES(nroComisariaComisaria27,'Comisaria 27',alturaPioneros,idCallePioneros,idLocalidadBariloche,idProvinciaRioNegro);

-- entidad Denuncia
CREATE TABLE denuncia (
 nroDenuncia INTEGER NOT NULL,
 descripcion VARCHAR(255) DEFAULT NULL,
 nroComisaria INTEGER NOT NULL,
 PRIMARY KEY(nroDenuncia),
 FOREIGN KEY(nroComisaria) REFERENCES comisaria(nroComisaria)
);
INSERT INTO "denuncia" VALUES(nroDenunciaChano,'El chano rompio todo.',nroComisariaComisaria51);
INSERT INTO "denuncia" VALUES(nroDenunciaSiniestro2,'Accidente porque se le pincho una rueda.',nroComisariaComisaria51);
INSERT INTO denuncia VALUES(nroDenunciaVuelco,'El chano volco su auto sobre Bustillo a la altura del hotel Altuen',nroComisariaComisaria27);

-- entidad Tipo de Colision
CREATE TABLE tipo_de_colision (
 idTipoColision INTEGER NOT NULL,
 tipo VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoColision)
);
INSERT INTO "tipo_de_colision" VALUES(idTipoColisionVehicular,'Vehicular');
INSERT INTO tipo_de_colision VALUES(idTipoColisionPeatonal,'Peatonal');
INSERT INTO tipo_de_colision VALUES(idTipoColisionAnimal,'Animal');
INSERT INTO tipo_de_colision VALUES(idTipoColisionEdilicia,'Edilicia');

-- entidad Modalidad
CREATE TABLE modalidad (
 idTipoModalidad INTEGER NOT NULL,
 tipo VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoModalidad)
);
INSERT INTO "modalidad" VALUES(idTipoModalidadChoque,'Choque');
INSERT INTO modalidad VALUES(idTipoModalidadVuelco,'Vuelco');
INSERT INTO modalidad VALUES(idTipoModalidadIncendio,'Incendio');
INSERT INTO modalidad VALUES(idTipoModalidadCaidaDeOcupante,'Caida de Ocupante');

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
INSERT INTO "siniestro" VALUES(idSiniestroChano,'05/08/2015',nroDenunciaChano,alturaMendoza,idCalleMendoza,idLocalidadCABA,idProvinciaBuenosAires);
INSERT INTO siniestro VALUES(idSiniestro2,'06/06/2015',nroDenunciaSiniestro2,alturaLibertador,idCalleLibertador,idLocalidadCABA,idProvinciaBuenosAires);
INSERT INTO siniestro VALUES(idSiniestroVuelco,'05/05/2014',nroDenunciaSiniestroVuelco,alturaBustillo,idCalleBustillo,idLocalidadBariloche,idProvinciaRioNegro);

-- relacion damnifica, entre Siniestro y Tipo de Colision
CREATE TABLE siniestro_damnifica_tipo_de_colision (
 idSiniestro INTEGER NOT NULL,
 idTipoColision INTEGER NOT NULL,
 PRIMARY KEY(idSiniestro, idTipoColision),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 FOREIGN KEY(idTipoColision) REFERENCES tipo_de_colision(idTipoColision)
);
INSERT INTO "siniestro_damnifica_tipo_de_colision" VALUES(idSiniestroVuelco,idTipoColisionVehicular);
INSERT INTO "siniestro_damnifica_tipo_de_colision" VALUES(idSiniestroChano,idTipoColisionVehicular);
INSERT INTO siniestro_damnifica_tipo_de_colision VALUES(idSiniestro2,idTipoColisionVehicular);

-- relacion formaDe, entre Siniestro y Modalidad
CREATE TABLE siniestro_forma_de_modalidad (
 idSiniestro INTEGER NOT NULL,
 idTipoModalidad INTEGER NOT NULL,
 PRIMARY KEY(idSiniestro, idTipoModalidad),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 FOREIGN KEY(idTipoModalidad) REFERENCES modalidad(idTipoModalidad)
);
INSERT INTO "siniestro_forma_de_modalidad" VALUES(idSiniestroChano,idTipoModalidadChoque);
INSERT INTO siniestro_forma_de_modalidad VALUES(idSiniestro2,idTipoModalidadChoque);
INSERT INTO siniestro_forma_de_modalidad VALUES(idSiniestroVuelco,idTipoModalidadVuelco);

-- entidad Tipo de Pavimento
CREATE TABLE tipo_de_pavimento (
 idTipoPavimento INTEGER NOT NULL,
 descripcion VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoPavimento)
);
INSERT INTO "tipo_de_pavimento" VALUES(idTipoPavimentoFlexible,'Flexible');
INSERT INTO tipo_de_pavimento VALUES(idTipoPavimentoRigido,'Rigido');
INSERT INTO tipo_de_pavimento VALUES(idTipoPavimentoCompuesto,'Compuesto');

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
INSERT INTO "estudio" VALUES(idEstudioChano,'El Chano venia pisteando como un campeon en contramano y choco 6 autos.','Buena condicion de via.','De noche, pero buena iluminacion.',False,idTipoPavimentoCompuesto,idSiniestroChano);

-- entidad Persona
CREATE TABLE persona (
 dni INTEGER NOT NULL,
 nombre VARCHAR(255) NOT NULL,
 apellido VARCHAR(255) NOT NULL,
 nacimiento DATE NOT NULL,
 PRIMARY KEY(dni)
);
INSERT INTO "persona" VALUES(dniAna,'Ana','Arias','01/01/1971');
INSERT INTO "persona" VALUES(dniTestigo,'Tomas','Troglio','07/07/1977');
INSERT INTO "persona" VALUES(dniChano,'Santiago','Moreno Charpentier','23/09/1981');
INSERT INTO persona VALUES(dniBeto,'Beto','Bielsa','01/01/1960');

-- relacion testigo, entre Siniestro y Persona
CREATE TABLE siniestro_testigo_persona (
 idSiniestro INTEGER NOT NULL,
 dni INTEGER NOT NULL,
 PRIMARY KEY(idSiniestro, dni),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 FOREIGN KEY(dni) REFERENCES persona(dni)
);
INSERT INTO "siniestro_testigo_persona" VALUES(idEstudioChano,dniTestigo);

-- relacion cinturon, entre Estudio y Persona
CREATE TABLE estudio_cinturon_persona (
 idEstudio INTEGER NOT NULL,
 idSiniestro INTEGER NOT NULL,
 dni INTEGER NOT NULL,
 si_o_no BOOLEAN NOT NULL,
 PRIMARY KEY(idEstudio, dni),
 FOREIGN KEY(idEstudio, idSiniestro) REFERENCES estudio(idEstudio, idSiniestro),
 FOREIGN KEY(dni) REFERENCES persona(dni)
);
INSERT INTO "estudio_cinturon_persona" VALUES(idEstudioChano,idSiniestroChano, dniChano,False);

-- entidad Tipo de Delito
CREATE TABLE tipo_de_delito (
 idTipoDelito INTEGER NOT NULL,
 descripcion VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoDelito)
);
INSERT INTO "tipo_de_delito" VALUES(idTipoDelitoDrogas,'Consumo Ilegal de Drogas');
INSERT INTO tipo_de_delito VALUES(idTipoDelitoRobo,'Robo');

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
INSERT INTO "antecedente_penal" VALUES(idAntecedenteChano,'06/06/2015',dniChano,idTipoDelitoDrogas);

-- entidad Tipo de Infraccion
CREATE TABLE tipo_de_infraccion (
 idTipoInfraccion INTEGER NOT NULL,
 descripcion VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoInfraccion)
);
INSERT INTO "tipo_de_infraccion" VALUES(idTipoInfraccionExcesoVelocidad,'Exceso de velocidad permitida.');
INSERT INTO tipo_de_infraccion VALUES(idTipoInfraccionCruceSemaforoRojo,'Cruzar semaforo en rojo');
INSERT INTO tipo_de_infraccion VALUES(idTipoInfraccionContramano,'Conducir en contramano');

-- entidad Infraccion de Transito
CREATE TABLE infraccion_de_transito (
 idInfraccion INTEGER NOT NULL,
 altura INTEGER NOT NULL,
 idCalle INTEGER NOT NULL,
 idLocalidad INTEGER NOT NULL,
 idProvincia INTEGER NOT NULL,
 idTipoInfraccion INTEGER NOT NULL,
 FOREIGN KEY(altura,idCalle,idLocalidad,idProvincia) REFERENCES direccion(altura,idCalle,idLocalidad,idProvincia),
 FOREIGN KEY(idTipoInfraccion) REFERENCES tipo_de_infraccion(idTipoInfraccion),
 PRIMARY KEY(idInfraccion)
);
INSERT INTO "infraccion_de_transito" VALUES(idInfraccionChano,alturaCabildo,idCalleCabildo,idLocalidadCABA,idProvinciaBuenosAires,idTipoInfraccionExcesoVelocidad);

-- entidad Persona con Licencia
CREATE TABLE persona_con_licencia (
 dni INTEGER NOT NULL,
 FOREIGN KEY(dni) REFERENCES persona(dni),
 PRIMARY KEY(dni)
);
INSERT INTO "persona_con_licencia" VALUES(dniChano);
INSERT INTO "persona_con_licencia" VALUES(dniBeto);
INSERT INTO "persona_con_licencia" VALUES(dniAna);

-- entidad Licencia
CREATE TABLE licencia (
 nroLicencia INTEGER NOT NULL,
 dni INTEGER NOT NULL,
 expedicion DATE NOT NULL,
 expiracion DATE NOT NULL,
 FOREIGN KEY(dni) REFERENCES persona_con_licencia(dni),
 PRIMARY KEY (nroLicencia, dni)
);
INSERT INTO "licencia" VALUES(nroLicenciaChano,dniChano,'01/01/2015','01/01/2016');
INSERT INTO "licencia" VALUES(nroLicenciaBeto,dniBeto,'01/01/2015','01/01/2016');
INSERT INTO "licencia" VALUES(nroLicenciaAna,dniAna,'06/06/2015','06/06/2016');

-- entidad Compania de Seguros
CREATE TABLE compania_de_seguro (
 cuit INTEGER NOT NULL,
 nombre VARCHAR(255) NOT NULL,
 PRIMARY KEY(cuit)
);
INSERT INTO "compania_de_seguro" VALUES(cuitLaCaja,'La Caja');

-- entidad Tipo de Cobertura
CREATE TABLE tipo_de_cobertura (
 idTipoCobertura INTEGER NOT NULL,
 descripcion VARCHAR(255) NOT NULL,
 PRIMARY KEY(idTipoCobertura)
);
INSERT INTO "tipo_de_cobertura" VALUES(idTipoCoberturaTotal,'cobertura total.');
INSERT INTO tipo_de_cobertura VALUES(idTipoCoberturaRobo,'cobertura frente a robos');

-- entidad Tipo de Vehiculo
CREATE TABLE tipo_de_vehiculo (
 idTipoVehiculo INTEGER NOT NULL,
 descripcion VARCHAR(255) NOT NULL,
 PRIMARY KEY(idTipoVehiculo)
);
INSERT INTO "tipo_de_vehiculo" VALUES(idTipoVehiculoAuto,'Auto');
INSERT INTO "tipo_de_vehiculo" VALUES(idTipoVehiculoCamioneta,'Camioneta');
INSERT INTO tipo_de_vehiculo VALUES(idTipoVehiculoCombi,'Combi');
INSERT INTO tipo_de_vehiculo VALUES(idTipoVehiculoMoto,'Moto');

-- entidad Categoria de Coche
CREATE TABLE categoria_de_vehiculo (
 idCategoria INTEGER NOT NULL,
 descripcion VARCHAR(255) NOT NULL,
 PRIMARY KEY(idCategoria)
);
INSERT INTO "categoria_de_vehiculo" VALUES(idCategoriaGamaMedia,'Gama media');
INSERT INTO "categoria_de_vehiculo" VALUES(idCategoriaGamaAlta,'Gama alta');

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
INSERT INTO "vehiculo" VALUES(nroPatenteChano1,'01/01/2010',idCategoriaGamaAlta,idTipoVehiculoCamioneta,dniChano);
INSERT INTO "vehiculo" VALUES(nroPatenteAna,'01/01/2009',idCategoriaGamaMedia,idTipoVehiculoAuto,dniAna);
INSERT INTO vehiculo VALUES(nroPatenteChano2,'02/02/2010',idCategoriaGamaMedia,idTipoVehiculoAuto,dniChano);
INSERT INTO vehiculo VALUES(nroPatenteChano3,'03/03/2010',idCategoriaGamaMedia,idTipoVehiculoAuto,dniChano);
INSERT INTO vehiculo VALUES(nroPatenteBeto,'01/01/1998',idCategoriaGamaMedia,idTipoVehiculoAuto,dniBeto);

-- entidad Seguro
CREATE TABLE seguro (
 idSeguro INTEGER NOT NULL,
 cuit INTEGER NOT NULL,
 idTipoCobertura INTEGER NOT NULL,
 nroPatente INTEGER NOT NULL,
 FOREIGN KEY(cuit) REFERENCES compania_de_seguro(cuit),
 FOREIGN KEY(idTipoCobertura) REFERENCES tipo_de_cobertura(idTipoCobertura),
 FOREIGN KEY(nroPatente) REFERENCES vehiculo(nroPatente),
 PRIMARY KEY(idSeguro)
);
INSERT INTO "seguro" VALUES(idSeguroAna,cuitLaCaja,idTipoCoberturaTotal,nroPatenteAna);

-- relacion cedula, entre Vehiculo y Persona con Licencia
CREATE TABLE cedula (
 nroPatente CHARACTER(6) NOT NULL,
 dni INTEGER NOT NULL,
 FOREIGN KEY(nroPatente) REFERENCES vehiculo(nroPatente),
 FOREIGN KEY(dni) REFERENCES persona_con_licencia(dni),
 PRIMARY KEY(nroPatente, dni)
);
INSERT INTO "cedula" VALUES(nroPatenteChano3,dniChano);
INSERT INTO "cedula" VALUES(nroPatenteChano2,dniChano);
INSERT INTO "cedula" VALUES(nroPatenteChano1,dniChano);
INSERT INTO "cedula" VALUES(nroPatenteAna,dniAna);

-- relacion protagoniza, entre Siniesto y Vehiculo
CREATE TABLE siniestro_protagoniza_vehiculo (
 nroPatente CHARACTER(6) NOT NULL,
 idSiniestro INTEGER NOT NULL,
 FOREIGN KEY(nroPatente) REFERENCES vehiculo(nroPatente),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 PRIMARY KEY(nroPatente, idSiniestro)
);
INSERT INTO "siniestro_protagoniza_vehiculo" VALUES(nroPatenteAna,idSiniestroChano);

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
INSERT INTO "siniestro_vehiculo_persona" VALUES(nroPatenteChano1,idSiniestroChano,dniChano,True);
INSERT INTO siniestro_vehiculo_persona VALUES(nroPatenteChano2,idSiniestro2,dniChano,True);
INSERT INTO siniestro_vehiculo_persona VALUES(nroPatenteBeto,idSiniestro2,dniBeto,False);
INSERT INTO siniestro_vehiculo_persona VALUES(nroPatenteChano1,idSiniestroVuelco,dniChano,True);

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
INSERT INTO "persona_en_vehiculo_comete_infraccion" VALUES(nroPatenteChano1,dniChano,idInfraccionChano);

COMMIT;
