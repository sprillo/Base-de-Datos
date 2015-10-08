SELECT s.fecha, c.nombre, d.altura, lo.nombre, pr.nombre, m.tipo, tc.tipo
FROM siniestro_vehiculo_persona svp, 
		persona p, 
		persona_con_licencia pl, 
		licencia l, 
		siniestro s,
		siniestro_forma_de_modalidad f, 
		modalidad m, 
		direccion d, 
		calle c, 
		localidad lo, 
		provincia pr, 
		siniestro_damnifica_tipo_de_colision dam, 
		tipo_de_colision tc
WHERE l.nroLicencia = 0		-- la licencia del Chano
-- join entre licencia, persona_con_licencia, persona y siniestro_vehiculo_persona
AND svp.dni = p.dni
AND p.dni = pl.dni
AND pl.dni = l.dni
-- join entre modalidad, siniestro_forma_de_modalidad, siniestro y siniestro_vehiculo_persona
AND s.idSiniestro = svp.idSiniestro
AND f.idSiniestro = s.idSiniestro
AND f.idTipoModalidad = m.idTipoModalidad
-- join entre siniestro, direccion, calle, localidad y provincia
AND s.idDireccion = d.idDireccion
AND d.idCalle = c.idCalle
AND c.idLocalidad = lo.idLocalidad
AND lo.idProvincia = pr.idProvincia
-- join entre siniestro, siniestro_damnifica_tipo_de_colision y tipo_de_colision
AND s.idSiniestro = dam.idSiniestro
AND dam.idTipoColision = tc.idTipoColision;
