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
INSERT INTO Producto_Compra VALUES ('PC004', 4, 55000.00, 'COM004', 'LIB001');
INSERT INTO Producto_Compra VALUES ('PC005', 1, 48000.00, 'COM005', 'LIB002');
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
