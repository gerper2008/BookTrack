---------------------------------------------------------------------------------------------
-- DISPARADORES OK / NO OK (SIN COLISIONES)
-- Casos estables con IDs aislados prefijo ZV
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-- PRECONDICIONES BASE
---------------------------------------------------------------------------------------------
INSERT INTO Categoria (id, nombre, descripcion)
VALUES ('CATZV60', 'Categoria ZV Disparadores', 'Base para pruebas de disparadores');

INSERT INTO Editorial (id, correo, telefono, nombre, pais)
VALUES ('EDTZV60', 'editorial.zv60@test.com', '3206000060', 'Editorial ZV 60', 'Colombia');

INSERT INTO Editorial (id, correo, telefono, nombre, pais)
VALUES ('EDTZV61', 'editorial.zv61@test.com', '3206000061', 'Editorial ZV 61', 'Colombia');

INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono)
VALUES ('PRVZV60', 'proveedor.zv60@test.com', 'Pablo', 'Zurita', 'Proveedor ZV 60', '3216000060');

COMMIT;

---------------------------------------------------------------------------------------------
-- DISPARADORES OK
---------------------------------------------------------------------------------------------

-- DISP-01 OK: Generación automática de idCategoria
INSERT INTO Categoria (nombre, descripcion)
VALUES ('Categoria Auto ZV', 'Prueba autogeneracion de categoria');

-- Verificar
--SELECT * FROM CATEGORIA WHERE nombre='Categoria Auto ZV';

-- DISP-02 OK: Generación automática de idLibro
INSERT INTO Libro (titulo, fecha_publicacion, idioma, descripcion, idCategoria)
VALUES (
    'Libro Auto ZV',
    TO_DATE('2015-01-01','YYYY-MM-DD'),
    'Espanol',
    'Prueba autogeneracion de libro',
    'CAT052'
);

COMMIT;

-- Verificar
--SELECT * FROM LIBRO WHERE titulo='Libro Auto ZV';

-- DISP-03 OK: Modificar título de libro SIN ediciones
INSERT INTO Libro (titulo, fecha_publicacion, idioma, descripcion, idCategoria)
VALUES (
    'Libro Editable ZV',
    TO_DATE('2020-01-01','YYYY-MM-DD'),
    'Espanol',
    'Sin ediciones asociadas',
    'CATZV60'
);

-- Verificar
SELECT * FROM LIBRO WHERE titulo='Libro Editable ZV';

UPDATE Libro
SET titulo = 'Libro Editado ZV'
WHERE descripcion = 'Sin ediciones asociadas';

-- Verificar
SELECT * FROM LIBRO WHERE titulo='Libro Editado ZV';

COMMIT;

-- DISP-04 OK: Generación automática de idAutor
INSERT INTO Autor (nombre, apellidos, genero, nacionalidad)
VALUES ('Autor', 'AutoZV', 'Masculino', 'Colombiana');

COMMIT;

-- Verificar
SELECT * FROM Autor WHERE nombre='Autor';

-- DISP-05 OK: Generación automática de idEdicion
INSERT INTO Libro (titulo, fecha_publicacion, idioma, descripcion, idCategoria)
VALUES (
    'Libro para Edicion Auto',
    TO_DATE('2018-01-01','YYYY-MM-DD'),
    'Espanol',
    'Base para edicion auto',
    'CAT052'
);

INSERT INTO Edicion (anio, paginas, idLibro, idEditorial)
VALUES (
    TO_DATE('2022-01-01','YYYY-MM-DD'),
    300,
    'LIB001',
    'EDT001'
);

COMMIT;

-- DISP-06 OK: Modificar edición SIN ejemplares asociados
INSERT INTO Edicion (id, idLibro, idEditorial, anio, paginas)
VALUES (
    'EDIZV63',
    'LIBZV62',
    'EDTZV60',
    TO_DATE('2023-01-01','YYYY-MM-DD'),
    200
);

UPDATE Edicion
SET idEditorial = 'EDTZV61'
WHERE id = 'EDIZV63';

COMMIT;

-- DISP-07 OK: Eliminar edición SIN ejemplares
INSERT INTO Edicion (id, idLibro, idEditorial, anio, paginas)
VALUES (
    'EDIZV64',
    'LIBZV62',
    'EDTZV60',
    TO_DATE('2024-01-01','YYYY-MM-DD'),
    150
);

DELETE FROM Edicion
WHERE id = 'EDIZV64';

COMMIT;

-- DISP-08 OK: Generación automática de idEditorial
INSERT INTO Editorial (nombre, correo, telefono, pais)
VALUES (
    'Editorial Auto ZV',
    'editorial.auto.zv@test.com',
    '3206000099',
    'Colombia'
);

COMMIT;

-- DISP-09 OK: Eliminar editorial SIN ediciones asociadas
INSERT INTO Editorial (id, correo, telefono, nombre, pais)
VALUES (
    'EDTZV69',
    'editorial.zv69@test.com',
    '3206000069',
    'Editorial Eliminable ZV',
    'Chile'
);

-- Ver ultimo id de editorial
-- SELECT * FROM EDITORIAL ORDER BY ID desc;

DELETE FROM Editorial
WHERE id = 'EDT054';

COMMIT;

-- DISP-10 OK: Generación automática de idEjemplar
INSERT INTO Edicion (id, idLibro, idEditorial, anio, paginas)
VALUES (
    'EDIZV70',
    'LIBZV62',
    'EDTZV60',
    TO_DATE('2021-01-01','YYYY-MM-DD'),
    220
);

INSERT INTO Ejemplar (idEdicion, estadoFisico, disponibilidad, localizacion, fechaAdquisicion)
VALUES (
    'EDI001',
    'Bueno',
    0,
    'Bodega ZV 70',
    TO_DATE('2024-01-01','YYYY-MM-DD')
);

COMMIT;

-- DISP-11 OK: Eliminar ejemplar NO disponible
INSERT INTO Ejemplar (idEdicion, estadoFisico, disponibilidad, localizacion, fechaAdquisicion)
VALUES (
    'EDI001',
    'Bueno',
    0,
    'Bodega ZV 71',
    TO_DATE('2024-01-01','YYYY-MM-DD')
);

-- Ver ultimo id de ejemplar
-- SELECT * FROM Ejemplar ORDER BY ID desc;

DELETE FROM Ejemplar
WHERE id = 'EJM053';

COMMIT;

-- DISP-12 OK: Generación automática de idCompra
INSERT INTO Compra (fecha, total, estado, idProveedor)
VALUES (
    TO_DATE('2025-01-01','YYYY-MM-DD'),
    100000,
    'COMPLETADO',
    'PRV001'
);

COMMIT;

-- Ver ultimo id de compra generado
-- SELECT * FROM COMPRA ORDER BY ID desc;

-- Buscar compra
-- SELECT * FROM COMPRA WHERE id='COM051';

-- DISP-13 OK: Estado inicial forzado a PENDIENTE
INSERT INTO Compra (id, fecha, total, estado, idProveedor)
VALUES (
    'COMZV73',
    TO_DATE('2025-02-01','YYYY-MM-DD'),
    200000,
    'COMPLETADO',
    'PRVZV60'
);

-- Ver ultimo id de compra generado
SELECT * FROM COMPRA ORDER BY ID desc;

-- Verificar:
SELECT estado FROM Compra WHERE id = 'COM052';
-- Esperado: PENDIENTE

COMMIT;

-- DISP-14 OK: Modificar compra en estado PENDIENTE
INSERT INTO Compra (id, fecha, total, estado, idProveedor)
VALUES (
    'COMZV74',
    TO_DATE('2025-03-01','YYYY-MM-DD'),
    50000,
    'PENDIENTE',
    'PRVZV60'
);

UPDATE Compra
SET total = 70000
WHERE id = 'COMZV74';

COMMIT;

-- DISP-15 OK: Eliminar compra en estado PENDIENTE
INSERT INTO Compra (id, fecha, total, estado, idProveedor)
VALUES (
    'COMZV75',
    TO_DATE('2025-04-01','YYYY-MM-DD'),
    30000,
    'PENDIENTE',
    'PRVZV60'
);

DELETE FROM Compra
WHERE id = 'COMZV75';

COMMIT;

-- DISP-16 OK: Generación automática de idProveedor
INSERT INTO Proveedor (nombre, apellidos, correo, empresa, telefono)
VALUES (
    'Carlos',
    'Ramirez',
    'proveedor.auto.zv@test.com',
    'Distribuidora Auto ZV',
    '3216000099'
);

COMMIT;     

-- DISP-17 OK: Eliminar proveedor SIN compras
INSERT INTO Proveedor (id, nombre, apellidos, correo, empresa, telefono)
VALUES (
    'PRVZV77',
    'Proveedor',
    'TemporalZV',
    'tempproveedor.zv@test.com',
    'Empresa Temporal ZV',
    '3216000077'
);

DELETE FROM Proveedor
WHERE id = 'PRVZV77';

COMMIT;

---------------------------------------------------------------------------------------------
-- DISPARADORES NO OK
---------------------------------------------------------------------------------------------

-- DISP-03 NO OK: No modificar título de libro con ediciones
INSERT INTO Libro (titulo, fecha_publicacion, idioma, descripcion, idCategoria)
VALUES (
    'Libro con Edicion',
    TO_DATE('2020-01-01','YYYY-MM-DD'),
    'Espanol',
    'No debe dejar cambiar titulo',
    'CATZV60'
);

-- SELECT idLibro FROM EDICION;

INSERT INTO Edicion (id, idLibro, idEditorial, anio, paginas)
VALUES (
    'EDIZV80',
    'LIBZV80',
    'EDTZV60',
    TO_DATE('2021-01-01','YYYY-MM-DD'),
    180
);

-- Error esperado: ORA-20020
UPDATE Libro
SET titulo = 'Titulo Prohibido ZV'
WHERE id = 'LIBZV80';

ROLLBACK;

-- DISP-06 NO OK: No modificar libro/editorial de edición con ejemplares
INSERT INTO Edicion (id, idLibro, idEditorial, anio, paginas)
VALUES (
    'EDIZV81',
    'LIBZV62',
    'EDTZV60',
    TO_DATE('2021-01-01','YYYY-MM-DD'),
    190
);

INSERT INTO Ejemplar (id, idEdicion, estadoFisico, disponibilidad, localizacion, fechaAdquisicion)
VALUES (
    'EJMZV81',
    'EDIZV81',
    'Bueno',
    1,
    'Sala ZV 81',
    TO_DATE('2024-01-01','YYYY-MM-DD')
);

-- Error esperado: ORA-20030
UPDATE Edicion
SET idEditorial = 'EDTZV61'
WHERE id = 'EDIZV81';

ROLLBACK;

-- DISP-07 NO OK: No eliminar edición con ejemplares
-- Error esperado: ORA-20063
DELETE FROM Edicion
WHERE id = 'EDIZV81';

ROLLBACK;

-- DISP-09 NO OK: No eliminar editorial con ediciones
INSERT INTO Editorial (id, correo, telefono, nombre, pais)
VALUES (
    'EDTZV82',
    'editorial.zv82@test.com',
    '3206000082',
    'Editorial Bloqueada ZV',
    'Colombia'
);

INSERT INTO Edicion (id, idLibro, idEditorial, anio, paginas)
VALUES (
    'EDIZV82',
    'LIBZV62',
    'EDTZV82',
    TO_DATE('2020-01-01','YYYY-MM-DD'),
    210
);

-- Error esperado: ORA-20072
DELETE FROM Editorial
WHERE id = 'EDTZV82';

ROLLBACK;

-- DISP-11 NO OK: No eliminar ejemplar disponible
INSERT INTO Ejemplar (id, idEdicion, estadoFisico, disponibilidad, localizacion, fechaAdquisicion)
VALUES (
    'EJMZV83',
    'EDIZV70',
    'Bueno',
    1,
    'Sala ZV 83',
    TO_DATE('2024-01-01','YYYY-MM-DD')
);

-- Error esperado: ORA-20040
DELETE FROM Ejemplar
WHERE id = 'EJMZV83';

ROLLBACK;

-- DISP-14 NO OK: No modificar compra NO pendiente
INSERT INTO Compra (id, fecha, total, estado, idProveedor)
VALUES (
    'COMZV84',
    TO_DATE('2025-05-01','YYYY-MM-DD'),
    90000,
    'COMPLETADO',
    'PRVZV60'
);

-- El trigger la deja en PENDIENTE; primero la pasamos a COMPLETADO
UPDATE Compra
SET estado = 'COMPLETADO'
WHERE id = 'COMZV84';

-- Error esperado: ORA-20060
UPDATE Compra
SET total = 120000
WHERE id = 'COMZV84';

ROLLBACK;

-- DISP-15 NO OK: No eliminar compra NO pendiente
-- Error esperado: ORA-20061
DELETE FROM Compra
WHERE id = 'COMZV84';

ROLLBACK;

-- DISP-17 NO OK: No eliminar proveedor con compras
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono)
VALUES (
    'PRVZV85',
    'proveedor.zv85@test.com',
    'Proveedor',
    'ConCompraZV',
    'Empresa ZV 85',
    '3216000085'
);

INSERT INTO Compra (id, fecha, total, estado, idProveedor)
VALUES (
    'COMZV85',
    TO_DATE('2025-06-01','YYYY-MM-DD'),
    50000,
    'PENDIENTE',
    'PRVZV85'
);

-- Error esperado: ORA-20101
DELETE FROM Proveedor
WHERE id = 'PRVZV85';

ROLLBACK;
