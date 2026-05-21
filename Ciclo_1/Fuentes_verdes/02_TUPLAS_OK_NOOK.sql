---------------------------------------------------------------------------------------------
-- TUPLAS OK / NO OK (CORREGIDO PARA EVITAR COLISIONES CON TRIGGERS)
-- Dataset aislado con prefijo ZV
-- RE-EJECUTABLE
---------------------------------------------------------------------------------------------

SET SERVEROUTPUT ON;

---------------------------------------------------------------------------------------------
-- PRE-LIMPIEZA (evitar duplicados)
---------------------------------------------------------------------------------------------
BEGIN
    DELETE FROM Producto_Compra WHERE id LIKE 'PCZV%';
    DELETE FROM Ejemplar WHERE id LIKE 'EJMZV%';
    DELETE FROM Compra WHERE id LIKE 'COMZV%';
    DELETE FROM Edicion WHERE id LIKE 'EDIZV%';
    DELETE FROM Libro WHERE id LIKE 'LIBZV%';
    DELETE FROM Proveedor WHERE id LIKE 'PRVZV%';
    DELETE FROM Editorial WHERE id LIKE 'EDTZV%';
    DELETE FROM Categoria WHERE id LIKE 'CATZV%';
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
END;
/

---------------------------------------------------------------------------------------------
-- PRECONDICIONES (datos padre necesarios)
---------------------------------------------------------------------------------------------

BEGIN
    INSERT INTO Categoria (id, nombre, descripcion)
    VALUES ('CATZV01', 'Categoria ZV', 'Categoria para pruebas tuplas');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Editorial (id, correo, telefono, nombre, pais)
    VALUES ('EDTZV01', 'zv01@test.com', '3201000001', 'EditorialZV', 'Colombia');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono)
    VALUES ('PRVZV01', 'prove.zv01@test.com', 'Pedro', 'Zapata', 'DistribZV', '3211000001');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria)
    VALUES ('LIBZV01', 'Libro Base ZV', TO_DATE('2018-01-01','YYYY-MM-DD'), 'Espanol', 'Libro prueba tuplas', 'CATZV01');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

BEGIN
    INSERT INTO Edicion (id, idLibro, idEditorial, anio, paginas)
    VALUES ('EDIZV01', 'LIBZV01', 'EDTZV01', TO_DATE('2019-01-01','YYYY-MM-DD'), 210);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

COMMIT;

---------------------------------------------------------------------------------------------
-- TUPLAS OK - CASOS QUE DEBEN PASAR
---------------------------------------------------------------------------------------------

-- TUP1 OK: Compra con total > 0 en estado PENDIENTE (inicial)
-- La Compra siempre inicia en PENDIENTE (DISP-13), luego actualizamos a COMPLETADO
BEGIN
    INSERT INTO Compra (id, fecha, total, estado, idProveedor)
    VALUES ('COMZV01', TO_DATE('2024-07-01','YYYY-MM-DD'), 200000.00, 'PENDIENTE', 'PRVZV01');
    DBMS_OUTPUT.PUT_LINE('TUP1 OK: Compra insertada con total > 0');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN 
        DBMS_OUTPUT.PUT_LINE('TUP1 OK: Compra ya existe, actualizando...');
        UPDATE Compra SET total = 200000.00, estado = 'PENDIENTE' WHERE id = 'COMZV01';
END;
/

-- Ahora actualizamos a COMPLETADO (DISP-14 permite updates cuando esta en PENDIENTE)
UPDATE Compra SET estado = 'COMPLETADO' WHERE id = 'COMZV01';
-- Verificar que quedó en COMPLETADO
SELECT id, estado, total FROM Compra WHERE id = 'COMZV01';

-- TUP1 OK (alternativo): Compra PENDIENTE con total >= 0
BEGIN
    INSERT INTO Compra (id, fecha, total, estado, idProveedor)
    VALUES ('COMZV02', TO_DATE('2024-08-10','YYYY-MM-DD'), 50000.00, 'PENDIENTE', 'PRVZV01');
    DBMS_OUTPUT.PUT_LINE('TUP1 OK: Compra PENDIENTE insertada');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

-- TUP2 OK: Producto_Compra con cantidad > 0 y precioUnidad > 0
BEGIN
    INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro)
    VALUES ('PCZV01', 4, 55000.00, 'COMZV01', 'LIBZV01');
    DBMS_OUTPUT.PUT_LINE('TUP2 OK: Producto_Compra insertado');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

-- TUP3 OK: Ejemplar disponible (disponibilidad = 1) con estadoFisico = Nuevo
BEGIN
    INSERT INTO Ejemplar (id, idEdicion, estadoFisico, disponibilidad, localizacion, fechaAdquisicion)
    VALUES ('EJMZV01', 'EDIZV01', 'Nuevo', 1, 'Estante ZV', TO_DATE('2024-01-15','YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('TUP3 OK: Ejemplar disponible insertado');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

-- TUP5 OK: Libro con titulo e idioma NO nulos
BEGIN
    INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria)
    VALUES ('LIBZV02', 'Libro Tupla OK', TO_DATE('1985-09-05','YYYY-MM-DD'), 'Espanol', 'Romance', 'CATZV01');
    DBMS_OUTPUT.PUT_LINE('TUP5 OK: Libro con titulo insertado');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/

COMMIT;

---------------------------------------------------------------------------------------------
-- TUPLAS NO OK - CASOS QUE DEBEN FALLAR
---------------------------------------------------------------------------------------------

-- TUP1 NO OK: Compra COMPLETADO con total = 0
-- Error esperado: ORA-02290 (CH_Compra_estado_total)
-- Este UPDATE debe fallar
BEGIN
    UPDATE Compra SET estado = 'COMPLETADO', total = 0 WHERE id = 'COMZV02';
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('TUP1 NO OK: Error - ' || SQLERRM);
END;
/

-- TUP2 NO OK: cantidad = 0
-- Error esperado: ORA-02290 (CH_ProductoCompra_importe)
BEGIN
    INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro)
    VALUES ('PCZV99', 0, 50000, 'COMZV01', 'LIBZV01');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('TUP2 NO OK: Error - ' || SQLERRM);
END;
/

-- TUP2 NO OK: precioUnidad negativo
-- Error esperado: ORA-02290
BEGIN
    INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro)
    VALUES ('PCZV98', 2, -1000, 'COMZV01', 'LIBZV01');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('TUP2 NO OK: Error - ' || SQLERRM);
END;
/

-- TUP3 NO OK: disponibilidad = 0 Y estadoFisico = Nuevo
-- Error esperado: ORA-02290 (CH_Ejemplar_nuevo_disponible)
BEGIN
    INSERT INTO Ejemplar (id, idEdicion, estadoFisico, disponibilidad, localizacion, fechaAdquisicion)
    VALUES ('EJMZV99', 'EDIZV01', 'Nuevo', 0, 'Bodega', TO_DATE('2024-01-01','YYYY-MM-DD'));
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('TUP3 NO OK: Error - ' || SQLERRM);
END;
/

-- TUP5 NO OK: titulo NULL
-- Error esperado: ORA-01400 o CHECK (si hay constraint NOT NULL)
BEGIN
    INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria)
    VALUES ('LIBZV99', NULL, TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol', 'Sin titulo', 'CATZV01');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('TUP5 NO OK: Error - ' || SQLERRM);
END;
/

---------------------------------------------------------------------------------------------
-- RESUMEN DE RESULTADOS
---------------------------------------------------------------------------------------------
PROMPT,
PROMPT ===== RESUMEN TUPLAS OK/NOOK =====
PROMPT,

-- Verificar datos insertados
SELECT 'Compras OK: ' || COUNT(*) AS resultado FROM Compra WHERE id LIKE 'COMZV%'
UNION ALL
SELECT 'Productos OK: ' || COUNT(*) FROM Producto_Compra WHERE id LIKE 'PCZV%'
UNION ALL
SELECT 'Ejemplares OK: ' || COUNT(*) FROM Ejemplar WHERE id LIKE 'EJMZV%'
UNION ALL
SELECT 'Libros OK: ' || COUNT(*) FROM Libro WHERE id LIKE 'LIBZV%';
