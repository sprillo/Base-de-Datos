-- Tabla Provincia
CREATE TABLE provincia (
 idProvincia INTEGER NOT NULL,
 nombre VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY (idProvincia)
);

-- Tabla Localidad
CREATE TABLE localidad (
 idLocalidad INTEGER NOT NULL PRIMARY KEY,
 nombre VARCHAR(255) DEFAULT NULL,
 tiene INTEGER NOT NULL,
 FOREIGN KEY(tiene) REFERENCES provincia(idProvincia)
);

-- Tabla Calle
CREATE TABLE calle (
 idCalle INTEGER NOT NULL PRIMARY KEY,
 nombre VARCHAR(255) DEFAULT NULL,
 tiene INTEGER NOT NULL,
 FOREIGN KEY(tiene) REFERENCES localidad(idLocalidad)
);

-- Tabla Direccion
CREATE TABLE direccion (
 idDireccion INTEGER NOT NULL PRIMARY KEY,
 altura INTEGER NOT NULL,
 tiene INTEGER NOT NULL,
 FOREIGN KEY(tiene) REFERENCES calle(idCalle)
);

-- Tabla Tipo de Lugar
CREATE TABLE tipo_lugar (
 idTipo INTEGER NOT NULL PRIMARY KEY,
 tipo VARCHAR(255) DEFAULT NULL
);

-- Tabla Tiene
CREATE TABLE tiene (
 idDireccion INTEGER NOT NULL,
 idTipo INTEGER NOT NULL,
 longitud INTEGER NOT NULL,
 PRIMARY KEY (idDireccion, idTipo),
 FOREIGN KEY(idDireccion) REFERENCES direccion(idDireccion),
 FOREIGN KEY(idTipo) REFERENCES tipo_lugar(idTipo)
);

-- Tabla Comisaria
CREATE TABLE comisaria (
 nroComisaria INTEGER NOT NULL PRIMARY KEY,
 nombre VARCHAR(255) DEFAULT NULL,
 tiene INTEGER NOT NULL,
 FOREIGN KEY(tiene) REFERENCES direccion(idDireccion)
);

-- Tabla Denuncia
CREATE TABLE denuncia (
 nroDenuncia INTEGER NOT NULL PRIMARY KEY,
 descripcion VARCHAR(255) DEFAULT NULL,
 hechaEn INTEGER NOT NULL,
 FOREIGN KEY(hechaEn) REFERENCES comisaria(nroComisaria)
);

-- Tabla Tipo Colision
CREATE TABLE tipo_colision (
 idTipo INTEGER NOT NULL PRIMARY KEY,
 tipo VARCHAR(255) DEFAULT NULL
);

-- Tabla Modalidad
CREATE TABLE modalidad (
 idTipo INTEGER NOT NULL PRIMARY KEY,
 tipo VARCHAR(255) DEFAULT NULL
);

-- Tabla Siniestro
CREATE TABLE siniestro (
 idSiniestro INTEGER NOT NULL PRIMARY KEY,
 fecha DATETIME DEFAULT NULL,
 seRegistra INTEGER NOT NULL,
 ocurre INTEGER NOT NULL,
 FOREIGN KEY(seRegistra) REFERENCES denuncia(nroDenuncia),
 FOREIGN KEY(ocurre) REFERENCES direccion(idDireccion)
);

-- Tabla Damnifica
CREATE TABLE damnifica (
 idSiniestro INTEGER NOT NULL,
 idTipo INTEGER NOT NULL,
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 FOREIGN KEY(idTipo) REFERENCES tipo_colision(idTipo),
 PRIMARY KEY (idSiniestro, idTipo)
);

-- Tabla Forma De
CREATE TABLE forma_de (
 idSiniestro INTEGER NOT NULL,
 idTipo INTEGER NOT NULL,
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 FOREIGN KEY(idTipo) REFERENCES modalidad(idTipo),
 PRIMARY KEY (idSiniestro, idTipo)
);

-- Tabla Pavimento
CREATE TABLE pavimento (
 idPavimento INTEGER NOT NULL PRIMARY KEY,
 descripcion VARCHAR(255) DEFAULT NULL
);

-- Tabla Estudio
CREATE TABLE estudio (
 idEstudio INTEGER NOT NULL,
 causaProbable VARCHAR(255) DEFAULT NULL,
 estadoVia VARCHAR(255) DEFAULT NULL,
 estadoIluminacion VARCHAR(255) DEFAULT NULL,
 seguridadPeatonal BOOLEAN DEFAULT NULL,
 tipoVia INTEGER NOT NULL,
 perita INTEGER NOT NULL,
 FOREIGN KEY(tipoVia) REFERENCES modalidad(idTipo),
 FOREIGN KEY(perita) REFERENCES siniestro(idSiniestro) ,
 PRIMARY KEY (idEstudio, perita)
);

-- Tabla Persona
CREATE TABLE persona (
 dni INTEGER NOT NULL PRIMARY KEY,
 nombre VARCHAR(255) NOT NULL,
 apellido VARCHAR(255) NOT NULL,
 nacimiento DATE NOT NULL
);

-- Tabla Testigo
CREATE TABLE testigo (
 idSiniestro INTEGER NOT NULL,
 dni INTEGER NOT NULL,
 FOREIGN KEY(idSiniestro) REFERENCES siniestro(idSiniestro),
 FOREIGN KEY(dni) REFERENCES persona(dni),
 PRIMARY KEY (idSiniestro, dni)
);

-- Tabla Cinturon
CREATE TABLE cinturon (
 idEstudio INTEGER NOT NULL,
 dni INTEGER NOT NULL,
 tiene BOOLEAN NOT NULL,
 FOREIGN KEY(idEstudio) REFERENCES estudio(idEstudio),
 FOREIGN KEY(dni) REFERENCES persona(dni),
 PRIMARY KEY (idEstudio, dni)
);

-- Tabla Tipo Delito
CREATE TABLE tipo_delito (
 idTipo INTEGER NOT NULL PRIMARY KEY,
 descripcion VARCHAR(255) DEFAULT NULL
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

