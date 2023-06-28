# MCD - Base de Datos Relacionales - Tarea 8

## 1421582 - Claudia Lissette Gutiérrez Díaz

---

Para esta tarea se crearon 3 vistas y 1 trigger, los cuales explicaré a continuación:

### DatosQueja

```sql
DROP VIEW IF EXISTS DatosQueja;
CREATE VIEW DatosQueja AS 
	SELECT q.id,
		q.fecha_recepcion,
		q.fecha_envio,
		p.nombre AS producto,
		s.nombre AS subproducto,
		a.descripcion AS asunto,
		sa.descripcion AS subasunto,
		q.descripcion_queja,
		q.descripcion_solucion,
		c.nombre AS compania,
		est.nombre AS estado,
		suc.codigo_postal,
		q.etiquetas,
		ea.descripcion AS estatus_autorizacion,
		mc.nombre AS medio_comunicacion,
		eq.descripcion AS estatus_queja,
		CASE WHEN q.se_abre_disputa = 1 THEN 'Sí' ELSE 'No' END AS se_abre_disputa,
		tiempo_respuesta
	FROM quejas q
	LEFT JOIN producto_subproductos ps
		ON ps.id = q.id_producto_subproducto 
	LEFT JOIN productos p
		ON p.id  = ps.id_producto 
	LEFT JOIN subproductos s 
		ON s.id = ps.id_subproducto
	LEFT JOIN asunto_subasuntos as2
		ON as2.id  = q.id_asunto_subasunto
	LEFT JOIN asuntos a
		ON a.id  = as2.id_asunto  
	LEFT JOIN subasuntos sa 
		ON sa.id = as2.id_subasunto 
	INNER JOIN sucursales suc
		ON suc.id  = q.id_sucursal 
	LEFT JOIN companias c
		ON c.id = suc.id_compania 
	LEFT JOIN estados est
		ON est.id = suc.id_estado
	INNER JOIN estatus_autorizacion ea
		ON ea.id = q.id_estatus_autorizacion 
	INNER JOIN medios_comunicacion mc 
		ON mc.id = q.id_medio_comunicacion 
	INNER JOIN estatus_quejas eq 
		ON eq.id = q.id_estatus_queja
```

Esta es la vista más importante, puesto que te trae todo el conjunto de datos de quejas ya con sus descripciones, que sería el producto final de salida.

---

### obtenerSubasuntosRelacionados

```sql
DROP VIEW IF EXISTS obtenerSubasuntosRelacionados;

CREATE VIEW obtenerSubasuntosRelacionados AS
SELECT as2.id AS id_asunto_subasunto, id_asunto, as2.id_subasunto AS id_subasunto_as2, s.id AS id_subasunto, descripcion
FROM asunto_subasuntos as2 
RIGHT JOIN subasuntos s
	ON as2.id_subasunto = s.id
```

Esta vista es con motivo para ejemplificar el RIGHT JOIN, te trae todos los subasuntos dados de alta en el sistema y te muestra si ya se encuentra relacionado o no.

---

### moda_tiempo_respuesta

```sql
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
```

Esto pone en práctica el ejercicio de la tarea 6 donde se tenía que obtener la moda, en ese entonces, yo elegí la moda del tiempo de respuesta. Ahora acá le añado la funcionalidad para soportar multimodal y además me traigo la información de quejas del tiempo de respuesta de moda.

---

### calculartiemporespuesta

```sql
DELIMITER $$
CREATE TRIGGER calculartiemporespuesta
AFTER INSERT ON quejas
FOR EACH ROW
BEGIN
	UPDATE quejas SET tiempo_respuesta = datediff(fecha_envio, fecha_recepcion);
END;$$
```

Este trigger es el ejercicio de para cuando se de de alta una queja nueva, se recalculen los tiempos de respuesta de todas las filas.
