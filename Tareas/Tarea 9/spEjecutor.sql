/* Stored para ejecutar cosas dinámicamente */
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