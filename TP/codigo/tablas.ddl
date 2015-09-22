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

