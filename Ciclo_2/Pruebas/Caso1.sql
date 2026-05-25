--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- PARTE IV: PRUEBA DE ACEPTACIÓN ----------------------------------------------
--------------------------------------------------------------------------------
--
-- Historia: "Marco registra el préstamo y devolución de un libro"
--
-- Todas las operaciones se realizan a través de pkg_Bibliotecario,
-- que internamente delega en los paquetes PC_PRESTAMO y PC_DEVOLUCION.
--
--------------------------------------------------------------------------------

-- LIMPIEZA PREVIA
BEGIN
    BEGIN
        DELETE FROM Pago
        WHERE idMulta IN (
            SELECT m.id FROM Multa m
            JOIN Devolucion d ON d.id = m.idDevolucion
            JOIN Prestamo   p ON p.id = d.idPrestamo
            WHERE p.idCliente IN ('USR001','USR003')
        );
        DELETE FROM Multa
        WHERE idDevolucion IN (
            SELECT d.id FROM Devolucion d
            JOIN Prestamo p ON p.id = d.idPrestamo
            WHERE p.idCliente IN ('USR001','USR003')
        );
        DELETE FROM Devolucion
        WHERE idPrestamo IN (
            SELECT id FROM Prestamo WHERE idCliente IN ('USR001','USR003')
        );
        -- Liberar ejemplares antes de borrar préstamos
        UPDATE Ejemplar SET disponibilidad = 1
        WHERE id IN (
            SELECT idEjemplar FROM Prestamo WHERE idCliente IN ('USR001','USR003')
        );
        DELETE FROM Prestamo WHERE idCliente IN ('USR001','USR003');
        COMMIT;
    EXCEPTION WHEN OTHERS THEN ROLLBACK; END;
END;
/


-- PASO 1 ----------------------------------------------------------------------
-- Marco registra un nuevo préstamo para un cliente activo con ejemplar disponible.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 1: Registro prestamo ===');

    pkg_Bibliotecario.AD_PRESTAMO(
        xID_BIBLIOTECARIO => 'USR002',
        xID_CLIENTE       => 'USR001',
        xID_EJEMPLAR      => 'EJM001',
        xFECHA_PRESTAMO   => DATE '2026-01-10'
    );

    DBMS_OUTPUT.PUT_LINE('Prestamo registrado');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 1 [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- Verificación paso 1
-- TRG_Prestamo_EjemplarOcupar debe haber marcado disponibilidad = 0.
SELECT p.id, p.fechaPrestamo, p.diasRetraso, e.disponibilidad
FROM   Prestamo p
JOIN   Ejemplar e ON e.id = p.idEjemplar
WHERE  p.idCliente  = 'USR001'
  AND  p.idEjemplar = 'EJM001'
ORDER BY p.fechaPrestamo DESC
FETCH FIRST 1 ROW ONLY;


-- PASO 2 ----------------------------------------------------------------------
-- Marco intenta registrar un segundo préstamo sobre el mismo ejemplar ya ocupado.
-- pkg_Bibliotecario.AD_PRESTAMO debe fallar: ejemplar con disponibilidad = 0.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 2: Prestamo sobre ejemplar no disponible ===');

    BEGIN
        pkg_Bibliotecario.AD_PRESTAMO(
            xID_BIBLIOTECARIO => 'USR002',
            xID_CLIENTE       => 'USR003',
            xID_EJEMPLAR      => 'EJM001',
            xFECHA_PRESTAMO   => DATE '2026-01-11'
        );

        RAISE_APPLICATION_ERROR(-20950,
            'FALLO ESPERADO NO OCURRIO en PASO 2 (debia bloquear prestamo sobre ejemplar no disponible).');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE IN (-20004, -20201, -20950) THEN
                DBMS_OUTPUT.PUT_LINE('Resultado PASO 2: ' || SQLERRM);
            ELSE
                RAISE;
            END IF;
    END;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR INESPERADO PASO 2 [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- → FALLA ESPERADA:
-- ORA-20004 (pkg_Bibliotecario: ejemplar no disponible)

-- Verificación paso 2
SELECT id, disponibilidad FROM Ejemplar WHERE id = 'EJM001';


-- PASO 3 ----------------------------------------------------------------------
-- Marco actualiza los días de retraso del préstamo (ajuste administrativo).
-- Se usa UPDATE directo porque MOD_PRESTAMO solo expone fechaPrestamo.
DECLARE
    vIDPrestamo VARCHAR2(10);
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 3: Actualizacion dias de retraso ===');

    -- Obtener el ID dinámicamente para evitar el 0 rows del UPDATE anterior
    SELECT id INTO vIDPrestamo
    FROM   Prestamo
    WHERE  idCliente  = 'USR001'
      AND  idEjemplar = 'EJM001'
    ORDER BY fechaPrestamo DESC
    FETCH FIRST 1 ROW ONLY;

    UPDATE Prestamo
    SET    diasRetraso = 3
    WHERE  id = vIDPrestamo;
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Dias de retraso actualizados | Prestamo: ' || vIDPrestamo);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 3: No se encontro prestamo activo para USR001/EJM001');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 3 [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- Verificación paso 3
SELECT id, fechaPrestamo, diasRetraso
FROM   Prestamo
WHERE  idCliente  = 'USR001'
  AND  idEjemplar = 'EJM001'
ORDER BY fechaPrestamo DESC
FETCH FIRST 1 ROW ONLY;


-- PASO 4 ----------------------------------------------------------------------
-- Marco registra la devolución con entrega en mal estado (estadoEntrega = 0).
-- Al tener diasRetraso = 3, TRG_Multa_RetrasoAuto genera multa automática.
DECLARE
    vIDPrestamo VARCHAR2(10);
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 4: Registro devolucion con retraso ===');

    SELECT id INTO vIDPrestamo
    FROM   Prestamo
    WHERE  idCliente  = 'USR001'
      AND  idEjemplar = 'EJM001'
      AND  NOT EXISTS (SELECT 1 FROM Devolucion d WHERE d.idPrestamo = Prestamo.id)
    ORDER BY fechaPrestamo DESC
    FETCH FIRST 1 ROW ONLY;

    pkg_Bibliotecario.AD_DEVOLUCION(
        xID_BIBLIOTECARIO => 'USR002',
        xID_PRESTAMO      => vIDPrestamo,
        xESTADO_ENTREGA   => 0,
        xOBSERVACIONES    => 'Portada con rayones leves'
    );

    DBMS_OUTPUT.PUT_LINE('Devolucion registrada para prestamo: ' || vIDPrestamo);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 4: No hay prestamo activo para USR001/EJM001');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 4 [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- Verificación paso 4
-- TRG_Multa_RetrasoAuto: monto = 3 * 3000 = 9000
-- TRG_Cliente_EstadoMoroso: cliente pasa a Moroso
SELECT d.id, d.fechaEstimada, d.estadoEntrega
FROM   Devolucion d
JOIN   Prestamo   p ON p.id = d.idPrestamo
WHERE  p.idCliente  = 'USR001'
  AND  p.idEjemplar = 'EJM001'
ORDER BY d.fechaEstimada DESC
FETCH FIRST 1 ROW ONLY;

SELECT m.id, m.montoAcumulado, m.motivo, m.estado
FROM   Multa     m
JOIN   Devolucion d ON d.id = m.idDevolucion
JOIN   Prestamo   p ON p.id = d.idPrestamo
WHERE  p.idCliente  = 'USR001'
  AND  p.idEjemplar = 'EJM001'
ORDER BY d.fechaEstimada DESC
FETCH FIRST 1 ROW ONLY;

SELECT idUsuario, estado FROM Cliente WHERE idUsuario = 'USR001';


-- PASO 5 ----------------------------------------------------------------------
-- Marco intenta registrar una segunda devolución sobre el mismo préstamo.
-- pkg_Bibliotecario.AD_DEVOLUCION debe fallar: préstamo ya tiene devolución.
DECLARE
    vIDPrestamo VARCHAR2(10);
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 5: Devolucion duplicada sobre el mismo prestamo ===');

    SELECT p.id INTO vIDPrestamo
    FROM   Prestamo   p
    JOIN   Devolucion d ON d.idPrestamo = p.id
    WHERE  p.idCliente  = 'USR001'
      AND  p.idEjemplar = 'EJM001'
    ORDER BY d.fechaEstimada DESC
    FETCH FIRST 1 ROW ONLY;

    BEGIN
        pkg_Bibliotecario.AD_DEVOLUCION(
            xID_BIBLIOTECARIO => 'USR002',
            xID_PRESTAMO      => vIDPrestamo,
            xESTADO_ENTREGA   => 1,
            xOBSERVACIONES    => 'Intento duplicado'
        );

        RAISE_APPLICATION_ERROR(-20951,
            'FALLO ESPERADO NO OCURRIO en PASO 5 (debia bloquear devolucion duplicada).');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE IN (-20007, -1, -20951) THEN
                DBMS_OUTPUT.PUT_LINE('Resultado PASO 5: ' || SQLERRM);
            ELSE
                RAISE;
            END IF;
    END;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 5: No se encontro prestamo con devolucion para USR001/EJM001');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR INESPERADO PASO 5 [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- → FALLA ESPERADA:
-- ORA-20007 (pkg_Bibliotecario: prestamo ya tiene devolucion)

-- Verificación paso 5
SELECT COUNT(*) AS total_devoluciones
FROM   Devolucion d
JOIN   Prestamo   p ON p.id = d.idPrestamo
WHERE  p.idCliente  = 'USR001'
  AND  p.idEjemplar = 'EJM001';


-- PASO 6 ----------------------------------------------------------------------
-- Marco consulta el estado completo del préstamo usando las vistas del paquete.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 6: Consulta estado prestamo ===');
END;
/

-- Verificación paso 6 - Historial de préstamos del cliente (pkg_Cliente)
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
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 6 HISTORIAL [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- Verificación paso 6 - Multas pendientes del cliente (pkg_Cliente)
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
        DBMS_OUTPUT.PUT_LINE('MULTA | ' || vID
            || ' | ' || vMotivo
            || ' | $' || vMonto
            || ' | ' || vEst);
    END LOOP;
    CLOSE vCursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 6 MULTAS [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- Verificación paso 6 - Estado del cliente (pkg_Cliente)
DECLARE
    vEstado VARCHAR2(20);
BEGIN
    vEstado := pkg_Cliente.VERIFICAR_ESTADO_CLIENTE('USR001');
    DBMS_OUTPUT.PUT_LINE('ESTADO CLIENTE USR001: ' || vEstado);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 6 ESTADO [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/


-- PASO 7 ----------------------------------------------------------------------
-- Marco intenta eliminar la devolución que ya tiene una multa pagada asociada.
-- ELI_DEVOLUCION valida: si existe multa con estado='Pagada' lanza ORA-20007.
-- IMPORTANTE: AD_PAGO deja la multa en 'Pagada' cuando montoAbonado >= montoAcumulado,
-- pero inserta el Pago en estado 'Pendiente'. Se usa AD_PAGO para pagar la multa
-- y así preparar el estado 'Pagada' que activa la protección de ELI_DEVOLUCION.
DECLARE
    vIDDevolucion VARCHAR2(10);
    vIDMulta      VARCHAR2(10);
    vEstadoMulta  VARCHAR2(20);
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 7: Eliminacion protegida de devolucion con multa pagada ===');

    SELECT d.id INTO vIDDevolucion
    FROM   Devolucion d
    JOIN   Prestamo   p ON p.id = d.idPrestamo
    WHERE  p.idCliente  = 'USR001'
      AND  p.idEjemplar = 'EJM001'
    ORDER BY d.fechaEstimada DESC
    FETCH FIRST 1 ROW ONLY;

    SELECT id INTO vIDMulta
    FROM   Multa
    WHERE  idDevolucion = vIDDevolucion
    FETCH FIRST 1 ROW ONLY;

    -- Verificar estado actual de la multa
    SELECT estado INTO vEstadoMulta FROM Multa WHERE id = vIDMulta;
    DBMS_OUTPUT.PUT_LINE('Estado multa antes de pagar: ' || vEstadoMulta);

    -- Pagar la multa con AD_PAGO (monto >= montoAcumulado → multa queda 'Pagada')
    -- MOD_MULTA no se usa porque lanzaría error si la multa ya estuviera Pagada.
    IF vEstadoMulta != 'Pagada' THEN
        pkg_Bibliotecario.AD_PAGO(
            xID_MULTA      => vIDMulta,
            xMONTO_ABONADO => 99999,   -- monto mayor al acumulado para garantizar estado Pagada
            xMETODO_PAGO   => 'Efectivo'
        );
    END IF;

    -- Confirmar que la multa quedó Pagada
    SELECT estado INTO vEstadoMulta FROM Multa WHERE id = vIDMulta;
    DBMS_OUTPUT.PUT_LINE('Estado multa despues de pagar: ' || vEstadoMulta);

    -- Intentar eliminar la devolución (debe fallar por multa Pagada)
    BEGIN
        pkg_Bibliotecario.ELI_DEVOLUCION(vIDDevolucion);

        RAISE_APPLICATION_ERROR(-20952,
            'FALLO ESPERADO NO OCURRIO en PASO 7 (debia bloquear eliminacion con multa Pagada).');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE IN (-20007, -20213, -20952) THEN
                DBMS_OUTPUT.PUT_LINE('Resultado PASO 7: ' || SQLERRM);
            ELSE
                RAISE;
            END IF;
    END;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 7: No se encontro devolucion o multa para USR001/EJM001');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR INESPERADO PASO 7 [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- → FALLA ESPERADA:
-- ORA-20007 (pkg_Bibliotecario: multa pagada asociada)

-- Verificación paso 7 - La devolución debe seguir existiendo
DECLARE
    vIDDevolucion VARCHAR2(10);
BEGIN
    SELECT d.id INTO vIDDevolucion
    FROM   Devolucion d
    JOIN   Prestamo   p ON p.id = d.idPrestamo
    WHERE  p.idCliente  = 'USR001'
      AND  p.idEjemplar = 'EJM001'
    ORDER BY d.fechaEstimada DESC
    FETCH FIRST 1 ROW ONLY;

    DBMS_OUTPUT.PUT_LINE('ID Devolucion verificado (sigue existiendo): ' || vIDDevolucion);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Devolucion no encontrada (fue eliminada incorrectamente)');
END;
/

SELECT m.id, m.estado
FROM   Multa     m
JOIN   Devolucion d ON d.id = m.idDevolucion
JOIN   Prestamo   p ON p.id = d.idPrestamo
WHERE  p.idCliente  = 'USR001'
  AND  p.idEjemplar = 'EJM001'
ORDER BY d.fechaEstimada DESC
FETCH FIRST 1 ROW ONLY;
