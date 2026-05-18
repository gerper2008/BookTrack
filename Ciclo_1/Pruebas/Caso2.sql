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
        id,
        nombre,
        apellidos,
        correo,
        empresa,
        telefono
    )
    VALUES (
        'PRV900',
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
SELECT *
FROM Proveedor
WHERE id = 'PRV900';


-- PASO 2 ----------------------------------------------------------------------
-- Carlos registra una nueva compra.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 2: Registro compra ===');

    INSERT INTO Compra(
        id,
        idProveedor,
        fecha,
        total,
        estado
    )
    VALUES (
        'COM900',
        'PRV900',
        DATE '2025-02-01',
        850000,
        'PENDIENTE'
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Compra registrada');
END;
/

-- Verificación paso 2
SELECT *
FROM Compra
WHERE id = 'COM900';


-- PASO 3 ----------------------------------------------------------------------
-- Carlos registra productos asociados a la compra.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 3: Registro productos compra ===');

    INSERT INTO Producto_Compra(
        id,
        idCompra,
        idLibro,
        cantidad,
        precioUnidad
    )
    VALUES (
        'PC900',
        'COM900',
        'LIB001',
        5,
        90000
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Producto registrado');
END;
/

-- Verificación paso 3
SELECT *
FROM Producto_Compra
WHERE idCompra = 'COM900';


-- PASO 4 ----------------------------------------------------------------------
-- Carlos actualiza el estado de la compra.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 4: Actualizacion compra ===');

    UPDATE Compra
    SET estado = 'COMPLETADA'
    WHERE id = 'COM900';

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Compra completada');
END;
/

-- Verificación paso 4
SELECT id, estado
FROM Compra
WHERE id = 'COM900';


-- PASO 5 ----------------------------------------------------------------------
-- Carlos intenta modificar una compra ya completada.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 5: Modificacion protegida ===');

    UPDATE Compra
    SET total = 999999
    WHERE id = 'COM900';

    COMMIT;
END;
/

-- → FALLA:
-- ORA-20060 No se puede modificar la compra porque no está en estado PENDIENTE


-- Verificación paso 5
SELECT id, total, estado
FROM Compra
WHERE id = 'COM900';


-- PASO 6 ----------------------------------------------------------------------
-- Carlos intenta eliminar la compra completada.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 6: Eliminacion protegida ===');

    DELETE FROM Compra
    WHERE id = 'COM900';

    COMMIT;
END;
/

-- → FALLA:
-- ORA-20061 No se puede eliminar la compra porque no está en estado PENDIENTE


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