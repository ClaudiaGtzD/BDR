DROP VIEW IF EXISTS moda_tiempo_respuesta;
CREATE VIEW moda_tiempo_respuesta as
SELECT d.* FROM datosqueja d
INNER JOIN	(SELECT tiempo_respuesta, count(*) as pcount
	FROM quejas
	GROUP BY tiempo_respuesta
	HAVING pcount = (SELECT max(moda) AS moda
		FROM (SELECT tiempo_respuesta, count(*) as moda
			FROM quejas
			GROUP BY tiempo_respuesta) AS x)) AS r
		ON r.tiempo_respuesta = d.tiempo_respuesta;