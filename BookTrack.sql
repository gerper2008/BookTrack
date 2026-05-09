---------------------------------------------------------------------------------------------
--- PERSISTENCIA: TABLAS -> Creación de tablas
---------------------------------------------------------------------------------------------
CREATE TABLE Usuario (
    id VARCHAR2(10),
    correo VARCHAR2(50),
    rol VARCHAR2(30),
    nombre VARCHAR2(60),
    apellidos VARCHAR2(60),
    telefono VARCHAR2(10)
);

CREATE TABLE Administrador (
    idUsuario VARCHAR2(10),
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
    nombre VARCHAR2(60),
    apellidos VARCHAR2(60),
    genero VARCHAR2(30),
    nacionalidad VARCHAR2(50)
);

CREATE TABLE Libro (
    id VARCHAR2(10),
    titulo VARCHAR2(60),
    fecha_publicacion DATE,
    idioma VARCHAR2(30),
    descripcion VARCHAR2(200),
    idCategoria VARCHAR2(10)
);

CREATE TABLE Libro_Autor (
    idLibro VARCHAR2(10),
    idAutor VARCHAR2(10)
);

CREATE TABLE Ejemplar (
    id VARCHAR2(10),
    estadoFisico VARCHAR2(30),
    disponibilidad BOOLEAN,
    localizacion VARCHAR2(40),
    fechaAdquisicion DATE,
    idEdicion VARCHAR2(10)
);

CREATE TABLE Edicion (
    id VARCHAR2(10),
    año DATE,
    paginas INT,
    idLibro VARCHAR2(10),
    idEditorial VARCHAR2(10)
);

CREATE TABLE Editorial (
    id VARCHAR2(10),
    correo VARCHAR2(100),
    telefono VARCHAR2(10),
    nombre VARCHAR2(50),
    pais VARCHAR2(60)
);

CREATE TABLE Producto_Compra (
    id VARCHAR2(10),
    cantidad INT,
    precioUnidad DECIMAL(10, 2),
    idCompra VARCHAR2(10),
    idLibro VARCHAR2(10)
);

CREATE TABLE Compra (
    id VARCHAR2(10),
    fecha DATE,
    total DECIMAL(10, 2),
    estado VARCHAR2(20),
    idProveedor VARCHAR2(10)
);

CREATE TABLE Proveedor (
    id VARCHAR2(10),
    correo VARCHAR2(100),
    nombre VARCHAR2(60),
    apellidos VARCHAR2(60),
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
ALTER TABLE Ejemplar ADD CONSTRAINT CHECK_Ejemplar_fechaAdquisicion CHECK (fechaAdquisicion <= TO_DATE('31/12/2025', 'DD/MM/YYYY'));
ALTER TABLE Ejemplar ADD CONSTRAINT CHECK_Ejemplar_estadoFisico CHECK (estadoFisico IN ('Desgastado', 'Bueno', 'Dañado', 'Restaurado', 'Perdido', 'Nuevo'));

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
ALTER TABLE Producto_Compra ADD CONSTRAINT CHECK_Producto_Compra_precioUnidad CHECK (precioUnidad > 0.0);

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
ALTER TABLE Libro_Autor ADD PRIMARY KEY (idLibro, idAutor);
ALTER TABLE Administrador ADD PRIMARY KEY(idUsuario);

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
ALTER TABLE Administrador ADD FOREIGN KEY(idUsuario) REFERENCES Usuario(id);
ALTER TABLE Libro ADD FOREIGN KEY(idCategoria) REFERENCES Categoria(id);
ALTER TABLE Edicion ADD FOREIGN KEY(idLibro) REFERENCES Libro(id);
ALTER TABLE Edicion ADD FOREIGN KEY(idEditorial) REFERENCES Editorial(id);
ALTER TABLE Ejemplar ADD FOREIGN KEY(idEdicion) REFERENCES Edicion(id);
ALTER TABLE Compra ADD FOREIGN KEY(idProveedor) REFERENCES Proveedor(id);
ALTER TABLE Producto_Compra ADD FOREIGN KEY(idCompra) REFERENCES Compra(id);
ALTER TABLE Producto_Compra ADD FOREIGN KEY(idLibro) REFERENCES Libro(id);
ALTER TABLE Libro_Autor ADD FOREIGN KEY (idLibro) REFERENCES Libro(id);
ALTER TABLE Libro_Autor ADD FOREIGN KEY (idAutor) REFERENCES Autor(id);

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

-- Edicion (id, año, paginas, idLibro, idEditorial)
INSERT INTO Edicion VALUES ('EDI001', TO_DATE('2000-01-01','YYYY-MM-DD'), 432, 'LIB001', 'ED001');
INSERT INTO Edicion VALUES ('EDI002', TO_DATE('2005-06-15','YYYY-MM-DD'), 200, 'LIB002', 'ED002');
INSERT INTO Edicion VALUES ('EDI003', TO_DATE('2010-03-20','YYYY-MM-DD'), 350, 'LIB003', 'ED003');

-- Ejemplar (id, estadoFisico, disponibilidad, localizacion, fecha_adquisicion, idEdicion)
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

-- Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro)
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

-- Libro con idCategoria que no existe
INSERT INTO Libro VALUES ('LIB099', 'Libro Huerfano', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol', 'Sin categoria valida', 'CAT999');

-- Edicion con idLibro que no existe
INSERT INTO Edicion VALUES ('EDI099', TO_DATE('2024-01-01','YYYY-MM-DD'), 100, 'LIB999', 'ED001');

-- Edicion con idEditorial que no existe
INSERT INTO Edicion VALUES ('EDI098', TO_DATE('2024-01-01','YYYY-MM-DD'), 200, 'LIB001', 'ED999');

-- Ejemplar con idEdicion que no existe
INSERT INTO Ejemplar VALUES ('EJE099', 'Nuevo', 1, 'Estante Z nueve', TO_DATE('2024-01-01','YYYY-MM-DD'), 'EDI999');

-- Compra con idProveedor que no existe
INSERT INTO Compra VALUES ('CMP099', TO_DATE('2024-06-01','YYYY-MM-DD'), 99999.00, 'COMPLETADO', 'PRV999');

-- Producto_Compra con idCompra que no existe
INSERT INTO Producto_Compra VALUES ('PC099', 1, 50000.00, 'CMP999', 'LIB001');

-- Producto_Compra con idLibro que no existe
INSERT INTO Producto_Compra VALUES ('PC098', 1, 50000.00, 'CMP001', 'LIB999');

-- Administrador con idUsuario que no existe
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
SELECT id, estadoFisico, localizacion FROM Ejemplar WHERE disponibilidad = 1;

-- Q4: Libro con su categoria
SELECT L.titulo, C.nombre AS categoria
FROM Libro L
JOIN Categoria C ON L.idCategoria = C.id;

-- Q5: Ediciones con su editorial
SELECT E.id, E.paginas, ED.nombre AS editorial
FROM Edicion E
JOIN Editorial ED ON E.idEditorial = ED.id;

-- Q6: Compras con su proveedor
SELECT C.id, C.fecha, C.total, P.nombre AS proveedor
FROM Compra C
JOIN Proveedor P ON C.idProveedor = P.id;

-- Q7: Cantidad de libros por categoria
SELECT C.nombre AS categoria, COUNT(L.id) AS total_libros
FROM Categoria C
JOIN Libro L ON L.idCategoria = C.id
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
DROP TABLE Libro_Autor CASCADE CONSTRAINTS;
DROP TABLE Autor CASCADE CONSTRAINTS;
DROP TABLE Categoria CASCADE CONSTRAINTS;
DROP TABLE Editorial CASCADE CONSTRAINTS;
DROP TABLE Proveedor CASCADE CONSTRAINTS;
DROP TABLE Usuario CASCADE CONSTRAINTS;

---------------------------------------------------------------------------------------------
--- TUPLAS: Restricciones que involucran más de un atributo
---------------------------------------------------------------------------------------------

-- TUP1: En Compra, si estado='COMPLETADO' el total debe ser > 0.
-- Nota: los valores válidos de estado están en mayúsculas según CHECK_Compra_estado.
--   Se unifica criterio: 'PENDIENTE', 'COMPLETADO', 'RECHAZADO'.
--   El trigger TRG_Compra_Estado_Inicial debe actualizarse para asignar 'PENDIENTE'.
ALTER TABLE Compra ADD CONSTRAINT CH_Compra_estado_total
    CHECK (
        (estado = 'COMPLETADO' AND total > 0)
        OR (estado IN ('PENDIENTE', 'RECHAZADO') AND total >= 0)
    );

-- TUP2: En Producto_Compra, cantidad y precioUnidad juntos deben ser positivos.
-- Nota: cada atributo ya tiene su CHECK individual (CHECK_Producto_Compra_cantidad
--   y CHECK_Producto_Compra_precioUnidad). Esta constraint es redundante pero se
--   conserva como documentación explícita de la regla de negocio conjunta.
ALTER TABLE Producto_Compra ADD CONSTRAINT CH_ProductoCompra_importe
    CHECK (cantidad > 0 AND precio_unidad > 0);

-- TUP3: En Ejemplar, si disponibilidad = 0 (no disponible), estadoFisico NO puede ser 'Nuevo'.
-- Nota: Oracle anterior a 23c no tiene tipo BOOLEAN nativo. La columna disponibilidad
--   se trata como NUMBER(1): 1 = disponible, 0 = no disponible.
--   Se corrige 'FALSE' (string inválido) por comparación numérica.
--   Se corrige también el nombre de columna: estado_fisico → estadoFisico (según DDL).
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

-- TUP7: En Autor, nombre, apellidos y nacionalidad son obligatorios en conjunto.
-- Nota: CHECK (col IS NOT NULL) es equivalente a NOT NULL en cada columna.
--   Se reemplaza por constraints NOT NULL directas, que son más eficientes.
ALTER TABLE Autor ADD CONSTRAINT CH_Autor_nombre_apellidos_nacionalidad
    CHECK (nombre IS NOT NULL AND apellidos IS NOT NULL nacionalidad IS NOT NULL);

---------------------------------------------------------------------------------------------
--- ACCIONES: Definición de acciones de referencia
---------------------------------------------------------------------------------------------

-- Libro.idCategoria → Categoria(id)  |  ON DELETE SET NULL
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
    FOREIGN KEY (idCategoria) REFERENCES Categoria(id) ON DELETE SET NULL;

-- Edicion.idLibro → Libro(id)  |  ON DELETE CASCADE
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
    FOREIGN KEY (idLibro) REFERENCES Libro(id) ON DELETE CASCADE;

-- Edicion.idEditorial → Editorial(id)  |  ON DELETE SET NULL
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
    FOREIGN KEY (idEditorial) REFERENCES Editorial(id) ON DELETE SET NULL;

-- Ejemplar.idEdicion → Edicion(id)  |  ON DELETE CASCADE
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
    FOREIGN KEY (idEdicion) REFERENCES Edicion(id) ON DELETE CASCADE;

-- Compra.idProveedor → Proveedor(id)  |  ON DELETE SET NULL
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
    FOREIGN KEY (idProveedor) REFERENCES Proveedor(id) ON DELETE SET NULL;

-- Producto_Compra.idCompra → Compra(id)  |  ON DELETE CASCADE
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
    FOREIGN KEY (idCompra) REFERENCES Compra(id) ON DELETE CASCADE;

-- Producto_Compra.idLibro → Libro(id)  |  ON DELETE SET NULL
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
    FOREIGN KEY (idLibro) REFERENCES Libro(id) ON DELETE SET NULL;

-- Administrador.idUsuario → Usuario(id)  |  ON DELETE CASCADE
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
    FOREIGN KEY (idUsuario) REFERENCES Usuario(id) ON DELETE CASCADE;

-- Libro_Autor: tabla nueva con sus FKs CASCADE
CREATE TABLE Libro_Autor (
    idLibro VARCHAR2(10),
    id_autor VARCHAR2(10)
);
ALTER TABLE Libro_Autor ADD PRIMARY KEY (idLibro, id_autor);
ALTER TABLE Libro_Autor ADD CONSTRAINT FK_LibroAutor_Libro
    FOREIGN KEY (idLibro) REFERENCES Libro(id) ON DELETE CASCADE;
ALTER TABLE Libro_Autor ADD CONSTRAINT FK_LibroAutor_Autor
    FOREIGN KEY (id_autor) REFERENCES Autor(id) ON DELETE CASCADE;

---------------------------------------------------------------------------------------------
--- DISPARADORES: Automatización y restricciones procedimentales
---------------------------------------------------------------------------------------------

-- ==========================================================================================
-- CU-1 (Mantener Categoría): COMO Administrador, QUIERO gestionar los géneros y
-- clasificaciones, PARA PODER organizar el catálogo por áreas temáticas.
-- ==========================================================================================

-- DISP-01: Generar automáticamente el id de Categoria con formato CAT + secuencial de 3 dígitos
-- CU-1 > A: "El id se genera automáticamente con el formato CAT + secuencial de
--   3 dígitos (CAT001, CAT002, ...)"
CREATE OR REPLACE TRIGGER TRG_Categoria_Generar_Id
BEFORE INSERT ON Categoria
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID
    FROM Categoria;

    :NEW.id := 'CAT' || LPAD(lastID + 1, 3, '0');
END TRG_Categoria_Generar_Id;
/

-- DISP-02: Solo un Administrador puede registrar Categorias
-- CU-1 > A: "Solo un Administrador puede registrar categorías"
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Categoria
BEFORE INSERT ON Categoria
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Administrador A
    JOIN Usuario U ON U.id = A.idUsuario
    WHERE U.rol = 'Administrador';

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Categorias.');
    END IF;
END TRG_Solo_Admin_Categoria;
/

-- DISP-03: Al eliminar Categoria, verificar que no tenga libros vinculados
-- CU-1 > E: "Se requiere que la categoría no tenga libros (0..*) vinculados
--   para mantener la integridad."
CREATE OR REPLACE TRIGGER TRG_Categoria_Baja_Sin_Libros
BEFORE DELETE ON Categoria
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Libro
    WHERE idCategoria = :OLD.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20040,
            'No se puede eliminar la categoría "' || :OLD.nombre ||
            '" porque tiene ' || count || ' libro(s) asociado(s).');
    END IF;
END TRG_Categoria_Baja_Sin_Libros;
/

-- DISP-04: Verificar que el nombre de la Categoria no esté duplicado
-- CU-1 > A: "Se requiere que el nombre no esté duplicado en el sistema."
CREATE OR REPLACE TRIGGER TRG_Categoria_Nombre_Unico
BEFORE INSERT OR UPDATE OF nombre ON Categoria
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Categoria
    WHERE UPPER(nombre) = UPPER(:NEW.nombre)
    AND   id != :NEW.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20042,
            'Ya existe una categoría con el nombre "' || :NEW.nombre || '" en el sistema.');
    END IF;
END TRG_Categoria_Nombre_Unico;
/

-- ==========================================================================================
-- CU-2 (Mantener Libro): COMO Administrador, QUIERO gestionar la información de los libros,
-- PARA PODER mantener el catálogo actualizado.
-- ==========================================================================================

-- DISP-05: Generar automáticamente el id de Libro con formato LIB + secuencial de 3 dígitos
-- CU-2 > A: "El id se genera automáticamente con el formato LIB + secuencial de
--   3 dígitos (LIB001, LIB002, ...)"
-- Corrección: SUBSTR arranca en posición 4 (longitud de prefijo 'LIB' = 3 chars).
--   La versión anterior usaba posición 6 y generaba 'LIB-001' con guion,
--   inconsistente con el formato definido en el caso de uso.
CREATE OR REPLACE TRIGGER TRG_Libro_Generar_Id
BEFORE INSERT ON Libro
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID
    FROM Libro;

    :NEW.id := 'LIB' || LPAD(lastID + 1, 3, '0');
END TRG_Libro_Generar_Id;
/

-- DISP-06: Verificar que el idCategoria del Libro exista en Categoria
-- CU-2 > A: "El idCategoria suministrado debe corresponder a una categoría
--   registrada en el sistema."
CREATE OR REPLACE TRIGGER TRG_Libro_Categoria_Existe
BEFORE INSERT OR UPDATE OF idCategoria ON Libro
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Categoria
    WHERE id = :NEW.idCategoria;

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20041,
            'La categoría "' || :NEW.idCategoria ||
            '" no existe en el catálogo.');
    END IF;
END TRG_Libro_Categoria_Existe;
/

-- DISP-07: Solo un Administrador puede registrar Libros
-- CU-2 > A: "Solo un Administrador puede registrar libros"
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Libro
BEFORE INSERT ON Libro
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Administrador A
    JOIN Usuario U ON U.id = A.idUsuario
    WHERE U.rol = 'Administrador';

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Libros.');
    END IF;
END TRG_Solo_Admin_Libro;
/

-- DISP-08: Al modificar el título del Libro, verificar que no tenga ediciones activas
-- CU-2 > M: "Se requiere que el libro no tenga ediciones activas si se intenta
--   cambiar el título."
CREATE OR REPLACE TRIGGER TRG_Libro_Titulo_Sin_Ediciones
BEFORE UPDATE OF titulo ON Libro
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Edicion
    WHERE idLibro = :OLD.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20020,
            'No se puede modificar el título del libro "' || :OLD.titulo ||
            '" porque tiene ' || count || ' edición(es) activa(s) registrada(s).');
    END IF;
END TRG_Libro_Titulo_Sin_Ediciones;
/

-- DISP-09: Al eliminar Libro, verificar que no tenga ediciones vinculadas
-- CU-2 > E: "Se requiere que el libro no posea ediciones vinculadas en el sistema."
CREATE OR REPLACE TRIGGER TRG_Libro_Baja_Sin_Ediciones
BEFORE DELETE ON Libro
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Edicion
    WHERE idLibro = :OLD.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20021,
            'No se puede eliminar el libro "' || :OLD.titulo ||
            '" porque posee ' || count || ' edición(es) registrada(s).');
    END IF;
END TRG_Libro_Baja_Sin_Ediciones;
/

-- ==========================================================================================
-- CU-3 (Mantener Autor): COMO Administrador, QUIERO gestionar la información de los
-- escritores, PARA PODER clasificar los libros según su autoría.
-- ==========================================================================================

-- DISP-10: Generar automáticamente el id de Autor con formato AUT + secuencial de 3 dígitos
-- CU-3 > A: "El id se genera automáticamente con el formato AUT + secuencial de
--   3 dígitos (AUT001, AUT002, ...)"
CREATE OR REPLACE TRIGGER TRG_Autor_Generar_Id
BEFORE INSERT ON Autor
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID
    FROM Autor;

    :NEW.id := 'AUT' || LPAD(lastID + 1, 3, '0');
END TRG_Autor_Generar_Id;
/

-- DISP-11: Solo un Administrador puede registrar Autores
-- CU-3 > A: "Solo un Administrador puede registrar autores"
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Autor
BEFORE INSERT ON Autor
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Administrador A
    JOIN Usuario U ON U.id = A.idUsuario
    WHERE U.rol = 'Administrador';

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Autores.');
    END IF;
END TRG_Solo_Admin_Autor;
/

-- DISP-12: Verificar que la combinación nombre + apellidos del Autor no esté duplicada
-- CU-3 > A/M: "Se requiere que la combinación nombre + apellidos no esté duplicada
--   en el sistema."
CREATE OR REPLACE TRIGGER TRG_Autor_Nombre_Unico
BEFORE INSERT OR UPDATE OF nombre, apellidos ON Autor
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Autor
    WHERE UPPER(nombre) = UPPER(:NEW.nombre)
    AND UPPER(apellidos) = UPPER(:NEW.apellidos)
    AND id != :NEW.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20050,
            'Ya existe un autor con el nombre "' || :NEW.nombre ||
            ' ' || :NEW.apellidos || '" en el sistema.');
    END IF;
END TRG_Autor_Nombre_Unico;
/

-- DISP-13: Verificar que el Autor exista antes de modificar
-- CU-3 > M: "Se requiere que el autor exista previamente en el sistema."
CREATE OR REPLACE TRIGGER TRG_Autor_Existe_Para_Modificar
BEFORE UPDATE ON Autor
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Autor
    WHERE id = :OLD.id;

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20051,
            'El autor con id "' || :OLD.id || '" no existe en el sistema.');
    END IF;
END TRG_Autor_Existe_Para_Modificar;
/

-- DISP-14: Al eliminar Autor, verificar que no tenga libros vinculados
-- CU-3 > E: "Se requiere que el autor no tenga libros (0..*) asociados para proceder."
-- Nota: se asume tabla intermedia Libro_Autor (idLibro, idAutor) por relación M:N
CREATE OR REPLACE TRIGGER TRG_Autor_Baja_Sin_Libros
BEFORE DELETE ON Autor
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Libro_Autor
    WHERE idAutor = :OLD.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20052,
            'No se puede eliminar el autor "' || :OLD.nombre || ' ' || :OLD.apellidos ||
            '" porque tiene ' || count || ' libro(s) asociado(s).');
    END IF;
END TRG_Autor_Baja_Sin_Libros;
/

-- ==========================================================================================
-- CU-4 (Mantener Edición): COMO Administrador, QUIERO gestionar las versiones específicas
-- de los títulos, PARA PODER controlar el año y la extensión de cada obra.
-- ==========================================================================================

-- DISP-15: Generar automáticamente el id de Edicion con formato EDI + secuencial de 3 dígitos
-- CU-4 > A: "El id se genera automáticamente con el formato EDI + secuencial de
--   3 dígitos (EDI001, EDI002, ...)"
CREATE OR REPLACE TRIGGER TRG_Edicion_Generar_Id
BEFORE INSERT ON Edicion
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID
    FROM Edicion;

    :NEW.id := 'EDI' || LPAD(lastID + 1, 3, '0');
END TRG_Edicion_Generar_Id;
/

-- DISP-16: Solo un Administrador puede registrar Ediciones
-- CU-4 > A: "Solo un Administrador puede registrar ediciones"
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Edicion
BEFORE INSERT ON Edicion
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Administrador A
    JOIN Usuario U ON U.id = A.idUsuario
    WHERE U.rol = 'Administrador';

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Ediciones.');
    END IF;
END TRG_Solo_Admin_Edicion;
/

-- DISP-17: Verificar que el idLibro de la Edicion exista en Libro
-- CU-4 > A/M: "El idLibro suministrado debe corresponder a un libro registrado
--   en el sistema."
CREATE OR REPLACE TRIGGER TRG_Edicion_Libro_Existe
BEFORE INSERT OR UPDATE OF idLibro ON Edicion
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Libro
    WHERE id = :NEW.idLibro;

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20060,
            'El libro con id "' || :NEW.idLibro || '" no existe en el catálogo.');
    END IF;
END TRG_Edicion_Libro_Existe;
/

-- DISP-18: Verificar que el idEditorial de la Edicion exista en Editorial
-- CU-4 > A/M: "El idEditorial suministrado debe corresponder a una editorial
--   registrada en el sistema."
CREATE OR REPLACE TRIGGER TRG_Edicion_Editorial_Existe
BEFORE INSERT OR UPDATE OF idEditorial ON Edicion
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Editorial
    WHERE id = :NEW.idEditorial;

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20061,
            'La editorial con id "' || :NEW.idEditorial || '" no existe en el sistema.');
    END IF;
END TRG_Edicion_Editorial_Existe;
/

-- DISP-19: Al modificar el origen (idLibro o idEditorial), verificar ausencia de Ejemplares
-- CU-4 > M: "Se requiere que la edición no tenga Ejemplares asociados si se desea
--   cambiar el origen (idLibro o idEditorial)."
CREATE OR REPLACE TRIGGER TRG_Edicion_Origen_Sin_Ejemplares
BEFORE UPDATE OF idLibro, idEditorial ON Edicion
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    IF (:NEW.idLibro     != :OLD.idLibro OR
        :NEW.idEditorial != :OLD.idEditorial) THEN

        SELECT COUNT(*)
        INTO count
        FROM Ejemplar
        WHERE idEdicion = :OLD.id;

        IF count > 0 THEN
            RAISE_APPLICATION_ERROR(-20062,
                'No se puede cambiar el origen de la edición "' || :OLD.id ||
                '" porque posee ' || count || ' ejemplar(es) registrado(s).');
        END IF;
    END IF;
END TRG_Edicion_Origen_Sin_Ejemplares;
/

-- DISP-20: Al eliminar Edicion, verificar que no tenga Ejemplares vinculados
-- CU-4 > E: "Se requiere que la edición no posea ejemplares (0..*) registrados."
CREATE OR REPLACE TRIGGER TRG_Edicion_Baja_Sin_Ejemplares
BEFORE DELETE ON Edicion
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Ejemplar
    WHERE idEdicion = :OLD.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20063,
            'No se puede eliminar la edición "' || :OLD.id ||
            '" porque posee ' || count || ' ejemplar(es) registrado(s).');
    END IF;
END TRG_Edicion_Baja_Sin_Ejemplares;
/

-- ==========================================================================================
-- CU-5 (Mantener Editorial): COMO Administrador, QUIERO gestionar las casas editoriales,
-- PARA PODER vincular las ediciones con sus respectivos orígenes.
-- ==========================================================================================

-- DISP-21: Generar automáticamente el id de Editorial con formato EDT + secuencial de 3 dígitos
-- CU-5 > A: "El id se genera automáticamente con el formato EDT + secuencial de
--   3 dígitos (EDT001, EDT002, ...)"
CREATE OR REPLACE TRIGGER TRG_Editorial_Generar_Id
BEFORE INSERT ON Editorial
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID
    FROM Editorial;

    :NEW.id := 'EDT' || LPAD(lastID + 1, 3, '0');
END TRG_Editorial_Generar_Id;
/

-- DISP-22: Solo un Administrador puede registrar Editoriales
-- CU-5 > A: "Solo un Administrador puede registrar editoriales"
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Editorial
BEFORE INSERT ON Editorial
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Administrador A
    JOIN Usuario U ON U.id = A.idUsuario
    WHERE U.rol = 'Administrador';

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Editoriales.');
    END IF;
END TRG_Solo_Admin_Editorial;
/

-- DISP-23: Verificar que el correo de la Editorial no esté duplicado
-- CU-5 > A/M: "Se requiere que el correo no esté duplicado en el sistema."
-- Nota: la constraint UNIQUE ya garantiza integridad; este trigger provee mensaje en español.
CREATE OR REPLACE TRIGGER TRG_Editorial_Correo_Unico
BEFORE INSERT OR UPDATE OF correo ON Editorial
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Editorial
    WHERE UPPER(correo) = UPPER(:NEW.correo)
    AND id != :NEW.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20070,
            'Ya existe una editorial con el correo "' || :NEW.correo || '" en el sistema.');
    END IF;
END TRG_Editorial_Correo_Unico;
/

-- DISP-24: Verificar que el teléfono de la Editorial no esté duplicado
-- CU-5 > A/M: "Se requiere que el teléfono no esté duplicado en el sistema."
-- Nota: la constraint UNIQUE ya garantiza integridad; este trigger provee mensaje en español.
CREATE OR REPLACE TRIGGER TRG_Editorial_Telefono_Unico
BEFORE INSERT OR UPDATE OF telefono ON Editorial
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Editorial
    WHERE telefono = :NEW.telefono
    AND id != :NEW.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20071,
            'Ya existe una editorial con el teléfono "' || :NEW.telefono || '" en el sistema.');
    END IF;
END TRG_Editorial_Telefono_Unico;
/

-- DISP-25: Al eliminar Editorial, verificar que no tenga ediciones vinculadas
-- CU-5 > E: "Se requiere que la editorial no tenga ediciones (0..*) vinculadas."
-- Nota: la FK Edicion.idEditorial → Editorial(id) ya bloquea el DELETE con ORA-02292;
--   este trigger provee mensaje descriptivo en español.
CREATE OR REPLACE TRIGGER TRG_Editorial_Baja_Sin_Ediciones
BEFORE DELETE ON Editorial
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Edicion
    WHERE idEditorial = :OLD.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20072,
            'No se puede eliminar la editorial "' || :OLD.nombre ||
            '" porque tiene ' || count || ' edición(es) registrada(s).');
    END IF;
END TRG_Editorial_Baja_Sin_Ediciones;
/

-- ==========================================================================================
-- CU-6 (Mantener Ejemplar): COMO Administrador, QUIERO gestionar las unidades físicas,
-- PARA PODER controlar el stock y su ubicación.
-- ==========================================================================================

-- DISP-26: Generar automáticamente el id de Ejemplar con formato EJM + secuencial de 3 dígitos
-- CU-6 > A: "El id se genera automáticamente con el formato EJM + secuencial de
--   3 dígitos (EJM001, EJM002, ...)"
CREATE OR REPLACE TRIGGER TRG_Ejemplar_Generar_Id
BEFORE INSERT ON Ejemplar
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID
    FROM Ejemplar;

    :NEW.id := 'EJM' || LPAD(lastID + 1, 3, '0');
END TRG_Ejemplar_Generar_Id;
/

-- DISP-27: Solo un Administrador puede registrar Ejemplares
-- CU-6 > A: "Solo un Administrador puede registrar ejemplares"
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Ejemplar
BEFORE INSERT ON Ejemplar
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Administrador A
    JOIN Usuario U ON U.id = A.idUsuario
    WHERE U.rol = 'Administrador';

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Ejemplares.');
    END IF;
END TRG_Solo_Admin_Ejemplar;
/

-- ==========================================================================================
-- CU-7 (Registrar Compra): COMO Administrador, QUIERO registrar adquisiciones de stock,
-- PARA PODER aumentar el conjunto bibliográfico.
-- ==========================================================================================

-- DISP-28: Generar automáticamente el id de Compra con formato COM + secuencial de 3 dígitos
-- CU-7 > A: "El id se genera automáticamente con el formato COM + secuencial de
--   3 dígitos (COM001, COM002, ...)"
CREATE OR REPLACE TRIGGER TRG_Compra_Generar_Id
BEFORE INSERT ON Compra
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID
    FROM Compra;

    :NEW.id := 'COM' || LPAD(lastID + 1, 3, '0');
END TRG_Compra_Generar_Id;
/

-- DISP-29: Solo un Administrador puede registrar Compras
-- CU-7 > A: "Solo un Administrador puede registrar compras"
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Compra
BEFORE INSERT ON Compra
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Administrador A
    JOIN Usuario U ON U.id = A.idUsuario
    WHERE U.rol = 'Administrador';

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Compras.');
    END IF;
END TRG_Solo_Admin_Compra;
/

-- DISP-30: Verificar que el idProveedor de la Compra exista en Proveedor
-- CU-7 > A: "El idProveedor suministrado debe corresponder a un proveedor registrado."
-- Nota: la FK Compra.idProveedor → Proveedor(id) ya garantiza integridad referencial;
--   este trigger provee mensaje descriptivo en español.
CREATE OR REPLACE TRIGGER TRG_Compra_Proveedor_Existe
BEFORE INSERT OR UPDATE OF idProveedor ON Compra
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Proveedor
    WHERE id = :NEW.idProveedor;

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20090,
            'El proveedor con id "' || :NEW.idProveedor || '" no existe en el sistema.');
    END IF;
END TRG_Compra_Proveedor_Existe;
/

-- DISP-31: Establecer el estado de la Compra en 'PENDIENTE' al registrar
-- CU-7 > A: "El estado se establece automáticamente en 'PENDIENTE' al momento del registro."
CREATE OR REPLACE TRIGGER TRG_Compra_Estado_Inicial
BEFORE INSERT ON Compra
FOR EACH ROW
BEGIN
    :NEW.estado := 'PENDIENTE';
END TRG_Compra_Estado_Inicial;
/

-- DISP-32: Solo se puede modificar una Compra si su estado es 'PENDIENTE'
-- CU-7 > M: "Se requiere que la compra esté en estado 'PENDIENTE' para poder modificarse."
CREATE OR REPLACE TRIGGER TRG_Compra_Modificar_Pendiente
BEFORE UPDATE OF total, idProveedor ON Compra
FOR EACH ROW
BEGIN
    IF :OLD.estado != 'PENDIENTE' THEN
        RAISE_APPLICATION_ERROR(-20091,
            'No se puede modificar la compra "' || :OLD.id ||
            '" porque su estado es "' || :OLD.estado || '" (solo se permiten modificaciones en estado Pendiente).');
    END IF;
END TRG_Compra_Modificar_Pendiente;
/

-- DISP-33: Al eliminar Compra, verificar que no se hayan generado Ejemplares a partir de ella
-- CU-7 > E: "Se requiere que no se hayan generado Ejemplares físicos a partir de esta compra."
-- Lógica: se verifica que ningún Libro referenciado en Producto_Compra de esta compra
--   tenga Ediciones con Ejemplares registrados, como trazabilidad indirecta de stock generado.
CREATE OR REPLACE TRIGGER TRG_Compra_Baja_Sin_Ejemplares
BEFORE DELETE ON Compra
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Ejemplar EJ
    JOIN Edicion  ED ON ED.id      = EJ.idEdicion
    JOIN Producto_Compra PC ON PC.idLibro = ED.idLibro
    WHERE PC.idCompra = :OLD.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20092,
            'No se puede eliminar la compra "' || :OLD.id ||
            '" porque se han generado ' || count || ' ejemplar(es) físico(s) a partir de sus productos.');
    END IF;
END TRG_Compra_Baja_Sin_Ejemplares;
/

-- ==========================================================================================
-- CU-8 (Mantener Proveedor): COMO Administrador, QUIERO gestionar la base de datos de
-- proveedores, PARA PODER formalizar los procesos de adquisición y compra.
-- ==========================================================================================

-- DISP-34: Generar automáticamente el id de Proveedor con formato PRV + secuencial de 3 dígitos
-- CU-8 > A: "El id se genera automáticamente con el formato PRV + secuencial de
--   3 dígitos (PRV001, PRV002, ...)"
CREATE OR REPLACE TRIGGER TRG_Proveedor_Generar_Id
BEFORE INSERT ON Proveedor
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID
    FROM Proveedor;

    :NEW.id := 'PRV' || LPAD(lastID + 1, 3, '0');
END TRG_Proveedor_Generar_Id;
/

-- DISP-35: Solo un Administrador puede registrar Proveedores
-- CU-8 > A: "Solo un Administrador puede registrar proveedores"
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Proveedor
BEFORE INSERT ON Proveedor
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Administrador A
    JOIN Usuario U ON U.id = A.idUsuario
    WHERE U.rol = 'Administrador';

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Proveedores.');
    END IF;
END TRG_Solo_Admin_Proveedor;
/

-- DISP-36: Verificar que el correo del Proveedor no esté duplicado
-- CU-8 > A/M: "Se requiere que el correo no esté duplicado en el sistema."
-- Nota: la constraint UNIQUE sobre Proveedor.correo ya garantiza integridad;
--   este trigger provee mensaje descriptivo en español.
CREATE OR REPLACE TRIGGER TRG_Proveedor_Correo_Unico
BEFORE INSERT OR UPDATE OF correo ON Proveedor
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Proveedor
    WHERE UPPER(correo) = UPPER(:NEW.correo)
    AND   id           != :NEW.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20100,
            'Ya existe un proveedor con el correo "' || :NEW.correo || '" en el sistema.');
    END IF;
END TRG_Proveedor_Correo_Unico;
/

-- DISP-37: Al eliminar Proveedor, verificar que no tenga Compras asociadas
-- CU-8 > E: "Se requiere que el proveedor no tenga registros de Compra (0..*) asociados."
-- Nota: la FK Compra.idProveedor → Proveedor(id) ya bloquea el DELETE con ORA-02292;
--   este trigger provee mensaje descriptivo en español.
CREATE OR REPLACE TRIGGER TRG_Proveedor_Baja_Sin_Compras
BEFORE DELETE ON Proveedor
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Compra
    WHERE idProveedor = :OLD.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20101,
            'No se puede eliminar el proveedor "' || :OLD.nombre || ' ' || :OLD.apellidos ||
            '" (' || :OLD.empresa || ') porque tiene ' || count || ' compra(s) registrada(s).');
    END IF;
END TRG_Proveedor_Baja_Sin_Compras;
/

---------------------------------------------------------------------------------------------
--- PRUEBAS: TuplasOK -> Ingreso correcto respecto a restricciones de tupla
---------------------------------------------------------------------------------------------

-- TUP1-OK: Compra completada con total > 0
INSERT INTO Compra VALUES ('CMP010', TO_DATE('2024-09-01','YYYY-MM-DD'), 200000.00, 'COMPLETADO', 'PRV001');

-- TUP1-OK: Compra pendiente con total = 0 (aún sin productos)
INSERT INTO Compra VALUES ('CMP011', TO_DATE('2024-09-05','YYYY-MM-DD'), 0.00, 'PENDIENTE',  'PRV002');

-- TUP1-OK: Compra rechazada con total = 0 (no se procesó)
INSERT INTO Compra VALUES ('CMP012', TO_DATE('2024-09-08','YYYY-MM-DD'), 0.00, 'RECHAZADO', 'PRV001');

-- TUP2-OK: Producto_Compra con cantidad y precio válidos
INSERT INTO Producto_Compra VALUES ('PC010', 3, 45000.00, 'CMP010', 'LIB001');

-- TUP3-OK: Ejemplar Nuevo con disponibilidad = TRUE (nuevo y disponible — correcto)
INSERT INTO Ejemplar VALUES ('EJE010', 'Nuevo',      1, 'Estante D cuatro', TO_DATE('2024-01-01','YYYY-MM-DD'), 'EDI001');

-- TUP3-OK: Ejemplar Desgastado con disponibilidad = FALSE (no disponible — correcto)
INSERT INTO Ejemplar VALUES ('EJE011', 'Desgastado', 0, 'Bodega sur',       TO_DATE('2022-03-10','YYYY-MM-DD'), 'EDI002');

-- TUP5-OK: Autor con nombre, apellidos y nacionalidad completos
INSERT INTO Autor VALUES ('AUT010', 'Juan', 'Rulfo Vizcaino', 'Masculino', 'Mexicana');

-- TUP6-OK: Libro con titulo e idioma presentes
INSERT INTO Libro VALUES ('LIB010', 'Pedro Paramo', TO_DATE('1955-03-19','YYYY-MM-DD'), 'Espanol', 'Novela del realismo magico mexicano', 'CAT001');

---------------------------------------------------------------------------------------------
--- PRUEBAS: TuplasNoOK -> Intentos incorrectos respecto a restricciones de tupla
---------------------------------------------------------------------------------------------

-- TUP1-NOK: Compra completada con total negativo  ✗
INSERT INTO Compra VALUES ('CERR1', TO_DATE('2024-09-10','YYYY-MM-DD'), -500.00, 'COMPLETADO', 'PRV001');

-- TUP1-NOK: Compra pendiente con total negativo  ✗
INSERT INTO Compra VALUES ('CERR2', TO_DATE('2024-09-10','YYYY-MM-DD'), -1.00, 'PENDIENTE', 'PRV001');

-- TUP2-NOK: Producto_Compra con cantidad = 0  ✗
INSERT INTO Producto_Compra VALUES ('PCER1', 0, 30000.00, 'CMP001', 'LIB001');

-- TUP2-NOK: Producto_Compra con precioUnidad negativo  ✗
INSERT INTO Producto_Compra VALUES ('PCER2', 2, -1000.00, 'CMP001', 'LIB001');

-- TUP3-NOK: Ejemplar Nuevo con disponibilidad = FALSE  ✗
INSERT INTO Ejemplar VALUES ('EERR1', 'Nuevo', 0, 'Estante X', TO_DATE('2024-01-01','YYYY-MM-DD'), 'EDI001');

-- TUP5-NOK: Autor con nacionalidad NULL  ✗
INSERT INTO Autor VALUES ('AERR1', 'Sin', 'Pais', 'Masculino', NULL);

-- TUP6-NOK: Libro sin idioma  ✗
INSERT INTO Libro VALUES ('LERR1', 'Sin Idioma', TO_DATE('2020-01-01','YYYY-MM-DD'), NULL, 'Sin idioma registrado', 'CAT001');

---------------------------------------------------------------------------------------------
--- PRUEBAS: AccionesOK -> Verificación de las acciones de referencia
---------------------------------------------------------------------------------------------

-- SET NULL: Al eliminar una Categoria, los Libros quedan con idCategoria = NULL
DELETE FROM Categoria WHERE id = 'CAT002';
-- Verificar: SELECT id, titulo, idCategoria FROM Libro WHERE idCategoria IS NULL;

-- CASCADE Edicion→Ejemplar: Al eliminar una Edicion, sus Ejemplares desaparecen
DELETE FROM Edicion WHERE id = 'EDI003';
-- Verificar: SELECT * FROM Ejemplar WHERE idEdicion = 'EDI003'; → Sin resultado

-- CASCADE Libro→Edicion: Al eliminar un Libro, sus Ediciones (y en cascada Ejemplares) desaparecen
DELETE FROM Libro WHERE id = 'LIB002';
-- Verificar: SELECT * FROM Edicion WHERE idLibro = 'LIB002';    → Sin resultado
-- Verificar: SELECT * FROM Ejemplar WHERE idEdicion = 'EDI002'; → Sin resultado

-- SET NULL: Al eliminar un Proveedor, las Compras quedan con idProveedor = NULL
DELETE FROM Proveedor WHERE id = 'PRV003';
-- Verificar: SELECT id, idProveedor FROM Compra WHERE id = 'CMP003'; → idProveedor = NULL

-- CASCADE Compra→Producto_Compra: Al eliminar una Compra, sus productos desaparecen
DELETE FROM Compra WHERE id = 'CMP001';
-- Verificar: SELECT * FROM Producto_Compra WHERE idCompra = 'CMP001'; → Sin resultado

-- CASCADE Usuario→Administrador: Al eliminar el Usuario, se elimina el Administrador
DELETE FROM Usuario WHERE id = 'USR001';
-- Verificar: SELECT * FROM Administrador WHERE idUsuario = 'USR001'; → Sin resultado

---------------------------------------------------------------------------------------------
--- PRUEBAS: DisparadoresOK -> Datos ingresados usando la automatización de disparadores
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
--- PRUEBAS: DisparadoresNoOK -> Intentos bloqueados por disparadores
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
--- ELIMINAR TODO: Bloque dinámico para limpiar todo el esquema
---------------------------------------------------------------------------------------------
BEGIN
    FOR cur_rec IN (SELECT object_name, object_type
        FROM   all_objects
        WHERE  object_type IN ('TABLE', 'VIEW', 'PACKAGE', 'PROCEDURE', 'FUNCTION', 'SEQUENCE')
        AND    owner = '<schema_name>')
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

---------------------------------------------------------------------------------------------
--- PERSISTENCIA: XTABLAS -> Eliminación de tablas (con CASCADE)
---------------------------------------------------------------------------------------------
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
