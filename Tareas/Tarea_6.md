# MCD - Base de Datos Relacionales - Tarea 6

## 1421582 - Claudia Lissette Gutiérrez Díaz

---

A modo de ejemplificar los diferentes usos que se le pueden dar a las funciones de agregación, enlistaré diferentes situaciones.

Por ejemplo, podremos saber la __frecuencia__ con la que se utilizan los diferentes productos:

```sql
SELECT p.nombre, count(1) AS Cantidad
FROM quejas q
INNER JOIN producto_subproductos ps 
	ON ps.id = q.id_producto_subproducto 
INNER JOIN productos p 
	ON p.id = ps.id_producto
GROUP BY p.nombre
ORDER BY p.nombre;
```

Da el siguiente resultado:

| nombre 	| cantidad 	|
|---	|---	|
| Bank account or service 	| 1285 	|
| Consumer Loan 	| 309 	|
| Credit card 	| 1225 	|
| Credit reporting 	| 1535 	|
| Debt collection 	| 2047 	|
| Money transfers 	| 78 	|
| Mortgage 	| 3837 	|
| Payday loan 	| 26 	|
| Student loan 	| 279 	|

---

Para los siguientes ejemplos, para facilitar las operaciones se agrega una nueva columna con el tiempo de respuesta de la queja.

```sql
ALTER TABLE quejas ADD COLUMN tiempo_respuesta int;

UPDATE quejas
SET tiempo_respuesta = datediff(fecha_envio, fecha_recepcion);
```

Podemos averiguar el __promedio__, el __máximo__ y el __mínimo__ del tiempo de respuesta de una queja:

```sql
SELECT floor(avg(tiempo_respuesta)) AS Media,
    max(tiempo_respuesta) AS Máximo,
    min(tiempo_respuesta) AS Mínimo 
FROM quejas q;
```

El cual da como resultado:

| Media 	| Máximo 	| Mínimo 	|
|---	|---	|---	|
| 4 	| 408 	| 0 	|

La cantidad es en días.

---

Para obtener los __cuartiles__, utilizamos la siguiente estrategia:

```sql
CREATE TABLE tiempos_respuesta(
	fila int AUTO_INCREMENT PRIMARY KEY,
	tiempo_respuesta int
);

INSERT INTO tiempos_respuesta (tiempo_respuesta)
SELECT tiempo_respuesta
FROM quejas
ORDER BY tiempo_respuesta;

SET @total = (SELECT count(1) FROM quejas q);

#Primer cuartil
SELECT fila, tiempo_respuesta AS Q1
FROM tiempos_respuesta
WHERE fila = round(0.25*CAST(@total AS decimal(10, 2)));

#Segundo cuartil o mediana
SELECT fila, tiempo_respuesta AS Q2
FROM tiempos_respuesta
WHERE fila = round(0.50*CAST(@total AS decimal(10, 2)));

#Tercer cuartil
SELECT fila, tiempo_respuesta AS Q3
FROM tiempos_respuesta
WHERE fila = round(0.75*CAST(@total AS decimal(10, 2)));

DROP TABLE tiempos_respuesta;
```

Para obtener los siguientes resultados

| fila 	| Q1 	|
|---	|---	|
| 2655 	| 0 	|

| fila 	| Q2 	|
|---	|---	|
| 5311 	| 1 	|

| fila 	| Q2 	|
|---	|---	|
| 7966 	| 3 	|

---

Para calcular la __moda__ del tiempo de respuesta:

```sql
SELECT tiempo_respuesta, count(*) as pcount
FROM quejas
GROUP BY tiempo_respuesta
ORDER BY pcount DESC LIMIT 1;
```

Obteniendo como resultado:

| tiempo_respuesta 	| cantidad 	|
|---	|---	|
| 0 	| 3469 	|

---

## Dificultades
La primera dificultad que atravesé fue que no tenía una columna como tal para calcular estos datos estadísticos, por lo que tuve que crear una para un fácil manejo.
Luego, mi intención para los cuartiles, era usar el limit y poner allí la posición del cuartil que necesitaba, pero mysql no permite poner variables allí, por lo que tuve que realizar lo de crear una tabla con las filas y los tiempos de respuesta para poder seleccionar la posición que deseaba.