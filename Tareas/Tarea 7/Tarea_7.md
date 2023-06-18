# MCD - Base de Datos Relacionales - Tarea 7

## 1421582 - Claudia Lissette Gutiérrez Díaz

---

Procederé a recorrer cada una de mis tablas e indicar si se hicieron cambios o no y qué dificultades tuve al limpiar las tablas.
Aclaro que antes de insertar la información mediante __LOAD FILE__ se realizó una limpieza previa, razón por la cual muy seguramente no habrá muchos cambios qué realizarle.
Antes de empezar, debo aclarar que para todas las actualizaciones, usé el __START TRANSACTION__, __COMMIT__, y __ROLLBACK__ para asegurar la integridad de los datos.

### Asuntos
---

Esta tabla fue limpiada previo a la inserción, pero al hacer un select y revisarla manualmente, noté que existían dobles comillas (Por ejemplo: _can''t_), por lo que le hice un update para corregir. Uno de los problemas que tuve fue cómo representar la comilla doble, si la misma comilla delimita el inicio y fin de una columna, se tiene que marcar doble comilla simple, para insertar una comilla en la columna.

```sql
START TRANSACTION;
UPDATE asuntos 
SET descripcion = REPLACE(descripcion, '''''', '''');
COMMIT;
ROLLBACK;
```

### Compañías
---

Los datos de compañías se ven bien y no requieren cambios.

### Estados
---

Los datos de estados se ven bien y no requieren cambios.

### Estatus de autorización
---

En esta tabla, noté que hacen falta registros, puesto que con la cantidad que filtré de quejas, ya no se necesitaron. Igual para la práctica, voy a insertarlos:

```sql
START TRANSACTION;
INSERT INTO estatus_autorizacion (descripcion)
VALUES ('Consent provided'),
('Consent not provided'),
('Other');
COMMIT;
ROLLBACK;
```

# Estatus Quejas
---

Los datos se ven bien y no requieren cambios.

# Medios de comunicación
---

Los datos se ven bien y no requieren cambios.

# Productos
---

Los datos se ven bien y no rquieren cambios.

# Subasuntos
---

Los datos tienen el mismo problema de las dobles comillas simples, por lo que utilizamos el mismo query anterior.

```sql
START TRANSACTION;
UPDATE subasuntos 
SET descripcion = REPLACE(descripcion, '''''', '''');
COMMIT;
ROLLBACK;
```

# Subproductos
---

En esta tabla hay un registro que tiene símbolos extraños, por lo que opto por hacer un update de ese registro directamente para corregirlo.

```sql
START TRANSACTION;
UPDATE subproductos 
SET nombre = 'Traveler''s/Cashier''s checks'
WHERE nombre = 'Travelerâ€™s/Cashierâ€™s checks';
COMMIT;
ROLLBACK;
```

# Sucursales
---

En esta tabla existen códigos postales, pero tienen dígitos disparejos, por lo que emplearemos ___LPAD___ para rellenar con ceros a la izquierda para que los dígitos de todos coincidan.

```sql
SELECT @len := MAX(LENGTH(codigo_postal)) FROM sucursales s ;

START TRANSACTION;
UPDATE sucursales 
SET codigo_postal = LPAD(codigo_postal, @len, "0");
COMMIT;
ROLLBACK;
```

#Quejas
---

Al ser esta la tabla principal, está compuesta prácticamente por primary keys de otras tablas, por lo que se necesita actualizar.

---

Adjunto de igual manera el archivo _.sql_ utilizado para las consultas: [Limpieza](/Tareas/Tarea%207/Limpieza_servicio_clientes.sql)