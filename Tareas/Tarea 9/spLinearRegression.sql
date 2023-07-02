/*
 * Stored para calcular la Regresión Lineal, mandando un varchar de coordenadas
 * y recibiendo los valores de b0 y b1
 */
DROP PROCEDURE IF EXISTS spLinearRegression;
DELIMITER $$
CREATE PROCEDURE spLinearRegression(
	IN xy TEXT,
	OUT fltb0 float,
	OUT fltb1 float
)
BEGIN

	-- Creamos una tabla temporal con las columnas que necesitamos
	DROP TABLE IF EXISTS LinearRegression;
	CREATE TABLE LinearRegression (
		iCodRegistro INTEGER AUTO_INCREMENT PRIMARY KEY,
		fltX float,
		fltY float,
		fltXY float,
		fltX2 float,
		fltY2 float
	);
	
	-- Insertamos en la tabla donde se va a calcular la Regresión Linear los valores
	CALL spEjecutor(CONCAT('INSERT INTO LinearRegression (fltX, fltY) VALUES', xy));
	
	-- Calculamos XY, X2 y Y2
	UPDATE LinearRegression
	SET fltXY = fltX * fltY,
		fltX2 = fltX * fltX,
		fltY2 = fltY * fltY;
	
	-- Calculamos las sumatorias
	SET @fltX = 0.0;
	SET	@fltY = 0.0;
	SET	@fltXY = 0.0;
	SET	@fltX2 = 0.0;
	SET	@fltY2 = 0.0;
	SET	@n = 0;
	
	SELECT @fltX := SUM(fltX),
		@fltY := SUM(fltY),
		@fltXY := SUM(fltXY),
		@fltX2 := SUM(fltX2),
		@fltY2 := SUM(fltY2),
		@n := MAX(iCodRegistro) 
	FROM LinearRegression;
	
	SELECT @fltX, @fltY, @fltXY, @fltX2, @fltY2;
	
	-- Calculamos b0
	SET fltb0 = 0.0;
	
	SET fltb0 = (@fltY * @fltX2 - @fltX * @fltXY) / (@n * @fltX2 - @fltX * @fltX);
	
	-- Calculamos b1
	
	SET fltb1 = 0.0;
	
	SET fltb1 = (@n * @fltXY - @fltX * @fltY) / (@n * @fltX2 - @fltX * @fltX);

	DROP TABLE LinearRegression;
END$$
DELIMITER ;