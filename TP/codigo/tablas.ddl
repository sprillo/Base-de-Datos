-- Tabla Provincia
CREATE TABLE provincia (
 idProvincia INTEGER NOT NULL,
 nombre VARCHAR(255) NOT NULL,
 PRIMARY KEY(idProvincia)
);

-- Tabla Localidad
CREATE TABLE localidad (
 idLocalidad INTEGER NOT NULL,
 nombre VARCHAR(255) DEFAULT NULL,
 idProvincia INTEGER NOT NULL,
 PRIMARY KEY(idLocalidad),
 FOREIGN KEY(idProvincia) REFERENCES provincia(idProvincia)
);

-- Tabla Calle
CREATE TABLE calle (
 idCalle INTEGER NOT NULL,
 nombre VARCHAR(255) DEFAULT NULL,
 idLocalidad INTEGER NOT NULL,
 PRIMARY KEY(idCalle),
 FOREIGN KEY(idLocalidad) REFERENCES localidad(idLocalidad)
);

-- Tabla Direccion
CREATE TABLE direccion (
 idDireccion INTEGER NOT NULL,
 altura INTEGER NOT NULL,
 idCalle INTEGER NOT NULL,
 PRIMARY KEY(idDireccion),
 FOREIGN KEY(idCalle) REFERENCES calle(idCalle)
);

-- Tabla Tipo de Lugar
CREATE TABLE tipo_de_lugar (
 idTipoLugar INTEGER NOT NULL,
 tipo VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoLugar)
);

-- Tabla relacion tiene, entre Direccion y Tipo de lugar
CREATE TABLE direccion_tiene_tipo_de_lugar (
 idDireccion INTEGER NOT NULL,
 idTipoLugar INTEGER NOT NULL,
 longitud INTEGER NOT NULL,
 PRIMARY KEY(idDireccion, idTipoLugar),
 FOREIGN KEY(idDireccion) REFERENCES direccion(idDireccion),
 FOREIGN KEY(idTipoLugar) REFERENCES tipo_de_lugar(idTipoLugar)
);

-- Tabla Comisaria
CREATE TABLE comisaria (
 nroComisaria INTEGER NOT NULL,
 nombre VARCHAR(255) DEFAULT NULL,
 idDireccion INTEGER NOT NULL,
 PRIMARY KEY(nroComisaria),
 FOREIGN KEY(idDireccion) REFERENCES direccion(idDireccion)
);

-- Tabla Denuncia
CREATE TABLE denuncia (
 nroDenuncia INTEGER NOT NULL,
 descripcion VARCHAR(255) DEFAULT NULL,
 nroComisaria INTEGER NOT NULL,
 PRIMARY KEY(nroDenuncia),
 FOREIGN KEY(nroComisaria) REFERENCES comisaria(nroComisaria)
);

-- Tabla Tipo de Colision
CREATE TABLE tipo_de_colision (
 idTipoColision INTEGER NOT NULL,
 tipo VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoColision)
);

-- Tabla Modalidad
CREATE TABLE modalidad (
 idTipoModalidad INTEGER NOT NULL,
 tipo VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoModalidad)
);

-- Tabla Siniestro
CREATE TABLE siniestro (
 idSiniestro INTEGER NOT NULL,
 fecha DATETIME DEFAULT NULL,
 nroDenuncia INTEGER NOT NULL,
 idDireccion INTEGER NOT NULL,
 PRIMARY KEY(idSiniestro),
 FOREIGN KEY(nroDenuncia) REFERENCES denuncia(nroDenuncia),
 FOREIGN KEY(idDireccion) REFERENCES direccion(idDireccion)
);

-- Tabla relacion damnifica, entre Siniestro y Tipo de Colision
CREATE TABLE siniestro_damnifica_tipo_de_colision (
 idSiniestro INTEGER NOT NULL,
 idTipoColision INTEGER NOT NULL,
 PRIMARY KEY(idSiniestro, idTipoColision),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 FOREIGN KEY(idTipoColision) REFERENCES tipo_de_colision(idTipoColision)
);

-- Tabla relacion formaDe, entre Siniestro y Modalidad
CREATE TABLE siniestro_forma_de_modalidad (
 idSiniestro INTEGER NOT NULL,
 idTipoModalidad INTEGER NOT NULL,
 PRIMARY KEY(idSiniestro, idTipoModalidad),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 FOREIGN KEY(idTipoModalidad) REFERENCES modalidad(idTipoModalidad)
);

-- Tabla Pavimento
CREATE TABLE pavimento (
 idPavimento INTEGER NOT NULL,
 descripcion VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idPavimento)
);

-- Tabla Estudio
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

-- Tabla Persona
CREATE TABLE persona (
 dni INTEGER NOT NULL,
 nombre VARCHAR(255) NOT NULL,
 apellido VARCHAR(255) NOT NULL,
 nacimiento DATE NOT NULL,
 PRIMARY KEY(dni)
);

-- Tabla relacion Testigo, entre Siniestro y Persona
CREATE TABLE siniestro_testigo_persona (
 idSiniestro INTEGER NOT NULL,
 dni INTEGER NOT NULL,
 PRIMARY KEY(idSiniestro, dni),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 FOREIGN KEY(dni) REFERENCES persona(dni)
);

-- Tabla Cinturon
CREATE TABLE cinturon (
 idEstudio INTEGER NOT NULL,
 dni INTEGER NOT NULL,
 si_o_no BOOLEAN NOT NULL,
 PRIMARY KEY(idEstudio, dni),
 FOREIGN KEY(idEstudio) REFERENCES estudio(idEstudio),
 FOREIGN KEY(dni) REFERENCES persona(dni)
);

-- Tabla Tipo de Delito
CREATE TABLE tipo_de_delito (
 idTipoDelito INTEGER NOT NULL,
 descripcion VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(idTipoDelito)
);

-- Tabla Antecedente penal
CREATE TABLE antecedente_penal (
 idAntecedente INTEGER NOT NULL PRIMARY KEY,
 fecha Date NOT NULL,
 haCometido INTEGER NOT NULL,
 es INTEGER NOT NULL,
 FOREIGN KEY(haCometido) REFERENCES persona(dni),
 FOREIGN KEY(es) REFERENCES tipo_delito(idTipo)
);

-- Tabla Tipo Infraccion
CREATE TABLE tipo_infraccion (
 idTipo INTEGER NOT NULL PRIMARY KEY,
 descripcion VARCHAR(255) DEFAULT NULL
);

-- Tabla Antecedente penal
CREATE TABLE infraccion_transito (
 idInfraccion INTEGER NOT NULL PRIMARY KEY,
 ocurreEn INTEGER NOT NULL,
 violo INTEGER NOT NULL,
 FOREIGN KEY(ocurreEn) REFERENCES direccion(idDireccion),
 FOREIGN KEY(violo) REFERENCES tipo_infraccion(idTipo)
);

-- Tabla Persona con Licencia
CREATE TABLE persona_con_licencia (
 dni INTEGER NOT NULL PRIMARY KEY,
 FOREIGN KEY(dni) REFERENCES persona(dni)
);

-- Licencia
CREATE TABLE licencia (
 nroLicencia INTEGER NOT NULL,
 dni INTEGER NOT NULL,
 expedicion DATE NOT NULL,
 expiracion DATE NOT NULL,
 FOREIGN KEY(dni) REFERENCES persona_con_licencia(dni),
 PRIMARY KEY (nroLicencia, dni) 
);

-- Tabla Compania Seguros
CREATE TABLE compania_seguro (
 cuit INTEGER NOT NULL PRIMARY KEY,
 nombre VARCHAR(255) NOT NULL
);

-- Tabla Cobertura
CREATE TABLE cobertura (
 idTipo INTEGER NOT NULL PRIMARY KEY,
 descripcion VARCHAR(255) NOT NULL
);

-- Tabla Seguros
CREATE TABLE seguro (
 idSeguro INTEGER NOT NULL PRIMARY KEY,
 emitidaPor INTEGER NOT NULL,
 proteccion INTEGER NOT NULL,
 FOREIGN KEY(emitidaPor) REFERENCES compania_seguro(cuit),
 FOREIGN KEY(proteccion) REFERENCES cobertura(idTipo)
);

-- Tabla Tipo Vehiculo
CREATE TABLE tipo_vehiculo (
 idTipo INTEGER NOT NULL PRIMARY KEY,
 descripcion VARCHAR(255) NOT NULL
);

-- Tabla Categoria Vehiculo
CREATE TABLE categoria_vehiculo (
 idCategoria INTEGER NOT NULL PRIMARY KEY,
 descripcion VARCHAR(255) NOT NULL
);

-- Tabla Vehiculo
CREATE TABLE vehiculo (
 nroPatente CHARACTER(6) NOT NULL PRIMARY KEY,
 fechaFabricacion DATE NOT NULL,
 valor INTEGER NOT NULL,
 clase INTEGER NOT NULL,
 protegido INTEGER NOT NULL,
 dueno INTEGER NOT NULL,
 FOREIGN KEY(valor) REFERENCES categoria_vehiculo(idCategoria),
 FOREIGN KEY(clase) REFERENCES tipo_vehiculo(idTipo),
 FOREIGN KEY(protegido) REFERENCES seguro(idSeguro),
 FOREIGN KEY(dueno) REFERENCES persona(dni)
);

-- Tabla Cedula
CREATE TABLE cedula (
 nroPatente CHARACTER(6) NOT NULL,
 dni INTEGER NOT NULL,
 FOREIGN KEY(nroPatente) REFERENCES vehiculo(nroPatente),
 FOREIGN KEY(dni) REFERENCES persona_con_licencia(dni),
 PRIMARY KEY (nroPatente, dni)
);

-- Tabla Protagoniza
CREATE TABLE protagoniza (
 nroPatente CHARACTER(6) NOT NULL,
 idSiniestro INTEGER NOT NULL,
 FOREIGN KEY(nroPatente) REFERENCES vehiculo(nroPatente),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 PRIMARY KEY (nroPatente, idSiniestro)
);

-- Tabla Accidente
CREATE TABLE accidente (
 nroPatente CHARACTER(6) NOT NULL,
 idSiniestro INTEGER NOT NULL,
 dni INTEGER NOT NULL,
 FOREIGN KEY(nroPatente) REFERENCES vehiculo(nroPatente),
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 FOREIGN KEY(dni) REFERENCES persona(dni), 
 PRIMARY KEY (nroPatente, idSiniestro)
);

-- Tabla Infraccion
CREATE TABLE infraccion (
 nroPatente CHARACTER(6) NOT NULL,
 dni INTEGER NOT NULL,
 idInfraccion INTEGER NOT NULL,
 FOREIGN KEY(nroPatente) REFERENCES vehiculo(nroPatente),
 FOREIGN KEY(dni) REFERENCES persona(dni), 
 FOREIGN KEY(idInfraccion) REFERENCES infraccion_transito(idInfraccion), 
 PRIMARY KEY (nroPatente, dni, idInfraccion)
);
