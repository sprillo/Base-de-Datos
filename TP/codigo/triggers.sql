-- Los conductores que pertenecen a un estudio deben ser conductores involucrados en el siniestro de ese estudio.
CREATE TRIGGER conductores_estudiados_en_siniestro BEFORE INSERT ON estudio_cinturon_persona
BEGIN
SELECT CASE
WHEN (NOT EXISTS (	SELECT *
					FROM siniestro_vehiculo_persona svp
					WHERE svp.dni = NEW.dni AND svp.idSiniestro = (SELECT e.idSiniestro FROM estudio e WHERE e.idEstudio = NEW.idEstudio)))
THEN RAISE(ABORT, 'El conductor no estuvo involucrado en el siniestro del estudio.')
END;
END;