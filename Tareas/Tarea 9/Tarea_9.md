# MCD - Base de Datos Relacionales - Tarea 9

## 1421582 - Claudia Lissette Gutiérrez Díaz

---

Decidí crear storeds procedures para calcular el coeficiente de correlación y la regresión linear, porque creo que me podrían ser de utilidad en mi trabajo y en las clases (aunque sé que en estas últimas ya existen mejores herramientas), también como parte de repaso para la siguiente clase de estadística que justo vamos a ver ese tema.

No me decidía cómo enviar la información a los storeds o si ésta ya debería estar precargada en alguna tabla. A modo de reto, porque el manejo de strings siempre se me complica, decidí mandarlo como un string de coordenadas.

Antes de comenzar con la explicación, debo comentar que todos los archivos se encuentran en la misma carpeta donde se encuentra este archivo.

Uno de los primeros retos, es que desconocía que la concatenación de cosas variaba entre MYSQL y SQL Server, en éste último estoy acostumbrada a concatenar todo con '+', cuando acá tengo que usar 'CONCAT'.

Otro de los retos, es que no sabía cómo crear en MYSQL queries dinámicos, puesto que es diferente que en SQL Server, entonces decidí hacer un [stored](/Tareas/Tarea%209/spEjecutor.sql) previo que ejecutara textos:

```sql
DROP PROCEDURE IF EXISTS spEjecutor;
DELIMITER $$
CREATE PROCEDURE spEjecutor(
	IN dynamic_statement TEXT
)
BEGIN
    SET @dynamic_statement := dynamic_statement;
    PREPARE prepared_statement FROM @dynamic_statement;
    EXECUTE prepared_statement;
    DEALLOCATE PREPARE prepared_statement;
END$$

DELIMITER ;
```

Recibe un texto y lo ejecuta como un statement, facilitándome el uso para lo que planeaba hacer.
```sql
CALL spEjecutor(CONCAT('INSERT INTO CorrelationCoefficient (fltX, fltY) VALUES', xy));
```

Con esto ya pude realizar la llamada que ejecutara el insert en la tabla que quería, con los valores que recibía.

Como segundo paso, cree el [Stored de Regresión Linear](/Tareas/Tarea%209/spLinearRegression.sql), el cuál recomiendo revisar, porque allí se encuentra comentarizado el proceso paso a paso.

```sql
DROP PROCEDURE IF EXISTS spLinearRegression;
DELIMITER $$
CREATE PROCEDURE spLinearRegression(
	IN xy TEXT,
	OUT fltb0 float,
	OUT fltb1 float
)
BEGIN
...
END$$
```

El stored recibe como parámetro un string con las coordenadas X y Y de los datos a calcular (por ejemplo '(1, 2), (2, 3), (4, 5)'), y regresa un par de valores que representan las variables b0 y b1.

El tercer paso, se crea el [Stored de Coeficiente de Correlación](/Tareas/Tarea%209/spCorrelationCoefficient.sql), el cual también recomiendo revisar, ya que también se encuentra comentarizado.

```sql
DROP PROCEDURE IF EXISTS spCorrelationCoefficient;
DELIMITER $$
CREATE PROCEDURE spCorrelationCoefficient(
	IN xy TEXT,
	OUT c FLOAT,
	OUT conclusion TEXT
)
BEGIN
...
END$$
```

Al igual que el otro stored, también recibe un string con las coordenadas X y Y, y devuelve un par de valores, uno con el coeficiente de relación y otro con una conclusión textual.

Por último, hice un [script](/Tareas/Tarea%209/Ejecuci%C3%B3n%20principal.sql) para mandar llamar a ambos storeds para comprobar su funcionamiento. Nuevamente, también recomiendo revisarlo, puesto que también se encuentra comentarizado.

En este script, cree una tabla auxiliar con los datos de ejemplo, realmente da igual el nombre de la tabla, ya que se formará un string que será el parámetro que se mandará a los storeds.

La parte interesante es la siguiente:

```sql
SET @xy = NULL;
SELECT @xy := GROUP_CONCAT(CONCAT('(',fltX,',',fltY,')')  SEPARATOR ', ')
FROM XY;
```

Estas líneas fueron el reto principal, ya que la manera de concatenar columnas y filas en una variable es muy diferente de MYSQL a SQL Server, entonces, cuando descubrí el "GROUP_CONCAT" fue un alivio (sí me tardé en encontrarlo), inicialmente había usado COALESCE, IFNULL, etc, pero no obtenía el resultado que necesitaba.

Una vez teniendo la variable con las coordenadas concatenadas, fue cuestión de llamar a ambos stored, ya que usé el mismo set de datos para ambas cosas, y después imprimí los resultados:

```sql
SELECT CONCAT('y = ', ROUND(@fltb0, 4),' + ', ROUND(@fltb1, 4), 'x');
SELECT CONCAT('De acuerdo al coeficiente de correlación: ', ROUND(@c, 3), ' conluimos: ', @conc); 
```