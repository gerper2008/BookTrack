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
