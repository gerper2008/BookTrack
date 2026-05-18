---------------------------------------------------------------------------------------------
-- ACCIONES OK
-- Pruebas correctas de acciones referenciales
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-- ACCION 1 OK
-- Libro.idCategoria → Categoria(id) ON DELETE SET NULL
---------------------------------------------------------------------------------------------

-- Crear categoria temporal
INSERT INTO Categoria
VALUES ('CAT800', 'Temporal', 'Categoria temporal');

-- Crear libro asociado
INSERT INTO Libro
VALUES (
    'LIB800',
    'Libro SET NULL',
    TO_DATE('2020-01-01','YYYY-MM-DD'),
    'Espanol',
    'Prueba SET NULL',
    'CAT800'
);

COMMIT;

-- Eliminar categoria
DELETE FROM Categoria
WHERE id = 'CAT800';

COMMIT;

-- Verificar:
-- SELECT idCategoria FROM Libro WHERE id = 'LIB800';
-- Resultado esperado: NULL

---------------------------------------------------------------------------------------------
-- ACCION 2 OK
-- Edicion.idLibro → Libro(id) ON DELETE CASCADE
---------------------------------------------------------------------------------------------

-- Crear libro temporal
INSERT INTO Libro
VALUES (
    'LIB801',
    'Libro CASCADE',
    TO_DATE('2021-01-01','YYYY-MM-DD'),
    'Espanol',
    'Prueba CASCADE',
    NULL
);

-- Crear edicion asociada
INSERT INTO Edicion
VALUES (
    'EDI801',
    TO_DATE('2022-01-01','YYYY-MM-DD'),
    200,
    'LIB801',
    'EDT001'
);

COMMIT;

-- Eliminar libro
DELETE FROM Libro
WHERE id = 'LIB801';

COMMIT;

-- Verificar:
-- SELECT * FROM Edicion WHERE id = 'EDI801';
-- Resultado esperado: no retorna filas

---------------------------------------------------------------------------------------------
-- ACCION 3 OK
-- Edicion.idEditorial → Editorial(id) ON DELETE SET NULL
---------------------------------------------------------------------------------------------

-- Crear editorial temporal
INSERT INTO Editorial
VALUES (
    'EDT800',
    'Editorial Temporal',
    'temp800@editorial.com',
    '3008881111',
    'Colombia'
);

-- Crear libro temporal
INSERT INTO Libro
VALUES (
    'LIB802',
    'Libro Editorial',
    TO_DATE('2020-01-01','YYYY-MM-DD'),
    'Espanol',
    'Prueba editorial',
    NULL
);

-- Crear edición asociada
INSERT INTO Edicion
VALUES (
    'EDI802',
    TO_DATE('2023-01-01','YYYY-MM-DD'),
    350,
    'LIB802',
    'EDT800'
);

COMMIT;

-- Eliminar editorial
DELETE FROM Editorial
WHERE id = 'EDT800';

COMMIT;

-- Verificar:
-- SELECT idEditorial FROM Edicion WHERE id = 'EDI802';
-- Resultado esperado: NULL

---------------------------------------------------------------------------------------------
-- ACCION 4 OK
-- Ejemplar.idEdicion → Edicion(id) ON DELETE CASCADE
---------------------------------------------------------------------------------------------

-- Crear libro temporal
INSERT INTO Libro
VALUES (
    'LIB803',
    'Libro Ejemplar',
    TO_DATE('2020-01-01','YYYY-MM-DD'),
    'Espanol',
    'Prueba ejemplares',
    NULL
);

-- Crear edición
INSERT INTO Edicion
VALUES (
    'EDI803',
    TO_DATE('2022-01-01','YYYY-MM-DD'),
    150,
    'LIB803',
    'EDT001'
);

-- Crear ejemplar
INSERT INTO Ejemplar
VALUES (
    'EJM803',
    'EDI803',
    'Bueno',
    1,
    'Estante Z',
    TO_DATE('2024-01-01','YYYY-MM-DD')
);

COMMIT;

-- Eliminar edición
DELETE FROM Edicion
WHERE id = 'EDI803';

COMMIT;

-- Verificar:
-- SELECT * FROM Ejemplar WHERE id = 'EJM803';
-- Resultado esperado: no retorna filas

---------------------------------------------------------------------------------------------
-- ACCION 5 OK
-- Libro_Autor.idAutor → Autor(id) ON DELETE CASCADE
---------------------------------------------------------------------------------------------

-- Crear autor temporal
INSERT INTO Autor
VALUES (
    'AUT800',
    'Autor',
    'Temporal',
    'Masculino',
    'Colombiana'
);

-- Crear libro temporal
INSERT INTO Libro
VALUES (
    'LIB804',
    'Libro Autor',
    TO_DATE('2020-01-01','YYYY-MM-DD'),
    'Espanol',
    'Prueba autor',
    NULL
);

-- Relación libro-autor
INSERT INTO Libro_Autor
VALUES (
    'LIB804',
    'AUT800'
);

COMMIT;

-- Eliminar autor
DELETE FROM Autor
WHERE id = 'AUT800';

COMMIT;

-- Verificar:
-- SELECT * FROM Libro_Autor WHERE idLibro='LIB804';
-- Resultado esperado: no retorna filas

---------------------------------------------------------------------------------------------
-- ACCION 6 OK
-- Libro_Autor.idLibro → Libro(id) ON DELETE CASCADE
---------------------------------------------------------------------------------------------

-- Crear autor temporal
INSERT INTO Autor
VALUES (
    'AUT801',
    'Autor',
    'LibroCascade',
    'Masculino',
    'Argentina'
);

-- Crear libro temporal
INSERT INTO Libro
VALUES (
    'LIB805',
    'Libro Relacion',
    TO_DATE('2020-01-01','YYYY-MM-DD'),
    'Espanol',
    'Prueba libro autor',
    NULL
);

-- Relación
INSERT INTO Libro_Autor
VALUES (
    'LIB805',
    'AUT801'
);

COMMIT;

-- Eliminar libro
DELETE FROM Libro
WHERE id = 'LIB805';

COMMIT;

-- Verificar:
-- SELECT * FROM Libro_Autor WHERE idAutor='AUT801';
-- Resultado esperado: no retorna filas

---------------------------------------------------------------------------------------------
-- ACCION 7 OK
-- Compra.idProveedor → Proveedor(id) ON DELETE SET NULL
---------------------------------------------------------------------------------------------

-- Crear proveedor temporal
INSERT INTO Proveedor
VALUES (
    'PRV800',
    'Proveedor',
    'Temporal',
    'proveedor800@test.com',
    'Distribuidora Temporal',
    '3118889999'
);

-- Crear compra asociada
INSERT INTO Compra
VALUES (
    'COM800',
    TO_DATE('2024-01-01','YYYY-MM-DD'),
    100000,
    'PENDIENTE',
    'PRV800'
);

COMMIT;

-- Eliminar proveedor
DELETE FROM Proveedor
WHERE id = 'PRV800';

COMMIT;

-- Verificar:
-- SELECT idProveedor FROM Compra WHERE id='COM800';
-- Resultado esperado: NULL

---------------------------------------------------------------------------------------------
-- ACCION 8 OK
-- Producto_Compra.idCompra → Compra(id) ON DELETE CASCADE
---------------------------------------------------------------------------------------------

-- Crear compra temporal
INSERT INTO Compra
VALUES (
    'COM801',
    TO_DATE('2024-01-01','YYYY-MM-DD'),
    80000,
    'PENDIENTE',
    NULL
);

-- Crear producto_compra
INSERT INTO Producto_Compra
VALUES (
    'PC801',
    2,
    40000,
    'COM801',
    'LIB001'
);

COMMIT;

-- Eliminar compra
DELETE FROM Compra
WHERE id = 'COM801';

COMMIT;

-- Verificar:
-- SELECT * FROM Producto_Compra WHERE id='PC801';
-- Resultado esperado: no retorna filas

---------------------------------------------------------------------------------------------
-- ACCION 9 OK
-- Producto_Compra.idLibro → Libro(id) ON DELETE SET NULL
---------------------------------------------------------------------------------------------

-- Crear libro temporal
INSERT INTO Libro
VALUES (
    'LIB806',
    'Libro Producto',
    TO_DATE('2020-01-01','YYYY-MM-DD'),
    'Espanol',
    'Prueba producto compra',
    NULL
);

-- Crear compra temporal
INSERT INTO Compra
VALUES (
    'COM802',
    TO_DATE('2024-01-01','YYYY-MM-DD'),
    90000,
    'PENDIENTE',
    NULL
);

-- Crear producto_compra
INSERT INTO Producto_Compra
VALUES (
    'PC802',
    1,
    90000,
    'COM802',
    'LIB806'
);

COMMIT;

-- Eliminar libro
DELETE FROM Libro
WHERE id = 'LIB806';

COMMIT;

-- Verificar:
-- SELECT idLibro FROM Producto_Compra WHERE id='PC802';
-- Resultado esperado: NULL

---------------------------------------------------------------------------------------------
-- ACCION 10 OK
-- Administrador.idUsuario → Usuario(id) ON DELETE CASCADE
---------------------------------------------------------------------------------------------

-- Crear usuario
INSERT INTO Usuario
VALUES (
    'USR800',
    'admin800@test.com',
    'Administrador',
    'Admin',
    'Temporal',
    '3001238000'
);

-- Crear administrador
INSERT INTO Administrador
VALUES (
    'USR800',
    'Completo',
    'Sede Norte'
);

COMMIT;

-- Eliminar usuario
DELETE FROM Usuario
WHERE id = 'USR800';

COMMIT;

-- Verificar:
-- SELECT * FROM Administrador WHERE idUsuario='USR800';
-- Resultado esperado: no retorna filas