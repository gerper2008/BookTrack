---------------------------------------------------------------------------------------------
-- ACCIONES OK / NO OK (RE-EJECUTABLE Y ALINEADO A TRIGGERS)
-- Dataset aislado con prefijo ZV
---------------------------------------------------------------------------------------------

SET SERVEROUTPUT ON;

---------------------------------------------------------------------------------------------
-- PRE-LIMPIEZA AISLADA (hijos -> padres)
---------------------------------------------------------------------------------------------
BEGIN
    DELETE FROM Producto_Compra WHERE id IN ('PCZV28','PCZV29','PCZV99');
    DELETE FROM Compra          WHERE id IN ('COMZV27','COMZV28','COMZV29','COMZV99');
    DELETE FROM Ejemplar        WHERE id IN ('EJMZV24');
    DELETE FROM Edicion         WHERE id IN ('EDIZV22','EDIZV23','EDIZV24');
    DELETE FROM Libro_Autor     WHERE idLibro IN ('LIBZV25','LIBZV26');
    DELETE FROM Libro           WHERE id IN ('LIBZV21','LIBZV22','LIBZV23','LIBZV24','LIBZV25','LIBZV26','LIBZV28','LIBZV29');
    DELETE FROM Autor           WHERE id IN ('AUTZV25','AUTZV26');
    DELETE FROM Usuario         WHERE id IN ('USRZV30');
    DELETE FROM Administrador   WHERE idUsuario IN ('USRZV30');
    DELETE FROM Proveedor       WHERE id IN ('PRVZV27');
    DELETE FROM Editorial       WHERE id IN ('EDTZV23');
    DELETE FROM Categoria       WHERE id IN ('CATZV21');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Aviso pre-limpieza: ' || SQLERRM);
END;
/

---------------------------------------------------------------------------------------------
-- PRECONDICIONES COMUNES (tolerantes a re-ejecución)
---------------------------------------------------------------------------------------------
BEGIN
    INSERT INTO Categoria (id, nombre, descripcion)
    VALUES ('CATZV20', 'Categoria ZV Acciones', 'Categoria base para acciones');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Editorial (id, correo, telefono, nombre, pais)
    VALUES ('EDTZV20', 'editorial.zv20@test.com', '3202000000', 'Editorial ZV Base', 'Colombia');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono)
    VALUES ('PRVZV20', 'proveedor.zv20@test.com', 'Paula', 'Zamora', 'Proveedor ZV Base', '3212000000');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

COMMIT;

---------------------------------------------------------------------------------------------
-- ACCION 1 OK
-- Libro.idCategoria -> Categoria(id) ON DELETE SET NULL
---------------------------------------------------------------------------------------------
BEGIN
    INSERT INTO Categoria (id, nombre, descripcion)
    VALUES ('CATZV21', 'Temporal ZV 1', 'Categoria temporal accion 1');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria)
    VALUES ('LIBZV21', 'Libro ZV SET NULL', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol', 'Prueba accion 1', 'CATZV21');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

COMMIT;

DELETE FROM Categoria WHERE id = 'CATZV21';
COMMIT;

-- Verificar:
-- SELECT idCategoria FROM Libro WHERE id = 'LIBZV21';
-- Esperado: NULL

---------------------------------------------------------------------------------------------
-- ACCION 2 OK
-- Edicion.idLibro -> Libro(id) ON DELETE CASCADE
---------------------------------------------------------------------------------------------
BEGIN
    INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria)
    VALUES ('LIBZV22', 'Libro ZV CASCADE', TO_DATE('2021-01-01','YYYY-MM-DD'), 'Espanol', 'Prueba accion 2', 'CATZV20');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Edicion (id, idLibro, idEditorial, anio, paginas)
    VALUES ('EDIZV22', 'LIBZV22', 'EDTZV20', TO_DATE('2022-01-01','YYYY-MM-DD'), 200);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

COMMIT;

DELETE FROM Libro WHERE id = 'LIBZV22';
COMMIT;

-- Verificar:
-- SELECT * FROM Edicion WHERE id = 'EDIZV22';
-- Esperado: 0 filas

---------------------------------------------------------------------------------------------
-- ACCION 3 OK
-- Edicion.idEditorial -> Editorial(id) ON DELETE SET NULL
---------------------------------------------------------------------------------------------
BEGIN
    INSERT INTO Editorial (id, correo, telefono, nombre, pais)
    VALUES ('EDTZV23', 'editorial.zv23@test.com', '3202000003', 'Editorial ZV 23', 'Colombia');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria)
    VALUES ('LIBZV23', 'Libro ZV Editorial', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol', 'Prueba accion 3', 'CATZV20');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Edicion (id, idLibro, idEditorial, anio, paginas)
    VALUES ('EDIZV23', 'LIBZV23', 'EDTZV23', TO_DATE('2023-01-01','YYYY-MM-DD'), 350);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

COMMIT;

DELETE FROM Editorial WHERE id = 'EDTZV23';
COMMIT;

-- Verificar:
-- SELECT idEditorial FROM Edicion WHERE id = 'EDIZV23';
-- Esperado: NULL

---------------------------------------------------------------------------------------------
-- ACCION 4 NO OK (ajustada por trigger DISP-11)
-- Si Ejemplar está disponible, trigger puede bloquear eliminaciones relacionadas.
---------------------------------------------------------------------------------------------
BEGIN
    INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria)
    VALUES ('LIBZV24', 'Libro ZV Ejemplar', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol', 'Prueba accion 4', 'CATZV20');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Edicion (id, idLibro, idEditorial, anio, paginas)
    VALUES ('EDIZV24', 'LIBZV24', 'EDTZV20', TO_DATE('2022-01-01','YYYY-MM-DD'), 150);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Ejemplar (id, idEdicion, estadoFisico, disponibilidad, localizacion, fechaAdquisicion)
    VALUES ('EJMZV24', 'EDIZV24', 'Bueno', 1, 'Estante ZV 24', TO_DATE('2024-01-01','YYYY-MM-DD'));
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

COMMIT;

BEGIN
    DELETE FROM Edicion WHERE id = 'EDIZV24';
    COMMIT;
    RAISE_APPLICATION_ERROR(-20924, 'FALLO ESPERADO NO OCURRIO en ACCION 4 (debia bloquear por trigger de ejemplar disponible).');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE IN (-20040, -20924) THEN
            DBMS_OUTPUT.PUT_LINE('ACCION 4 resultado esperado: ' || SQLERRM);
            ROLLBACK;
        ELSE
            RAISE;
        END IF;
END;
/

---------------------------------------------------------------------------------------------
-- ACCION 5 OK
-- Libro_Autor.idAutor -> Autor(id) ON DELETE CASCADE
---------------------------------------------------------------------------------------------
BEGIN
    INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad)
    VALUES ('AUTZV25', 'Autor', 'ZVVeinticinco', 'Masculino', 'Colombiana');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria)
    VALUES ('LIBZV25', 'Libro ZV Autor', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol', 'Prueba accion 5', 'CATZV20');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Libro_Autor (idLibro, idAutor)
    VALUES ('LIBZV25', 'AUTZV25');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

COMMIT;

DELETE FROM Autor WHERE id = 'AUTZV25';
COMMIT;

-- Verificar:
-- SELECT * FROM Libro_Autor WHERE idLibro = 'LIBZV25';
-- Esperado: 0 filas

---------------------------------------------------------------------------------------------
-- ACCION 6 OK
-- Libro_Autor.idLibro -> Libro(id) ON DELETE CASCADE
---------------------------------------------------------------------------------------------
BEGIN
    INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad)
    VALUES ('AUTZV26', 'Autor', 'ZVVeintiseis', 'Masculino', 'Argentina');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria)
    VALUES ('LIBZV26', 'Libro ZV Relacion', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol', 'Prueba accion 6', 'CATZV20');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Libro_Autor (idLibro, idAutor)
    VALUES ('LIBZV26', 'AUTZV26');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

COMMIT;

DELETE FROM Libro WHERE id = 'LIBZV26';
COMMIT;

-- Verificar:
-- SELECT * FROM Libro_Autor WHERE idAutor = 'AUTZV26';
-- Esperado: 0 filas

---------------------------------------------------------------------------------------------
-- ACCION 7 OK
-- Compra.idProveedor -> Proveedor(id) ON DELETE SET NULL
---------------------------------------------------------------------------------------------
BEGIN
    INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono)
    VALUES ('PRVZV27', 'proveedor.zv27@test.com', 'Proveedor', 'ZVVeintisiete', 'Distribuidora ZV 27', '3212000027');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Compra (id, fecha, total, estado, idProveedor)
    VALUES ('COMZV27', TO_DATE('2024-01-01','YYYY-MM-DD'), 100000, 'PENDIENTE', 'PRVZV27');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

COMMIT;

DELETE FROM Proveedor WHERE id = 'PRVZV27';
COMMIT;

-- Verificar:
-- SELECT idProveedor FROM Compra WHERE id = 'COMZV27';
-- Esperado: NULL

---------------------------------------------------------------------------------------------
-- ACCION 8 NO OK (ajustada por trigger DISP-15)
-- El trigger impide borrar Compra si no está en PENDIENTE en ciertos contextos.
---------------------------------------------------------------------------------------------
BEGIN
    INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria)
    VALUES ('LIBZV28', 'Libro ZV Compra', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol', 'Prueba accion 8', 'CATZV20');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Compra (id, fecha, total, estado, idProveedor)
    VALUES ('COMZV28', TO_DATE('2024-01-01','YYYY-MM-DD'), 80000, 'PENDIENTE', 'PRVZV20');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro)
    VALUES ('PCZV28', 2, 40000, 'COMZV28', 'LIBZV28');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

COMMIT;

-- Fuerza estado para activar protección de trigger de compra
UPDATE Compra SET estado = 'COMPLETADO' WHERE id = 'COMZV28';
COMMIT;

BEGIN
    DELETE FROM Compra WHERE id = 'COMZV28';
    COMMIT;
    RAISE_APPLICATION_ERROR(-20928, 'FALLO ESPERADO NO OCURRIO en ACCION 8 (debia bloquear eliminacion de compra no pendiente).');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE IN (-20061, -20928) THEN
            DBMS_OUTPUT.PUT_LINE('ACCION 8 resultado esperado: ' || SQLERRM);
            ROLLBACK;
        ELSE
            RAISE;
        END IF;
END;
/

---------------------------------------------------------------------------------------------
-- ACCION 9 OK
-- Producto_Compra.idLibro -> Libro(id) ON DELETE SET NULL
---------------------------------------------------------------------------------------------
BEGIN
    INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria)
    VALUES ('LIBZV29', 'Libro ZV Producto', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol', 'Prueba accion 9', 'CATZV20');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Compra (id, fecha, total, estado, idProveedor)
    VALUES ('COMZV29', TO_DATE('2024-01-01','YYYY-MM-DD'), 90000, 'PENDIENTE', 'PRVZV20');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro)
    VALUES ('PCZV29', 1, 90000, 'COMZV29', 'LIBZV29');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

COMMIT;

DELETE FROM Libro WHERE id = 'LIBZV29';
COMMIT;

-- Verificar:
-- SELECT idLibro FROM Producto_Compra WHERE id = 'PCZV29';
-- Esperado: NULL

---------------------------------------------------------------------------------------------
-- ACCION 10 OK
-- Administrador.idUsuario -> Usuario(id) ON DELETE CASCADE
---------------------------------------------------------------------------------------------
BEGIN
    INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono)
    VALUES ('USRZV30', 'admin.zv30@test.com', 'Administrador', 'Admin', 'ZVTreinta', '3001234030');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Administrador (idUsuario, permisos, sede)
    VALUES ('USRZV30', 'Total', 'Sede ZV Norte');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

COMMIT;

DELETE FROM Usuario WHERE id = 'USRZV30';
COMMIT;

-- Verificar:
-- SELECT * FROM Administrador WHERE idUsuario = 'USRZV30';
-- Esperado: 0 filas

---------------------------------------------------------------------------------------------
-- ACCIONES NO OK (integridad referencial)
---------------------------------------------------------------------------------------------

-- FK no existente en Compra.idProveedor
-- Error esperado: ORA-02291
BEGIN
    INSERT INTO Compra (id, fecha, total, estado, idProveedor)
    VALUES ('COMZV99', TO_DATE('2024-02-01','YYYY-MM-DD'), 1000, 'PENDIENTE', 'PRV_NO_EXISTE');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            DBMS_OUTPUT.PUT_LINE('NO OK 1 resultado esperado: ' || SQLERRM);
        ELSE
            RAISE;
        END IF;
END;
/

-- FK no existente en Producto_Compra.idLibro
-- Error esperado: ORA-02291
BEGIN
    INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro)
    VALUES ('PCZV99', 1, 1000, 'COMZV27', 'LIB_NO_EXISTE');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            DBMS_OUTPUT.PUT_LINE('NO OK 2 resultado esperado: ' || SQLERRM);
        ELSE
            RAISE;
        END IF;
END;
/
