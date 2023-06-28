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