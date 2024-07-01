-- TABLA FAMILIA: => Contiene las familias a las que pertenecen los productos, 
-- como por ejemplo ordenadores, impresoras,etc.

CREATE TABLE FAMILIA (
    codfamilia number (3) PRIMARY KEY,
    denofamilia varchar2 (50) NOT NULL UNIQUE
);

-- TABLA PRODUCTO: => contendrá información general sobre los productos que 
-- distribuye la empresa a las tiendas.

CREATE TABLE PRODUCTO (
    codproducto number (5) PRIMARY KEY,
    denoproducto varchar2 (20) NOT NULL,
    descripcion varchar2 (100),
    preciobase number (6,2) NOT NULL,
    porcreposicion number (3),
    unidadesminimas number (4) NOT NULL,
    codfamilia number (3) NOT NULL,
    CONSTRAINT PRO_PBA_CK CHECK (preciobase > 0),
    CONSTRAINT PRO_PRE_CK CHECK (porcreposicion > 0),
    CONSTRAINT PRO_UMI_CK CHECK (unidadesminimas > 0),
    CONSTRAINT FAM_CFA_FK FOREIGN KEY (codfamilia) REFERENCES FAMILIA (codfamilia)
);

-- TABLA TIENDA: => contendrá información básica sobre las tiendas que 
-- distribuyen los productos.

CREATE TABLE TIENDA (
    codtienda number (3) PRIMARY KEY,
    denotienda varchar2 (20) NOT NULL,
    telefono varchar2 (11),
    codigopostal varchar2 (5) NOT NULL,
    provincia varchar2 (5) NOT NULL
);

-- TABLA STOCK: => Contendrá, para cada tienda, el número de unidades 
-- disponibles de cada producto. La clave primaria está formada por la 
-- concatenación de los campos Codtienda y Codproducto.

CREATE TABLE STOCK (
    codtienda number (3) NOT NULL,
    codproducto number (5) NOT NULL,
    unidades number (6) NOT NULL,
    CONSTRAINT STO_CTI_FK FOREIGN KEY (codtienda) REFERENCES TIENDA (codtienda),
    CONSTRAINT STO_CPR_FK FOREIGN KEY (codproducto) REFERENCES PRODUCTO (codproducto),
    CONSTRAINT STO_CTP_PK PRIMARY KEY (codtienda, codproducto),
    CONSTRAINT STO_UNI_CK CHECK (unidades > 0)
);