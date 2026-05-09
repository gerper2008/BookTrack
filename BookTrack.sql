---------------------------------------------------------------------------------------------
--- PERSISTENCIA: TABLAS -> Creación de tablas
---------------------------------------------------------------------------------------------
CREATE TABLE Usuario (
    id VARCHAR2(10),
    correo VARCHAR2(50),
    rol VARCHAR2(30),
    nombre VARCHAR2(50),
    apellidos VARCHAR2(50),
    telefono VARCHAR2(10)
);

CREATE TABLE Administrador (
    id_usuario VARCHAR2(10),
    permisos VARCHAR2(30),
    sede VARCHAR2(60)
);

CREATE TABLE Categoria (
    id VARCHAR2(10),
    nombre VARCHAR(50),
    descripcion VARCHAR2(100)
);

CREATE TABLE Autor (
    id VARCHAR2(10),
    nombre VARCHAR2(50),
    apellidos VARCHAR2(50),
    genero VARCHAR2(30),
    nacionalidad VARCHAR2(30)
);

CREATE TABLE Libro (
    id VARCHAR2(10),
    titulo VARCHAR2(40),
    fecha_publicacion DATE,
    idioma VARCHAR2(30),
    descripcion VARCHAR2(100),
    id_categoria VARCHAR2(10)
);

CREATE TABLE Ejemplar (
    id VARCHAR2(10),
    estado_fisico VARCHAR2(30),
    disponibilidad CHAR(1),
    localizacion VARCHAR2(40),
    fecha_adquisicion DATE,
    id_edicion VARCHAR2(10)
);

CREATE TABLE Edicion (
    id VARCHAR2(10),
    año DATE,
    paginas INT,
    id_libro VARCHAR2(10),
    id_editorial VARCHAR2(10)
);

CREATE TABLE Editorial (
    id VARCHAR2(10),
    correo VARCHAR2(50),
    telefono VARCHAR2(10),
    nombre VARCHAR2(30),
    pais VARCHAR2(60)
);

CREATE TABLE Producto_Compra (
    id VARCHAR2(10),
    cantidad INT,
    precio_unidad DECIMAL(10, 2),
    id_compra VARCHAR2(10),
    id_libro VARCHAR2(10)
);

CREATE TABLE Compra (
    id VARCHAR2(10),
    fecha DATE,
    total DECIMAL(10, 2),
    estado VARCHAR2(10),
    id_proveedor VARCHAR2(10)
);

CREATE TABLE Proveedor (
    id VARCHAR2(10),
    correo VARCHAR2(50),
    nombre VARCHAR2(30),
    apellidos VARCHAR2(50),
    empresa VARCHAR2(50),
    telefono VARCHAR2(10)
);

---------------------------------------------------------------------------------------------
--- PERSISTENCIA: ATRIBUTOS -> Definición de restricciones para un único atributo
---------------------------------------------------------------------------------------------

-- Usuario
ALTER TABLE Usuario ADD CONSTRAINT CHECK_Usuario_nombre CHECK (REGEXP_LIKE(nombre, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Usuario ADD CONSTRAINT CHECK_Usuario_apellidos CHECK (REGEXP_LIKE(apellidos, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Usuario ADD CONSTRAINT CHECK_Usuario_correo CHECK (REGEXP_LIKE(correo, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'));
ALTER TABLE Usuario ADD CONSTRAINT CHECK_Usuario_telefono CHECK (REGEXP_LIKE(telefono, '^[0-9]{10}$'));
ALTER TABLE Usuario ADD CONSTRAINT CHECK_Usuario_rol CHECK (rol IN ('Administrador', 'Lector', 'Bibliotecario'));

-- Administrador
ALTER TABLE Administrador ADD CONSTRAINT CHECK_Administrador_permisos CHECK (permisos IN ('Solo Lectura', 'Operativo', 'Total'));
ALTER TABLE Administrador ADD CONSTRAINT CHECK_Administrador_sede CHECK (REGEXP_LIKE(sede, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));

-- Categoria
ALTER TABLE Categoria ADD CONSTRAINT CHECK_Categoria_nombre CHECK (REGEXP_LIKE(nombre, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Categoria ADD CONSTRAINT CHECK_Categoria_descripcion CHECK (REGEXP_LIKE(descripcion, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));

-- Autor
ALTER TABLE Autor ADD CONSTRAINT CHECK_Autor_nombre CHECK (REGEXP_LIKE(nombre, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Autor ADD CONSTRAINT CHECK_Autor_apellidos CHECK (REGEXP_LIKE(apellidos, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Autor ADD CONSTRAINT CHECK_Autor_genero CHECK (genero IN ('Masculino', 'Femenino', 'Otro'));
ALTER TABLE Autor ADD CONSTRAINT CHECK_Autor_nacionalidad CHECK (REGEXP_LIKE(nacionalidad, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));

-- Libro
ALTER TABLE Libro ADD CONSTRAINT CHECK_Libro_titulo CHECK (REGEXP_LIKE(titulo, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Libro ADD CONSTRAINT CHECK_Libro_idioma CHECK (REGEXP_LIKE(idioma, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Libro ADD CONSTRAINT CHECK_Libro_descripcion CHECK (REGEXP_LIKE(descripcion, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Libro ADD CONSTRAINT CHECK_Libro_fecha_publicacion CHECK (fecha_publicacion <= TO_DATE('31/12/2025', 'DD/MM/YYYY'));

-- Ejemplar
ALTER TABLE Ejemplar ADD CONSTRAINT CHECK_Ejemplar_localizacion CHECK (REGEXP_LIKE(localizacion, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Ejemplar ADD CONSTRAINT CHECK_Ejemplar_fecha_adquisicion CHECK (fecha_adquisicion <= TO_DATE('31/12/2025', 'DD/MM/YYYY'));
ALTER TABLE Ejemplar ADD CONSTRAINT CHECK_Ejemplar_estado_fisico CHECK (estado_fisico IN ('Desgastado', 'Bueno', 'Dañado', 'Restaurado', 'Perdido', 'Nuevo'));

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
ALTER TABLE Compra ADD CONSTRAINT CHECK_Compra_estado CHECK (estado IN ('PENDIENTE', 'COMPLETADO', 'RECHAZADO'));

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
--- PRUEBAS: PoblarOK -> Ingreso de datos correctos
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
INSERT INTO Autor VALUES ('AUT001', 'Gabriel',    'Garcia Marquez', 'Masculino', 'Colombiana');
INSERT INTO Autor VALUES ('AUT002', 'Jorge Luis', 'Borges',         'Masculino', 'Argentina');
INSERT INTO Autor VALUES ('AUT003', 'Isabel',     'Allende',        'Femenino',  'Chilena');

-- Libro
INSERT INTO Libro VALUES ('LIB001', 'Cien Anos de Soledad',    TO_DATE('1967-06-05','YYYY-MM-DD'), 'Espanol', 'Novela del realismo magico colombiano',    'CAT001');
INSERT INTO Libro VALUES ('LIB002', 'Ficciones',               TO_DATE('1944-01-01','YYYY-MM-DD'), 'Espanol', 'Coleccion de cuentos fantasticos de Borges','CAT001');
INSERT INTO Libro VALUES ('LIB003', 'La Casa de los Espiritus',TO_DATE('1982-10-01','YYYY-MM-DD'), 'Espanol', 'Saga familiar con elementos magicos chilenos','CAT001');

-- Edicion (id, año, paginas, id_libro, id_editorial)
INSERT INTO Edicion VALUES ('EDI001', TO_DATE('2000-01-01','YYYY-MM-DD'), 432, 'LIB001', 'ED001');
INSERT INTO Edicion VALUES ('EDI002', TO_DATE('2005-06-15','YYYY-MM-DD'), 200, 'LIB002', 'ED002');
INSERT INTO Edicion VALUES ('EDI003', TO_DATE('2010-03-20','YYYY-MM-DD'), 350, 'LIB003', 'ED003');

-- Ejemplar (id, estado_fisico, disponibilidad, localizacion, fecha_adquisicion, id_edicion)
INSERT INTO Ejemplar VALUES ('EJE001', 'Nuevo',   1, 'Estante A uno',  TO_DATE('2021-01-10','YYYY-MM-DD'), 'EDI001');
INSERT INTO Ejemplar VALUES ('EJE002', 'Bueno',   1, 'Estante B tres', TO_DATE('2020-05-22','YYYY-MM-DD'), 'EDI002');
INSERT INTO Ejemplar VALUES ('EJE003', 'Dañado',  0, 'Bodega central', TO_DATE('2019-08-15','YYYY-MM-DD'), 'EDI003');

-- Proveedor
INSERT INTO Proveedor VALUES ('PRV001', 'ventas@distribuidora.com', 'Carlos', 'Ramirez Torres',  'Distribuidora Nacional',  '3151112233');
INSERT INTO Proveedor VALUES ('PRV002', 'pedidos@libros.com',       'Maria',  'Lopez Ruiz',       'Libros y Mas',            '3004445566');
INSERT INTO Proveedor VALUES ('PRV003', 'contacto@editorial.com',   'Pedro',  'Suarez Gil',       'Editorial Sudamericana',  '3006667788');

-- Usuario
INSERT INTO Usuario VALUES ('USR001', 'admin@biblioteca.com',  'Administrador', 'Ana',   'Martinez Gil',  '3001234567');
INSERT INTO Usuario VALUES ('USR002', 'biblio@biblioteca.com', 'Bibliotecario', 'Luis',  'Torres Pena',   '3109876543');
INSERT INTO Usuario VALUES ('USR003', 'lector@gmail.com',      'Lector',        'Sofia', 'Herrera Diaz',  '3207778899');

-- Administrador
INSERT INTO Administrador VALUES ('USR001', 'Total', 'Sede Central Bogota');

-- Compra
INSERT INTO Compra VALUES ('CMP001', TO_DATE('2024-01-15','YYYY-MM-DD'), 350000.00, 'COMPLETADO', 'PRV001');
INSERT INTO Compra VALUES ('CMP002', TO_DATE('2024-03-10','YYYY-MM-DD'), 180000.00, 'COMPLETADO', 'PRV002');
INSERT INTO Compra VALUES ('CMP003', TO_DATE('2024-06-20','YYYY-MM-DD'),  95000.00, 'PENDIENTE',  'PRV003');

-- Producto_Compra (id, cantidad, precio_unidad, id_compra, id_libro)
INSERT INTO Producto_Compra VALUES ('PC001', 5, 70000.00, 'CMP001', 'LIB001');
INSERT INTO Producto_Compra VALUES ('PC002', 3, 60000.00, 'CMP002', 'LIB002');
INSERT INTO Producto_Compra VALUES ('PC003', 2, 47500.00, 'CMP003', 'LIB003');


---------------------------------------------------------------------------------------------
--- PRUEBAS: PoblarNoOK -> Intento de ingreso de datos erroneos protegidos
---------------------------------------------------------------------------------------------

-- ===== VIOLACIONES DE CLAVE PRIMARIA (PK duplicada) =====

-- PK duplicada en Categoria
INSERT INTO Categoria VALUES ('CAT001', 'Duplicado', 'Viola PRIMARY KEY de Categoria');

-- PK duplicada en Autor
INSERT INTO Autor VALUES ('AUT001', 'Clon', 'Apellido', 'Masculino', 'Colombiana');

-- PK duplicada en Libro
INSERT INTO Libro VALUES ('LIB001', 'Titulo clon', TO_DATE('2000-01-01','YYYY-MM-DD'), 'Espanol', 'Viola PRIMARY KEY de Libro', 'CAT001');

-- PK duplicada en Editorial
INSERT INTO Editorial VALUES ('ED001', 'nuevo@correo.com', '3000000001', 'Editorial Clon', 'Mexico');

-- ===== VIOLACIONES DE CLAVE FORANEA (FK a registro inexistente) =====

-- Libro con id_categoria que no existe
INSERT INTO Libro VALUES ('LIB099', 'Libro Huerfano', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol', 'Sin categoria valida', 'CAT999');

-- Edicion con id_libro que no existe
INSERT INTO Edicion VALUES ('EDI099', TO_DATE('2024-01-01','YYYY-MM-DD'), 100, 'LIB999', 'ED001');

-- Edicion con id_editorial que no existe
INSERT INTO Edicion VALUES ('EDI098', TO_DATE('2024-01-01','YYYY-MM-DD'), 200, 'LIB001', 'ED999');

-- Ejemplar con id_edicion que no existe
INSERT INTO Ejemplar VALUES ('EJE099', 'Nuevo', 1, 'Estante Z nueve', TO_DATE('2024-01-01','YYYY-MM-DD'), 'EDI999');

-- Compra con id_proveedor que no existe
INSERT INTO Compra VALUES ('CMP099', TO_DATE('2024-06-01','YYYY-MM-DD'), 99999.00, 'COMPLETADO', 'PRV999');

-- Producto_Compra con id_compra que no existe
INSERT INTO Producto_Compra VALUES ('PC099', 1, 50000.00, 'CMP999', 'LIB001');

-- Producto_Compra con id_libro que no existe
INSERT INTO Producto_Compra VALUES ('PC098', 1, 50000.00, 'CMP001', 'LIB999');

-- Administrador con id_usuario que no existe
INSERT INTO Administrador VALUES ('USR999', 'Total', 'Sede Norte');

-- ===== VIOLACIONES DE CLAVE UNICA (UNIQUE) =====

-- Correo duplicado en Usuario
INSERT INTO Usuario VALUES ('USR099', 'admin@biblioteca.com', 'Lector', 'Intruso', 'Apellido', '3000000000');

-- Correo duplicado en Editorial
INSERT INTO Editorial VALUES ('ED099', 'contacto@planeta.com', '3000000002', 'Editorial Pirata', 'Peru');

-- Telefono duplicado en Editorial
INSERT INTO Editorial VALUES ('ED098', 'diferente@correo.com', '3001234567', 'Editorial Copia', 'Chile');

-- Correo duplicado en Proveedor
INSERT INTO Proveedor VALUES ('PRV099', 'ventas@distribuidora.com', 'Pirata', 'Nombre Falso', 'Empresa Clon', '3199999999');

-- ===== VIOLACIONES DE CHECK (tipos y formatos) =====

-- Rol invalido en Usuario  (valores validos: 'Administrador', 'Lector', 'Bibliotecario')
INSERT INTO Usuario VALUES ('USR098', 'valido@correo.com', 'X', 'Nombre', 'Apellido', '3001112222');

-- Genero invalido en Autor  (valores validos: 'Masculino', 'Femenino', 'Otro')
INSERT INTO Autor VALUES ('AUT099', 'Nombre', 'Apellido', 'Transgenero', 'Colombiana');

-- Paginas negativas en Edicion
INSERT INTO Edicion VALUES ('EDI097', TO_DATE('2020-01-01','YYYY-MM-DD'), -10, 'LIB001', 'ED001');

-- Precio negativo en Producto_Compra
INSERT INTO Producto_Compra VALUES ('PC097', 3, -5000.00, 'CMP001', 'LIB001');

-- Cantidad cero en Producto_Compra
INSERT INTO Producto_Compra VALUES ('PC096', 0, 50000.00, 'CMP001', 'LIB001');

-- Total negativo en Compra
INSERT INTO Compra VALUES ('CMP098', TO_DATE('2024-01-01','YYYY-MM-DD'), -100.00, 'PENDIENTE', 'PRV001');

-- Estado invalido en Compra  (valores validos: 'PENDIENTE', 'COMPLETADO', 'RECHAZADO')
INSERT INTO Compra VALUES ('CMP097', TO_DATE('2024-01-01','YYYY-MM-DD'), 50000.00, 'CO', 'PRV001');

-- Correo con formato invalido en Editorial
INSERT INTO Editorial VALUES ('ED097', 'correo_sin_arroba', '3001234999', 'Editorial Mala', 'Bolivia');

-- Telefono con letras en Usuario
INSERT INTO Usuario VALUES ('USR097', 'nuevo@correo.com', 'Administrador', 'Nombre', 'Apellido', 'ABCD123456');

-- Estado fisico invalido en Ejemplar
-- (valores validos: 'Desgastado', 'Bueno', 'Dañado', 'Restaurado', 'Perdido', 'Nuevo')
INSERT INTO Ejemplar VALUES ('EJE098', 'XX', 1, 'Estante Q', TO_DATE('2023-01-01','YYYY-MM-DD'), 'EDI001');

-- Fecha de publicacion futura en Libro
INSERT INTO Libro VALUES ('LIB098', 'Libro Futuro', TO_DATE('2099-01-01','YYYY-MM-DD'), 'Espanol', 'Fecha invalida futura', 'CAT001');

-- Permisos invalidos en Administrador  (valores validos: 'Solo Lectura', 'Operativo', 'Total')
INSERT INTO Administrador VALUES ('USR002', 'X', 'Sede Sur');

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

-- Consulta de restricciones foraneas
SELECT constraint_name, table_name, r_constraint_name
FROM user_constraints
WHERE constraint_type = 'R'
ORDER BY table_name;

---------------------------------------------------------------------------------------------
--- PERSISTENCIA: XTABLAS -> Eliminación de tablas (con CASCADE)
---------------------------------------------------------------------------------------------
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

---------------------------------------------------------------------------------------------
--- DISPARADORES: Automatización y restricciones procedimentales
---------------------------------------------------------------------------------------------

-- =====================================================================
-- DISP-1: Validar que el año de la Edicion no sea anterior a
--         fecha_publicacion del Libro
-- CU-4 (Ediciones) > A: "Se requiere la existencia de un Libro y una
--   Editorial para establecer el vínculo" + TUP-4: "El año de la Edicion
--   no puede ser anterior a la fecha_publicacion del Libro."
-- =====================================================================
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
/

-- =====================================================================
-- DISP-2: Actualizar automáticamente el total de una Compra
--         al insertar, modificar o eliminar un Producto_Compra
-- CU-7 (Compras) > A: "Presenta fecha, costo y la lista de Producto
--   Compra (cantidad, precio_unitario)" + "Se requiere un Proveedor
--   válido y que el estado: Logico sea verdadero al finalizar."
-- El total debe mantenerse consistente con sus líneas de detalle en
-- todo momento, sin depender de cálculos manuales desde la aplicación.
-- =====================================================================
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

-- =====================================================================
-- DISP-3: Impedir la eliminación de un Ejemplar disponible
-- CU-6 (Ejemplares) > E: "Se requiere que el ejemplar tenga
--   disponibilidad: Falso y no esté vinculado a devoluciones
--   pendientes."
-- La primera condición (disponibilidad=FALSE) se enforza aquí.
-- La segunda (devoluciones pendientes) requiere las tablas Prestamo
-- y Devolucion aún no definidas en el DDL — ver DISP-16 comentado.
-- =====================================================================
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

-- =====================================================================
-- DISP-4: Solo un Administrador puede insertar en tablas de gestión.
-- CU-1 al CU-8 (todos los casos de uso de Administrador):
--   Cada caso de uso del rol Administrador implica que solo ese rol
--   puede ejecutar altas. No hay una línea textual única; es la
--   asignación de rol "COMO Administrador, QUIERO..." la que
--   establece la restricción transversal a todas las tablas de catálogo.
-- =====================================================================
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
    AND    U.rol = 'Administrador';

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
    AND    U.rol = 'Administrador';

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
    AND    U.rol = 'Administrador';

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
    AND    U.rol = 'Administrador';

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
    AND    U.rol = 'Administrador';

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
    AND    U.rol = 'Administrador';

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
    AND    U.rol = 'Administrador';

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

-- =====================================================================
-- DISP-5: Al modificar el correo de un Proveedor, verificar que no
--         exista en Editorial
-- CU-8 (Proveedores) > M: "Se requiere que el proveedor exista en el
--   sistema." + CU-5 (Editoriales) > A: "Se requiere que el id sea
--   único y el correo cumpla con el formato de validación."
-- La restricción UNIQUE en Editorial.correo y Proveedor.correo garantiza
-- unicidad dentro de cada tabla, pero no entre ambas. Este trigger cubre
-- el cruce: un correo ya registrado como editorial no puede asignarse
-- a un proveedor y viceversa, preservando la integridad de contacto
-- a nivel de sistema.
-- =====================================================================
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

-- =====================================================================
-- DISP-6: Al modificar título del Libro, verificar que no tenga
--         ediciones activas
-- CU-2 (Libros) > M: "Se requiere que el libro no tenga ediciones
--   activas si se intenta cambiar el título."
-- Cita directa del caso de uso: la restricción aplica únicamente al
-- campo titulo, no a otros atributos modificables (descripcion, idioma).
-- =====================================================================
CREATE OR REPLACE TRIGGER TRG_Libro_Titulo_Sin_Ediciones
BEFORE UPDATE OF titulo ON Libro
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Edicion
    WHERE  id_libro = :OLD.id;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20020,
            'No se puede modificar el título del libro ' || :OLD.id ||
            ' porque tiene ' || v_count || ' edición(es) activa(s) registrada(s).');
    END IF;
END TRG_Libro_Titulo_Sin_Ediciones;
/

-- =====================================================================
-- DISP-7: Al eliminar Libro, verificar que no tenga ediciones vinculadas
-- CU-2 (Libros) > E: "Se requiere que el libro no posea ediciones
--   (1..*) vinculadas en el sistema."
-- Aunque FK_Edicion_Libro es ON DELETE CASCADE, el caso de uso exige
-- una validación explícita con mensaje de negocio antes de permitir
-- la baja — el CASCADE debe cambiarse a RESTRICT para que este
-- trigger tenga efecto real (ver recomendación general #1).
-- =====================================================================
CREATE OR REPLACE TRIGGER TRG_Libro_Baja_Sin_Ediciones
BEFORE DELETE ON Libro
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Edicion
    WHERE  id_libro = :OLD.id;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20021,
            'No se puede eliminar el libro "' || :OLD.titulo ||
            '" porque posee ' || v_count || ' edición(es) registrada(s).');
    END IF;
END TRG_Libro_Baja_Sin_Ediciones;
/

-- =====================================================================
-- DISP-8: Al eliminar Autor, verificar que no tenga libros asociados
-- CU-3 (Autores) > E: "Se requiere que el autor no tenga libros (1..*)
--   asociados para proceder."
-- La relación autor-libro es N:M a través de Libro_Autor. La FK
-- FK_LibroAutor_Autor es ON DELETE CASCADE, por lo que eliminaría
-- las filas intermedias sin validar. Este trigger intercepta antes
-- y lanza el error de negocio requerido.
-- =====================================================================
CREATE OR REPLACE TRIGGER TRG_Autor_Baja_Sin_Libros
BEFORE DELETE ON Autor
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Libro_Autor
    WHERE  id_autor = :OLD.id;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20030,
            'No se puede eliminar al autor ' || :OLD.nombre || ' ' || :OLD.apellidos ||
            ' porque tiene ' || v_count || ' libro(s) vinculado(s).');
    END IF;
END TRG_Autor_Baja_Sin_Libros;
/

-- =====================================================================
-- DISP-9: Al eliminar Categoria, verificar que no tenga libros vinculados
-- CU-1 (Categorias) > E: "Se requiere que la categoría no tenga libros
--   (0..*) vinculados para mantener la integridad."
-- Nótese que el caso de uso usa (0..*), lo que significa que SÍ puede
-- existir con cero libros — la restricción es no eliminar si hay al
-- menos uno. FK_Libro_Categoria es ON DELETE SET NULL, así que sin
-- este trigger Oracle permitiría la eliminación dejando libros
-- huérfanos de categoría silenciosamente.
-- =====================================================================
CREATE OR REPLACE TRIGGER TRG_Categoria_Baja_Sin_Libros
BEFORE DELETE ON Categoria
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Libro
    WHERE  id_categoria = :OLD.id;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20040,
            'No se puede eliminar la categoría "' || :OLD.nombre ||
            '" porque tiene ' || v_count || ' libro(s) asociado(s).');
    END IF;
END TRG_Categoria_Baja_Sin_Libros;
/

-- =====================================================================
-- DISP-10: Al eliminar Edicion, verificar que no tenga ejemplares
--          registrados
-- CU-4 (Ediciones) > E: "Se requiere que la edición no posea ejemplares
--   (1..*) registrados."
-- FK_Ejemplar_Edicion es ON DELETE CASCADE — sin este trigger la
-- eliminación arrastraría todos los ejemplares físicos sin advertencia,
-- lo cual contradice directamente el requisito del caso de uso.
-- =====================================================================
CREATE OR REPLACE TRIGGER TRG_Edicion_Baja_Sin_Ejemplares
BEFORE DELETE ON Edicion
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Ejemplar
    WHERE  id_edicion = :OLD.id;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20050,
            'No se puede eliminar la edición ' || :OLD.id ||
            ' porque posee ' || v_count || ' ejemplar(es) registrado(s).');
    END IF;
END TRG_Edicion_Baja_Sin_Ejemplares;
/

-- =====================================================================
-- DISP-11: Al modificar Edicion (id_libro o id_editorial), verificar
--          que no tenga ejemplares asociados
-- CU-4 (Ediciones) > M: "Se requiere que la edición no tenga Ejemplares
--   asociados si se desea cambiar el origen."
-- "El origen" refiere a los vínculos con Libro y Editorial. Cambiar
-- cualquiera de esas dos FKs estando ya materializada en ejemplares
-- físicos comprometería la trazabilidad del inventario.
-- =====================================================================
CREATE OR REPLACE TRIGGER TRG_Edicion_Origen_Sin_Ejemplares
BEFORE UPDATE OF id_libro, id_editorial ON Edicion
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Ejemplar
    WHERE  id_edicion = :OLD.id;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20051,
            'No se puede cambiar el origen de la edición ' || :OLD.id ||
            ' porque tiene ' || v_count || ' ejemplar(es) asociado(s).');
    END IF;
END TRG_Edicion_Origen_Sin_Ejemplares;
/

-- =====================================================================
-- DISP-12: Al eliminar Editorial, verificar que no tenga ediciones
--          vinculadas
-- CU-5 (Editoriales) > E: "Se requiere que la editorial no tenga
--   ediciones (1..*) vinculadas."
-- FK_Edicion_Editorial es ON DELETE SET NULL, por lo que Oracle
-- permitiría la eliminación dejando ediciones sin editorial. El trigger
-- bloquea esto y exige el mensaje de negocio requerido por el CU.
-- =====================================================================
CREATE OR REPLACE TRIGGER TRG_Editorial_Baja_Sin_Ediciones
BEFORE DELETE ON Editorial
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Edicion
    WHERE  id_editorial = :OLD.id;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20060,
            'No se puede eliminar la editorial "' || :OLD.nombre ||
            '" porque tiene ' || v_count || ' edición(es) publicada(s).');
    END IF;
END TRG_Editorial_Baja_Sin_Ediciones;
/

-- =====================================================================
-- DISP-13: Al eliminar Proveedor, verificar que no tenga compras
--          asociadas
-- CU-8 (Proveedores) > E: "Se requiere que el proveedor no tenga
--   registros de Compra (1..*) asociados."
-- FK_Compra_Proveedor es ON DELETE SET NULL — sin este trigger la
-- eliminación dejaría compras históricas sin proveedor identificable,
-- perdiendo trazabilidad de adquisición.
-- =====================================================================
CREATE OR REPLACE TRIGGER TRG_Proveedor_Baja_Sin_Compras
BEFORE DELETE ON Proveedor
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Compra
    WHERE  id_proveedor = :OLD.id;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20070,
            'No se puede eliminar al proveedor "' || :OLD.empresa ||
            '" porque tiene ' || v_count || ' compra(s) registrada(s).');
    END IF;
END TRG_Proveedor_Baja_Sin_Compras;
/

-- =====================================================================
-- DISP-14: Al modificar Compra, verificar que esté en estado PENDIENTE
-- CU-7 (Compras) > M: "Se requiere que la compra esté en estado
--   'Pendiente' y no haya sido procesada totalmente."
-- Solo las compras aún no procesadas (PENDIENTE) pueden ajustarse.
-- Una compra COMPLETADA o RECHAZADA es un registro histórico inmutable.
-- =====================================================================
CREATE OR REPLACE TRIGGER TRG_Compra_Modificar_Solo_Pendiente
BEFORE UPDATE ON Compra
FOR EACH ROW
BEGIN
    IF :OLD.estado != 'PENDIENTE' THEN
        RAISE_APPLICATION_ERROR(-20080,
            'Solo se puede modificar una compra en estado PENDIENTE. ' ||
            'Estado actual: ' || :OLD.estado);
    END IF;
END TRG_Compra_Modificar_Solo_Pendiente;
/

-- =====================================================================
-- DISP-15: Al eliminar Compra, verificar que no haya generado
--          ejemplares físicos
-- CU-7 (Compras) > E: "Se requiere que no se hayan generado Ejemplares
--   físicos a partir de esta compra."
-- El modelo actual no tiene FK directa Compra→Ejemplar, por lo que
-- la detección es heurística: cruza Producto_Compra → Edicion →
-- Ejemplar filtrando por fecha_adquisicion = fecha de la compra.
-- Si el modelo incorpora un campo id_compra en Ejemplar en el futuro,
-- reemplazar esta lógica por un JOIN directo.
-- =====================================================================
CREATE OR REPLACE TRIGGER TRG_Compra_Baja_Sin_Ejemplares
BEFORE DELETE ON Compra
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Ejemplar ej
    JOIN   Edicion  ed ON ed.id = ej.id_edicion
    JOIN   Producto_Compra pc ON pc.id_libro = ed.id_libro
    WHERE  pc.id_compra = :OLD.id
    AND    ej.fecha_adquisicion = :OLD.fecha;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20081,
            'No se puede eliminar la compra ' || :OLD.id ||
            ' porque ya se generaron ' || v_count || ' ejemplar(es) físicos a partir de ella.');
    END IF;
END TRG_Compra_Baja_Sin_Ejemplares;
/

---------------------------------------------------------------------------------------------
--- XDISPARADORES: Eliminación de disparadores
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
DROP TRIGGER TRG_Libro_Titulo_Sin_Ediciones;
DROP TRIGGER TRG_Libro_Baja_Sin_Ediciones;
DROP TRIGGER TRG_Autor_Baja_Sin_Libros;
DROP TRIGGER TRG_Categoria_Baja_Sin_Libros;
DROP TRIGGER TRG_Edicion_Baja_Sin_Ejemplares;
DROP TRIGGER TRG_Edicion_Origen_Sin_Ejemplares;
DROP TRIGGER TRG_Editorial_Baja_Sin_Ediciones;
DROP TRIGGER TRG_Proveedor_Baja_Sin_Compras;
DROP TRIGGER TRG_Compra_Modificar_Solo_Pendiente;
DROP TRIGGER TRG_Compra_Baja_Sin_Ejemplares;