# MCD - Base de Datos Relacionales - Tarea 1

## Descripción Proyecto

---
Se pidió generar un sistema en el que se administren las quejas hacia ciertos productos o servicios financieros de diferentes compañías con el fin de que en un futuro se puedan analizar y generar un plan de mitigación para bajar el porcentaje de queja de los clientes. Para ello la información del cliente no es relevante, pero sí el de la compañía, y las características de la queja.<br>
Para la compañía es necesario conocer su nombre, el estado de la sucursal y su código postal.<br>
La queja debe tener una fecha asignada, a un tipo de producto o servicio financiero, un asunto, la queja del cliente de manera detallada, la contestación por parte de la compañía, alguna etiqueta de texto libre opcional clasificatoria, mencionar la vía por la que se dio de alta la queja, la fecha en la que se redirigió la queja hacia la compañía involucrada, si se necesitó pedir algún tipo de consentimiento al cliente, el estatus de la queja, si se respondió a tiempo la queja y si el cliente quedó satisfecho o abrió disputa. <br>
Para los tipos de productos, éstos tienen a su vez sub productos. Un subproducto puede pertenecer a más de un producto. También existen subasuntos, que puede pertenecer a más de un tipo de asunto. Tanto el subproducto, como el subasunto, son opcionales.<br>

## Estructura Proyecto

---
### Compañía
- Nombre (Texto)

### Estados
- Nombre (Texto)
- Abreviación (Texto)

### Sucursales
- Compañía (id)
- Estado (id)
- Código Postal (entero)

### Medio de comunicación
- Nombre (Texto)

### Estatus de quejas
- Descripción (Texto)

### Producto
- Nombre (Texto)

### Subproducto
- Nombre (Texto)

### Relación Producto - Subproducto
- Producto (id)
- Subproducto (id)

### Asunto
- Descripción (Texto)

### Subasunto
- Descripción (Texto)

### Relación Asunto - Subasunto
- Asunto (id)
- Subasunto (id)

### Queja
- Fecha de recepcion de la queja (fecha)
- Fecha del envío de la queja al área (fecha)
- Relación Producto - Subproducto (id)
- Relación Asunto - Subasunto (id)
- Descripción de la queja (texto libre)
- Descripción de la solución (texto libre)
- Sucursal de la compañía (id)
- Etiquetas (texto libre)
- Consentimiento del cliente (sí/no)
- Medio de comunicación (id)
- Estatus de la queja (id)
- ¿Se respondió a tiempo? (sí/no)
- ¿Se abrió disputa? (sí/no)

## SGBD: MySQL

---
MySQL es un sistema gestor de base datos que sirve para tener una fácil interacción cliente-servidor mediante peticiones o "queries" que tienen ciertas condiciones para obtener la información requerida. Este SGBD maneja bases de datos relacionales, por lo que es de una fácil comprensión. La interfase (en este caso, yo conozco workbench) es intuitiva, permite crear el diseño de la base de datos mediante clics y mediante instrucciones de SQL, también hay un apartado para observar el diagrama entidad-relación de la base de datos creada. Tiene la facilidad de la creación de stored procedures, funciones, vistas, que te facilitan la reutilización de las instrucciones y lo hacen más eficiente. Te permite optimizar instrucciones, mediante indexaciones y depuraciones. Lo mejor de todo es que es open source, lo cual lo hace más accesible para un estudiante o compañías pequeñas que buscan ahorrar costos en softwares, en funcionalidades básicas, no le pide nada a softwares de paga. Elegí utilizarlo ya que en mi trabajo actual, uso SQL Server, conozco la sintaxis básica de MySQL y a modo de reto, quise elegirlo para poder dominarlo tanto como creo que domino SQL Server.