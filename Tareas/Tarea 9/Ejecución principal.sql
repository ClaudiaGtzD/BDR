-- Creamos la tabla con la información
DROP TABLE IF EXISTS XY;
CREATE TABLE XY (
	iCodRegistro INTEGER AUTO_INCREMENT PRIMARY KEY,
	fltX float,
	fltY float
);

-- Insertamos la información del ejemplo
INSERT INTO XY(fltX, fltY)
VALUES (140, 60),
	(155, 62),
	(159, 67),
	(179, 70),
	(192, 71),
	(200, 72),
	(212, 75);

-- Concatenamos los valores en una variable
SET @xy = NULL;
SELECT @xy := GROUP_CONCAT(CONCAT('(',fltX,',',fltY,')')  SEPARATOR ', ')
FROM XY;

SET @fltb0 = 0.0;
SET @fltb1 = 0.0;
SET @c = 0.0;
SET @conc = '';

-- Llamamos al stored de regresión linear
CALL spLinearRegression(@xy, @fltb0, @fltb1); 

-- Llamamos al stored del coeficiente de correlación
CALL spCorrelationCoefficient(@xy, @c, @conc);

-- Imprimimos los resultados
SELECT CONCAT('y = ', ROUND(@fltb0, 4),' + ', ROUND(@fltb1, 4), 'x');

SELECT CONCAT('De acuerdo al coeficiente de correlación: ', ROUND(@c, 3), ' conluimos: ', @conc); 

DROP TABLE XY;


	

