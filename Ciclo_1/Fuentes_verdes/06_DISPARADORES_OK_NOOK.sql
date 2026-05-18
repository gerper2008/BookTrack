---------------------------------------------------------------------------------------------
-- DISPARADORES OK
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-- DISP-01 OK
-- Generación automática de idCategoria
---------------------------------------------------------------------------------------------

INSERT INTO Categoria(nombre, descripcion)
VALUES (
    'Astronomia',
    'Libros sobre el espacio'
);

-- Verificar:
-- SELECT * FROM Categoria ORDER BY id DESC;
-- Resultado esperado: id autogenerado tipo CAT###

---------------------------------------------------------------------------------------------
-- DISP-02 OK
-- Generación automática de idLibro
---------------------------------------------------------------------------------------------

INSERT INTO Libro(
    titulo,
    fecha_publicacion,
    idioma,
    descripcion,
    idCategoria
)
VALUES (
    'Dune',
    TO_DATE('1965-01-01','YYYY-MM-DD'),
    'Espanol',
    'Novela de ciencia ficción',
    'CAT001'
);

COMMIT;

-- Resultado esperado:
-- id generado automáticamente tipo LIB###

---------------------------------------------------------------------------------------------
-- DISP-03 OK
-- Modificar título de libro SIN ediciones
---------------------------------------------------------------------------------------------

-- Crear libro temporal sin ediciones
INSERT INTO Libro(
    titulo,
    fecha_publicacion,
    idioma,
    descripcion,
    idCategoria
)
VALUES (
    'Libro Editable',
    TO_DATE('2020-01-01','YYYY-MM-DD'),
    'Espanol',
    'Temporal',
    'CAT001'
);

COMMIT;

-- Modificación permitida
UPDATE Libro
SET titulo = 'Libro Editado Correctamente'
WHERE titulo = 'Libro Editable';

COMMIT;

---------------------------------------------------------------------------------------------
-- DISP-04 OK
-- Generación automática de idAutor
---------------------------------------------------------------------------------------------

INSERT INTO Autor(
    nombre,
    apellidos,
    genero,
    nacionalidad
)
VALUES (
    'Mario',
    'Vargas Llosa',
    'Masculino',
    'Peruana'
);

COMMIT;

---------------------------------------------------------------------------------------------
-- DISP-05 OK
-- Generación automática de idEdicion
---------------------------------------------------------------------------------------------

INSERT INTO Edicion(
    anio,
    paginas,
    idLibro,
    idEditorial
)
VALUES (
    TO_DATE('2022-01-01','YYYY-MM-DD'),
    450,
    'LIB001',
    'EDT001'
);

COMMIT;

---------------------------------------------------------------------------------------------
-- DISP-06 OK
-- Modificar edición SIN ejemplares asociados
---------------------------------------------------------------------------------------------

-- Crear libro temporal
INSERT INTO Libro(
    titulo,
    fecha_publicacion,
    idioma,
    descripcion,
    idCategoria
)
VALUES (
    'Libro Temporal Edicion',
    TO_DATE('2020-01-01','YYYY-MM-DD'),
    'Espanol',
    'Temporal',
    'CAT001'
);

-- Crear edición temporal
INSERT INTO Edicion(
    anio,
    paginas,
    idLibro,
    idEditorial
)
VALUES (
    TO_DATE('2024-01-01','YYYY-MM-DD'),
    200,
    'LIB002',
    'EDT001'
);

COMMIT;

-- Modificación válida
UPDATE Edicion
SET idEditorial = 'EDT002'
WHERE paginas = 200;

COMMIT;

---------------------------------------------------------------------------------------------
-- DISP-07 OK
-- Eliminar edición SIN ejemplares
---------------------------------------------------------------------------------------------

-- Crear edición temporal
INSERT INTO Edicion(
    anio,
    paginas,
    idLibro,
    idEditorial
)
VALUES (
    TO_DATE('2023-01-01','YYYY-MM-DD'),
    150,
    'LIB001',
    'EDT001'
);

-- Verificar cantidad de ejemplares de esa edición
SELECT 
    E.id AS id_edicion,
    COUNT(EJ.id) AS cantidad_ejemplares
FROM Edicion E
LEFT JOIN Ejemplar EJ
    ON EJ.idEdicion = E.id
WHERE E.paginas = 150
GROUP BY E.id;

-- Eliminación válida
DELETE FROM Edicion
WHERE paginas = 150;

COMMIT;

---------------------------------------------------------------------------------------------
-- DISP-08 OK
-- Generación automática de idEditorial
---------------------------------------------------------------------------------------------

INSERT INTO Editorial(
    nombre,
    correo,
    telefono,
    pais
)
VALUES (
    'Editorial Temporal',
    'editorialtemp@test.com',
    '3114445555',
    'Colombia'
);

COMMIT;

-- Consultar
SELECT * FROM Editorial WHERE nombre = 'Editorial Temporal';

---------------------------------------------------------------------------------------------
-- DISP-09 OK
-- Eliminar editorial SIN ediciones asociadas
---------------------------------------------------------------------------------------------

-- Crear editorial temporal
INSERT INTO Editorial(
    nombre,
    correo,
    telefono,
    pais
)
VALUES (
    'Editorial Eliminable',
    'elim@test.com',
    '3008881111',
    'Chile'
);

COMMIT;

-- Verificar cantidad de ediciones de esa editorial
SELECT 
    E.id AS id_editorial,
    E.nombre,
    COUNT(ED.id) AS cantidad_ediciones
FROM Editorial E
LEFT JOIN Edicion ED
    ON ED.idEditorial = E.id
WHERE E.id = 'EDT001'
GROUP BY E.id, E.nombre;

DELETE FROM Editorial
WHERE correo = 'elim@test.com';

COMMIT;

---------------------------------------------------------------------------------------------
-- DISP-10 OK
-- Generación automática de idEjemplar
---------------------------------------------------------------------------------------------

INSERT INTO Ejemplar(
    idEdicion,
    estadoFisico,
    disponibilidad,
    localizacion,
    fechaAdquisicion
)
VALUES (
    'EDI001',
    'Bueno',
    0,
    'Bodega Norte',
    TO_DATE('2024-01-01','YYYY-MM-DD')
);

COMMIT;

---------------------------------------------------------------------------------------------
-- DISP-11 OK
-- Eliminar ejemplar NO disponible
---------------------------------------------------------------------------------------------

-- Crear ejemplar no disponible
INSERT INTO Ejemplar(
    idEdicion,
    estadoFisico,
    disponibilidad,
    localizacion,
    fechaAdquisicion
)
VALUES (
    'EDI001',
    'Regular',
    0,
    'Bodega',
    TO_DATE('2024-01-01','YYYY-MM-DD')
);

COMMIT;

DELETE FROM Ejemplar
WHERE localizacion = 'Bodega';

COMMIT;

---------------------------------------------------------------------------------------------
-- DISP-12 OK
-- Generación automática de idCompra
---------------------------------------------------------------------------------------------

INSERT INTO Compra(
    fecha,
    total,
    estado,
    idProveedor
)
VALUES (
    TO_DATE('2025-01-01','YYYY-MM-DD'),
    100000,
    'COMPLETADO',
    'PRV001'
);

COMMIT;

---------------------------------------------------------------------------------------------
-- DISP-13 OK
-- Estado inicial forzado a PENDIENTE
---------------------------------------------------------------------------------------------

INSERT INTO Compra(
    fecha,
    total,
    estado,
    idProveedor
)
VALUES (
    TO_DATE('2025-02-01','YYYY-MM-DD'),
    200000,
    'COMPLETADO',
    'PRV001'
);

COMMIT;

-- Verificar:
-- SELECT estado FROM Compra ORDER BY id DESC;
-- Resultado esperado: PENDIENTE

---------------------------------------------------------------------------------------------
-- DISP-14 OK
-- Modificar compra en estado PENDIENTE
---------------------------------------------------------------------------------------------

INSERT INTO Compra(
    fecha,
    total,
    estado,
    idProveedor
)
VALUES (
    TO_DATE('2025-03-01','YYYY-MM-DD'),
    50000,
    'PENDIENTE',
    'PRV001'
);

COMMIT;

UPDATE Compra
SET total = 70000
WHERE total = 50000;

COMMIT;

---------------------------------------------------------------------------------------------
-- DISP-15 OK
-- Eliminar compra en estado PENDIENTE
---------------------------------------------------------------------------------------------

INSERT INTO Compra(
    fecha,
    total,
    estado,
    idProveedor
)
VALUES (
    TO_DATE('2025-04-01','YYYY-MM-DD'),
    30000,
    'PENDIENTE',
    'PRV001'
);

COMMIT;

DELETE FROM Compra
WHERE total = 30000;

COMMIT;

---------------------------------------------------------------------------------------------
-- DISP-16 OK
-- Generación automática de idProveedor
---------------------------------------------------------------------------------------------

INSERT INTO Proveedor(
    nombre,
    apellidos,
    correo,
    empresa,
    telefono
)
VALUES (
    'Carlos',
    'Ramirez',
    'proveedor@test.com',
    'Distribuidora Norte',
    '3001112222'
);

COMMIT;

---------------------------------------------------------------------------------------------
-- DISP-17 OK
-- Eliminar proveedor SIN compras
---------------------------------------------------------------------------------------------

INSERT INTO Proveedor(
    nombre,
    apellidos,
    correo,
    empresa,
    telefono
)
VALUES (
    'Proveedor',
    'Temporal',
    'tempproveedor@test.com',
    'Empresa Temporal',
    '3119998888'
);

COMMIT;

DELETE FROM Proveedor
WHERE correo = 'tempproveedor@test.com';

COMMIT;

---------------------------------------------------------------------------------------------
-- DISPARADORES NO OK
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-- DISP-03 NO OK
-- No modificar título de libro con ediciones
---------------------------------------------------------------------------------------------

-- Error esperado:
-- ORA-20020
UPDATE Libro
SET titulo = 'Titulo Prohibido'
WHERE id = 'LIB001';

ROLLBACK;

---------------------------------------------------------------------------------------------
-- DISP-06 NO OK
-- No modificar libro/editorial de edición con ejemplares
---------------------------------------------------------------------------------------------

-- Error esperado:
-- ORA-20030
UPDATE Edicion
SET idEditorial = 'EDT002'
WHERE id = 'EDI001';

ROLLBACK;

---------------------------------------------------------------------------------------------
-- DISP-07 NO OK
-- No eliminar edición con ejemplares
---------------------------------------------------------------------------------------------

-- Error esperado:
-- ORA-20063
DELETE FROM Edicion
WHERE id = 'EDI001';

ROLLBACK;

---------------------------------------------------------------------------------------------
-- DISP-09 NO OK
-- No eliminar editorial con ediciones
---------------------------------------------------------------------------------------------

-- Error esperado:
-- ORA-20072
DELETE FROM Editorial
WHERE id = 'EDT001';

ROLLBACK;

---------------------------------------------------------------------------------------------
-- DISP-11 NO OK
-- No eliminar ejemplar disponible
---------------------------------------------------------------------------------------------

-- Error esperado:
-- ORA-20040
DELETE FROM Ejemplar
WHERE id = 'EJM001';

ROLLBACK;

---------------------------------------------------------------------------------------------
-- DISP-14 NO OK
-- No modificar compra NO pendiente
---------------------------------------------------------------------------------------------

-- Crear compra completada
INSERT INTO Compra(
    fecha,
    total,
    estado,
    idProveedor
)
VALUES (
    TO_DATE('2025-05-01','YYYY-MM-DD'),
    90000,
    'COMPLETADO',
    'PRV001'
);

COMMIT;

-- El trigger la deja en PENDIENTE,
-- así que primero se cambia manualmente
UPDATE Compra
SET estado = 'COMPLETADO'
WHERE total = 90000;

COMMIT;

-- Error esperado:
-- ORA-20060
UPDATE Compra
SET total = 120000
WHERE total = 90000;

ROLLBACK;

---------------------------------------------------------------------------------------------
-- DISP-15 NO OK
-- No eliminar compra NO pendiente
---------------------------------------------------------------------------------------------

-- Error esperado:
-- ORA-20061
DELETE FROM Compra
WHERE total = 90000;

ROLLBACK;

---------------------------------------------------------------------------------------------
-- DISP-17 NO OK
-- No eliminar proveedor con compras
---------------------------------------------------------------------------------------------

-- Error esperado:
-- ORA-20101
DELETE FROM Proveedor
WHERE id = 'PRV001';

ROLLBACK;