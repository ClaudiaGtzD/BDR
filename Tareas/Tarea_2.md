# MCD - Base de Datos Relacionales - Tarea 1

## 1421582 - Claudia Lissette Gutiérrez Díaz

## Diagrama

```mermaid
---
title: Recopilación de quejas de clientes
---

flowchart LR
    Ent1["Compañía"]
    Ent1 --- Atr11([<ins>id</ins>])
    Atr11 --- Dom111{{"Número > 0"}}
    Ent1 --- Atr12(["Nombre"])
    Atr12 --- Dom121{{"Texto (100)"}}
    Ent2["Estado"]
    Ent2 --- Atr21([<ins>id</ins>])
    Atr21 --- Dom211{{"Número > 0"}}
    Ent2 --- Atr22(["Nombre"])
    Atr22 --- Dom221{{"Texto (50)"}}
    Ent2 --- Atr23(["Abreviatura"])
    Atr23 --- Dom231{{"Texto (2)"}}
    Ent1 --- |1|Rel13{"Tiene/Pertenece"}
    Rel13 --- |N|Ent3
    Ent2 ---|1|Rel23{"Tiene/Pertenece"}
    Rel23 ---|N|Ent3
    Ent3["Sucursal"]
    Ent3 --- Atr31([<ins>id</ins>])
    Atr31 --- Dom311{{"Número > 0"}}
    Ent3 --- Atr32(["Compañía.id"])
    Atr32 --- Dom321{{"Número > 0"}}
    Ent3 --- Atr33(["Estado.id"])
    Atr33 --- Dom331{{"Número > 0"}}
    Ent3 --- Atr34(["Código Postal"])
    Atr34 --- Dom341{{"Número > 0"}}
    Ent4["Medio de Comunicacion"]
    Ent4 --- Atr41([<ins>id</ins>])
    Atr41 --- Dom411{{"Número > 0"}}
    Ent4 --- Atr42(["Nombre"])
    Atr42 --- Dom421{{"Texto (20)"}}
    Ent5["Estatus de quejas"]
    Ent5 --- Atr51([<ins>id</ins>])
    Atr51 --- Dom511{{"Número > 0"}}
    Ent5 --- Atr52(["Descripción"])
    Atr52 --- Dom521{{"Texto (40)"}}
    Ent6["Producto"]
    Ent6 --- Atr61([<ins>id</ins>])
    Atr61 --- Dom611{{"Número > 0"}}
    Ent6 --- Atr62(["Nombre"])
    Atr62 --- Dom621{{"Texto (50)"}}
    Ent7["Subproducto"]
    Ent7 --- Atr71([<ins>id</ins>])
    Atr71 --- Dom711{{"Número > 0"}}
    Ent7 --- Atr72(["Nombre"])
    Atr72 --- Dom721{{"Texto (50)"}}
    Ent6 ---|N|Rel67    
    Rel67 ---|N|Ent7
    Rel67{"Relación Productos"}
    Rel67 --- Atr671(["Producto.id"])
    Atr671 --- Dom6711{{"Número > 0"}}
    Rel67 --- Atr672(["Subproducto.id"])
    Atr672 --- Dom6712{{"Número > 0"}}
    Ent8["Asunto"]
    Ent8 --- Atr81([<ins>id</ins>])
    Atr81 --- Dom811{{"Número > 0"}}
    Ent8 --- Atr82(["Descripción"])
    Atr82 --- Dom821{{"Texto (50)"}}
    Ent9["Subasunto"]
    Ent9 --- Atr91([<ins>id</ins>])
    Atr91 --- Dom911{{"Número > 0"}}
    Ent9 --- Atr92(["Descripción"])
    Atr92 --- Dom921{{"Texto (50)"}}
    Rel89{"Relación Asuntos"}
    Rel89 --- Atr891(["Producto.id"])
    Atr891 --- Dom8911{{"Número > 0"}}
    Rel89 --- Atr892(["Subproducto.id"])
    Atr892 --- Dom8921{{"Número > 0"}}
    Ent8 --- |N|Rel89
    Rel89 --- |N|Ent9
    Ent10["Queja"]
    Ent10 --- Atr101(["id"])
    Atr101 --- Dom1011{{"Número > 0"}}
    Ent10 --- Atr102(["Fecha de Recepción"])
    Atr102 --- Dom1021{{"Fecha"}}
    Ent10 --- Atr103(["Fecha de Envío"])
    Atr103 --- Dom1031{{"Fecha"}}
    Ent10 --- Atr104(["Relación Productos.id"])
    Atr104 --- Dom1041{{"Número > 0"}}
    Ent10 --- Atr105(["Relación Asuntos.id"])
    Atr105 --- Dom1051{{"Número > 0"}}
    Ent10 --- Atr106(["Descripción Queja"])
    Atr106 --- Dom1061{{"Texto (cualquier cantidad)"}}
    Ent10 --- Atr107(["Descripción Solución"])
    Atr107 --- Dom1071{{"Texto (cualquier cantidad)"}}
    Ent10 --- Atr108(["Sucursal.id"])
    Atr108 --- Dom1081{{"Número > 0"}}
    Ent10 --- Atr109(["Etiquetas"])
    Atr109 --- Dom1091{{"Texto (50)"}}
    Ent10 --- Atr1010(["Consentimiento del cliente"])
    Atr1010 --- Dom10101{{"Decisión (Sí/No)"}}
    Ent10 --- Atr1011(["Medio de comunicación.id"])
    Atr1011 --- Dom10111{{"Número > 0"}}
    Ent10 --- Atr1012(["Estatus de quejas.id"])
    Atr1012 --- Dom10121{{"Número > 0"}}
    Ent10 --- Atr1013(["¿Se respondió a tiempo?"])
    Atr1013 --- Dom10131{{"Decisión (Sí/No)"}}
    Ent10 --- Atr1014(["¿Se abrió disputa?"])
    Atr1014 --- Dom10141{{"Decisión (Sí/No)"}}
    Ent5 ---|1|Rel510{"Tiene/Se le asocia"}
    Rel510 ---|N|Ent10
    Ent4 ---|1|Rel410{"Contiene/Se hizo"}
    Rel410 ---|N|Ent10
    Rel67 ---|1|Rel6710{"Puede tener/Se categoriza"}
    Rel6710 ---|N|Ent10
    Ent3 ---|1|Rel310{"Contiene/Pertenece"}
    Rel310 ---|N|Ent10
    Rel89 ---|1|Rel8910{"Puede tener/Se categoriza"}
    Rel8910 ---|N|Ent10
```