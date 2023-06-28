DROP VIEW IF EXISTS obtenerSubasuntosRelacionados;

CREATE VIEW obtenerSubasuntosRelacionados AS
SELECT as2.id AS id_asunto_subasunto, id_asunto, as2.id_subasunto AS id_subasunto_as2, s.id AS id_subasunto, descripcion
FROM asunto_subasuntos as2 
RIGHT JOIN subasuntos s
	ON as2.id_subasunto = s.id

