---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
--- CICLO 1 ---------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
--- PERSISTENCIA: TABLAS -> Creación de tablas ----------------------------------------------
---------------------------------------------------------------------------------------------
CREATE TABLE Usuario (
    id          VARCHAR2(10),
    correo      VARCHAR2(50),
    rol         CHAR(1),
    nombre      VARCHAR2(50),
    apellidos   VARCHAR2(50),
    telefono    VARCHAR2(10)
);

CREATE TABLE Administrador (
    id_usuario  VARCHAR2(10),
    permisos    CHAR(1),
    sede        VARCHAR2(60)
);

CREATE TABLE Categoria (
    id          VARCHAR2(10),
    nombre      VARCHAR2(50),
    descripcion VARCHAR2(100)
);

CREATE TABLE Autor (
    id            VARCHAR2(10),
    nombre        VARCHAR2(50),
    apellidos     VARCHAR2(50),
    genero        CHAR(1),
    nacionalidad  VARCHAR2(30)
);

CREATE TABLE Editorial (
    id        VARCHAR2(10),
    correo    VARCHAR2(50),
    telefono  VARCHAR2(10),
    nombre    VARCHAR2(30),
    pais      VARCHAR2(60)
);

CREATE TABLE Libro (
    id                 VARCHAR2(10),
    titulo             VARCHAR2(40),
    fecha_publicacion  DATE,
    idioma             VARCHAR2(30),
    descripcion        VARCHAR2(100),
    id_categoria       VARCHAR2(10)   -- FK -> Categoria
);

CREATE TABLE Edicion (
    id           VARCHAR2(10),
    año          DATE,
    paginas      INT,
    id_libro     VARCHAR2(10),        -- FK -> Libro
    id_editorial VARCHAR2(10)         -- FK -> Editorial
);

CREATE TABLE Ejemplar (
    id                VARCHAR2(10),
    estado_fisico     CHAR(2),
    disponibilidad    CHAR(1),
    localizacion      VARCHAR2(40),
    fecha_adquisicion DATE,
    id_edicion        VARCHAR2(10)    -- FK -> Edicion
);

CREATE TABLE Proveedor (
    id         VARCHAR2(10),
    correo     VARCHAR2(50),
    nombre     VARCHAR2(30),
    apellidos  VARCHAR2(50),
    empresa    VARCHAR2(50),
    telefono   VARCHAR2(10)
);

CREATE TABLE Compra (
    id           VARCHAR2(10),
    fecha        DATE,
    total        DECIMAL(10, 2),
    estado       CHAR(1),
    id_proveedor VARCHAR2(10)         -- FK -> Proveedor
);

CREATE TABLE Producto_Compra (
    id           VARCHAR2(10),
    cantidad     INT,
    precio_unidad DECIMAL(10, 2),
    id_compra    VARCHAR2(10),        -- FK -> Compra
    id_libro     VARCHAR2(10)         -- FK -> Libro
);

---------------------------------------------------------------------------------------------
--- PERSISTENCIA: ATRIBUTOS -> Definición de restricciones para un único atributos (TIpos)
---------------------------------------------------------------------------------------------
-- Usuario
ALTER TABLE Usuario ADD CONSTRAINT CHECK_Usuario_nombre CHECK (REGEXP_LIKE(nombre, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Usuario ADD CONSTRAINT CHECK_Usuario_apellidos CHECK (REGEXP_LIKE(apellidos, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Usuario ADD CONSTRAINT CHECK_Usuario_correo CHECK (REGEXP_LIKE(correo, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'));
ALTER TABLE Usuario ADD CONSTRAINT CHECK_Usuario_telefono CHECK (REGEXP_LIKE(telefono, '^[0-9]{10}$'));
ALTER TABLE Usuario ADD CONSTRAINT CHECK_Usuario_rol CHECK (rol IN ('A', 'L', 'B')); -- Administrador, Lector, Bibliotecario
 
-- Administrador
ALTER TABLE Administrador ADD CONSTRAINT CHECK_Administrador_permisos CHECK (permisos IN ('L', 'O', 'T')); -- Solo Lectura, Operativo, Total
ALTER TABLE Administrador ADD CONSTRAINT CHECK_Administrador_sede CHECK (REGEXP_LIKE(sede, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
 
-- Categoria
ALTER TABLE Categoria ADD CONSTRAINT CHECK_Categoria_nombre CHECK (REGEXP_LIKE(nombre, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Categoria ADD CONSTRAINT CHECK_Categoria_descripcion CHECK (REGEXP_LIKE(descripcion, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
 
-- Autor
ALTER TABLE Autor ADD CONSTRAINT CHECK_Autor_nombre CHECK (REGEXP_LIKE(nombre, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Autor ADD CONSTRAINT CHECK_Autor_apellidos CHECK (REGEXP_LIKE(apellidos, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Autor ADD CONSTRAINT CHECK_Autor_genero CHECK (genero IN ('M', 'F', 'O')); -- Masculino, Femenino, Otro
ALTER TABLE Autor ADD CONSTRAINT CHECK_Autor_nacionalidad CHECK (REGEXP_LIKE(nacionalidad, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
 
-- Libro
ALTER TABLE Libro ADD CONSTRAINT CHECK_Libro_titulo CHECK (REGEXP_LIKE(titulo, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Libro ADD CONSTRAINT CHECK_Libro_idioma CHECK (REGEXP_LIKE(idioma, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Libro ADD CONSTRAINT CHECK_Libro_descripcion CHECK (REGEXP_LIKE(descripcion, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Libro ADD CONSTRAINT CHECK_Libro_fecha_publicacion CHECK (fecha_publicacion <= TO_DATE('31/12/2025', 'DD/MM/YYYY'));
 
-- Ejemplar
ALTER TABLE Ejemplar ADD CONSTRAINT CHECK_Ejemplar_localizacion CHECK (REGEXP_LIKE(localizacion, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Ejemplar ADD CONSTRAINT CHECK_Ejemplar_fecha_adquisicion CHECK (fecha_adquisicion <= TO_DATE('31/12/2025', 'DD/MM/YYYY'));
ALTER TABLE Ejemplar ADD CONSTRAINT CHECK_Ejemplar_estado_fisico CHECK (estado_fisico IN ('DG', 'BN', 'DN', 'NV', 'RO', 'PD')); -- Desgastado, Bueno, Dañado, Nuevo, Restaurado, Perdido
 
-- Edicion
ALTER TABLE Edicion ADD CONSTRAINT CHECK_Edicion_año CHECK (año <= TO_DATE('31/12/2025', 'DD/MM/YYYY'));
ALTER TABLE Edicion ADD CONSTRAINT CHECK_Edicion_paginas CHECK (paginas > 0);
 
-- Editorial
ALTER TABLE Editorial ADD CONSTRAINT CHECK_Editorial_correo CHECK (REGEXP_LIKE(correo, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'));
ALTER TABLE Editorial ADD CONSTRAINT CHECK_Editorial_telefono CHECK (REGEXP_LIKE(telefono, '^[0-9]{10}$'));
ALTER TABLE Editorial ADD CONSTRAINT CHECK_Editorial_nombre CHECK (REGEXP_LIKE(nombre, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Editorial ADD CONSTRAINT CHECK_Editorial_pais CHECK (REGEXP_LIKE(pais, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
 
-- Producto_Compra
ALTER TABLE Producto_Compra ADD CONSTRAINT CHECK_Producto_Compra_cantidad CHECK (cantidad > 0);
ALTER TABLE Producto_Compra ADD CONSTRAINT CHECK_Producto_Compra_precio_unidad CHECK (precio_unidad > 0.0);
 
-- Compra
ALTER TABLE Compra ADD CONSTRAINT CHECK_Compra_fecha CHECK (fecha <= TO_DATE('31/12/2025', 'DD/MM/YYYY'));
ALTER TABLE Compra ADD CONSTRAINT CHECK_Compra_total CHECK (total > 0.0);
 
-- Proveedor
ALTER TABLE Proveedor ADD CONSTRAINT CHECK_Proveedor_correo CHECK (REGEXP_LIKE(correo, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'));
ALTER TABLE Proveedor ADD CONSTRAINT CHECK_Proveedor_nombre CHECK (REGEXP_LIKE(nombre, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Proveedor ADD CONSTRAINT CHECK_Proveedor_apellidos CHECK (REGEXP_LIKE(apellidos, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Proveedor ADD CONSTRAINT CHECK_Proveedor_empresa CHECK (REGEXP_LIKE(empresa, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Proveedor ADD CONSTRAINT CHECK_Proveedor_telefono CHECK (REGEXP_LIKE(telefono, '^[0-9]{10}$'));
 
---------------------------------------------------------------------------------------------
--- PERSISTENCIA: PRIMARIAS -> Definición de claves primarias
---------------------------------------------------------------------------------------------
ALTER TABLE Usuario ADD PRIMARY KEY(id);
ALTER TABLE Compra ADD PRIMARY KEY(id);
ALTER TABLE Producto_Compra ADD PRIMARY KEY(id);
ALTER TABLE Proveedor ADD PRIMARY KEY(id);
ALTER TABLE Autor ADD PRIMARY KEY(id);
ALTER TABLE Libro ADD PRIMARY KEY(id);
ALTER TABLE Ejemplar ADD PRIMARY KEY(id);
ALTER TABLE Categoria ADD PRIMARY KEY(id);
ALTER TABLE Edicion ADD PRIMARY KEY(id);
ALTER TABLE Editorial ADD PRIMARY KEY(id);

---------------------------------------------------------------------------------------------
--- PERSISTENCIA: UNICAS -> Definición de claves únicas
---------------------------------------------------------------------------------------------
ALTER TABLE Usuario ADD UNIQUE(correo);
ALTER TABLE Proveedor ADD UNIQUE(correo);
ALTER TABLE Editorial ADD UNIQUE(correo);
ALTER TABLE Editorial ADD UNIQUE(telefono);
 
---------------------------------------------------------------------------------------------
--- PERSISTENCIA: FORANEAS -> Definición de claves foraneas
---------------------------------------------------------------------------------------------
ALTER TABLE Administrador ADD FOREIGN KEY(id_usuario) REFERENCES Usuario(id);
ALTER TABLE Libro ADD FOREIGN KEY(id_categoria) REFERENCES Categoria(id);
ALTER TABLE Edicion ADD FOREIGN KEY(id_libro) REFERENCES Libro(id);
ALTER TABLE Edicion ADD FOREIGN KEY(id_editorial) REFERENCES Editorial(id);
ALTER TABLE Ejemplar ADD FOREIGN KEY(id_edicion) REFERENCES Edicion(id);
ALTER TABLE Compra ADD FOREIGN KEY(id_proveedor) REFERENCES Proveedor(id);
ALTER TABLE Producto_Compra ADD FOREIGN KEY(id_compra) REFERENCES Compra(id);
ALTER TABLE Producto_Compra ADD FOREIGN KEY(id_libro) REFERENCES Libro(id);
---------------------------------------------------------------------------------------------
--- PERSISTENCIA: XTABLAS -> Eliminación de tablas
---------------------------------------------------------------------------------------------
DROP TABLE Producto_Compra;
DROP TABLE Compra;
DROP TABLE Ejemplar;
DROP TABLE Edicion;
DROP TABLE Administrador;
DROP TABLE Libro;
DROP TABLE Autor;
DROP TABLE Categoria;
DROP TABLE Editorial;
DROP TABLE Proveedor;
DROP TABLE Usuario;

---------------------------------------------------------------------------------------------
--- PERSISTENCIA: CONSULTAS
---------------------------------------------------------------------------------------------
-- Q1: Lista simple de todos los libros
SELECT id, titulo, idioma, fecha_publicacion FROM Libro;
 
-- Q2: Lista de autores registrados
SELECT id, nombre, apellidos, nacionalidad FROM Autor;
 
-- Q3: Ejemplares disponibles para prestar
SELECT id, estado_fisico, localizacion FROM Ejemplar WHERE disponibilidad = 1;
 
-- Q4: Libro con su categoria
SELECT L.titulo, C.nombre AS categoria
FROM Libro L
JOIN Categoria C ON L.id_categoria = C.id;
 
-- Q5: Ediciones con su editorial
SELECT E.id, E.paginas, ED.nombre AS editorial
FROM Edicion E
JOIN Editorial ED ON E.id_editorial = ED.id;
 
-- Q6: Compras con su proveedor
SELECT C.id, C.fecha, C.total, P.nombre AS proveedor
FROM Compra C
JOIN Proveedor P ON C.id_proveedor = P.id;
 
-- Q7: Cantidad de libros por categoria
SELECT C.nombre AS categoria, COUNT(L.id) AS total_libros
FROM Categoria C
JOIN Libro L ON L.id_categoria = C.id
GROUP BY C.nombre;

---------------------------------------------------------------------------------------------
--- PRUEBAS: PoblarOK -> Ingreso de datos correctos. (Sin automatización) -------------------
---------------------------------------------------------------------------------------------
-- Categoria
INSERT INTO Categoria VALUES ('CAT001', 'Ficcion', 'Novelas y cuentos de ficcion literaria');
INSERT INTO Categoria VALUES ('CAT002', 'Historia', 'Libros sobre historia universal y colombiana');
INSERT INTO Categoria VALUES ('CAT003', 'Tecnologia', 'Libros de informatica y programacion');
 
-- Editorial
INSERT INTO Editorial VALUES ('ED001', 'contacto@planeta.com', '3001234567', 'Planeta', 'Colombia');
INSERT INTO Editorial VALUES ('ED002', 'info@norma.com', '3107654321', 'Norma', 'Colombia');
INSERT INTO Editorial VALUES ('ED003', 'hola@penguin.com', '3209876543', 'Penguin', 'Argentina');
 
-- Autor
INSERT INTO Autor VALUES ('AUT001', 'Gabriel', 'Garcia Marquez', 'M', 'Colombiana');
INSERT INTO Autor VALUES ('AUT002', 'Jorge Luis', 'Borges', 'M', 'Argentina');
INSERT INTO Autor VALUES ('AUT003', 'Isabel', 'Allende', 'F', 'Chilena');
 
-- Libro
INSERT INTO Libro VALUES ('LIB001', 'Cien Anos de Soledad', TO_DATE('1967-06-05','YYYY-MM-DD'), 'Espanol', 'Novela del realismo magico colombiano', 'CAT001');
INSERT INTO Libro VALUES ('LIB002', 'Ficciones', TO_DATE('1944-01-01','YYYY-MM-DD'), 'Espanol', 'Coleccion de cuentos fantasticos de Borges', 'CAT001');
INSERT INTO Libro VALUES ('LIB003', 'La Casa de los Espiritus', TO_DATE('1982-10-01','YYYY-MM-DD'), 'Espanol', 'Saga familiar con elementos magicos chilenos', 'CAT001');
 
-- Edicion (id, año, paginas, id_libro, id_editorial)
INSERT INTO Edicion VALUES ('EDI001', TO_DATE('2000-01-01','YYYY-MM-DD'), 432, 'LIB001', 'ED001');
INSERT INTO Edicion VALUES ('EDI002', TO_DATE('2005-06-15','YYYY-MM-DD'), 200, 'LIB002', 'ED002');
INSERT INTO Edicion VALUES ('EDI003', TO_DATE('2010-03-20','YYYY-MM-DD'), 350, 'LIB003', 'ED003');
 
-- Ejemplar (id, estado_fisico, disponibilidad, localizacion, fecha_adquisicion, id_edicion)
INSERT INTO Ejemplar VALUES ('EJE001', 'NV', 1, 'Estante A uno', TO_DATE('2021-01-10','YYYY-MM-DD'), 'EDI001');
INSERT INTO Ejemplar VALUES ('EJE002', 'BN', 1, 'Estante B tres', TO_DATE('2020-05-22','YYYY-MM-DD'), 'EDI002');
INSERT INTO Ejemplar VALUES ('EJE003', 'DG', 0, 'Bodega central', TO_DATE('2019-08-15','YYYY-MM-DD'), 'EDI003');
 
-- Proveedor
INSERT INTO Proveedor VALUES ('PRV001', 'ventas@distribuidora.com', 'Carlos', 'Ramirez Torres', 'Distribuidora Nacional', '3151112233');
INSERT INTO Proveedor VALUES ('PRV002', 'pedidos@libros.com', 'Maria', 'Lopez Ruiz', 'Libros y Mas', '3004445566');
INSERT INTO Proveedor VALUES ('PRV003', 'contacto@editorial.com', 'Pedro', 'Suarez Gil', 'Editorial Sudamericana', '3006667788');
 
-- Usuario
INSERT INTO Usuario VALUES ('USR001', 'admin@biblioteca.com', 'A', 'Ana', 'Martinez Gil', '3001234567');
INSERT INTO Usuario VALUES ('USR002', 'biblio@biblioteca.com', 'B', 'Luis', 'Torres Pena', '3109876543');
INSERT INTO Usuario VALUES ('USR003', 'lector@gmail.com', 'L', 'Sofia', 'Herrera Diaz', '3207778899');
 
-- Administrador (id_usuario, permisos, sede)
INSERT INTO Administrador VALUES ('USR001', 'T', 'Sede Central Bogota');
 
-- Compra (id, fecha, total, estado, id_proveedor)
INSERT INTO Compra VALUES ('CMP001', TO_DATE('2024-01-15','YYYY-MM-DD'), 350000.00, 1, 'PRV001');
INSERT INTO Compra VALUES ('CMP002', TO_DATE('2024-03-10','YYYY-MM-DD'), 180000.00, 1, 'PRV002');
INSERT INTO Compra VALUES ('CMP003', TO_DATE('2024-06-20','YYYY-MM-DD'), 95000.00, 0, 'PRV003');
 
-- Producto_Compra (id, cantidad, precio_unidad, id_compra, id_libro)
INSERT INTO Producto_Compra VALUES ('PC001', 5, 70000.00, 'CMP001', 'LIB001');
INSERT INTO Producto_Compra VALUES ('PC002', 3, 60000.00, 'CMP002', 'LIB002');
INSERT INTO Producto_Compra VALUES ('PC003', 2, 47500.00, 'CMP003', 'LIB003');
 

---------------------------------------------------------------------------------------------
--- PRUEBAS: PoblarNoOK -> Intento de ingreso de datos erroneos protegidos ------------------
---------------------------------------------------------------------------------------------

 
-- PK duplicada en Categoria
INSERT INTO Categoria VALUES ('CAT001', 'Duplicado', 'Viola PRIMARY KEY de Categoria');
 
-- PK duplicada en Autor
INSERT INTO Autor VALUES ('AUT001', 'Clon', 'Apellido', 'M', 'Colombiana');
 
-- PK duplicada en Libro
INSERT INTO Libro VALUES ('LIB001', 'Titulo clon', TO_DATE('2000-01-01','YYYY-MM-DD'), 'Espanol', 'Viola PRIMARY KEY de Libro');
 
-- PK compuesta duplicada en Libro_Autor
INSERT INTO Libro_Autor VALUES ('LIB001', 'AUT001');
 
-- PK duplicada en Editorial
INSERT INTO Editorial VALUES ('ED001', 'nuevo@correo.com', '3000000001', 'Editorial Clon', 'Mexico');
 
-- ===== VIOLACIONES DE CLAVE FORANEA (FK a registro inexistente) =====
 
-- Libro con id_categoria que no existe
INSERT INTO Libro VALUES ('LIB099', 'Libro Huerfano', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol', 'Sin categoria valida');
-- Al hacer el ALTER de FK id_categoria = 'CAT999' falla
 
-- Edicion con id_libro que no existe
INSERT INTO Edicion VALUES ('EDI099', TO_DATE('2024-01-01','YYYY-MM-DD'), 100, 'LIB999', 'ED001');
 
-- Edicion con id_editorial que no existe
INSERT INTO Edicion VALUES ('EDI098', TO_DATE('2024-01-01','YYYY-MM-DD'), 200, 'LIB001', 'ED999');
 
-- Ejemplar con id_edicion que no existe
INSERT INTO Ejemplar VALUES ('EJE099', 'NV', 1, 'Estante Z nueve', TO_DATE('2024-01-01','YYYY-MM-DD'), 'EDI999');
 
-- Libro_Autor con id_libro que no existe
INSERT INTO Libro_Autor VALUES ('LIB999', 'AUT001');
 
-- Libro_Autor con id_autor que no existe
INSERT INTO Libro_Autor VALUES ('LIB001', 'AUT999');
 
-- Compra con id_proveedor que no existe
INSERT INTO Compra VALUES ('CMP099', TO_DATE('2024-06-01','YYYY-MM-DD'), 99999.00, 1, 'PRV999');
 
-- Producto_Compra con id_compra que no existe
INSERT INTO Producto_Compra VALUES ('PC099', 1, 50000.00, 'CMP999', 'LIB001');
 
-- Producto_Compra con id_libro que no existe
INSERT INTO Producto_Compra VALUES ('PC098', 1, 50000.00, 'CMP001', 'LIB999');
 
-- Administrador con id_usuario que no existe
INSERT INTO Administrador VALUES ('USR999', 'T', 'Sede Norte');
 
-- ===== VIOLACIONES DE CLAVE UNICA (UNIQUE) =====
 
-- Correo duplicado en Usuario
INSERT INTO Usuario VALUES ('USR099', 'admin@biblioteca.com', 'B', 'Intruso', 'Apellido', '3000000000');
 
-- Correo duplicado en Editorial
INSERT INTO Editorial VALUES ('ED099', 'contacto@planeta.com', '3000000002', 'Editorial Pirata', 'Peru');
 
-- Telefono duplicado en Editorial
INSERT INTO Editorial VALUES ('ED098', 'diferente@correo.com', '3001234567', 'Editorial Copia', 'Chile');
 
-- Correo duplicado en Proveedor
INSERT INTO Proveedor VALUES ('PRV099', 'ventas@distribuidora.com', 'Pirata', 'Nombre Falso', 'Empresa Clon', '3199999999');
 
-- ===== VIOLACIONES DE CHECK (tipos y formatos) =====
 
-- Rol invalido en Usuario (solo A, L, B permitidos)
INSERT INTO Usuario VALUES ('USR098', 'valido@correo.com', 'X', 'Nombre', 'Apellido', '3001112222');
 
-- Genero invalido en Autor (solo M, F, O permitidos)
INSERT INTO Autor VALUES ('AUT099', 'Nombre', 'Apellido', 'Z', 'Colombiana');
 
-- Paginas negativas en Edicion
INSERT INTO Edicion VALUES ('EDI097', TO_DATE('2020-01-01','YYYY-MM-DD'), -10, 'LIB001', 'ED001');
 
-- Precio negativo en Producto_Compra
INSERT INTO Producto_Compra VALUES ('PC097', 3, -5000.00, 'CMP001', 'LIB001');
 
-- Cantidad cero en Producto_Compra
INSERT INTO Producto_Compra VALUES ('PC096', 0, 50000.00, 'CMP001', 'LIB001');
 
-- Total negativo en Compra
INSERT INTO Compra VALUES ('CMP098', TO_DATE('2024-01-01','YYYY-MM-DD'), -100.00, 1, 'PRV001');
 
-- Correo con formato invalido en Editorial
INSERT INTO Editorial VALUES ('ED097', 'correo_sin_arroba', '3001234999', 'Editorial Mala', 'Bolivia');
 
-- Telefono con letras en Usuario
INSERT INTO Usuario VALUES ('USR097', 'nuevo@correo.com', 'A', 'Nombre', 'Apellido', 'ABCD123456');
 
-- Estado fisico invalido en Ejemplar (solo DG, BN, DN, NV, RO, PD)
INSERT INTO Ejemplar VALUES ('EJE098', 'XX', 1, 'Estante Q', TO_DATE('2023-01-01','YYYY-MM-DD'), 'EDI001');
 
-- Fecha de publicacion futura en Libro
INSERT INTO Libro VALUES ('LIB098', 'Libro Futuro', TO_DATE('2099-01-01','YYYY-MM-DD'), 'Espanol', 'Fecha invalida futura');
 
-- Permisos invalidos en Administrador (solo L, O, T)
INSERT INTO Administrador VALUES ('USR002', 'X', 'Sede Sur');
 
---------------------------------------------------------------------------------------------
--- PRUEBAS: XPoblar -> Eliminación de datos ------------------------------------------------
---------------------------------------------------------------------------------------------
DELETE FROM Producto_Compra WHERE id IN ('PC001','PC002','PC003');
DELETE FROM Compra WHERE id IN ('CMP001','CMP002','CMP003');
DELETE FROM Ejemplar WHERE id IN ('EJE001','EJE002','EJE003');
DELETE FROM Edicion WHERE id IN ('EDI001','EDI002','EDI003');
DELETE FROM Libro_Autor WHERE id_libro IN ('LIB001','LIB002','LIB003');
DELETE FROM Administrador WHERE id_usuario = 'USR001';
DELETE FROM Libro WHERE id IN ('LIB001','LIB002','LIB003');
DELETE FROM Autor WHERE id IN ('AUT001','AUT002','AUT003');
DELETE FROM Categoria WHERE id IN ('CAT001','CAT002','CAT003');
DELETE FROM Editorial WHERE id IN ('ED001','ED002','ED003');
DELETE FROM Proveedor WHERE id IN ('PRV001','PRV002','PRV003');
DELETE FROM Usuario WHERE id IN ('USR001','USR002','USR003');

---------------------------------------------------------------------------------------------
--- TUPLAS: Restricciones que involucran más de un atributo ---------------------------------
---------------------------------------------------------------------------------------------

-- TUP1: En Compra, si estado='COMPLETADO' el total debe ser > 0
ALTER TABLE Compra ADD CONSTRAINT CH_Compra_estado_total
    CHECK (
        (estado = 'COMPLETADO' AND total > 0)
        OR (estado IN ('PENDIENTE', 'RECHAZADO') AND total >= 0)
    );
 
-- TUP2: En Producto_Compra, cantidad y precio_unidad juntos deben generar un importe válido
ALTER TABLE Producto_Compra ADD CONSTRAINT CH_ProductoCompra_importe
    CHECK (cantidad > 0 AND precio_unidad > 0);
 
-- TUP3: En Ejemplar, si disponibilidad = FALSE, el estado_fisico NO puede ser 'Nuevo'
ALTER TABLE Ejemplar 
ADD CONSTRAINT CH_Ejemplar_nuevo_disponible
CHECK (
    NOT (disponibilidad = 'FALSE' AND estado_fisico = 'Nuevo')
);
 
-- TUP4: El año de la Edicion no puede ser anterior a la fecha_publicacion del Libro.
--       Se implementa como disparador TRG_Edicion_Validar_Anio (ver sección Disparadores).
 
-- TUP5: En Autor, nombre, apellidos y nacionalidad deben existir juntos
ALTER TABLE Autor ADD CONSTRAINT CH_Autor_identidad
    CHECK (
        nombre IS NOT NULL AND apellidos IS NOT NULL AND nacionalidad IS NOT NULL
    );
 
-- TUP6: En Libro, titulo e idioma deben existir juntos
ALTER TABLE Libro ADD CONSTRAINT CH_Libro_titulo_idioma
    CHECK (titulo IS NOT NULL AND idioma IS NOT NULL);
 
---------------------------------------------------------------------------------------------
--- ACCIONES: Definición de acciones de referencia -----------------------------------------
---------------------------------------------------------------------------------------------
 
-- Libro.id_categoria → Categoria(id)  |  ON DELETE SET NULL
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'LIBRO'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'CATEGORIA' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Libro DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Libro ADD CONSTRAINT FK_Libro_Categoria
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id) ON DELETE SET NULL;
 
-- Edicion.id_libro → Libro(id)  |  ON DELETE CASCADE
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'EDICION'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'LIBRO' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Edicion DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Edicion ADD CONSTRAINT FK_Edicion_Libro
    FOREIGN KEY (id_libro) REFERENCES Libro(id) ON DELETE CASCADE;
 
-- Edicion.id_editorial → Editorial(id)  |  ON DELETE SET NULL
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'EDICION'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'EDITORIAL' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Edicion DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Edicion ADD CONSTRAINT FK_Edicion_Editorial
    FOREIGN KEY (id_editorial) REFERENCES Editorial(id) ON DELETE SET NULL;
 
-- Ejemplar.id_edicion → Edicion(id)  |  ON DELETE CASCADE
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'EJEMPLAR'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'EDICION' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Ejemplar DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Ejemplar ADD CONSTRAINT FK_Ejemplar_Edicion
    FOREIGN KEY (id_edicion) REFERENCES Edicion(id) ON DELETE CASCADE;
 
-- Compra.id_proveedor → Proveedor(id)  |  ON DELETE SET NULL
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'COMPRA'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'PROVEEDOR' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Compra DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Compra ADD CONSTRAINT FK_Compra_Proveedor
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id) ON DELETE SET NULL;
 
-- Producto_Compra.id_compra → Compra(id)  |  ON DELETE CASCADE
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'PRODUCTO_COMPRA'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'COMPRA' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Producto_Compra DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Producto_Compra ADD CONSTRAINT FK_ProductoCompra_Compra
    FOREIGN KEY (id_compra) REFERENCES Compra(id) ON DELETE CASCADE;
 
-- Producto_Compra.id_libro → Libro(id)  |  ON DELETE SET NULL
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'PRODUCTO_COMPRA'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'LIBRO' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Producto_Compra DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Producto_Compra ADD CONSTRAINT FK_ProductoCompra_Libro
    FOREIGN KEY (id_libro) REFERENCES Libro(id) ON DELETE SET NULL;
 
-- Administrador.id_usuario → Usuario(id)  |  ON DELETE CASCADE
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'ADMINISTRADOR'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'USUARIO' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Administrador DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Administrador ADD CONSTRAINT FK_Administrador_Usuario
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id) ON DELETE CASCADE;
 
-- Libro_Autor: tabla nueva con sus FKs CASCADE
CREATE TABLE Libro_Autor (
    id_libro VARCHAR2(10),
    id_autor VARCHAR2(10)
);
ALTER TABLE Libro_Autor ADD PRIMARY KEY (id_libro, id_autor);
ALTER TABLE Libro_Autor ADD CONSTRAINT FK_LibroAutor_Libro
    FOREIGN KEY (id_libro) REFERENCES Libro(id) ON DELETE CASCADE;
ALTER TABLE Libro_Autor ADD CONSTRAINT FK_LibroAutor_Autor
    FOREIGN KEY (id_autor) REFERENCES Autor(id) ON DELETE CASCADE;
 
---------------------------------------------------------------------------------------------
--- DISPARADORES: Automatización y restricciones procedimentales ----------------------------
---------------------------------------------------------------------------------------------
 
-- DISP-1: Validar que el año de la Edicion no sea anterior a fecha_publicacion del Libro
CREATE OR REPLACE TRIGGER TRG_Edicion_Validar_Anio
BEFORE INSERT OR UPDATE ON Edicion
FOR EACH ROW
DECLARE
    v_fecha_pub Libro.fecha_publicacion%TYPE;
BEGIN
    SELECT fecha_publicacion
    INTO   v_fecha_pub
    FROM   Libro
    WHERE  id = :NEW.id_libro;
 
    IF :NEW.año < v_fecha_pub THEN
        RAISE_APPLICATION_ERROR(-20001,
            'El año de la edicion (' || TO_CHAR(:NEW.año,'YYYY') ||
            ') no puede ser anterior a la fecha de publicacion del libro (' ||
            TO_CHAR(v_fecha_pub,'YYYY') || ').');
    END IF;
END TRG_Edicion_Validar_Anio;

 
-- DISP-2: Actualizar automáticamente el total de una Compra
--         al insertar, modificar o eliminar un Producto_Compra
CREATE OR REPLACE TRIGGER TRG_ProductoCompra_Actualizar_Total
AFTER INSERT OR UPDATE OR DELETE ON Producto_Compra
FOR EACH ROW
DECLARE
    v_id_compra VARCHAR2(10);
BEGIN
    IF DELETING THEN
        v_id_compra := :OLD.id_compra;
    ELSE
        v_id_compra := :NEW.id_compra;
    END IF;
 
    UPDATE Compra
    SET total = (
        SELECT NVL(SUM(cantidad * precio_unidad), 0)
        FROM   Producto_Compra
        WHERE  id_compra = v_id_compra
    )
    WHERE  id = v_id_compra;
END TRG_ProductoCompra_Actualizar_Total;
/
 
-- DISP-3: Impedir la eliminación de un Ejemplar disponible (disponibilidad = TRUE)
CREATE OR REPLACE TRIGGER TRG_Ejemplar_Proteger_Disponible
BEFORE DELETE ON Ejemplar
FOR EACH ROW
BEGIN
    IF :OLD.disponibilidad = 'TRUE' THEN
        RAISE_APPLICATION_ERROR(-20002,
            'No se puede eliminar el ejemplar ' || :OLD.id ||
            ' porque está marcado como disponible (en circulacion activa).');
    END IF;
END;
/
 
-- DISP-4: Solo un Administrador puede insertar en tablas de gestión.
--         El USER de sesión Oracle debe coincidir con el correo
--         de un Usuario con rol 'Administrador' registrado en Administrador.
 
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Compra
BEFORE INSERT ON Compra
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Administrador A
    JOIN   Usuario U ON U.id = A.id_usuario
    WHERE  UPPER(U.correo) = UPPER(USER)
    AND  U.rol = 'Administrador';
 
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Compras.');
    END IF;
END TRG_Solo_Admin_Compra;
/
 
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Libro
BEFORE INSERT ON Libro
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Administrador A
    JOIN   Usuario U ON U.id = A.id_usuario
    WHERE  UPPER(U.correo) = UPPER(USER)
    AND  U.rol = 'Administrador';
 
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Libros.');
    END IF;
END TRG_Solo_Admin_Libro;
/
 
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Edicion
BEFORE INSERT ON Edicion
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Administrador A
    JOIN   Usuario U ON U.id = A.id_usuario
    WHERE  UPPER(U.correo) = UPPER(USER)
    AND  U.rol = 'Administrador';
 
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Ediciones.');
    END IF;
END TRG_Solo_Admin_Edicion;
/
 
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Editorial
BEFORE INSERT ON Editorial
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Administrador A
    JOIN   Usuario U ON U.id = A.id_usuario
    WHERE  UPPER(U.correo) = UPPER(USER)
    AND  U.rol = 'Administrador';
 
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Editoriales.');
    END IF;
END TRG_Solo_Admin_Editorial;
/
 
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Autor
BEFORE INSERT ON Autor
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Administrador A
    JOIN   Usuario U ON U.id = A.id_usuario
    WHERE  UPPER(U.correo) = UPPER(USER)
    AND  U.rol = 'Administrador';
 
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Autores.');
    END IF;
END TRG_Solo_Admin_Autor;
/
 
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Categoria
BEFORE INSERT ON Categoria
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Administrador A
    JOIN   Usuario U ON U.id = A.id_usuario
    WHERE  UPPER(U.correo) = UPPER(USER)
    AND  U.rol = 'Administrador';
 
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Categorias.');
    END IF;
END TRG_Solo_Admin_Categoria;
/
 
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Ejemplar
BEFORE INSERT ON Ejemplar
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Administrador A
    JOIN   Usuario U ON U.id = A.id_usuario
    WHERE  UPPER(U.correo) = UPPER(USER)
    AND  U.rol = 'Administrador';
 
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Ejemplares.');
    END IF;
END TRG_Solo_Admin_Ejemplar;
/
 
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Proveedor
BEFORE INSERT ON Proveedor
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Administrador A
    JOIN   Usuario U ON U.id = A.id_usuario
    WHERE  UPPER(U.correo) = UPPER(USER)
      AND  U.rol = 'Administrador';
 
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Proveedores.');
    END IF;
END TRG_Solo_Admin_Proveedor;
/
 
-- DISP-5: Al modificar el correo de un Proveedor, verificar que no exista en Editorial
CREATE OR REPLACE TRIGGER TRG_Proveedor_Correo_CrossCheck
BEFORE UPDATE OF correo ON Proveedor
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM   Editorial
    WHERE  correo = :NEW.correo;
 
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20003,
            'El correo ' || :NEW.correo ||
            ' ya está registrado como correo de una Editorial.');
    END IF;
END TRG_Proveedor_Correo_CrossCheck;
/
 
---------------------------------------------------------------------------------------------
--- XDISPARADORES: Eliminación de disparadores ----------------------------------------------
---------------------------------------------------------------------------------------------
DROP TRIGGER TRG_Edicion_Validar_Anio;
DROP TRIGGER TRG_ProductoCompra_Actualizar_Total;
DROP TRIGGER TRG_Ejemplar_Proteger_Disponible;
DROP TRIGGER TRG_Solo_Admin_Compra;
DROP TRIGGER TRG_Solo_Admin_Libro;
DROP TRIGGER TRG_Solo_Admin_Edicion;
DROP TRIGGER TRG_Solo_Admin_Editorial;
DROP TRIGGER TRG_Solo_Admin_Autor;
DROP TRIGGER TRG_Solo_Admin_Categoria;
DROP TRIGGER TRG_Solo_Admin_Ejemplar;
DROP TRIGGER TRG_Solo_Admin_Proveedor;
DROP TRIGGER TRG_Proveedor_Correo_CrossCheck;
 
---------------------------------------------------------------------------------------------
--- PRUEBAS: TuplasOK -> Ingreso correcto respecto a restricciones de tupla -----------------
---------------------------------------------------------------------------------------------
 
-- TUP1-OK: Compra completada con total > 0
  
-- TUP1-OK: Compra pendiente con total = 0 (aún sin productos)
INSERT INTO Compra VALUES ('CMP011', TO_DATE('2024-09-05','YYYY-MM-DD'), 0.00, 'PENDIENTE',  'PRV002');
 
-- TUP1-OK: Compra rechazada con total = 0 (no se procesó)
INSERT INTO Compra VALUES ('CMP012', TO_DATE('2024-09-08','YYYY-MM-DD'), 0.00, 'RECHAZADO', 'PRV001');
 
-- TUP2-OK: Producto_Compra con cantidad y precio válidos
INSERT INTO Producto_Compra VALUES ('PC010', 3, 45000.00, 'CMP010', 'LIB001');
 
-- TUP3-OK: Ejemplar Nuevo con disponibilidad = TRUE (nuevo y disponible — correcto)
INSERT INTO Ejemplar VALUES ('EJE010', 'Nuevo',1, 'Estante D cuatro', TO_DATE('2024-01-01','YYYY-MM-DD'), 'EDI001'); -- arreglar esto
 
-- TUP3-OK: Ejemplar Desgastado con disponibilidad = FALSE (no disponible — correcto)
INSERT INTO Ejemplar VALUES ('EJE011', 'Desgastado', 0, 'Bodega sur',       TO_DATE('2022-03-10','YYYY-MM-DD'), 'EDI002');
 
-- TUP5-OK: Autor con nombre, apellidos y nacionalidad completos
INSERT INTO Autor VALUES ('AUT010', 'Juan', 'Rulfo Vizcaino', 'Masculino', 'Mexicana');
 
-- TUP6-OK: Libro con titulo e idioma presentes
INSERT INTO Libro VALUES ('LIB010', 'Pedro Paramo', TO_DATE('1955-03-19','YYYY-MM-DD'), 'Espanol', 'Novela del realismo magico mexicano', 'CAT001');
 
---------------------------------------------------------------------------------------------
--- PRUEBAS: TuplasNoOK -> Intentos incorrectos respecto a restricciones de tupla -----------
---------------------------------------------------------------------------------------------
 
-- TUP1-NOK: Compra completada con total negativo  ✗
INSERT INTO Compra VALUES ('CERR1', TO_DATE('2024-09-10','YYYY-MM-DD'), -500.00, 'COMPLETADO', 'PRV001');
 
-- TUP1-NOK: Compra pendiente con total negativo  ✗
INSERT INTO Compra VALUES ('CERR2', TO_DATE('2024-09-10','YYYY-MM-DD'), -1.00, 'PENDIENTE', 'PRV001');
 
-- TUP2-NOK: Producto_Compra con cantidad = 0  ✗
INSERT INTO Producto_Compra VALUES ('PCER1', 0, 30000.00, 'CMP001', 'LIB001');
 
-- TUP2-NOK: Producto_Compra con precio_unidad negativo  ✗
INSERT INTO Producto_Compra VALUES ('PCER2', 2, -1000.00, 'CMP001', 'LIB001');
 
-- TUP3-NOK: Ejemplar Nuevo con disponibilidad = FALSE  ✗
INSERT INTO Ejemplar VALUES ('EERR1', 'Nuevo', 0, 'Estante X', TO_DATE('2024-01-01','YYYY-MM-DD'), 'EDI001');
 
-- TUP5-NOK: Autor con nacionalidad NULL  ✗
INSERT INTO Autor VALUES ('AERR1', 'Sin', 'Pais', 'Masculino', NULL);
 
-- TUP6-NOK: Libro sin idioma  ✗
INSERT INTO Libro VALUES ('LERR1', 'Sin Idioma', TO_DATE('2020-01-01','YYYY-MM-DD'), NULL, 'Sin idioma registrado', 'CAT001');
 
---------------------------------------------------------------------------------------------
--- PRUEBAS: AccionesOK -> Verificación de las acciones de referencia -----------------------
---------------------------------------------------------------------------------------------
 
-- SET NULL: Al eliminar una Categoria, los Libros quedan con id_categoria = NULL
DELETE FROM Categoria WHERE id = 'CAT002';
-- Verificar: SELECT id, titulo, id_categoria FROM Libro WHERE id_categoria IS NULL;
 
-- CASCADE Edicion→Ejemplar: Al eliminar una Edicion, sus Ejemplares desaparecen
DELETE FROM Edicion WHERE id = 'EDI003';
-- Verificar: SELECT * FROM Ejemplar WHERE id_edicion = 'EDI003'; → Sin resultado
 
-- CASCADE Libro→Edicion: Al eliminar un Libro, sus Ediciones (y en cascada Ejemplares) desaparecen
DELETE FROM Libro WHERE id = 'LIB002';
-- Verificar: SELECT * FROM Edicion WHERE id_libro = 'LIB002';    → Sin resultado
-- Verificar: SELECT * FROM Ejemplar WHERE id_edicion = 'EDI002'; → Sin resultado
 
-- SET NULL: Al eliminar un Proveedor, las Compras quedan con id_proveedor = NULL
DELETE FROM Proveedor WHERE id = 'PRV003';
-- Verificar: SELECT id, id_proveedor FROM Compra WHERE id = 'CMP003'; → id_proveedor = NULL
 
-- CASCADE Compra→Producto_Compra: Al eliminar una Compra, sus productos desaparecen
DELETE FROM Compra WHERE id = 'CMP001';
-- Verificar: SELECT * FROM Producto_Compra WHERE id_compra = 'CMP001'; → Sin resultado
 
-- CASCADE Usuario→Administrador: Al eliminar el Usuario, se elimina el Administrador
DELETE FROM Usuario WHERE id = 'USR001';
-- Verificar: SELECT * FROM Administrador WHERE id_usuario = 'USR001'; → Sin resultado
 
---------------------------------------------------------------------------------------------
--- PRUEBAS: DisparadoresOK -> Datos ingresados usando la automatización de disparadores ----
---------------------------------------------------------------------------------------------
 
-- DISP-1-OK: Edicion con año POSTERIOR a la fecha de publicacion del libro  ✓
INSERT INTO Edicion VALUES ('EDI010', TO_DATE('2010-01-01','YYYY-MM-DD'), 300, 'LIB001', 'ED001');
-- LIB001 publicado en 1967, edicion 2010 → válido
 
-- DISP-1-OK: Edicion con año IGUAL al año de publicacion  ✓
INSERT INTO Edicion VALUES ('EDI011', TO_DATE('1967-06-05','YYYY-MM-DD'), 350, 'LIB001', 'ED002');
 
-- DISP-2-OK: Insertar Producto_Compra → el total de la Compra se recalcula automáticamente
SELECT total FROM Compra WHERE id = 'CMP002';  -- Total antes del nuevo producto
INSERT INTO Producto_Compra VALUES ('PC020', 2, 40000.00, 'CMP002', 'LIB002');
SELECT total FROM Compra WHERE id = 'CMP002';  -- Total después (debe haber aumentado en 80000)
 
-- DISP-2-OK: Eliminar un Producto_Compra → total se reduce automáticamente
DELETE FROM Producto_Compra WHERE id = 'PC020';
SELECT total FROM Compra WHERE id = 'CMP002';  -- Vuelve al valor original
 
-- DISP-3-OK: Eliminar un Ejemplar NO disponible no genera error  ✓
UPDATE Ejemplar SET disponibilidad = FALSE WHERE id = 'EJE003';
DELETE FROM Ejemplar WHERE id = 'EJE003';      -- disponibilidad=FALSE → permitido
 
-- DISP-4-OK: Insertar como sesión del Administrador registrado → permitido  ✓
-- (Sesión Oracle es 'admin@biblioteca.com', USR001 con rol 'Administrador')
-- CONNECT admin@biblioteca.com/...;
INSERT INTO Compra    VALUES ('CMP030', TO_DATE('2024-10-01','YYYY-MM-DD'), 120000.00, 'PENDIENTE',  'PRV001');
INSERT INTO Libro     VALUES ('LIB030', 'El Otono del Patriarca', TO_DATE('1975-01-01','YYYY-MM-DD'), 'Espanol', 'Novela de dictadura de Garcia Marquez', 'CAT001');
INSERT INTO Autor     VALUES ('AUT030', 'Ernesto', 'Sabato Rojas', 'Masculino', 'Argentina');
INSERT INTO Categoria VALUES ('CAT030', 'Ciencia Ficcion', 'Libros de ciencia ficcion contemporanea');
INSERT INTO Ejemplar  VALUES ('EJE030', 'Nuevo', 1, 'Estante F seis', TO_DATE('2024-01-01','YYYY-MM-DD'), 'EDI001');
INSERT INTO Proveedor VALUES ('PRV030', 'nuevo@proveedor.com', 'Jorge', 'Mendez Rios', 'Libros Colombia', '3159990011');
-- Todos deben insertarse sin error
 
-- DISP-5-OK: Actualizar correo de Proveedor a uno que NO existe en Editorial  ✓
UPDATE Proveedor SET correo = 'nuevo_proveedor@logistica.com' WHERE id = 'PRV001';
-- Ese correo no está en Editorial → permitido
 
---------------------------------------------------------------------------------------------
--- PRUEBAS: DisparadoresNoOK -> Intentos bloqueados por disparadores -----------------------
---------------------------------------------------------------------------------------------
 
-- DISP-1-NOK: Edicion con año ANTERIOR a la fecha de publicacion del libro  ✗
INSERT INTO Edicion VALUES ('EDI099', TO_DATE('1950-01-01','YYYY-MM-DD'), 200, 'LIB001', 'ED001');
-- LIB001 publicado en 1967, edicion en 1950 → ORA-20001
 
-- DISP-1-NOK: Edicion con año muy anterior  ✗
INSERT INTO Edicion VALUES ('EDI098', TO_DATE('1900-01-01','YYYY-MM-DD'), 150, 'LIB002', 'ED002');
-- LIB002 publicado en 1944, edicion en 1900 → ORA-20001
 
-- DISP-3-NOK: Intentar eliminar un Ejemplar disponible (disponibilidad = TRUE)  ✗
UPDATE Ejemplar SET disponibilidad = TRUE WHERE id = 'EJE001';
DELETE FROM Ejemplar WHERE id = 'EJE001';
-- → ORA-20002: No se puede eliminar el ejemplar EJE001 porque está en circulacion activa.
 
-- DISP-4-NOK: Insertar como sesión de un Bibliotecario → denegado  ✗
-- (Sesión Oracle es 'biblio@biblioteca.com', USR002 con rol 'Bibliotecario')
-- CONNECT biblio@biblioteca.com/...;
INSERT INTO Compra    VALUES ('CERR9', TO_DATE('2024-10-05','YYYY-MM-DD'), 50000.00, 'PENDIENTE', 'PRV001');
-- → ORA-20010: Acceso denegado: solo un Administrador puede registrar Compras.
 
INSERT INTO Libro     VALUES ('LERR9', 'Libro No Autorizado', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol', 'Sin permiso', 'CAT001');
-- → ORA-20010: Acceso denegado: solo un Administrador puede registrar Libros.
 
INSERT INTO Autor     VALUES ('AERR9', 'No', 'Autorizado', 'Masculino', 'Colombiana');
-- → ORA-20010: Acceso denegado: solo un Administrador puede registrar Autores.
 
INSERT INTO Proveedor VALUES ('PERR9', 'no@autorizado.com', 'Sin', 'Permiso Gil', 'Empresa X', '3000000099');
-- → ORA-20010: Acceso denegado: solo un Administrador puede registrar Proveedores.
 
-- DISP-4-NOK: Insertar como sesión de un Lector → denegado  ✗
-- CONNECT lector@gmail.com/...;
INSERT INTO Categoria VALUES ('KERR9', 'Sin Permiso', 'Categoria no autorizada');
-- → ORA-20010: Acceso denegado: solo un Administrador puede registrar Categorias.
 
-- DISP-5-NOK: Actualizar correo de Proveedor a uno que ya existe en Editorial  ✗
UPDATE Proveedor SET correo = 'contacto@planeta.com' WHERE id = 'PRV002';
-- 'contacto@planeta.com' ya es correo de ED001 → ORA-20003
 
---------------------------------------------------------------------------------------------
--- PRUEBAS: XPoblar -> Eliminación de datos ------------------------------------------------
---------------------------------------------------------------------------------------------
DELETE FROM Producto_Compra WHERE id IN ('PC001','PC002','PC003');
DELETE FROM Compra WHERE id IN ('CMP001','CMP002','CMP003');
DELETE FROM Ejemplar WHERE id IN ('EJE001','EJE002','EJE003');
DELETE FROM Edicion WHERE id IN ('EDI001','EDI002','EDI003');
DELETE FROM Libro_Autor WHERE id_libro IN ('LIB001','LIB002','LIB003');
DELETE FROM Administrador WHERE id_usuario = 'USR001';
DELETE FROM Libro WHERE id IN ('LIB001','LIB002','LIB003');
DELETE FROM Autor WHERE id IN ('AUT001','AUT002','AUT003');
DELETE FROM Categoria WHERE id IN ('CAT001','CAT002','CAT003');
DELETE FROM Editorial WHERE id IN ('ED001','ED002','ED003');
DELETE FROM Proveedor WHERE id IN ('PRV001','PRV002','PRV003');
DELETE FROM Usuario WHERE id IN ('USR001','USR002','USR003');
 
---------------------------------------------------------------------------------------------
--- ELIMINAR TODO ---------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
BEGIN
    FOR cur_rec IN (SELECT object_name, object_type
        FROM   all_objects
        WHERE  object_type IN ('TABLE', 'VIEW', 'PACKAGE', 'PROCEDURE', 'FUNCTION', 'SEQUENCE')
        AND  owner = '<schema_name>')
    LOOP
        BEGIN
        IF cur_rec.object_type = 'TABLE' THEN
            EXECUTE IMMEDIATE 'DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '" CASCADE CONSTRAINTS';
        ELSE
            EXECUTE IMMEDIATE 'DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '"';
        END IF;
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line('FAILED: DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '"');
        END;
    END LOOP;
END;
/
 
DROP TABLE Libro_Autor CASCADE CONSTRAINTS;
DROP TABLE Producto_Compra CASCADE CONSTRAINTS;
DROP TABLE Compra CASCADE CONSTRAINTS;
DROP TABLE Ejemplar CASCADE CONSTRAINTS;
DROP TABLE Edicion CASCADE CONSTRAINTS;
DROP TABLE Administrador CASCADE CONSTRAINTS;
DROP TABLE Libro CASCADE CONSTRAINTS;
DROP TABLE Autor CASCADE CONSTRAINTS;
DROP TABLE Categoria CASCADE CONSTRAINTS;
DROP TABLE Editorial CASCADE CONSTRAINTS;
DROP TABLE Proveedor CASCADE CONSTRAINTS;
DROP TABLE Usuario CASCADE CONSTRAINTS;