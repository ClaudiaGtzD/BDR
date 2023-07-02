/*
 * Stored para calcular el coeficiente de relación, mandando un varchar de coordenadas
 * y recibiendo el coeficiente
 */

-- Creamos una tabla temporal con las columnas que necesitamos
DROP PROCEDURE IF EXISTS spCorrelationCoefficient;
DELIMITER $$
CREATE PROCEDURE spCorrelationCoefficient(
	IN xy TEXT,
	OUT c FLOAT,
	OUT conclusion TEXT
)
BEGIN

	-- Creamos una tabla temporal con las columnas que necesitamos
	DROP TABLE IF EXISTS CorrelationCoefficient;

	CREATE TABLE CorrelationCoefficient(
		iCodRegistro INTEGER AUTO_INCREMENT PRIMARY KEY,
		fltX FLOAT,
		fltY FLOAT,
		fltXmXM FLOAT,
		fltYmYM FLOAT,
		fltXmXMYmYM FLOAT,
		fltXmXMXmXM FLOAT,
		fltYmYMYmYM FLOAT
	);
	
	-- Insertamos en la tabla
	CALL spEjecutor(CONCAT('INSERT INTO CorrelationCoefficient (fltX, fltY) VALUES', xy));
	
	-- Calculamos las medias de X y Y
	SET @fltX = 0.0;
	SET @fltY = 0.0;
	SET @n = 0.0;
	SET @fltXM = 0.0;
	SET @fltYM = 0.0;
	
	SELECT @fltX := SUM(fltX),
		@fltY := SUM(fltY),
		@n := MAX(iCodRegistro)
	FROM CorrelationCoefficient;
	
	SET @fltXM = @fltX / @n;
	SET @fltYM = @fltY / @n;
	
	-- Calculamos la diferencia de medias
	UPDATE CorrelationCoefficient
	SET fltXmXM = fltX - @fltXM,
		fltYmYM = fltY - @fltYM;
	
	-- Calculamos el resto de las columnas
	UPDATE CorrelationCoefficient
	SET fltXmXMYmYM = fltXmXM * fltYmYM,
		fltXmXMXmXM = fltXmXM * fltXmXM,
		fltYmYMYmYM = fltYmYM * fltYmYM;
		
	-- Calculamos las sumas
	SET @fltXmXMYmYM = 0.0;
	SET	@fltXmXMXmXM = 0.0;
	SET	@fltYmYMYmYM = 0.0;
	
	SELECT @fltXmXMYmYM := SUM(fltXmXMYmYM),
		@fltXmXMXmXM := SUM(fltXmXMXmXM),
		@fltYmYMYmYM := SUM(fltYmYMYmYM)
	FROM CorrelationCoefficient;
	
	-- Calculamos el Coeficiente de Correlación de Pearson
	SET c = 0.0;
	
	SET c = @fltXmXMYmYM / SQRT(@fltXmXMXmXM * @fltYmYMYmYM);

	IF c >= -1 AND c < -0.5 THEN 
		SET conclusion = 'Correlación linear negativa';
	ELSEIF c >= -0.5 AND c <= 0.5 THEN
		SET conclusion = 'Sin Correlación linear';
	ELSE SET conclusion = 'Correlación linear positiva';
	END IF;

	DROP TABLE CorrelationCoefficient;
END$$
DELIMITER ;