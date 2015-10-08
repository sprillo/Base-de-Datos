SELECT m.idTipoModalidad, j.nroLicencia, j.dni, COUNT(*)
FROM (modalidad m JOIN 
		siniestro_forma_de_modalidad sm JOIN 
		siniestro_vehiculo_persona svp JOIN 
		persona_con_licencia pl JOIN 
		licencia l) j
WHERE m.idTipoModalidad = 0
GROUP BY j.nroLicencia;
