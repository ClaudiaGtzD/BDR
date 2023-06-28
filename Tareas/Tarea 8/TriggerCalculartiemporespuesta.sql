DELIMITER $$
CREATE TRIGGER calculartiemporespuesta
AFTER INSERT ON quejas
FOR EACH ROW
BEGIN
	UPDATE quejas SET tiempo_respuesta = datediff(fecha_envio, fecha_recepcion);
END;$$
