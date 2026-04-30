---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
--- CICLO 1 ---------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
 
---------------------------------------------------------------------------------------------
--- PERSISTENCIA: TABLAS -> Creación de tablas ----------------------------------------------
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
    disponibilidad BOOLEAN,
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
    estado VARCHAR2(10),   -- PENDIENTE, COMPLETADO, RECHAZADO
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
--- PERSISTENCIA: ATRIBUTOS -> Definición de restricciones para un único atributo -----------
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
--- PRUEBAS: PoblarOK -> Ingreso de datos correctos -----------------------------------------
---------------------------------------------------------------------------------------------
-- Categoria
INSERT INTO Categoria VALUES ('CAT001', 'Ficcion', 'Novelas y cuentos de ficcion literaria');
INSERT INTO Categoria VALUES ('CAT002', 'Historia', 'Libros sobre historia universal y colombiana');
INSERT INTO Categoria VALUES ('CAT003', 'Tecnologia', 'Libros de informatica y programacion');
 
-- Editorial
INSERT INTO Editorial VALUES ('ED001', 'contacto@planeta.com', '3001234567', 'Planeta', 'Colombia');
INSERT INTO Editorial VALUES ('ED002', 'info@norma.com', '3107654321', 'Norma', 'Colombia');
INSERT INTO Editorial VALUES ('ED003', 'hola@penguin.com', '3209876543', 'Penguin', 'Argentina');
 
-- Autor  (genero con cadena completa)
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
-- estado_fisico con cadena completa
INSERT INTO Ejemplar VALUES ('EJE001', 'Nuevo',   1, 'Estante A uno',  TO_DATE('2021-01-10','YYYY-MM-DD'), 'EDI001');
INSERT INTO Ejemplar VALUES ('EJE002', 'Bueno',   1, 'Estante B tres', TO_DATE('2020-05-22','YYYY-MM-DD'), 'EDI002');
INSERT INTO Ejemplar VALUES ('EJE003', 'Dañado',  0, 'Bodega central', TO_DATE('2019-08-15','YYYY-MM-DD'), 'EDI003');
 
-- Proveedor
INSERT INTO Proveedor VALUES ('PRV001', 'ventas@distribuidora.com', 'Carlos', 'Ramirez Torres',  'Distribuidora Nacional',  '3151112233');
INSERT INTO Proveedor VALUES ('PRV002', 'pedidos@libros.com',       'Maria',  'Lopez Ruiz',       'Libros y Mas',            '3004445566');
INSERT INTO Proveedor VALUES ('PRV003', 'contacto@editorial.com',   'Pedro',  'Suarez Gil',       'Editorial Sudamericana',  '3006667788');
 
-- Usuario  (rol con cadena completa)
INSERT INTO Usuario VALUES ('USR001', 'admin@biblioteca.com',  'Administrador', 'Ana',   'Martinez Gil',  '3001234567');
INSERT INTO Usuario VALUES ('USR002', 'biblio@biblioteca.com', 'Bibliotecario', 'Luis',  'Torres Pena',   '3109876543');
INSERT INTO Usuario VALUES ('USR003', 'lector@gmail.com',      'Lector',        'Sofia', 'Herrera Diaz',  '3207778899');
 
-- Administrador  (permisos con cadena completa)
INSERT INTO Administrador VALUES ('USR001', 'Total', 'Sede Central Bogota');
 
-- Compra  (estado con cadena completa)
INSERT INTO Compra VALUES ('CMP001', TO_DATE('2024-01-15','YYYY-MM-DD'), 350000.00, 'COMPLETADO', 'PRV001');
INSERT INTO Compra VALUES ('CMP002', TO_DATE('2024-03-10','YYYY-MM-DD'), 180000.00, 'COMPLETADO', 'PRV002');
INSERT INTO Compra VALUES ('CMP003', TO_DATE('2024-06-20','YYYY-MM-DD'),  95000.00, 'PENDIENTE',  'PRV003');
 
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
INSERT INTO Autor VALUES ('AUT001', 'Clon', 'Apellido', 'Masculino', 'Colombiana');
 
-- PK duplicada en Libro
INSERT INTO Libro VALUES ('LIB001', 'Titulo clon', TO_DATE('2000-01-01','YYYY-MM-DD'), 'Espanol', 'Viola PRIMARY KEY de Libro', 'CAT001');
 
-- PK compuesta duplicada en Libro_Autor
INSERT INTO Libro_Autor VALUES ('LIB001', 'AUT001');
 
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
 
-- Libro_Autor con id_libro que no existe
INSERT INTO Libro_Autor VALUES ('LIB999', 'AUT001');
 
-- Libro_Autor con id_autor que no existe
INSERT INTO Libro_Autor VALUES ('LIB001', 'AUT999');
 
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
 
 
SELECT constraint_name, table_name, r_constraint_name
FROM user_constraints
WHERE constraint_type = 'R'
ORDER BY table_name;
 
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