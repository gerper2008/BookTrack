--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- PARTE IV: PRUEBA DE ACEPTACIÓN ----------------------------------------------
--------------------------------------------------------------------------------
--
-- Historia: "Marco registra el préstamo y devolución de un libro"
--
--------------------------------------------------------------------------------

-- LIMPIEZA PREVIA
DELETE FROM Pago       WHERE id      = 'PG900';
DELETE FROM Multa      WHERE id      = 'MT900';
DELETE FROM Devolucion WHERE id      = 'DV900';
DELETE FROM Prestamo   WHERE id      = 'PR900';
COMMIT;

-- PASO 1 ----------------------------------------------------------------------
-- Marco registra un nuevo préstamo para un cliente activo con ejemplar disponible.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 1: Registro prestamo ===');

    INSERT INTO Prestamo(
        id,
        idCliente,
        idEjemplar,
        idBibliotecario,
        fechaPrestamo,
        diasRetraso
    )
    VALUES (
        'PR900',
        'USR001',
        'EJM001',
        'USR002',
        DATE '2026-01-10',
        0
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Prestamo registrado');
END;
/

-- Verificación paso 1
-- El trigger TRG_Prestamo_EjemplarOcupar debe haber marcado disponibilidad = 0
SELECT p.id, p.fechaPrestamo, p.diasRetraso, e.disponibilidad
FROM   Prestamo p
JOIN   Ejemplar e ON e.id = p.idEjemplar
WHERE  p.id = 'PR900';


-- PASO 2 ----------------------------------------------------------------------
-- Marco intenta registrar un segundo préstamo sobre el mismo ejemplar ya ocupado.
-- Debe fallar por disponibilidad = 0.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 2: Prestamo sobre ejemplar no disponible ===');

    BEGIN
        INSERT INTO Prestamo(
            id,
            idCliente,
            idEjemplar,
            idBibliotecario,
            fechaPrestamo,
            diasRetraso
        )
        VALUES (
            'PR901',
            'USR003',
            'EJM001',
            'USR002',
            DATE '2026-01-11',
            0
        );

        COMMIT;

        -- Si llegó aquí, no falló como debía
        RAISE_APPLICATION_ERROR(-20950, 'FALLO ESPERADO NO OCURRIO en PASO 2 (debia bloquear prestamo sobre ejemplar no disponible).');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE IN (-20201, -20950) THEN
                DBMS_OUTPUT.PUT_LINE('Resultado PASO 2: ' || SQLERRM);
            ELSE
                RAISE;
            END IF;
    END;
END;
/

-- → FALLA ESPERADA:
-- ORA-20201 (paquete) o ORA-20950 (falla forzada de aceptación)

-- Verificación paso 2
SELECT id, disponibilidad
FROM   Ejemplar
WHERE  id = 'EJM001';


-- PASO 3 ----------------------------------------------------------------------
-- Marco actualiza los días de retraso del préstamo (ajuste administrativo).
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 3: Actualizacion dias de retraso ===');

    UPDATE Prestamo
    SET    diasRetraso = 3
    WHERE  id = 'PR900';

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Dias de retraso actualizados');
END;
/

-- Verificación paso 3
SELECT id, fechaPrestamo, diasRetraso
FROM   Prestamo
WHERE  id = 'PR900';


-- PASO 4 ----------------------------------------------------------------------
-- Marco registra la devolución del libro con entrega en mal estado (estadoEntrega = 0).
-- Al tener diasRetraso = 3, el trigger TRG_Multa_RetrasoAuto genera una multa automática.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 4: Registro devolucion con retraso ===');

    INSERT INTO Devolucion(
        id,
        idPrestamo,
        fechaEstimada,
        observaciones,
        estadoEntrega
    )
    VALUES (
        'DV900',
        'PR900',
        DATE '2026-02-15',
        'Portada con rayones leves',
        0
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Devolucion registrada');
END;
/

-- Verificación paso 4
-- TRG_Multa_RetrasoAuto debe haber generado una multa con monto = 3 * 3000 = 9000
-- TRG_Cliente_EstadoMoroso debe haber puesto al cliente en estado Moroso
SELECT d.id, d.fechaEstimada, d.estadoEntrega
FROM   Devolucion d
WHERE  d.id = 'DV900';

SELECT m.id, m.montoAcumulado, m.motivo, m.estado
FROM   Multa m
WHERE  m.idDevolucion = 'DV900';

SELECT idUsuario, estado
FROM   Cliente
WHERE  idUsuario = 'USR001';


-- PASO 5 ----------------------------------------------------------------------
-- Marco intenta registrar una segunda devolución sobre el mismo préstamo.
-- Debe fallar por la restricción única UQ_Devolucion_Prestamo.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 5: Devolucion duplicada sobre el mismo prestamo ===');

    BEGIN
        INSERT INTO Devolucion(
            id,
            idPrestamo,
            fechaEstimada,
            observaciones,
            estadoEntrega
        )
        VALUES (
            'DV901',
            'PR900',
            DATE '2026-03-01',
            'Intento duplicado',
            1
        );

        COMMIT;

        -- Si llegó aquí, no falló como debía
        RAISE_APPLICATION_ERROR(-20951, 'FALLO ESPERADO NO OCURRIO en PASO 5 (debia bloquear devolucion duplicada).');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE IN (-1, -20951) THEN
                DBMS_OUTPUT.PUT_LINE('Resultado PASO 5: ' || SQLERRM);
            ELSE
                RAISE;
            END IF;
    END;
END;
/

-- → FALLA ESPERADA:
-- ORA-00001 (unique constraint UQ_Devolucion_Prestamo) o ORA-20951 (falla forzada)

-- Verificación paso 5
SELECT COUNT(*) AS total_devoluciones
FROM   Devolucion
WHERE  idPrestamo = 'PR900';


-- PASO 6 ----------------------------------------------------------------------
-- Marco consulta el estado completo del préstamo: devolucion, multa y cliente.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 6: Consulta estado prestamo ===');
END;
/

-- Verificación paso 6
SELECT
    p.id              AS prestamo,
    p.fechaPrestamo,
    p.diasRetraso,
    d.id              AS devolucion,
    d.fechaEstimada,
    d.estadoEntrega,
    m.id              AS multa,
    m.montoAcumulado,
    m.motivo,
    m.estado          AS estado_multa,
    c.estado          AS estado_cliente
FROM  Prestamo  p
JOIN  Devolucion d ON d.idPrestamo   = p.id
JOIN  Multa      m ON m.idDevolucion = d.id
JOIN  Cliente    c ON c.idUsuario    = p.idCliente
WHERE p.id = 'PR900';


-- PASO 7 ----------------------------------------------------------------------
-- Marco intenta eliminar la devolución que ya tiene una multa pagada asociada.
-- Debe fallar para proteger la integridad del cobro.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 7: Eliminacion protegida de devolucion con multa pagada ===');

    -- Primero marcamos la multa como Pagada para preparar el escenario
    UPDATE Multa SET estado = 'Pagada' WHERE idDevolucion = 'DV900';
    COMMIT;

    BEGIN
        DELETE FROM Devolucion WHERE id = 'DV900';
        COMMIT;

        -- Si llegó aquí, no falló como debía
        RAISE_APPLICATION_ERROR(-20952, 'FALLO ESPERADO NO OCURRIO en PASO 7 (debia bloquear eliminacion con multa pagada).');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE IN (-20213, -20952) THEN
                DBMS_OUTPUT.PUT_LINE('Resultado PASO 7: ' || SQLERRM);
            ELSE
                RAISE;
            END IF;
    END;
END;
/

-- → FALLA ESPERADA:
-- ORA-20213 (paquete ELI_DEVOLUCION) o ORA-20952 (falla forzada de aceptación)

-- Verificación paso 7
SELECT id, estado
FROM   Multa
WHERE  idDevolucion = 'DV900';
