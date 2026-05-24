-- ============================================================
-- CRUDI - IMPLEMENTACION DE LOS PAQUETES
-- ============================================================

-- -----------------------------------------------
-- PC_PRESTAMO
-- -----------------------------------------------
CREATE OR REPLACE PACKAGE BODY PC_PRESTAMO IS

    PROCEDURE AD_PRESTAMO(xID_CLIENTE IN VARCHAR2, xID_EJEMPLAR IN VARCHAR2, xFECHA_PRESTAMO IN DATE) IS
    BEGIN
        INSERT INTO Prestamo(id, idCliente, idEjemplar, fechaPrestamo, diasRetraso)
        VALUES ('PR' || LPAD(SQ_PRESTAMO.NEXTVAL, 3, '0'), xID_CLIENTE, xID_EJEMPLAR, xFECHA_PRESTAMO, 0);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
            RAISE_APPLICATION_ERROR(-20201, 'Error al insertar Prestamo: ' || SQLERRM);
    END AD_PRESTAMO;

    PROCEDURE MOD_PRESTAMO(xID IN VARCHAR2, xFECHA_PRESTAMO IN DATE) IS
    BEGIN
        UPDATE Prestamo SET fechaPrestamo = xFECHA_PRESTAMO WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
            RAISE_APPLICATION_ERROR(-20202, 'Error al modificar Prestamo: ' || SQLERRM);
    END MOD_PRESTAMO;

    PROCEDURE ELI_PRESTAMO(xID IN VARCHAR2, xID_ADMIN IN VARCHAR2) IS
    BEGIN
        DELETE FROM Prestamo WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
            RAISE_APPLICATION_ERROR(-20203, 'Error al eliminar Prestamo: ' || SQLERRM);
    END ELI_PRESTAMO;

    FUNCTION CO_PRESTAMO(xFECHA_PRESTAMO IN DATE) RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
            SELECT id, fechaPrestamo, diasRetraso
            FROM   Prestamo
            WHERE  fechaPrestamo = xFECHA_PRESTAMO
            ORDER BY diasRetraso DESC;
        RETURN cur;
    END CO_PRESTAMO;

END PC_PRESTAMO;
/

-- -----------------------------------------------
-- PC_DEVOLUCION
-- -----------------------------------------------
CREATE OR REPLACE PACKAGE BODY PC_DEVOLUCION IS

    PROCEDURE AD_DEVOLUCION(xID_PRESTAMO IN VARCHAR2, xESTADO_ENTREGA IN BOOLEAN, xOBSERVACIONES IN VARCHAR2) IS
        v_estadoEntrega NUMBER(1);
    BEGIN
        v_estadoEntrega := CASE WHEN xESTADO_ENTREGA THEN 1 ELSE 0 END;
        INSERT INTO Devolucion(id, idPrestamo, fechaEstimada, estadoEntrega, observaciones)
        VALUES ('DV' || LPAD(SQ_DEVOLUCION.NEXTVAL, 3, '0'), xID_PRESTAMO, SYSDATE, v_estadoEntrega, xOBSERVACIONES);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
            RAISE_APPLICATION_ERROR(-20211, 'Error al insertar Devolucion: ' || SQLERRM);
    END AD_DEVOLUCION;

    PROCEDURE MOD_DEVOLUCION(xID IN VARCHAR2, xOBSERVACIONES IN VARCHAR2) IS
    BEGIN
        UPDATE Devolucion SET observaciones = xOBSERVACIONES WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
            RAISE_APPLICATION_ERROR(-20212, 'Error al modificar Devolucion: ' || SQLERRM);
    END MOD_DEVOLUCION;

    PROCEDURE ELI_DEVOLUCION(xID IN VARCHAR2) IS
    BEGIN
        DELETE FROM Devolucion WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
            RAISE_APPLICATION_ERROR(-20213, 'Error al eliminar Devolucion: ' || SQLERRM);
    END ELI_DEVOLUCION;

    FUNCTION CO_DEVOLUCION(xESTADO_ENTREGA IN BOOLEAN) RETURN SYS_REFCURSOR IS
        cur             SYS_REFCURSOR;
        v_estadoEntrega NUMBER(1);
    BEGIN
        v_estadoEntrega := CASE WHEN xESTADO_ENTREGA THEN 1 ELSE 0 END;
        OPEN cur FOR
            SELECT id, fechaEstimada, observaciones, estadoEntrega
            FROM   Devolucion
            WHERE  estadoEntrega = v_estadoEntrega
            ORDER BY fechaEstimada ASC;
        RETURN cur;
    END CO_DEVOLUCION;

END PC_DEVOLUCION;
/

-- -----------------------------------------------
-- PC_MULTA
-- -----------------------------------------------
CREATE OR REPLACE PACKAGE BODY PC_MULTA IS

    PROCEDURE AD_MULTA(xID_DEVOLUCION IN VARCHAR2, xMOTIVO IN VARCHAR2, xMONTO_ACUMULADO IN NUMBER) IS
        v_idCliente Devolucion.idPrestamo%TYPE;
    BEGIN
        SELECT p.idCliente
        INTO   v_idCliente
        FROM   Devolucion d JOIN Prestamo p ON d.idPrestamo = p.id
        WHERE  d.id = xID_DEVOLUCION;

        INSERT INTO Multa(id, idDevolucion, idCliente, montoAcumulado, motivo, estado)
        VALUES ('MT' || LPAD(SQ_MULTA.NEXTVAL, 3, '0'), xID_DEVOLUCION, v_idCliente, xMONTO_ACUMULADO, xMOTIVO, 'Pendiente');
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
            RAISE_APPLICATION_ERROR(-20221, 'Error al insertar Multa: ' || SQLERRM);
    END AD_MULTA;

    PROCEDURE MOD_MULTA(xID IN VARCHAR2, xMONTO_ACUMULADO IN NUMBER, xESTADO IN VARCHAR2) IS
    BEGIN
        UPDATE Multa SET montoAcumulado = xMONTO_ACUMULADO, estado = xESTADO WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
            RAISE_APPLICATION_ERROR(-20222, 'Error al modificar Multa: ' || SQLERRM);
    END MOD_MULTA;

    PROCEDURE ELI_MULTA(xID IN VARCHAR2, xID_ADMIN IN VARCHAR2) IS
    BEGIN
        DELETE FROM Multa WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
            RAISE_APPLICATION_ERROR(-20223, 'Error al eliminar Multa: ' || SQLERRM);
    END ELI_MULTA;

    FUNCTION CO_MULTA(xESTADO IN VARCHAR2) RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
            SELECT id, montoAcumulado, motivo, estado
            FROM   Multa
            WHERE  estado = xESTADO
            ORDER BY montoAcumulado DESC;
        RETURN cur;
    END CO_MULTA;

END PC_MULTA;
/

-- -----------------------------------------------
-- PC_PAGO
-- -----------------------------------------------
CREATE OR REPLACE PACKAGE BODY PC_PAGO IS

    PROCEDURE AD_PAGO(xID_MULTA IN VARCHAR2, xMONTO_ABONADO IN NUMBER, xMETODO_PAGO IN VARCHAR2) IS
        v_idCliente Multa.idCliente%TYPE;
    BEGIN
        SELECT idCliente INTO v_idCliente FROM Multa WHERE id = xID_MULTA;

        INSERT INTO Pago(id, idCliente, idMulta, estado, fechaPago, metodoPago)
        VALUES ('PG' || LPAD(SQ_PAGO.NEXTVAL, 3, '0'), v_idCliente, xID_MULTA, 'Completado', SYSDATE, xMETODO_PAGO);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
            RAISE_APPLICATION_ERROR(-20231, 'Error al insertar Pago: ' || SQLERRM);
    END AD_PAGO;

    PROCEDURE MOD_PAGO(xID IN VARCHAR2, xMETODO_PAGO IN VARCHAR2) IS
    BEGIN
        UPDATE Pago SET metodoPago = xMETODO_PAGO WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
            RAISE_APPLICATION_ERROR(-20232, 'Error al modificar Pago: ' || SQLERRM);
    END MOD_PAGO;

    PROCEDURE ELI_PAGO(xID IN VARCHAR2) IS
    BEGIN
        DELETE FROM Pago WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
            RAISE_APPLICATION_ERROR(-20233, 'Error al eliminar Pago: ' || SQLERRM);
    END ELI_PAGO;

    FUNCTION CO_PAGO(xESTADO IN VARCHAR2) RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
            SELECT id, estado, fechaPago, metodoPago
            FROM   Pago
            WHERE  estado = xESTADO
            ORDER BY fechaPago ASC;
        RETURN cur;
    END CO_PAGO;

END PC_PAGO;
/
