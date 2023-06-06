# MCD - Base de Datos Relacionales - Tarea 3

## 1421582 - Claudia Lissette Gutiérrez Díaz

## Esquema modelo relacional
---
Companias(<u>id</u>, nombre)<br>
Estados(<u>id</u>, nombre, abreviacion)<br>
Sucursales(<u>id</u>, id_compania, id_estado, codigo_postal)<br>
Medios_Cominicacion(<u>id</u>, nombre)<br>
Estatus_Quejas(<u>id</u>, descripcion)<br>
Productos(<u>id</u>, nombre)<br>
Subproductos(<u>id</u>, nombre)<br>
Producto_Subproducto(<u>id</u>, id_producto, id_subproducto)<br>
Asuntos(<u>id</u>, descripcion)<br>
Subasuntos(<u>id</u>, descripcion)<br>
Asunto_Subasunto(<u>id</u>, id_asunto, id_subasunto)<br>
Estatus_Autorizacion(<u>id</u>, descripcion)<br>
Quejas(<u>id</u>, fecha_recepcion, fecha_envio, id_producto_subproducto, id_asunto_subasunto, descripcion_queja, descripcion_solucion, id_sucursal, etiquetas, id_consentimiento_cliente, id_medio_comunicacion, id_estatus_queja, respuesta_a_tiempo, se_abre_disputa)

## Diagrama relacional
---
```mermaid
---
title: Recopilación de quejas de clientes
---

CREATE TABLE Temporal(
	fecha_recepcion varchar(10),
	fecha_envio varchar(10),
	producto varchar(50),
	subproducto varchar(50),
	asunto varchar(50),
	subasunto varchar(50),
	descripcion_queja varchar(6000),
	descripcion_solucion varchar(3000),
	compania varchar(100),
	estado_abbr varchar(100),
	estado varchar(100),	
	sucursal varchar(3000),
	etiquetas varchar(50),
	estatus_autorizacion varchar(30),
	medio_comunicacion varchar(100),
	estatus_queja varchar(50),
	respuesta_a_tiempo varchar(4),
	se_abre_disputa varchar(3000)
);

erDiagram
    Companias {
        int id PK
        varchar(100) nombre
    }
    Companias ||--o{ Sucursales : "Tiene/Pertenece"
    Estados {
        int id PK
        varchar(50) nombre
        vachar(2) abreviacion
    }
    Estados ||--o{ Sucursales  : "Tiene/Pertenece"
    Sucursales{
        int id PK
        int id_compania FK
        int id_estado FK
        varchar(6) codigo_postal
    }
    Sucursales ||--o{ Quejas : "Contiene/Pertenece"
    Medios_Comunicacion{
        int id PK
        varchar(20) nombre
    }
    Medios_Comunicacion ||--o{ Quejas : "Contiene/Se hizo"
    Estatus_Quejas{
        int id PK
        varchar(40) descripcion
    }
    Estatus_Quejas ||--o{ Quejas : "Tiene/Se le asocia"
    Productos{
        int id PK
        varchar(50) nombre
    }
    Productos ||--o{ Producto_Subproducto : "Estar/Tener"
    Subproductos{
        int id PK
        varchar(50) nombre
    }
    Subproductos ||--o{ Producto_Subproducto : "Estar/Tener"
    Producto_Subproducto{
        int id PK
        int id_producto FK
        int id_subproducto FK
    }
    Producto_Subproducto ||--o{ Quejas : "Puede tener/Se categoriza"
    Asuntos{
        int id PK
        varchar(50) descripcion
    }
    Asuntos ||--o{ Asunto_Subasunto : "Estar/Tener"
    Subasuntos{
        int id PK 
        varchar(50) descripcion
    }
    Subasuntos ||--o{ Asunto_Subasunto : "Estar/Tener"
    Asunto_Subasunto{
        int id PK
        int id_asunto FK
        int id_subasunto FK
    }
    Asunto_Subasunto ||--o{ Quejas : "Puede tener/Se categoriza"
    Estatus_Autorizacion{
        int id PK
        varchar(30) descripcion
    }
    Estatus_Autorizacion ||--o{ Quejas : "Tiene/Se le asocia"
    Quejas{
        int id PK
        datetime fecha_recepcion
        datetime fecha_envio
        int id_producto_subproducto FK
        int id_asunto_subasunto FK
        varchar(max) descripcion_queja
        varchar(max) descripcion_solucion
        int id_sucursal FK
        varchar(50) etiquetas
        int id_estatus_autorizacion FK
        int id_medio_comunicacion FK
        int id_estatus_queja FK
        tinyint respuesta_a_tiempo
        tinyint se_abre_disputa}
```

## Operadores álgebra relacional
---
### Operación 1: Obtener los códigos postales de las sucursales que sean de Bank of America en Texas.
<br>
ΠSucursal.codigo_postal[(σSucursal.id_estado=(Πid_estado(σEstados.abreviacion="TX"(Estados)).id (SucursalesxEstados)))U(σSucursal.id_compania=(Πid_compania(σCompanias.nombre="Bank of America"(Companias).id(SucursalesxCompanias)))]<br><br>

**Explicación:** Selecciona los códigos postales de las sucursales, donde el id_estado de Sucursales, coincida con el cruce de id de Estados y donde la abreviación del Estado sea "TX", en intersección con el cruce de Sucursales y Compañías, donde el id_compania de Sucursales, coincida con el id de Companias y que el nombre de la Compañía sea "Bank of America".<br><br>

### Operación 2: Obtener los productos de las quejas que se han realizado mediante Teléfono.
<br>
ΠProductos.nombre[σProductos.id=(Πid_producto(σProducto_Subproducto.id=(ΠQuejas.id_producto_subproducto(σQuejas.id_medio_comunicacion=(ΠMedios_Comunicacion.id(σMedios_Comunicacion.nombre="Phone"(Medios_Comunicacion))).id (QuejasxMedios_Comunicacion))).id(Producto_SubproductoxQuejas)).id_producto(ProductosxProducto_Subproducto)]<br><br>

**Explicación:** Selecciona el nombre del producto, cuyo id se encuentre entre el cruce de Productos y la relación Producto_Subproducto, cuyo id de Producto_Subproducto, se encuentre entre el cruce de Producto_Subproducto y Quejas, cuyo id de medio de comunicación (perteneciente a Quejas) se encuentre en el cruce entre Quejas y Medios_Comunicacion en donde el nombre del medio de comunicación sea "Phone".<br><br>

### Operación 3: Obtener un listado de las quejas cerradas.
<br>
ΠQuejas.id[σQuejas.id_estatus_queja=(Πid_estatus_queja(σEstatus_Quejas.descripcion="Closed"(Estatus_Quejas))).id(QuejasxEstatus_Quejas)]<br><br>

**Explicación:** Selecciona el id de las quejas, cuyo id_estatus_queja se encuentre entre el cruce de Quejas y Estatus_Quejas, donde la descripción del Estatus_Quejas sea "Closed".<br><br>

### Operación 4: Obtener los asuntos de las quejas que no hayan presentado disputa.
<br>
ΠAsuntos.descripcion[σAsuntos.id=(Πid_asunto(σAsunto_Subasunto.id=(Πid_asunto_subasunto(σQuejas.se_abre_disputa=0(Quejas))).id_asunto_subasunto(Asunto_SubasuntoxQuejas)).id_asunto(AsuntosxAsunto_Subasunto)]<br><br>

**Explicación:** Selecciona la descripción de los Asuntos, cuyo id se encuentre entre el cruce de Asuntos y la relación Asunto_Subasunto, cuyo id de Asunto_Subasunto, se encuentre entre el cruce de Asunto_Subasunto y Quejas, donde se_abre_disputa, sea 0.


