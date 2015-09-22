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

