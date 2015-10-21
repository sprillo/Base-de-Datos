SELECT s.fecha, c.nombre, d.altura, lo.nombre, pr.nombre, m.tipo, tc.tipo, svp.culpable, au.cantidad_autos
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
		tipo_de_colision tc,

		(SELECT COUNT(*) cantidad_autos
			FROM licencia l2 NATURAL JOIN 
				 persona_con_licencia pl2 NATURAL JOIN
				 cedula NATURAL JOIN
				 vehiculo
			WHERE l2.nroLicencia = 0 -- la licencia del Chano
		) au
		-- vehiculo v
WHERE l.nroLicencia = 0		-- la licencia del Chano
-- join entre licencia, persona_con_licencia, persona y siniestro_vehiculo_persona
AND pl.dni = l.dni
AND p.dni = pl.dni
AND svp.dni = p.dni
-- join entre modalidad, siniestro_forma_de_modalidad, siniestro y siniestro_vehiculo_persona
AND s.idSiniestro = svp.idSiniestro
AND f.idSiniestro = s.idSiniestro
AND f.idTipoModalidad = m.idTipoModalidad
-- join entre siniestro, siniestro_damnifica_tipo_de_colision y tipo_de_colision
AND s.idSiniestro = dam.idSiniestro
AND dam.idTipoColision = tc.idTipoColision
-- join entre siniestro, direccion, calle, localidad y provincia
AND s.altura = d.altura
AND s.idCalle = d.idCalle
AND s.idLocalidad = d.idLocalidad
AND s.idProvincia = d.idProvincia
-- join entre direccion y calle
AND d.idCalle = c.idCalle
AND d.idLocalidad = c.idLocalidad
AND d.idProvincia = c.idProvincia
-- join entre calle y localidad
AND c.idLocalidad = lo.idLocalidad
AND c.idProvincia = lo.idProvincia
-- join entre localidad y provincia
AND lo.idProvincia = pr.idProvincia;
