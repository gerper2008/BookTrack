--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- PARTE IV: PRUEBA DE ACEPTACIÓN ----------------------------------------------
--------------------------------------------------------------------------------
--
-- Historia: "Carlos administra compras para la biblioteca"
--
--------------------------------------------------------------------------------

-- LIMPIEZA PREVIA
DELETE FROM Producto_Compra WHERE id = 'PC900';
DELETE FROM Compra          WHERE id = 'COM900';
DELETE FROM Proveedor       WHERE id = 'PRV900';
COMMIT;

-- PASO 1 ----------------------------------------------------------------------
-- Carlos registra un proveedor nuevo.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 1: Registro proveedor ===');

    INSERT INTO Proveedor(
        nombre,
        apellidos,
        correo,
        empresa,
        telefono
    )
    VALUES (
        'Andres',
        'Lopez',
        'andres@libros.com',
        'Distribuidora Central',
        '3001112233'
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Proveedor registrado');
END;
/

-- Verificación paso 1
SELECT * FROM PROVEEDOR ORDER BY ID DESC; -- VER ULTIMO ID
SELECT *
FROM Proveedor
WHERE id = 'PRV054';


-- PASO 2 ----------------------------------------------------------------------
-- Carlos registra una nueva compra.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 2: Registro compra ===');

    INSERT INTO Compra(
        idProveedor,
        fecha,
        total,
        estado
    )
    VALUES (
        'PRV054',
        DATE '2025-02-01',
        850000,
        'PENDIENTE'
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Compra registrada');
END;
/

-- Verificación paso 2
SELECT * FROM Compra ORDER BY ID DESC; -- VER ULTIMO ID
SELECT *
FROM Compra
WHERE id = 'COM055';


-- PASO 3 ----------------------------------------------------------------------
-- Carlos registra productos asociados a la compra.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 3: Registro productos compra ===');

    INSERT INTO Producto_Compra(
        idLibro,
        cantidad,
        precioUnidad
    )
    VALUES (
        'COM055',
        'LIB001',
        5,
        90000
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Producto registrado');
END;
/

-- Verificación paso 3
SELECT * FROM Compra ORDER BY ID DESC; -- VER ULTIMO ID
SELECT *
FROM Producto_Compra
WHERE idCompra = 'COM900';


-- PASO 4 ----------------------------------------------------------------------
-- Carlos deja la compra en estado no pendiente para activar reglas de protección.
-- El trigger de inserción fuerza PENDIENTE inicialmente, por eso aquí se ajusta.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 4: Ajuste de estado compra ===');

    UPDATE Compra
    SET estado = 'COMPLETADO'
    WHERE id = 'COM900';

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Compra en estado COMPLETADO');
END;
/

-- Verificación paso 4
SELECT id, estado
FROM Compra
WHERE id = 'COM900';


-- PASO 5 ----------------------------------------------------------------------
-- Carlos intenta modificar una compra ya completada.
-- Debe fallar. Si no falla por trigger, forzamos error explícito para marcar NOOK.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 5: Modificacion protegida ===');

    BEGIN
        UPDATE Compra
        SET total = 9990999
        WHERE id = 'COM900';

        COMMIT;

        -- Si llegó aquí, no falló como debía
        RAISE_APPLICATION_ERROR(-20960, 'FALLO ESPERADO NO OCURRIO en PASO 5 (debia bloquear modificacion).');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE IN (-20060, -20960) THEN
                DBMS_OUTPUT.PUT_LINE('Resultado PASO 5: ' || SQLERRM);
            ELSE
                RAISE;
            END IF;
    END;
END;
/

-- → FALLA ESPERADA:
-- ORA-20060 (trigger) o ORA-20960 (falla forzada de aceptación)


-- Verificación paso 5
SELECT id, total, estado
FROM Compra
WHERE id = 'COM900';


-- PASO 6 ----------------------------------------------------------------------
-- Carlos intenta eliminar la compra completada.
-- Debe fallar. Si no falla por trigger, forzamos error explícito para marcar NOOK.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 6: Eliminacion protegida ===');

    BEGIN
        DELETE FROM Compra
        WHERE id = 'COM900';

        COMMIT;

        -- Si llegó aquí, no falló como debía
        RAISE_APPLICATION_ERROR(-20961, 'FALLO ESPERADO NO OCURRIO en PASO 6 (debia bloquear eliminacion).');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE IN (-20061, -20961) THEN
                DBMS_OUTPUT.PUT_LINE('Resultado PASO 6: ' || SQLERRM);
            ELSE
                RAISE;
            END IF;
    END;
END;
/

-- → FALLA ESPERADA:
-- ORA-20061 (trigger) o ORA-20961 (falla forzada de aceptación)


-- Verificación paso 6
SELECT *
FROM Compra
WHERE id = 'COM900';


-- PASO 7 ----------------------------------------------------------------------
-- Carlos consulta los productos comprados.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 7: Consulta final compra ===');
END;
/

-- Verificación paso 7
SELECT
    C.id              AS compra,
    P.id              AS producto,
    P.cantidad,
    P.precioUnidad,
    L.titulo
FROM Compra C
JOIN Producto_Compra P
    ON P.idCompra = C.id
LEFT JOIN Libro L
    ON L.id = P.idLibro
WHERE C.id = 'COM900';