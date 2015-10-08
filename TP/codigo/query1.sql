SELECT s.fecha, c.nombre, d.altura, lo.nombre, pr.nombre, m.tipo
FROM accidente a, persona p, persona_con_licencia pl, licencia l, siniestro s, siniestro_forma_de_modalidad f, modalidad m, direccion d, calle c, localidad lo, provincia pr, siniestro_damnifica_tipo_de_colision dam, tipo_de_colision tc
WHERE a.dni = p.dni
AND p.dni = pl.dni
AND pl.dni = l.dni
AND l.nroLicencia = 0		-- la licencia del Chano
-- join contra modalidad
AND s.idSiniestro = a.idSiniestro
AND f.idSiniestro = s.idSiniestro
AND f.idTipoModalidad = m.idTipoModalidad
-- join contra direccion
AND s.idDireccion = d.idDireccion
AND d.idCalle = c.idCalle
AND c.idLocalidad = lo.idLocalidad
AND lo.idProvincia = pr.idProvincia
-- esto es para joinear con el tipo
AND s.idSiniestro = dam.idSiniestro
AND dam.idTipoColision = tc.idTipoColision;
