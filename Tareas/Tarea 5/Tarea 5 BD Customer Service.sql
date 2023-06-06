/*********************************************
 * UANL
 * FCFM
 * Maestría en Ciencias de Datos
 * Bases de Datos Relacionales
 * 1421582. Claudia Lissette Gutiérrez Díaz
 * Tarea 5: Importación y Exportación
 ********************************************/

USE servicio_clientes;

/* Creamos una tabla madre que contendrá la información tal cual viene del dataset conseguido*/
DROP TABLE IF EXISTS Temporal;
CREATE TABLE Temporal(
	fecha_recepcion varchar(10),
	fecha_envio varchar(10),
	producto varchar(50),
	id_producto int,
	subproducto varchar(50),
	id_subproducto int,
	asunto varchar(50),
	id_asunto int,
	subasunto varchar(50),
	id_subasunto int,
	descripcion_queja varchar(3500),
	descripcion_solucion varchar(3000),
	compania varchar(100),
	id_compania int,
	estado_abbr varchar(100),
	id_estado int,
	estado varchar(200),	
	sucursal varchar(50),
	etiquetas varchar(50),
	estatus_autorizacion varchar(30),
	medio_comunicacion varchar(100),
	estatus_queja varchar(50),
	respuesta_a_tiempo varchar(4),
	se_abre_disputa varchar(30)
);

/*Leemos el archivo .csv*/
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Dataset_servicio_clientes.csv'
	INTO TABLE temporal 
	FIELDS TERMINATED BY ','
	ENCLOSED BY '"'
	LINES TERMINATED BY '\r\n'
	IGNORE 1 LINES 
	(fecha_recepcion, fecha_envio, producto, subproducto, asunto, subasunto, descripcion_queja, descripcion_solucion,
	compania, estado_abbr, estado, sucursal, etiquetas, estatus_autorizacion, medio_comunicacion, estatus_queja,
	respuesta_a_tiempo, se_abre_disputa);

/* Zona de creaciones de índices para acelerar el proceso */
SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_Temporal_id_producto_subproducto'
  )
  ,'SELECT ''index idx_Temporal_id_producto_subproducto EXISTS'' _______;'
  ,'create index idx_Temporal_id_producto_subproducto on Temporal(id_producto, id_subproducto)') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_Temporal_id_asunto_subasunto'
  )
  ,'SELECT ''index idx_Temporal_id_asunto_subasunto EXISTS'' _______;'
  ,'create index idx_Temporal_id_asunto_subasunto on Temporal(id_asunto, id_subasunto)') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_Temporal_sucursales'
  )
  ,'SELECT ''index idx_Temporal_sucursales EXISTS'' _______;'
  ,'create index idx_Temporal_sucursales on Temporal(id_compania, id_estado, sucursal)') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_Temporal_estatus_autorizacion'
  )
  ,'SELECT ''index idx_Temporal_estatus_autorizacion EXISTS'' _______;'
  ,'create index idx_Temporal_estatus_autorizacion on Temporal(estatus_autorizacion)') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_Temporal_medio_comunicacion'
  )
  ,'SELECT ''index idx_Temporal_medio_comunicacion EXISTS'' _______;'
  ,'create index idx_Temporal_medio_comunicacion on Temporal(medio_comunicacion)') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_Temporal_estatus_queja'
  )
  ,'SELECT ''index idx_Temporal_estatus_queja EXISTS'' _______;'
  ,'create index idx_Temporal_estatus_queja on Temporal(estatus_queja)') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_Temporal_producto'
  )
  ,'SELECT ''index idx_Temporal_producto EXISTS'' _______;'
  ,'create index idx_Temporal_producto on Temporal(producto)') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_Temporal_subproducto'
  )
  ,'SELECT ''index idx_Temporal_subproducto EXISTS'' _______;'
  ,'create index idx_Temporal_subproducto on Temporal(subproducto)') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_Temporal_asunto'
  )
  ,'SELECT ''index idx_Temporal_asunto EXISTS'' _______;'
  ,'create index idx_Temporal_asunto on Temporal(asunto)') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_Temporal_subasunto'
  )
  ,'SELECT ''index idx_Temporal_subasunto EXISTS'' _______;'
  ,'create index idx_Temporal_subasunto on Temporal(subasunto)') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_Temporal_compania'
  )
  ,'SELECT ''index idx_Temporal_compania EXISTS'' _______;'
  ,'create index idx_Temporal_compania on Temporal(compania)') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_Temporal_estado_abbr'
  )
  ,'SELECT ''index idx_Temporal_estado_abbr EXISTS'' _______;'
  ,'create index idx_Temporal_estado_abbr on Temporal(estado_abbr)') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_Temporal_estado_abbr'
  )
  ,'SELECT ''index idx_Temporal_estado_abbr EXISTS'' _______;'
  ,'create index idx_Temporal_estado_abbr on Temporal(estado_abbr)') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

/*Insertamos en COMPAÑÍAS los registros que no se han insertado en la Tarea 4*/
SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_companias_nombre'
  )
  ,'ALTER TABLE companias DROP INDEX idx_companias_nombre;'
  ,'SELECT ''index idx_Temporal_estado_abbr EXISTS'' _______;') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

INSERT INTO companias (nombre)
SELECT DISTINCT compania
FROM Temporal t
WHERE NOT EXISTS(SELECT 1
	FROM companias c
	WHERE c.nombre = t.compania)
ORDER BY compania;

CREATE INDEX idx_companias_nombre ON companias (nombre);

UPDATE temporal t
INNER JOIN companias c
	ON c.nombre = t.compania
SET t.id_compania = c.id;

/*Insertamos en ESTADOS los registros que no se han insertado en la Tarea 4*/
SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_estados_abreviacion'
  )
  ,'ALTER TABLE estados DROP INDEX idx_estados_abreviacion;'
  ,'SELECT ''Exists'';') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

INSERT INTO estados (abreviacion, nombre)
SELECT DISTINCT estado_abbr, estado
FROM Temporal t
WHERE NOT EXISTS(SELECT 1
	FROM estados c
	WHERE c.abreviacion = t.estado_abbr)
ORDER BY estado_abbr;

CREATE INDEX idx_estados_abreviacion ON estados (abreviacion);

UPDATE temporal t
INNER JOIN estados e
	ON e.abreviacion = t.estado_abbr
SET t.id_estado = e.id;

/*Insertamos en SUCURSALES los registros que no se han insertado en la Tarea 4*/
INSERT INTO sucursales (id_compania, id_estado, codigo_postal)
SELECT DISTINCT t.id_compania, t.id_estado, t.sucursal
FROM temporal t
WHERE NOT EXISTS (SELECT 1
	FROM sucursales s
	WHERE s.codigo_postal = t.sucursal
	AND s.id_compania = t.id_compania
	AND s.id_estado = t.id_estado);

/*Insertamos en MEDIOS DE COMUNICACIÓN los registros que no se han insertado en la Tarea 4*/
SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_medios_comunicacion_nombre'
  )
  ,'ALTER TABLE medios_comunicacion DROP INDEX idx_medios_comunicacion_nombre;'
  ,'SELECT ''Exists'';') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

INSERT INTO medios_comunicacion (nombre)
SELECT DISTINCT t.medio_comunicacion
FROM temporal t
WHERE NOT EXISTS (SELECT 1
	FROM medios_comunicacion mc
	WHERE mc.nombre = t.medio_comunicacion);

CREATE INDEX idx_medios_comunicacion_nombre ON medios_comunicacion (nombre);

/*Insertamos en ESTATUS_QUEJAS los registros que no se han insertado en la Tarea 4*/
SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_estatus_quejas_descripcion'
  )
  ,'ALTER TABLE estatus_quejas DROP INDEX idx_estatus_quejas_descripcion;'
  ,'SELECT ''Exists'';') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

INSERT INTO estatus_quejas (descripcion)
SELECT DISTINCT t.estatus_queja
FROM temporal t
WHERE NOT EXISTS (SELECT 1
	FROM estatus_quejas eq
	WHERE eq.descripcion = t.estatus_queja);

CREATE INDEX idx_estatus_quejas_descripcion ON estatus_quejas (descripcion);

/*Insertamos en PRODUCTOS los registros que no se han insertado en la Tarea 4*/
SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_productos_nombre'
  )
  ,'ALTER TABLE productos DROP INDEX idx_productos_nombre;'
  ,'SELECT ''Exists'';') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

INSERT INTO productos (nombre)
SELECT DISTINCT t.producto
FROM temporal t
WHERE NOT EXISTS (SELECT 1
	FROM productos p
	WHERE p.nombre = t.producto);

CREATE INDEX idx_productos_nombre ON productos (nombre);

UPDATE temporal t
INNER JOIN productos p
	ON p.nombre = t.producto
SET t.id_producto = p.id;

/*Insertamos en SUBPRODUCTOS los registros que no se han insertado en la Tarea 4*/
SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_subproductos_nombre'
  )
  ,'ALTER TABLE subproductos DROP INDEX idx_subproductos_nombre;'
  ,'SELECT ''Exists'';') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

INSERT INTO subproductos (nombre)
SELECT DISTINCT t.subproducto
FROM temporal t
WHERE NOT EXISTS (SELECT 1
	FROM subproductos s
	WHERE s.nombre = t.subproducto);

CREATE INDEX idx_subproductos_nombre ON subproductos (nombre);

UPDATE temporal t
INNER JOIN subproductos s
	ON s.nombre = t.subproducto
SET t.id_subproducto = s.id;

/*Insertamos en PRODUCTOS-SUBPRODUCTOS los registros que no se han insertado en la Tarea 4*/
INSERT INTO producto_subproductos (id_producto, id_subproducto)
SELECT DISTINCT t.id_producto, t.id_subproducto
FROM temporal t
WHERE NOT EXISTS (SELECT 1
	FROM producto_subproductos ps
	WHERE ps.id_producto = t.id_producto
	AND ps.id_subproducto = t.id_subproducto);

/*Insertamos en ASUNTOS los registros que no se han insertado en la Tarea 4*/
SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_asuntos_descripcion'
  )
  ,'ALTER TABLE asuntos DROP INDEX idx_asuntos_descripcion;'
  ,'SELECT ''Exists'';') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

INSERT INTO asuntos (descripcion)
SELECT DISTINCT t.asunto
FROM temporal t
WHERE NOT EXISTS (SELECT 1
	FROM asuntos a
	WHERE a.descripcion = t.asunto);

CREATE INDEX idx_asuntos_descripcion ON asuntos (descripcion);

UPDATE temporal t
INNER JOIN asuntos a
	ON a.descripcion = t.asunto
SET t.id_asunto = a.id;

/*Insertamos en SUBASUNTOS los registros que no se han insertado en la Tarea 4*/
SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_subasuntos_descripcion'
  )
  ,'ALTER TABLE subasuntos DROP INDEX idx_subasuntos_descripcion;'
  ,'SELECT ''Exists'';') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

INSERT INTO subasuntos (descripcion)
SELECT DISTINCT t.subasunto
FROM temporal t
WHERE NOT EXISTS (SELECT 1
	FROM subasuntos s
	WHERE s.descripcion = t.subasunto);

CREATE INDEX idx_subasuntos_descripcion ON subasuntos (descripcion);

UPDATE temporal t
INNER JOIN subasuntos s 
	ON s.descripcion = t.subasunto
SET t.id_subasunto = s.id;

/*Insertamos en ASUNTO-SUBASUNTO los registros que no se han insertado en la Tarea 4*/
INSERT INTO asunto_subasuntos (id_asunto, id_subasunto)
SELECT DISTINCT t.id_asunto, t.id_subasunto
FROM temporal t
WHERE NOT EXISTS(SELECT	1
	FROM asunto_subasuntos asu
	WHERE asu.id_asunto = t.id_asunto
	AND asu.id_subasunto = t.id_subasunto);

/*Insertamos en ESTATUS_AUTORIZACION los registros que no se han insertado en la Tarea 4*/
SELECT IF (
  EXISTS(
    SELECT DISTINCT index_name FROM information_schema.statistics 
    WHERE index_name LIKE 'idx_estatus_autorizacion_descripcion'
  )
  ,'ALTER TABLE estatus_autorizacion DROP INDEX idx_estatus_autorizacion_descripcion;'
  ,'SELECT ''Exists'';') INTO @a;
PREPARE stmt1 FROM @a;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

INSERT INTO estatus_autorizacion (descripcion)
SELECT DISTINCT t.estatus_autorizacion
FROM temporal t
WHERE NOT EXISTS (SELECT 1
	FROM estatus_autorizacion ea
	WHERE ea.descripcion = t.estatus_autorizacion);

CREATE INDEX idx_estatus_autorizacion_descripcion ON estatus_autorizacion (descripcion);

/*Limpiamos e insertamos en QUEJAS los registros que no se han insertado en la Tarea 4*/
TRUNCATE TABLE quejas;

INSERT INTO quejas (fecha_recepcion, fecha_envio, id_producto_subproducto, id_asunto_subasunto,
	descripcion_queja, descripcion_solucion, id_sucursal, etiquetas, id_estatus_autorizacion,
	id_medio_comunicacion, id_estatus_queja, respuesta_a_tiempo, se_abre_disputa)
SELECT date_format(str_to_date(t.fecha_recepcion, '%d/%m/%Y'), '%Y-%m-%d'),
	date_format(str_to_date(t.fecha_envio, '%d/%m/%Y'), '%Y-%m-%d'),
	ps.id, asu.id, t.descripcion_queja, t.descripcion_solucion, suc.id,
	t.etiquetas, ea.id, mc.id, eq.id,
	CASE WHEN t.respuesta_a_tiempo = 'Yes' THEN 1 ELSE 0 END,
	CASE WHEN t.se_abre_disputa = 'Yes' THEN 1 ELSE 0 END
FROM Temporal t
INNER JOIN producto_subproductos ps 
	ON ps.id_producto = t.id_producto
	AND ps.id_subproducto = t.id_subproducto
INNER JOIN asunto_subasuntos asu 
	ON asu.id_asunto = t.id_asunto
	AND asu.id_subasunto = t.id_subasunto
INNER JOIN sucursales suc
	ON suc.id_compania = t.id_compania
	AND suc.id_estado = t.id_estado
	AND suc.codigo_postal = t.sucursal
INNER JOIN medios_comunicacion mc 
	ON mc.nombre = t.medio_comunicacion
INNER JOIN estatus_quejas eq
	ON eq.descripcion = t.estatus_queja
INNER JOIN estatus_autorizacion ea
	ON ea.descripcion = t.estatus_autorizacion;

DROP TABLE Temporal;

/*Exportamos la tabla de Quejas en un .txt*/
SELECT * FROM quejas
INTO OUTFILE 'Quejas.txt'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';
