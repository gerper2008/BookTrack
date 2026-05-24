--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- PARTE IV: PRUEBA DE ACEPTACIÓN ----------------------------------------------
--------------------------------------------------------------------------------
--
-- Historia: "Sofia gestiona una multa y registra su cobro"
--
--------------------------------------------------------------------------------

-- LIMPIEZA PREVIA
DELETE FROM Pago       WHERE id           = 'PG900';
DELETE FROM Multa      WHERE id           = 'MT900';
DELETE FROM Devolucion WHERE id           = 'DV900';
DELETE FROM Prestamo   WHERE id           = 'PR900';
COMMIT;

-- DATOS DE APOYO ----------------------------------------------------------
-- Préstamo y devolución base necesarios para el escenario.
-- Se insertan con IDs fijos para que el caso sea idempotente.

INSERT INTO Prestamo(id, idCliente, idEjemplar, idBibliotecario, fechaPrestamo, diasRetraso)
VALUES ('PR900', 'USR001', 'EJM002', 'USR002', DATE '2026-01-05', 5);

INSERT INTO Devolucion(id, idPrestamo, fechaEstimada, observaciones, estadoEntrega)
VALUES ('DV900', 'PR900', DATE '2026-02-20', 'Paginas con humedad', 0);

COMMIT;


-- PASO 1 ----------------------------------------------------------------------
-- Sofia verifica que el trigger generó automáticamente la multa por retraso.
-- TRG_Multa_RetrasoAuto: estadoEntrega=0 y diasRetraso=5 → monto = 5 * 3000 = 15000
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 1: Verificacion multa autogenerada por retraso ===');
END;
/

-- Verificación paso 1
SELECT m.id, m.montoAcumulado, m.motivo, m.estado, c.estado AS estado_cliente
FROM   Multa  m
JOIN   Cliente c ON c.idUsuario = m.idCliente
WHERE  m.idDevolucion = 'DV900';


-- PASO 2 ----------------------------------------------------------------------
-- Sofia registra manualmente una segunda multa por daño físico sobre la misma devolución.
-- Debe fallar: la restricción UQ_Multa_Devolucion permite solo una multa por devolución.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 2: Segunda multa sobre la misma devolucion ===');

    BEGIN
        INSERT INTO Multa(id, idDevolucion, idCliente, montoAcumulado, motivo, estado)
        VALUES ('MT900', 'DV900', 'USR001', 30000, 'Daño', 'Pendiente');

        COMMIT;

        -- Si llegó aquí, no falló como debía
        RAISE_APPLICATION_ERROR(-20960, 'FALLO ESPERADO NO OCURRIO en PASO 2 (debia bloquear multa duplicada por devolucion).');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE IN (-1, -20960) THEN
                DBMS_OUTPUT.PUT_LINE('Resultado PASO 2: ' || SQLERRM);
            ELSE
                RAISE;
            END IF;
    END;
END;
/

-- → FALLA ESPERADA:
-- ORA-00001 (unique constraint UQ_Multa_Devolucion) o ORA-20960 (falla forzada)

-- Verificación paso 2
SELECT COUNT(*) AS total_multas
FROM   Multa
WHERE  idDevolucion = 'DV900';


-- PASO 3 ----------------------------------------------------------------------
-- Sofia intenta modificar el monto de la multa con un motivo inválido.
-- Debe fallar por CHECK_Multa_motivo.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 3: Modificacion con motivo invalido ===');

    BEGIN
        UPDATE Multa
        SET    motivo = 'Vandalismo'
        WHERE  idDevolucion = 'DV900';

        COMMIT;

        -- Si llegó aquí, no falló como debía
        RAISE_APPLICATION_ERROR(-20961, 'FALLO ESPERADO NO OCURRIO en PASO 3 (debia bloquear motivo invalido).');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE IN (-2290, -20961) THEN
                DBMS_OUTPUT.PUT_LINE('Resultado PASO 3: ' || SQLERRM);
            ELSE
                RAISE;
            END IF;
    END;
END;
/

-- → FALLA ESPERADA:
-- ORA-02290 (CHECK_Multa_motivo) o ORA-20961 (falla forzada de aceptación)

-- Verificación paso 3
SELECT id, motivo, montoAcumulado
FROM   Multa
WHERE  idDevolucion = 'DV900';


-- PASO 4 ----------------------------------------------------------------------
-- Sofia registra el pago de la multa pendiente.
-- TRG_Multa_PagadaEstado: cambia estado de Multa a 'Pagada' y descuenta saldo del Cliente.
-- TRG_Cliente_EstadoMoroso: si no quedan multas pendientes, reactiva al Cliente a 'Activo'.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 4: Registro de pago de la multa ===');

    INSERT INTO Pago(
        id,
        idCliente,
        idMulta,
        estado,
        fechaPago,
        metodoPago
    )
    VALUES (
        'PG900',
        'USR001',
        (SELECT id FROM Multa WHERE idDevolucion = 'DV900'),
        'Completado',
        DATE '2026-03-01',
        'Efectivo'
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Pago registrado');
END;
/

-- Verificación paso 4
-- Multa debe estar en estado 'Pagada'; Cliente debe haber vuelto a 'Activo'
SELECT p.id, p.estado AS estado_pago, p.metodoPago, p.fechaPago
FROM   Pago p
WHERE  p.id = 'PG900';

SELECT m.id, m.estado AS estado_multa
FROM   Multa m
WHERE  m.idDevolucion = 'DV900';

SELECT idUsuario, estado AS estado_cliente
FROM   Cliente
WHERE  idUsuario = 'USR001';


-- PASO 5 ----------------------------------------------------------------------
-- Sofia intenta registrar un pago con metodoPago = 'Transferencia' en estado 'Rechazado'.
-- Debe fallar por CHECK_Pago_RechazoMetodo.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 5: Pago invalido Transferencia + Rechazado ===');

    BEGIN
        INSERT INTO Pago(id, idCliente, idMulta, estado, fechaPago, metodoPago)
        VALUES (
            'PG901',
            'USR001',
            (SELECT id FROM Multa WHERE idDevolucion = 'DV900'),
            'Rechazado',
            DATE '2026-03-02',
            'Transferencia'
        );

        COMMIT;

        -- Si llegó aquí, no falló como debía
        RAISE_APPLICATION_ERROR(-20962, 'FALLO ESPERADO NO OCURRIO en PASO 5 (debia bloquear Transferencia+Rechazado).');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE IN (-2290, -20962) THEN
                DBMS_OUTPUT.PUT_LINE('Resultado PASO 5: ' || SQLERRM);
            ELSE
                RAISE;
            END IF;
    END;
END;
/

-- → FALLA ESPERADA:
-- ORA-02290 (CHECK_Pago_RechazoMetodo) o ORA-20962 (falla forzada de aceptación)

-- Verificación paso 5
SELECT COUNT(*) AS pagos_rechazados_transferencia
FROM   Pago
WHERE  estado = 'Rechazado' AND metodoPago = 'Transferencia';


-- PASO 6 ----------------------------------------------------------------------
-- Sofia intenta eliminar el pago ya completado.
-- Debe fallar: un pago 'Completado' no puede eliminarse sin revertir efectos.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 6: Eliminacion protegida de pago completado ===');

    BEGIN
        DELETE FROM Pago WHERE id = 'PG900';
        COMMIT;

        -- Si llegó aquí, no falló como debía
        RAISE_APPLICATION_ERROR(-20963, 'FALLO ESPERADO NO OCURRIO en PASO 6 (debia bloquear eliminacion de pago completado).');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE IN (-20233, -20963) THEN
                DBMS_OUTPUT.PUT_LINE('Resultado PASO 6: ' || SQLERRM);
            ELSE
                RAISE;
            END IF;
    END;
END;
/

-- → FALLA ESPERADA:
-- ORA-20233 (paquete ELI_PAGO) o ORA-20963 (falla forzada de aceptación)

-- Verificación paso 6
SELECT id, estado
FROM   Pago
WHERE  id = 'PG900';


-- PASO 7 ----------------------------------------------------------------------
-- Sofia consulta el resumen completo del ciclo de cobro.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 7: Consulta final ciclo multa-pago ===');
END;
/

-- Verificación paso 7
SELECT
    pr.id             AS prestamo,
    pr.diasRetraso,
    dv.id             AS devolucion,
    dv.estadoEntrega,
    mt.id             AS multa,
    mt.montoAcumulado,
    mt.motivo,
    mt.estado         AS estado_multa,
    pg.id             AS pago,
    pg.metodoPago,
    pg.estado         AS estado_pago,
    cl.estado         AS estado_cliente
FROM  Prestamo  pr
JOIN  Devolucion dv ON dv.idPrestamo   = pr.id
JOIN  Multa      mt ON mt.idDevolucion = dv.id
JOIN  Pago       pg ON pg.idMulta      = mt.id
JOIN  Cliente    cl ON cl.idUsuario    = pr.idCliente
WHERE pr.id = 'PR900';
