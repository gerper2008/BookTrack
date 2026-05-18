---------------------------------------------------------------------------------------------
-- TUPLAS OK
---------------------------------------------------------------------------------------------
-- TUP1 OK: estado COMPLETADO con total > 0
INSERT INTO Compra VALUES ('CMP004', TO_DATE('2024-07-01','YYYY-MM-DD'), 200000.00, 'COMPLETADO', 'PRV001');
 
-- TUP1 OK: estado PENDIENTE con total >= 0
INSERT INTO Compra VALUES ('CMP005', TO_DATE('2024-08-10','YYYY-MM-DD'), 50000.00, 'PENDIENTE', 'PRV002');
 
-- TUP1 OK: estado RECHAZADO con total >= 0
INSERT INTO Compra VALUES ('CMP006', TO_DATE('2024-09-05','YYYY-MM-DD'), 0.01, 'RECHAZADO', 'PRV003');
 
-- TUP2 OK: cantidad > 0 y precioUnidad > 0 juntos
INSERT INTO Producto_Compra VALUES ('PC004', 4, 55000.00, 'CMP004', 'LIB001');
INSERT INTO Producto_Compra VALUES ('PC005', 1, 48000.00, 'CMP001', 'LIB002');
COMMIT;

-- TUP3 OK: disponibilidad = 1 con estadoFisico = 'Nuevo' (combinacion permitida)
INSERT INTO Ejemplar VALUES ('EJE004', 'Nuevo', 1, 'Estante C dos',  TO_DATE('2024-01-15','YYYY-MM-DD'), 'EDI001');
 
-- TUP3 OK: disponibilidad = 0 con estadoFisico = 'Bueno' (no es Nuevo, permitido)
INSERT INTO Ejemplar VALUES ('EJE005', 'Bueno', 0, 'Bodega norte',   TO_DATE('2024-02-20','YYYY-MM-DD'), 'EDI002');
 
-- TUP3 OK: disponibilidad = 0 con estadoFisico = 'Desgastado' (permitido)
INSERT INTO Ejemplar VALUES ('EJE006', 'Desgastado', 0, 'Bodega sur', TO_DATE('2023-11-10','YYYY-MM-DD'), 'EDI003');
 
-- TUP5 OK: titulo e idioma ambos presentes (NOT NULL)
INSERT INTO Libro VALUES ('LIB004', 'El Amor en los Tiempos del Colera', TO_DATE('1985-09-05','YYYY-MM-DD'), 'Espanol', 'Romance en el caribe colombiano', 'CAT001');
 
-- TUP6 OK: nombre, apellidos y nacionalidad todos presentes (NOT NULL)
INSERT INTO Autor VALUES ('AUT004', 'Mario', 'Vargas Llosa', 'Masculino', 'Peruana');
 
COMMIT;
SELECT * FROM categoria;

---------------------------------------------------------------------------------------------
-- DISPARADORES OK
---------------------------------------------------------------------------------------------
 
-- DISP-01 OK: trigger genera id automaticamente (CAT004)
-- DISP-02 OK: nombre 'Ciencia' es unico en la tabla
INSERT INTO Categoria(nombre, descripcion) VALUES ('Ciencia', 'Libros de ciencias naturales y exactas');
 
-- DISP-04 OK: trigger genera id automaticamente (LIB005)
-- DISP-05 OK: CAT002 existe en Categoria
INSERT INTO Libro(idCategoria, titulo, fecha_publicacion, idioma) VALUES ('CAT002', 'Sapiens', TO_DATE('2011-01-01','YYYY-MM-DD'), 'Espanol');
 
-- DISP-08 OK: trigger genera id automaticamente (AUT005)
-- DISP-09 OK: 'Jorge Amado' es distinto a todos los nombre+apellidos existentes
INSERT INTO Autor(nombre, apellidos, genero, nacionalidad) VALUES ('Jorge', 'Amado', 'Masculino', 'Brasilena');
 
-- DISP-09 OK: mismo nombre 'Jorge' que AUT002 pero apellidos distintos -> no hay duplicado
INSERT INTO Autor(nombre, apellidos, genero, nacionalidad) VALUES ('Jorge', 'Icaza', 'Masculino', 'Ecuatoriana');
 
-- DISP-17 OK: trigger genera id automaticamente (EDT004)
-- DISP-18 OK: correo 'info@sm.com' es unico
-- DISP-19 OK: telefono '3211112233' es unico
INSERT INTO Editorial(nombre, correo, telefono, pais) VALUES ('Santillana', 'info@sm.com', '3211112233', 'Espana');
 
-- DISP-21 OK: trigger genera id automaticamente (EJE007)
INSERT INTO Ejemplar(idEdicion, estadoFisico, disponibilidad, localizacion, fechaAdquisicion) VALUES ('EDI001', 'Bueno', 1, 'Estante D uno', TO_DATE('2024-03-01','YYYY-MM-DD'));
 
-- DISP-24 OK: trigger sobreescribe estado a PENDIENTE sin importar lo que se ingrese
INSERT INTO Compra(idProveedor, fecha, total, estado) VALUES ('PRV001', TO_DATE('2025-01-10','YYYY-MM-DD'), 120000.00, 'COMPLETADO');
 
-- DISP-23 OK: PRV002 existe -> trigger no lanza error
INSERT INTO Compra(idProveedor, fecha, total, estado) VALUES ('PRV002', TO_DATE('2025-02-15','YYYY-MM-DD'), 75000.00, 'PENDIENTE');
 
-- DISP-25 OK: la compra anterior quedo en PENDIENTE -> se puede modificar
UPDATE Compra SET total = 90000.00 WHERE id = 'COM005';
COMMIT; 
-- DISP-27 OK: trigger genera id automaticamente (PRV004)
-- DISP-28 OK: correo 'nuevo@prov.com' es unico
INSERT INTO Proveedor(nombre, apellidos, correo, empresa, telefono) VALUES ('Laura', 'Gomez Rios', 'nuevo@prov.com', 'Importadora Andes', '3178889900');
 
COMMIT;

---------------------------------------------------------------------------------------------
--- ACCIONES OK -> Acciones de referencia
---------------------------------------------------------------------------------------------

-- SET NULL: Al eliminar Categoria, Libros quedan con idCategoria = NULL
-- CAT003 'Tecnologia' -> LIB005 'Sapiens' tiene idCategoria = CAT003
DELETE FROM Categoria WHERE id = 'CAT003';
COMMIT;

-- CASCADE: Insertar edicion limpia para LIB005 y borrarla sin ejemplares
INSERT INTO Edicion(idLibro, idEditorial, anio, paginas)
VALUES ('LIB005', 'ED001', TO_DATE('2020-01-01','YYYY-MM-DD'), 280);
COMMIT;

DELETE FROM Edicion WHERE idLibro = 'LIB005';
COMMIT;

-- CASCADE: LIB005 ya sin ediciones -> se puede borrar
DELETE FROM Libro WHERE id = 'LIB005';
COMMIT;

-- CASCADE: Al eliminar Usuario, su Administrador desaparece
INSERT INTO Usuario(id, correo, rol, nombre, apellidos, telefono)
VALUES ('USR004', 'temp@biblioteca.com', 'Lector', 'Temp', 'Usuario Prueba', '3001119999');
INSERT INTO Administrador(idUsuario, permisos, sede)
VALUES ('USR004', 'Solo Lectura', 'Sede Sur');
COMMIT;

DELETE FROM Usuario WHERE id = 'USR004';
COMMIT;

-- ============================================================
--  BOOKTRACK -- CASOS NO OK (errores esperados)
--  Disparadores, Acciones Referenciales y Tuplas
-- ============================================================

-- ============================================================
-- SECCIÓN 1: DISPARADORES
-- ============================================================

-- DISP-02: Nombre de Categoria duplicado
-- Error esperado: ORA-20042 - Ya existe una categoría con el nombre...
EXEC PC_CATEGORIA.AD_CATEGORIA('Ficcion', 'Libros de fantasia');

-- DISP-03: Eliminar Categoria con Libros asociados
-- Error esperado: ORA-20040 - No se puede eliminar la categoria porque tiene libros
EXEC PC_CATEGORIA.ELI_CATEGORIA('CAT001');

-- DISP-05: Insertar Libro con Categoria inexistente
-- Error esperado: ORA-20041 - La categoría "CAT999" no existe en el catálogo
EXEC PC_LIBRO.AD_LIBRO('CAT999', 'Libro Fantasma', 'Descripcion', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol');

-- DISP-06: Modificar titulo de Libro que tiene Ediciones activas
-- Error esperado: ORA-20020 - No se puede modificar el título porque tiene ediciones activas
EXEC PC_LIBRO.MOD_LIBRO('LIB001', 'CAT001', 'Titulo Cambiado', 'Descripcion', 'Espanol');

-- DISP-07: Eliminar Libro que tiene Ediciones
-- Error esperado: ORA-20021 - No se puede eliminar el libro porque posee ediciones
EXEC PC_LIBRO.ELI_LIBRO('LIB001');

-- DISP-09: Autor con nombre + apellidos duplicados
-- Error esperado: ORA-20050 - Ya existe un autor con el nombre "Gabriel Garcia Marquez"
EXEC PC_AUTOR.AD_AUTOR('Gabriel', 'Garcia Marquez', 'Masculino', 'Colombiana');

-- DISP-11: Eliminar Autor con libros vinculados
-- Error esperado: ORA-20052 - No se puede eliminar el autor porque tiene libros asociados
EXEC PC_AUTOR.ELI_AUTOR('AUT001');

-- DISP-13: Insertar Edicion con Libro inexistente
-- Error esperado: ORA-20060 - El libro con id "LIB999" no existe en el catálogo
EXEC PC_EDICION.AD_EDICION('LIB999', 'ED001', TO_DATE('2020-01-01','YYYY-MM-DD'), 300);

-- DISP-14: Insertar Edicion con Editorial inexistente
-- Error esperado: ORA-20061 - La editorial con id "EDT999" no existe en el sistema
EXEC PC_EDICION.AD_EDICION('LIB001', 'EDT999', TO_DATE('2020-01-01','YYYY-MM-DD'), 300);

-- DISP-15: Modificar idLibro de Edicion que tiene Ejemplares
-- Error esperado: ORA-20062 - No se puede cambiar el origen de la edición porque posee ejemplares
EXEC PC_EDICION.MOD_EDICION('EDI001', 'LIB002', 'ED001', TO_DATE('2000-01-01','YYYY-MM-DD'), 432);

-- DISP-16: Eliminar Edicion que tiene Ejemplares
-- Error esperado: ORA-20063 - No se puede eliminar la edicion porque posee ejemplares
EXEC PC_EDICION.ELI_EDICION('EDI001');

-- DISP-18: Correo de Editorial duplicado
-- Error esperado: ORA-20070 - Ya existe una editorial con el correo...
EXEC PC_EDITORIAL.AD_EDITORIAL('Nueva Editorial', 'contacto@planeta.com', '3999999999', 'Colombia');

-- DISP-19: Teléfono de Editorial duplicado
-- Error esperado: ORA-20071 - Ya existe una editorial con el teléfono...
EXEC PC_EDITORIAL.AD_EDITORIAL('Otra Editorial', 'nueva@otra.com', '3001234567', 'Colombia');

-- DISP-20: Eliminar Editorial con Ediciones activas
-- Error esperado: ORA-20072 - No se puede eliminar la editorial porque tiene ediciones
EXEC PC_EDITORIAL.ELI_EDITORIAL('ED001');

-- DISP-23: Insertar Compra con Proveedor inexistente
-- Error esperado: ORA-20090 - El proveedor con id "PRV999" no existe en el sistema
EXEC PC_COMPRA.AD_COMPRA('PRV999', TO_DATE('2025-01-01','YYYY-MM-DD'), 100000, 'PENDIENTE');

-- DISP-24: Estado inicial de Compra forzado a PENDIENTE
-- (aunque se pase COMPLETADO, el trigger lo sobreescribe a PENDIENTE)
-- Verificar con: SELECT estado FROM Compra ORDER BY id DESC;
EXEC PC_COMPRA.AD_COMPRA('PRV001', TO_DATE('2025-04-01','YYYY-MM-DD'), 50000, 'COMPLETADO');

-- DISP-25: Modificar Compra que NO está en estado PENDIENTE
-- Error esperado: ORA-20091 - No se puede modificar la compra porque su estado no es PENDIENTE
-- CMP001 está en estado COMPLETADO
EXEC PC_COMPRA.MOD_COMPRA('CMP001', TO_DATE('2024-02-01','YYYY-MM-DD'), 999999, 'COMPLETADO');

-- DISP-28: Correo de Proveedor duplicado
-- Error esperado: ORA-20100 - Ya existe un proveedor con el correo...
EXEC PC_PROVEEDOR.AD_PROVEEDOR('Juan', 'Perez', 'ventas@distribuidora.com', 'Empresa Nueva', '3111111111');

-- DISP-29: Eliminar Proveedor con Compras registradas
-- Error esperado: ORA-20101 - No se puede eliminar el proveedor porque tiene compras
EXEC PC_PROVEEDOR.ELI_PROVEEDOR('PRV001');

-- ============================================================
-- SECCIÓN 2: ACCIONES REFERENCIALES
-- ============================================================

-- ON DELETE SET NULL: Eliminar Categoria deja idCategoria=NULL en Libro
-- (requiere que el libro NO tenga ediciones para que DISP-03 lo permita)
-- Primero verificar con un libro sin ediciones; si no hay, crear uno:
EXEC PC_LIBRO.AD_LIBRO('CAT005', 'Libro Sin Edicion', 'Libro temporal sin edicion', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol');
-- Luego intentar eliminar CAT005 (Filosofia) — fallará por DISP-03 si tiene libros
-- Este caso muestra el conflicto entre el trigger y la acción referencial:
EXEC PC_CATEGORIA.ELI_CATEGORIA('CAT005');

-- ON DELETE CASCADE: Eliminar Edicion elimina sus Ejemplares
-- (requiere que DISP-16 no lo bloquee → usar edicion sin ejemplares)
EXEC PC_EDICION.AD_EDICION('LIB005', 'EDT005', TO_DATE('2020-06-01','YYYY-MM-DD'), 250);
-- Verificar ID generado y luego eliminar:
-- EXEC PC_EDICION.ELI_EDICION('EDI00X'); → eliminará ejemplares en cascada

-- ON DELETE CASCADE: Eliminar Usuario elimina su Administrador
-- Error esperado: ninguno — se elimina en cascada (caso de verificación)
-- Primero insertar usuario y admin de prueba:
EXEC PC_USUARIO.AD_USUARIO('cascada@test.com', 'Administrador', 'Test', 'Cascada', '3111222333');
-- Verificar ID y registrar como admin:
-- EXEC PC_USUARIO.AD_ADMINISTRADOR('USR00X', 'Operativo', 'Sede Test');
-- Al eliminar el usuario, el administrador se borra en cascada:
-- EXEC PC_USUARIO.ELI_USUARIO('USR00X');

-- ============================================================
-- SECCIÓN 3: RESTRICCIONES DE TUPLAS
-- ============================================================

-- TUP1: Compra COMPLETADA con total = 0
-- Error esperado: ORA-02290 - restricción de control CH_Compra_estado_total violada
-- (el trigger DISP-24 fuerza estado=PENDIENTE en INSERT,
--  así que se prueba haciendo UPDATE a COMPLETADO con total=0)
UPDATE Compra SET estado = 'COMPLETADO', total = 0 WHERE id = 'COM007';
COMMIT;

-- TUP2: Producto_Compra con cantidad = 0
-- Error esperado: ORA-02290 - restricción CH_ProductoCompra_importe violada
EXEC PC_COMPRA.AD_PRODUCTO_COMPRA('COM007', 'LIB001', 0, 50000);

-- TUP2: Producto_Compra con precioUnidad negativo
-- Error esperado: ORA-02290 - restricción CH_ProductoCompra_importe violada
EXEC PC_COMPRA.AD_PRODUCTO_COMPRA('COM007', 'LIB001', 3, -1000);

-- TUP3: Ejemplar no disponible ('0') con estadoFisico 'Nuevo'
-- Error esperado: ORA-02290 - restricción CH_Ejemplar_nuevo_disponible violada
EXEC PC_EJEMPLAR.AD_EJEMPLAR('EDI001', 'Nuevo', '0', 'Estante A uno', TO_DATE('2024-01-01','YYYY-MM-DD'));

-- TUP5: Libro con titulo NULL
-- Error esperado: ORA-02290 - restricción CH_Libro_titulo_idioma violada
INSERT INTO Libro(id, idCategoria, titulo, descripcion, fecha_publicacion, idioma)
VALUES ('LIBX', 'CAT001', NULL, 'Sin titulo', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol');

-- TUP5: Libro con idioma NULL
-- Error esperado: ORA-02290 - restricción CH_Libro_titulo_idioma violada
INSERT INTO Libro(id, idCategoria, titulo, descripcion, fecha_publicacion, idioma)
VALUES ('LIBY', 'CAT001', 'Titulo sin idioma', 'Descripcion', TO_DATE('2020-01-01','YYYY-MM-DD'), NULL);

-- TUP6: Autor con nacionalidad NULL
-- Error esperado: ORA-02290 - restricción CH_Autor_identidad violada
INSERT INTO Autor(id, nombre, apellidos, genero, nacionalidad)
VALUES ('AUTX', 'Sin', 'Nacionalidad', 'Masculino', NULL);
