#Asuntos
#Se reemplazan las dobles comillas
SELECT * FROM asuntos a  WHERE descripcion LIKE '%''''%';

START TRANSACTION;
UPDATE asuntos 
SET descripcion = REPLACE(descripcion, '''''', '''');
COMMIT;
ROLLBACK;

#Estatus Autorización
SELECT * FROM estatus_autorizacion ea ;

START TRANSACTION;
INSERT INTO estatus_autorizacion (descripcion)
VALUES ('Consent provided'),
('Consent not provided'),
('Other');
COMMIT;
ROLLBACK;

#Estatus Quejas
SELECT * FROM estatus_quejas eq ;

#Medios de Comunicación
SELECT * FROM medios_comunicacion mc ;

#Productos
SELECT * FROM productos p ORDER BY nombre;

#Sub asuntos
SELECT * FROM subasuntos s WHERE descripcion LIKE '%''''%' ORDER BY descripcion;

START TRANSACTION;
UPDATE subasuntos 
SET descripcion = REPLACE(descripcion, '''''', '''');
COMMIT;
ROLLBACK;

#Sub productos
SELECT * FROM subproductos s;

START TRANSACTION;
UPDATE subproductos 
SET nombre = 'Traveler''s/Cashier''s checks'
WHERE nombre = 'Travelerâ€™s/Cashierâ€™s checks';
COMMIT;
ROLLBACK;

#Sucursales
SELECT @len := MAX(LENGTH(codigo_postal)) FROM sucursales s ;

START TRANSACTION;
UPDATE sucursales 
SET codigo_postal = LPAD(codigo_postal, @len, "0");
COMMIT;
ROLLBACK;

SELECT * FROM sucursales s ;

#Quejas
SELECT * FROM quejas q ;