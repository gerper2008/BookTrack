--------------------------------------------------------------------------------
-- SEGURIDADOK: Pruebas de ingreso de datos correctos
--------------------------------------------------------------------------------

-- -------------------------------------------------------
-- PASO 0: Limpieza previa para idempotencia
-- -------------------------------------------------------
BEGIN
    DELETE FROM Pago       WHERE idCliente IN ('USR001', 'USR003');
    DELETE FROM Multa      WHERE idCliente IN ('USR001', 'USR003');
    DELETE FROM Devolucion WHERE idPrestamo IN (
        SELECT id FROM Prestamo WHERE idCliente IN ('USR001', 'USR003')
    );
    DELETE FROM Prestamo   WHERE idCliente IN ('USR001', 'USR003');
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('PASO 0: Limpieza OK');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR PASO 0 [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- -------------------------------------------------------
-- VERIFICACION PREVIA DE DATOS SEMILLA
-- -------------------------------------------------------
DECLARE
    vRolBib  VARCHAR2(30);
    vRolCli  VARCHAR2(30);
    vDispBib NUMBER(1);
    vEstCli  VARCHAR2(20);
    vDispE1  NUMBER(1);
    vDispE2  NUMBER(1);
BEGIN
    -- Verificar bibliotecario USR002
    BEGIN
        SELECT u.rol, b.disponibilidad
        INTO   vRolBib, vDispBib
        FROM   Usuario u
        JOIN   Bibliotecario b ON b.idUsuario = u.id
        WHERE  u.id = 'USR002';
        DBMS_OUTPUT.PUT_LINE('USR002 rol=' || vRolBib || ' disponible=' || vDispBib);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('*** USR002 no existe en Usuario/Bibliotecario ***');
    END;

    -- Verificar cliente USR001
    BEGIN
        SELECT u.rol, c.estado
        INTO   vRolCli, vEstCli
        FROM   Usuario u
        JOIN   Cliente c ON c.idUsuario = u.id
        WHERE  u.id = 'USR001';
        DBMS_OUTPUT.PUT_LINE('USR001 rol=' || vRolCli || ' estado=' || vEstCli);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('*** USR001 no existe en Usuario/Cliente ***');
    END;

    -- Verificar ejemplares
    BEGIN
        SELECT disponibilidad INTO vDispE1 FROM Ejemplar WHERE id = 'EJM001';
        DBMS_OUTPUT.PUT_LINE('EJM001 disponible=' || vDispE1);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('*** EJM001 no existe en Ejemplar ***');
    END;

    BEGIN
        SELECT disponibilidad INTO vDispE2 FROM Ejemplar WHERE id = 'EJM002';
        DBMS_OUTPUT.PUT_LINE('EJM002 disponible=' || vDispE2);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('*** EJM002 no existe en Ejemplar ***');
    END;
END;
/

-- -------------------------------------------------------
-- A) PRESTAMO: Registrar un préstamo nuevo
-- -------------------------------------------------------
BEGIN
    pkg_Bibliotecario.AD_PRESTAMO(
        xID_BIBLIOTECARIO => 'USR002',
        xID_CLIENTE       => 'USR001',
        xID_EJEMPLAR      => 'EJM001',
        xFECHA_PRESTAMO   => SYSDATE
    );
    DBMS_OUTPUT.PUT_LINE('AD_PRESTAMO: OK');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR AD_PRESTAMO [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- -------------------------------------------------------
-- C) PRESTAMO: Consultar préstamos de hoy
-- -------------------------------------------------------
DECLARE
    vCursor SYS_REFCURSOR;
    vID     VARCHAR2(10);
    vFecha  DATE;
    vDias   NUMBER;
    vNombre VARCHAR2(60);
    vApell  VARCHAR2(60);
    vEjem   VARCHAR2(10);
BEGIN
    vCursor := pkg_Bibliotecario.CO_PRESTAMO(SYSDATE);
    LOOP
        FETCH vCursor INTO vID, vFecha, vDias, vNombre, vApell, vEjem;
        EXIT WHEN vCursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('CO_PRESTAMO | ' || vID
            || ' | ' || vNombre || ' ' || vApell
            || ' | Retraso: ' || vDias
            || ' | Ejemplar: ' || vEjem);
    END LOOP;
    CLOSE vCursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR CO_PRESTAMO [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- -------------------------------------------------------
-- A) DEVOLUCION: Registrar devolución en buen estado
-- -------------------------------------------------------
DECLARE
    vIDPrestamo VARCHAR2(10);
BEGIN
    SELECT id INTO vIDPrestamo
    FROM   Prestamo
    WHERE  idCliente = 'USR001'
      AND  NOT EXISTS (SELECT 1 FROM Devolucion d WHERE d.idPrestamo = Prestamo.id)
    ORDER BY fechaPrestamo DESC
    FETCH FIRST 1 ROW ONLY;

    pkg_Bibliotecario.AD_DEVOLUCION(
        xID_BIBLIOTECARIO => 'USR002',
        xID_PRESTAMO      => vIDPrestamo,
        xESTADO_ENTREGA   => 1,
        xOBSERVACIONES    => 'Libro devuelto en buen estado'
    );
    DBMS_OUTPUT.PUT_LINE('AD_DEVOLUCION: OK | Prestamo: ' || vIDPrestamo);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR AD_DEVOLUCION: No hay préstamo activo para USR001');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR AD_DEVOLUCION [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- -------------------------------------------------------
-- C) DEVOLUCION: Consultar devoluciones en buen estado
-- -------------------------------------------------------
DECLARE
    vCursor SYS_REFCURSOR;
    vID     VARCHAR2(10);
    vFecha  DATE;
    vObs    VARCHAR2(200);
    vEst    NUMBER;
    vNombre VARCHAR2(60);
    vApell  VARCHAR2(60);
BEGIN
    vCursor := pkg_Bibliotecario.CO_DEVOLUCION(1);
    LOOP
        FETCH vCursor INTO vID, vFecha, vObs, vEst, vNombre, vApell;
        EXIT WHEN vCursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('CO_DEVOLUCION | ' || vID
            || ' | ' || vNombre || ' ' || vApell
            || ' | ' || vObs);
    END LOOP;
    CLOSE vCursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR CO_DEVOLUCION [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- -------------------------------------------------------
-- PREPARACION PARA MULTA: segundo préstamo en mal estado
-- -------------------------------------------------------
BEGIN
    pkg_Bibliotecario.AD_PRESTAMO(
        xID_BIBLIOTECARIO => 'USR002',
        xID_CLIENTE       => 'USR001',
        xID_EJEMPLAR      => 'EJM002',
        xFECHA_PRESTAMO   => SYSDATE - 5
    );
    DBMS_OUTPUT.PUT_LINE('PRESTAMO base para multa: OK');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PRESTAMO multa [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

UPDATE Prestamo
SET    diasRetraso = 5
WHERE  idCliente   = 'USR001'
  AND  idEjemplar  = 'EJM002'
  AND  id = (
           SELECT id FROM Prestamo
           WHERE  idCliente = 'USR001' AND idEjemplar = 'EJM002'
           ORDER BY fechaPrestamo DESC
           FETCH FIRST 1 ROW ONLY
       );
COMMIT;

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
    DBMS_OUTPUT.PUT_LINE('DEVOLUCION base para multa: OK | Prestamo: ' || vIDPrestamo);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR DEVOLUCION multa: No hay préstamo activo EJM002/USR001');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR DEVOLUCION multa [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- -------------------------------------------------------
-- A) MULTA: Registrar multa por daño físico
-- -------------------------------------------------------
DECLARE
    vIDDevolucion VARCHAR2(10);
BEGIN
    SELECT d.id INTO vIDDevolucion
    FROM   Devolucion d
    JOIN   Prestamo   p ON p.id = d.idPrestamo
    WHERE  p.idCliente     = 'USR001'
      AND  d.estadoEntrega = 0
      AND  NOT EXISTS (SELECT 1 FROM Multa m WHERE m.idDevolucion = d.id)
    ORDER BY d.fechaEstimada DESC
    FETCH FIRST 1 ROW ONLY;

    pkg_Bibliotecario.AD_MULTA(
        xID_DEVOLUCION   => vIDDevolucion,
        xMOTIVO          => 'Daño',
        xMONTO_ACUMULADO => 15000
    );
    DBMS_OUTPUT.PUT_LINE('AD_MULTA: OK | Devolucion: ' || vIDDevolucion);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR AD_MULTA: No hay devolución en mal estado sin multa para USR001');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR AD_MULTA [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- -------------------------------------------------------
-- C) MULTA: Consultar multas pendientes
-- -------------------------------------------------------
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
        DBMS_OUTPUT.PUT_LINE('CO_MULTA | ' || vID
            || ' | ' || vNombre || ' ' || vApell
            || ' | Motivo: ' || vMotivo
            || ' | Monto: $' || vMonto);
    END LOOP;
    CLOSE vCursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR CO_MULTA [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- -------------------------------------------------------
-- A) PAGO: Registrar pago de la multa pendiente de USR001
-- -------------------------------------------------------
DECLARE
    vIDMulta VARCHAR2(10);
BEGIN
    SELECT id INTO vIDMulta
    FROM   Multa
    WHERE  idCliente = 'USR001'
      AND  estado    = 'Pendiente'
    ORDER BY montoAcumulado DESC
    FETCH FIRST 1 ROW ONLY;

    pkg_Bibliotecario.AD_PAGO(
        xID_MULTA      => vIDMulta,
        xMONTO_ABONADO => 15000,
        xMETODO_PAGO   => 'Efectivo'
    );
    DBMS_OUTPUT.PUT_LINE('AD_PAGO: OK | Multa: ' || vIDMulta);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR AD_PAGO: No hay multa Pendiente para USR001');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR AD_PAGO [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- -------------------------------------------------------
-- C) PAGO: Consultar pagos pendientes
-- -------------------------------------------------------
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
        DBMS_OUTPUT.PUT_LINE('CO_PAGO | ' || vID
            || ' | ' || vNombre || ' ' || vApell
            || ' | Metodo: ' || vMetodo
            || ' | Estado: ' || vEst);
    END LOOP;
    CLOSE vCursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR CO_PAGO [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- -------------------------------------------------------
-- VISTAS DE CONSULTA (Bibliotecario)
-- -------------------------------------------------------

-- Ejemplares disponibles
DECLARE
    vCursor SYS_REFCURSOR;
    vID     VARCHAR2(10);
    vEst    VARCHAR2(30);
    vDisp   NUMBER;
    vLoc    VARCHAR2(100);
BEGIN
    vCursor := pkg_Bibliotecario.VE_EJEMPLARES_DISPONIBLES();
    LOOP
        FETCH vCursor INTO vID, vEst, vDisp, vLoc;
        EXIT WHEN vCursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('VE_EJEMPLARES | ' || vID
            || ' | Estado: ' || vEst
            || ' | Loc: ' || vLoc);
    END LOOP;
    CLOSE vCursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR VE_EJEMPLARES [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- Préstamos activos
DECLARE
    vCursor SYS_REFCURSOR;
    vID     VARCHAR2(10);
    vFecha  DATE;
    vDias   NUMBER;
    vNombre VARCHAR2(60);
    vApell  VARCHAR2(60);
    vEjem   VARCHAR2(10);
BEGIN
    vCursor := pkg_Bibliotecario.VE_PRESTAMOS_ACTIVOS();
    LOOP
        FETCH vCursor INTO vID, vFecha, vDias, vNombre, vApell, vEjem;
        EXIT WHEN vCursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('VE_PRESTAMOS_ACTIVOS | ' || vID
            || ' | ' || vNombre || ' ' || vApell
            || ' | Dias retraso: ' || vDias);
    END LOOP;
    CLOSE vCursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR VE_PRESTAMOS_ACTIVOS [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- Multas generadas pendientes
DECLARE
    vCursor SYS_REFCURSOR;
    vID     VARCHAR2(10);
    vMonto  NUMBER;
    vMotivo VARCHAR2(30);
    vEst    VARCHAR2(20);
    vNombre VARCHAR2(60);
    vApell  VARCHAR2(60);
BEGIN
    vCursor := pkg_Bibliotecario.VE_MULTAS_GENERADAS('Pendiente');
    LOOP
        FETCH vCursor INTO vID, vMonto, vMotivo, vEst, vNombre, vApell;
        EXIT WHEN vCursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('VE_MULTAS_GENERADAS | ' || vID
            || ' | ' || vNombre || ' ' || vApell
            || ' | $' || vMonto);
    END LOOP;
    CLOSE vCursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR VE_MULTAS_GENERADAS [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- -------------------------------------------------------
-- CONSULTAS DE CLIENTE (pkg_Cliente)
-- -------------------------------------------------------

-- Validar cliente
DECLARE
    vResult NUMBER;
BEGIN
    vResult := pkg_Cliente.VALIDAR_CLIENTE('USR001');
    DBMS_OUTPUT.PUT_LINE('VALIDAR_CLIENTE USR001: ' || vResult);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR VALIDAR_CLIENTE [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- Verificar estado del cliente
DECLARE
    vEstado VARCHAR2(20);
BEGIN
    vEstado := pkg_Cliente.VERIFICAR_ESTADO_CLIENTE('USR001');
    DBMS_OUTPUT.PUT_LINE('ESTADO CLIENTE USR001: ' || vEstado);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR VERIFICAR_ESTADO [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- Verificar saldo del cliente
DECLARE
    vSaldo NUMBER;
BEGIN
    vSaldo := pkg_Cliente.VERIFICAR_SALDO_CLIENTE('USR001');
    DBMS_OUTPUT.PUT_LINE('SALDO CLIENTE USR001: $' || vSaldo);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR VERIFICAR_SALDO [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- Historial de préstamos del cliente
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
        DBMS_OUTPUT.PUT_LINE('ERROR VE_HISTORIAL [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-- Multas pendientes del cliente
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
            || ' | ' || vMotivo
            || ' | $' || vMonto);
    END LOOP;
    CLOSE vCursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR VE_MULTAS_PENDIENTES [' || SQLCODE || ']: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/