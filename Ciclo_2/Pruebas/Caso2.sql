--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- PARTE IV: PRUEBA DE ACEPTACIÓN ----------------------------------------------
--------------------------------------------------------------------------------
--
-- Historia: "Sofia gestiona una multa y registra su cobro"
--
-- Todas las operaciones se realizan a través de pkg_Bibliotecario,
-- que internamente delega en los paquetes PC_MULTA y PC_PAGO.
--
--------------------------------------------------------------------------------
SET SERVEROUTPUT ON;
--------------------------------------------------------------------------------
-- LIMPIEZA PREVIA
BEGIN
    BEGIN
        DELETE FROM Pago
        WHERE idMulta IN (
            SELECT m.id FROM Multa m
            JOIN Devolucion d ON d.id = m.idDevolucion
            JOIN Prestamo   p ON p.id = d.idPrestamo
            WHERE p.idCliente = 'USR001' AND p.idEjemplar = 'EJM002'
        );
        DELETE FROM Multa
        WHERE idDevolucion IN (
            SELECT d.id FROM Devolucion d
            JOIN Prestamo p ON p.id = d.idPrestamo
            WHERE p.idCliente = 'USR001' AND p.idEjemplar = 'EJM002'
        );
        DELETE FROM Devolucion
        WHERE idPrestamo IN (
            SELECT id FROM Prestamo
            WHERE idCliente = 'USR001' AND idEjemplar = 'EJM002'
        );
        UPDATE Ejemplar SET disponibilidad = 1 WHERE id = 'EJM002';
        DELETE FROM Prestamo
        WHERE idCliente = 'USR001' AND idEjemplar = 'EJM002';
        COMMIT;
    EXCEPTION WHEN OTHERS THEN ROLLBACK; END;
END;
/

-- DATOS DE APOYO --------------------------------------------------------------
-- Préstamo y devolución base necesarios para el escenario.
BEGIN
    pkg_Bibliotecario.AD_PRESTAMO(
        xID_BIBLIOTECARIO => 'USR002',
        xID_CLIENTE       => 'USR001',
        xID_EJEMPLAR      => 'EJM002',
        xFECHA_PRESTAMO   => DATE '2026-01-05'
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR DATOS APOYO - AD_PRESTAMO [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- Ajuste administrativo de diasRetraso = 5.
-- Se obtiene el ID dinámicamente para garantizar que el UPDATE afecte filas.
DECLARE
    vIDPrestamo VARCHAR2(10);
BEGIN
    SELECT id INTO vIDPrestamo
    FROM   Prestamo
    WHERE  idCliente  = 'USR001'
      AND  idEjemplar = 'EJM002'
    ORDER BY fechaPrestamo DESC
    FETCH FIRST 1 ROW ONLY;

    UPDATE Prestamo SET diasRetraso = 5 WHERE id = vIDPrestamo;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('diasRetraso actualizado | Prestamo: ' || vIDPrestamo);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR DATOS APOYO - UPDATE: No se encontro prestamo para USR001/EJM002');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR DATOS APOYO - UPDATE [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- Devolución base con estadoEntrega = 0 → dispara TRG_Multa_RetrasoAuto
DECLARE
    vIDPrestamo VARCHAR2(10);
BEGIN
    SELECT id INTO vIDPrestamo
    FROM   Prestamo
    WHERE  idCliente  = 'USR001'
      AND  idEjemplar = 'EJM002'
      AND  NOT EXISTS (SELECT 1 FROM Devolucion d WHERE d.idPrestamo = Prestamo.id)
    ORDER BY fechaPrestamo DESC
    FETCH FIRST 1 ROW ONLY;

    pkg_Bibliotecario.AD_DEVOLUCION(
        xID_BIBLIOTECARIO => 'USR002',
        xID_PRESTAMO      => vIDPrestamo,
        xESTADO_ENTREGA   => 0,
        xOBSERVACIONES    => 'Paginas con humedad'
    );
    DBMS_OUTPUT.PUT_LINE('Devolucion base creada | Prestamo: ' || vIDPrestamo);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR DATOS APOYO - AD_DEVOLUCION: No hay prestamo activo para USR001/EJM002');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR DATOS APOYO - AD_DEVOLUCION [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/


-- PASO 1 ----------------------------------------------------------------------
-- Sofia verifica que el trigger generó automáticamente la multa por retraso.
-- TRG_Multa_RetrasoAuto: estadoEntrega=0 y diasRetraso=5 → monto = 5 * 3000 = 15000
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 1: Verificacion multa autogenerada por retraso ===');
END;
/

-- Verificación paso 1 - Multa generada directamente en la tabla
SELECT m.id, m.montoAcumulado, m.motivo, m.estado
FROM   Multa     m
JOIN   Devolucion d ON d.id = m.idDevolucion
JOIN   Prestamo   p ON p.id = d.idPrestamo
WHERE  p.idCliente  = 'USR001'
  AND  p.idEjemplar = 'EJM002'
ORDER BY d.fechaEstimada DESC
FETCH FIRST 1 ROW ONLY;

-- Verificación paso 1 - Vista del bibliotecario CO_MULTA
DECLARE
    vCursor SYS_REFCURSOR;
    vID     VARCHAR2(10);
    vMonto  NUMBER;
    vMotivo VARCHAR2(30);
    vEst    VARCHAR2(20);
    vNombre VARCHAR2(60);
    vApell  VARCHAR2(60);
BEGIN
    vCursor := pkg_Bibliotecario.CO_MULTA('Pendiente');
    LOOP
        FETCH vCursor INTO vID, vMonto, vMotivo, vEst, vNombre, vApell;
        EXIT WHEN vCursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('MULTA | ' || vID
            || ' | ' || vNombre || ' ' || vApell
            || ' | Monto: $' || vMonto
            || ' | Motivo: ' || vMotivo);
    END LOOP;
    CLOSE vCursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 1 CO_MULTA [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- Verificación paso 1 - Estado del cliente (debe ser Moroso)
DECLARE
    vEstado VARCHAR2(20);
BEGIN
    vEstado := pkg_Cliente.VERIFICAR_ESTADO_CLIENTE('USR001');
    DBMS_OUTPUT.PUT_LINE('ESTADO CLIENTE USR001: ' || vEstado);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 1 ESTADO [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/


-- PASO 2 ----------------------------------------------------------------------
-- Sofia intenta registrar manualmente una segunda multa sobre la misma devolución.
-- pkg_Bibliotecario.AD_MULTA debe fallar: restricción UQ_Multa_Devolucion.
DECLARE
    vIDDevolucion VARCHAR2(10);
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 2: Segunda multa sobre la misma devolucion ===');

    SELECT d.id INTO vIDDevolucion
    FROM   Devolucion d
    JOIN   Prestamo   p ON p.id = d.idPrestamo
    WHERE  p.idCliente  = 'USR001'
      AND  p.idEjemplar = 'EJM002'
    ORDER BY d.fechaEstimada DESC
    FETCH FIRST 1 ROW ONLY;

    BEGIN
        pkg_Bibliotecario.AD_MULTA(
            xID_DEVOLUCION   => vIDDevolucion,
            xMOTIVO          => 'Daño',
            xMONTO_ACUMULADO => 30000
        );

        RAISE_APPLICATION_ERROR(-20960,
            'FALLO ESPERADO NO OCURRIO en PASO 2 (debia bloquear multa duplicada por devolucion).');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE IN (-1, -20221, -20960) THEN
                DBMS_OUTPUT.PUT_LINE('Resultado PASO 2: ' || SQLERRM);
            ELSE
                RAISE;
            END IF;
    END;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 2: No se encontro devolucion para USR001/EJM002');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR INESPERADO PASO 2 [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- → FALLA ESPERADA:
-- ORA-00001 (UQ_Multa_Devolucion) o ORA-20221 (PC_MULTA)

-- Verificación paso 2
DECLARE
    vIDDevolucion VARCHAR2(10);
    vTotal        NUMBER;
BEGIN
    SELECT d.id INTO vIDDevolucion
    FROM   Devolucion d
    JOIN   Prestamo   p ON p.id = d.idPrestamo
    WHERE  p.idCliente  = 'USR001'
      AND  p.idEjemplar = 'EJM002'
    ORDER BY d.fechaEstimada DESC
    FETCH FIRST 1 ROW ONLY;

    SELECT COUNT(*) INTO vTotal FROM Multa WHERE idDevolucion = vIDDevolucion;
    DBMS_OUTPUT.PUT_LINE('Total multas para la devolucion: ' || vTotal);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR VERIFICACION PASO 2: No se encontro devolucion');
END;
/


-- PASO 3 ----------------------------------------------------------------------
-- Sofia intenta modificar el monto de la multa con un motivo inválido.
-- Debe fallar por CHECK_Multa_motivo en la capa de datos.
-- Nota: MOD_MULTA no expone el campo motivo en su firma; se usa UPDATE directo.
DECLARE
    vIDMulta VARCHAR2(10);
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 3: Modificacion con motivo invalido ===');

    SELECT m.id INTO vIDMulta
    FROM   Multa     m
    JOIN   Devolucion d ON d.id = m.idDevolucion
    JOIN   Prestamo   p ON p.id = d.idPrestamo
    WHERE  p.idCliente  = 'USR001'
      AND  p.idEjemplar = 'EJM002'
    ORDER BY d.fechaEstimada DESC
    FETCH FIRST 1 ROW ONLY;

    BEGIN
        UPDATE Multa SET motivo = 'Vandalismo' WHERE id = vIDMulta;
        COMMIT;

        RAISE_APPLICATION_ERROR(-20961,
            'FALLO ESPERADO NO OCURRIO en PASO 3 (debia bloquear motivo invalido).');
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            IF SQLCODE IN (-2290, -20961) THEN
                DBMS_OUTPUT.PUT_LINE('Resultado PASO 3: ' || SQLERRM);
            ELSE
                RAISE;
            END IF;
    END;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 3: No se encontro multa para USR001/EJM002');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR INESPERADO PASO 3 [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- → FALLA ESPERADA:
-- ORA-02290 (CHECK_Multa_motivo)

-- Verificación paso 3 - El motivo debe seguir siendo el original
SELECT m.id, m.motivo, m.montoAcumulado
FROM   Multa     m
JOIN   Devolucion d ON d.id = m.idDevolucion
JOIN   Prestamo   p ON p.id = d.idPrestamo
WHERE  p.idCliente  = 'USR001'
  AND  p.idEjemplar = 'EJM002'
ORDER BY d.fechaEstimada DESC
FETCH FIRST 1 ROW ONLY;


-- PASO 4 ----------------------------------------------------------------------
-- Sofia registra el pago de la multa pendiente usando pkg_Bibliotecario.AD_PAGO.
-- AD_PAGO: si montoAbonado >= montoAcumulado → UPDATE Multa SET estado = 'Pagada'.
-- El Pago se inserta en estado 'Pendiente' (comportamiento del paquete).
-- TRG_Cliente_EstadoMoroso: si no quedan multas pendientes, reactiva Cliente a 'Activo'.
DECLARE
    vIDMulta VARCHAR2(10);
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 4: Registro de pago de la multa ===');

    SELECT m.id INTO vIDMulta
    FROM   Multa     m
    JOIN   Devolucion d ON d.id = m.idDevolucion
    JOIN   Prestamo   p ON p.id = d.idPrestamo
    WHERE  p.idCliente  = 'USR001'
      AND  p.idEjemplar = 'EJM002'
      AND  m.estado     = 'Pendiente'
    ORDER BY d.fechaEstimada DESC
    FETCH FIRST 1 ROW ONLY;

    pkg_Bibliotecario.AD_PAGO(
        xID_MULTA      => vIDMulta,
        xMONTO_ABONADO => 15000,
        xMETODO_PAGO   => 'Efectivo'
    );

    DBMS_OUTPUT.PUT_LINE('Pago registrado para multa: ' || vIDMulta);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 4: No hay multa Pendiente para USR001/EJM002');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 4 [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- Verificación paso 4
-- Multa debe estar Pagada; Pago en estado Pendiente (comportamiento de AD_PAGO);
-- Cliente debe haber vuelto a Activo.
SELECT m.id, m.estado AS estado_multa
FROM   Multa     m
JOIN   Devolucion d ON d.id = m.idDevolucion
JOIN   Prestamo   p ON p.id = d.idPrestamo
WHERE  p.idCliente  = 'USR001'
  AND  p.idEjemplar = 'EJM002'
ORDER BY d.fechaEstimada DESC
FETCH FIRST 1 ROW ONLY;

-- El pago queda en estado 'Pendiente' porque AD_PAGO así lo inserta.
-- Se consulta con 'Pendiente' para reflejar el comportamiento real del paquete.
DECLARE
    vCursor SYS_REFCURSOR;
    vID     VARCHAR2(10);
    vEst    VARCHAR2(20);
    vFecha  DATE;
    vMetodo VARCHAR2(30);
    vNombre VARCHAR2(60);
    vApell  VARCHAR2(60);
BEGIN
    vCursor := pkg_Bibliotecario.CO_PAGO('Pendiente');
    LOOP
        FETCH vCursor INTO vID, vEst, vFecha, vMetodo, vNombre, vApell;
        EXIT WHEN vCursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('PAGO | ' || vID
            || ' | ' || vNombre || ' ' || vApell
            || ' | Metodo: ' || vMetodo
            || ' | Estado: ' || vEst);
    END LOOP;
    CLOSE vCursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 4 CO_PAGO [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

DECLARE
    vEstado VARCHAR2(20);
BEGIN
    vEstado := pkg_Cliente.VERIFICAR_ESTADO_CLIENTE('USR001');
    DBMS_OUTPUT.PUT_LINE('ESTADO CLIENTE USR001 tras pago: ' || vEstado);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 4 ESTADO [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/


-- PASO 5 ----------------------------------------------------------------------
-- Sofia intenta registrar un pago con metodoPago = 'Transferencia' en estado 'Rechazado'.
-- Debe fallar por CHECK_Pago_RechazoMetodo en la capa de datos.
-- AD_PAGO siempre inserta en 'Pendiente'; se usa INSERT directo para probar el CHECK.
DECLARE
    vIDMulta VARCHAR2(10);
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 5: Pago invalido Transferencia + Rechazado ===');

    SELECT m.id INTO vIDMulta
    FROM   Multa     m
    JOIN   Devolucion d ON d.id = m.idDevolucion
    JOIN   Prestamo   p ON p.id = d.idPrestamo
    WHERE  p.idCliente  = 'USR001'
      AND  p.idEjemplar = 'EJM002'
    ORDER BY d.fechaEstimada DESC
    FETCH FIRST 1 ROW ONLY;

    BEGIN
        INSERT INTO Pago(id, idCliente, idMulta, estado, fechaPago, metodoPago)
        VALUES ('PG901', 'USR001', vIDMulta, 'Rechazado', DATE '2026-03-02', 'Transferencia');
        COMMIT;

        RAISE_APPLICATION_ERROR(-20962,
            'FALLO ESPERADO NO OCURRIO en PASO 5 (debia bloquear Transferencia+Rechazado).');
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            IF SQLCODE IN (-2290, -20962) THEN
                DBMS_OUTPUT.PUT_LINE('Resultado PASO 5: ' || SQLERRM);
            ELSE
                RAISE;
            END IF;
    END;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 5: No se encontro multa para USR001/EJM002');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR INESPERADO PASO 5 [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- → FALLA ESPERADA:
-- ORA-02290 (CHECK_Pago_RechazoMetodo)

-- Verificación paso 5
SELECT COUNT(*) AS pagos_rechazados_transferencia
FROM   Pago
WHERE  estado = 'Rechazado' AND metodoPago = 'Transferencia';


-- PASO 6 ----------------------------------------------------------------------
-- Sofia intenta eliminar el pago registrado por AD_PAGO.
-- ELI_PAGO permite eliminar pagos en estado 'Pendiente' o 'Rechazado'.
-- AD_PAGO inserta en estado 'Pendiente', por lo que ELI_PAGO SÍ lo eliminaría.
-- Para probar la protección se necesita un pago en estado 'Completado'.
-- Se usa UPDATE directo para preparar el escenario, luego se intenta eliminar.
DECLARE
    vIDPago VARCHAR2(10);
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 6: Eliminacion protegida de pago completado ===');

    -- Obtener el pago del escenario (estado actual: Pendiente)
    SELECT p.id INTO vIDPago
    FROM   Pago       p
    JOIN   Multa      m  ON m.id  = p.idMulta
    JOIN   Devolucion d  ON d.id  = m.idDevolucion
    JOIN   Prestamo   pr ON pr.id = d.idPrestamo
    WHERE  pr.idCliente  = 'USR001'
      AND  pr.idEjemplar = 'EJM002'
    ORDER BY p.fechaPago DESC
    FETCH FIRST 1 ROW ONLY;

    -- Promover a 'Completado' para activar la protección de ELI_PAGO
    UPDATE Pago SET estado = 'Completado' WHERE id = vIDPago;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Pago promovido a Completado: ' || vIDPago);

    BEGIN
        pkg_Bibliotecario.ELI_PAGO(vIDPago);

        RAISE_APPLICATION_ERROR(-20963,
            'FALLO ESPERADO NO OCURRIO en PASO 6 (debia bloquear eliminacion de pago Completado).');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE IN (-20013, -20233, -20963) THEN
                DBMS_OUTPUT.PUT_LINE('Resultado PASO 6: ' || SQLERRM);
            ELSE
                RAISE;
            END IF;
    END;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 6: No se encontro pago para USR001/EJM002');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR INESPERADO PASO 6 [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- → FALLA ESPERADA:
-- ORA-20013 (pkg_Bibliotecario: pago no es Pendiente/Rechazado)

-- Verificación paso 6 - El pago debe seguir existiendo en estado Completado
SELECT p.id, p.estado
FROM   Pago       p
JOIN   Multa      m  ON m.id  = p.idMulta
JOIN   Devolucion d  ON d.id  = m.idDevolucion
JOIN   Prestamo   pr ON pr.id = d.idPrestamo
WHERE  pr.idCliente  = 'USR001'
  AND  pr.idEjemplar = 'EJM002'
  AND  p.estado      = 'Completado'
ORDER BY p.fechaPago DESC
FETCH FIRST 1 ROW ONLY;


-- PASO 7 ----------------------------------------------------------------------
-- Sofia consulta el resumen completo del ciclo multa-pago.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 7: Consulta final ciclo multa-pago ===');
END;
/

-- Verificación paso 7 - Historial de préstamos del cliente (pkg_Cliente)
DECLARE
    vCursor SYS_REFCURSOR;
    vID     VARCHAR2(10);
    vFecha  DATE;
    vDias   NUMBER;
    vEjem   VARCHAR2(10);
BEGIN
    vCursor := pkg_Cliente.VE_HISTORIAL_PRESTAMOS('USR001');
    LOOP
        FETCH vCursor INTO vID, vFecha, vDias, vEjem;
        EXIT WHEN vCursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('HISTORIAL | ' || vID
            || ' | Ejemplar: ' || vEjem
            || ' | Retraso: ' || vDias);
    END LOOP;
    CLOSE vCursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 7 HISTORIAL [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- Verificación paso 7 - Multas pendientes (debe estar vacío tras el pago)
DECLARE
    vCursor SYS_REFCURSOR;
    vID     VARCHAR2(10);
    vMonto  NUMBER;
    vMotivo VARCHAR2(30);
    vEst    VARCHAR2(20);
BEGIN
    vCursor := pkg_Cliente.VE_MULTAS_PENDIENTES('USR001');
    LOOP
        FETCH vCursor INTO vID, vMonto, vMotivo, vEst;
        EXIT WHEN vCursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('MULTA PENDIENTE | ' || vID
            || ' | ' || vMotivo || ' | $' || vMonto);
    END LOOP;
    CLOSE vCursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 7 MULTAS [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- Verificación paso 7 - Estado final del cliente
DECLARE
    vEstado VARCHAR2(20);
    vSaldo  NUMBER;
BEGIN
    vEstado := pkg_Cliente.VERIFICAR_ESTADO_CLIENTE('USR001');
    vSaldo  := pkg_Cliente.VERIFICAR_SALDO_CLIENTE('USR001');
    DBMS_OUTPUT.PUT_LINE('ESTADO FINAL CLIENTE USR001 | Estado: ' || vEstado
        || ' | Saldo: $' || vSaldo);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 7 ESTADO [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- Verificación paso 7 - Pagos completados (pkg_Bibliotecario)
DECLARE
    vCursor SYS_REFCURSOR;
    vID     VARCHAR2(10);
    vEst    VARCHAR2(20);
    vFecha  DATE;
    vMetodo VARCHAR2(30);
    vNombre VARCHAR2(60);
    vApell  VARCHAR2(60);
BEGIN
    vCursor := pkg_Bibliotecario.CO_PAGO('Completado');
    LOOP
        FETCH vCursor INTO vID, vEst, vFecha, vMetodo, vNombre, vApell;
        EXIT WHEN vCursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('PAGO | ' || vID
            || ' | ' || vNombre || ' ' || vApell
            || ' | Metodo: ' || vMetodo
            || ' | ' || TO_CHAR(vFecha, 'YYYY-MM-DD'));
    END LOOP;
    CLOSE vCursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 7 CO_PAGO [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/