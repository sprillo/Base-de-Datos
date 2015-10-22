SELECT m.idTipoModalidad, j.nroLicencia, j.dni, COUNT(*)
FROM (modalidad m NATURAL JOIN 
		siniestro_forma_de_modalidad sm NATURAL JOIN 
		siniestro_vehiculo_persona svp NATURAL JOIN 
		persona_con_licencia pl NATURAL JOIN 
		licencia l) j
WHERE m.idTipoModalidad = 1
GROUP BY j.nroLicencia;