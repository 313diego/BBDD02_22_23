-- Añadir a la tabla STOCK
-- Una columna de tipo fecha, llamada FechaUltimaEntrada, que por defecto tome 
-- el valor de la fecha actual.
-- Una columna llamada Beneficio, que contendrá el tipo de porcentaje de 
-- beneficio que esa tienda aplica en ese producto. Se debe controlar que el 
-- valor que almacene sea 1,2, 3, 4 o 5

ALTER TABLE STOCK 
ADD FechaUltimaEntrada DATE DEFAULT SYSDATE;

ALTER TABLE STOCK ADD beneficio number (1);
ALTER TABLE STOCK ADD CONSTRAINT sto_ben_CK CHECK (beneficio in (1, 2, 3, 4, 5));

-- En la tabla PRODUCTO
-- Eliminar de la tabla producto la columna Descripción.
-- Añadir una columna llamada perecedero, que únicamente acepte los valores: 
-- S o N.
-- Modificar el tamaño de la columna Denoproducto a 50.

ALTER TABLE PRODUCTO DROP COLUMN descripcion;

ALTER TABLE PRODUCTO ADD perecedero varchar2 (1);
ALTER TABLE PRODUCTO ADD CONSTRAINT pro_per_CK CHECK (perecedero in ('S', 'N'));

ALTER TABLE PRODUCTO MODIFY Denoproducto varchar2 (50);

-- En la tabla FAMILIA
-- Añadir una columna llamada IVA, que represente el porcentaje de IVA y 
-- únicamente pueda contener los valores 21,10,ó 4.

ALTER TABLE FAMILIA ADD iva NUMBER (2);
ALTER TABLE FAMILIA ADD CONSTRAINT pro_iva_CK CHECK (iva in (21,10,4));

-- B) Renombra la tabla STOCK por PRODXTIENDAS.

RENAME STOCK TO PRODXTIENDAS;

-- C) Elimina la tabla FAMILIA y su contenido si lo tuviera.

DROP TABLE FAMILIA CASCADE CONSTRAINTS;

-- D) Crea un usuario llamado C##INVITADO siguiendo los pasos de la unidad 1 y 
-- dale todos los privilegios sobre la tabla PRODUCTO.

create user C##INVITADO identified by INVITADO;
grant all ON PRODUCTO TO C##INVITADO;

-- E) Retira los permisos de modificar la estructura de la tabla y borrar 
-- contenido de la tabla PRODUCTO al usuario anterior.

revoke ALTER, DELETE ON PRODUCTO FROM C##INVITADO;

