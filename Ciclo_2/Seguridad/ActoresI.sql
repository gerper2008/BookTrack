---------------------------------------------------------------------------------------------
--- SEGURIDAD: ACTORES IMPLEMENTACION -> Cuerpos de los paquetes de actores
--- Correcciones: Incluye validaciones completas con todas las relaciones del proyecto
---------------------------------------------------------------------------------------------

-- ========================
-- PKG BODY: Bibliotecario
-- ========================
CREATE OR REPLACE PACKAGE BODY pkg_Bibliotecario AS

    -- -------------------------------------------------------
    -- PRESTAMO
    -- -------------------------------------------------------
    PROCEDURE AD_PRESTAMO(
        xID_BIBLIOTECARIO IN VARCHAR2,
        xID_CLIENTE     IN VARCHAR2,
        xID_EJEMPLAR    IN VARCHAR2,
        xFECHA_PRESTAMO IN DATE
    ) IS
        vEstado          VARCHAR2(20);
        vDisponible     NUMBER(1);
        vPermisos       VARCHAR2(30);
        vBiblioEstado   NUMBER(1);
        vID             VARCHAR2(10);
    BEGIN
        -- Validar bibliotecario existe y tiene permisos
        SELECT permisos, disponibilidad INTO vPermisos, vBiblioEstado
        FROM Bibliotecario WHERE idUsuario = xID_BIBLIOTECARIO;
        
        IF vBiblioEstado != 1 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El bibliotecario no esta disponible.');
        END IF;
        
        IF vPermisos NOT IN ('Operativo', 'Total') THEN
            RAISE_APPLICATION_ERROR(-20002, 'El bibliotecario no tiene permisos para realizar prestamos.');
        END IF;

        -- Validar cliente existe y esta activo
        SELECT estado INTO vEstado
        FROM Cliente WHERE idUsuario = xID_CLIENTE;
        
        IF vEstado NOT IN ('Activo') THEN
            RAISE_APPLICATION_ERROR(-20003, 'El cliente debe estar Activo para prestar.');
        END IF;

        -- Validar ejemplar existe y esta disponible
        SELECT disponibilidad INTO vDisponible
        FROM Ejemplar WHERE id = xID_EJEMPLAR;
        
        IF vDisponible != 1 THEN
            RAISE_APPLICATION_ERROR(-20004, 'El ejemplar no esta disponible.');
        END IF;

        -- Generar ID del prestamo
        SELECT 'PR' || LPAD(SQ_PRESTAMO.NEXTVAL, 3, '0') INTO vID FROM DUAL;

        -- Insertar prestamo (incluye idBibliotecario - FK a Bibliotecario)
        INSERT INTO Prestamo(id, fechaPrestamo, diasRetraso, idBibliotecario, idCliente, idEjemplar)
        VALUES(vID, xFECHA_PRESTAMO, 0, xID_BIBLIOTECARIO, xID_CLIENTE, xID_EJEMPLAR);

        -- NOTA: El disparador TRG_Prestamo_EjemplarOcupar ya actualiza disponibilidad
        -- Se elimina UPDATE manual para evitar conflicto con trigger

        COMMIT;
    END AD_PRESTAMO;

    PROCEDURE MOD_PRESTAMO(
        xID             IN VARCHAR2,
        xFECHA_PRESTAMO IN DATE
    ) IS
        vCount NUMBER;
    BEGIN
        SELECT COUNT(*) INTO vCount FROM Devolucion WHERE idPrestamo = xID;
        IF vCount > 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'El prestamo ya tiene una devolucion registrada.');
        END IF;

        UPDATE Prestamo SET fechaPrestamo = xFECHA_PRESTAMO WHERE id = xID;
        COMMIT;
    END MOD_PRESTAMO;

    PROCEDURE ELI_PRESTAMO(
        xID       IN VARCHAR2,
        xID_ADMIN IN VARCHAR2
    ) IS
        vPermisos VARCHAR2(30);
    BEGIN
        SELECT permisos INTO vPermisos
        FROM Administrador WHERE idUsuario = xID_ADMIN;
        IF vPermisos NOT IN ('Operativo', 'Total') THEN
            RAISE_APPLICATION_ERROR(-20004, 'El administrador no tiene autorizacion.');
        END IF;

        UPDATE Ejemplar SET disponibilidad = 1
        WHERE id = (SELECT idEjemplar FROM Prestamo WHERE id = xID);

        DELETE FROM Prestamo WHERE id = xID;
        COMMIT;
    END ELI_PRESTAMO;

    FUNCTION CO_PRESTAMO(
        xFECHA_PRESTAMO IN DATE
    ) RETURN SYS_REFCURSOR IS
        vCursor SYS_REFCURSOR;
    BEGIN
        OPEN vCursor FOR
            SELECT p.id, p.fechaPrestamo, p.diasRetraso,
                   u.nombre, u.apellidos, p.idEjemplar
            FROM Prestamo p
            JOIN Cliente c  ON c.idUsuario = p.idCliente
            JOIN Usuario u  ON u.id        = c.idUsuario
            WHERE TRUNC(p.fechaPrestamo) = TRUNC(xFECHA_PRESTAMO)
            ORDER BY p.diasRetraso DESC;
        RETURN vCursor;
    END CO_PRESTAMO;

-- -------------------------------------------------------
    -- DEVOLUCION
    -- -------------------------------------------------------
    PROCEDURE AD_DEVOLUCION(
        xID_BIBLIOTECARIO IN VARCHAR2,
        xID_PRESTAMO    IN VARCHAR2,
        xESTADO_ENTREGA IN NUMBER,
        xOBSERVACIONES  IN VARCHAR2
    ) IS
        vCount         NUMBER;
        vID           VARCHAR2(10);
        vPermisos     VARCHAR2(30);
        vBiblioEstado NUMBER(1);
        vDiasRetraso NUMBER(5,2);
    BEGIN
        -- Validar bibliotecario existe y tiene permisos
        SELECT permisos, disponibilidad INTO vPermisos, vBiblioEstado
        FROM Bibliotecario WHERE idUsuario = xID_BIBLIOTECARIO;
        
        IF vBiblioEstado != 1 THEN
            RAISE_APPLICATION_ERROR(-20005, 'El bibliotecario no esta disponible.');
        END IF;
        
        IF vPermisos NOT IN ('Operativo', 'Total') THEN
            RAISE_APPLICATION_ERROR(-20006, 'El bibliotecario no tiene permisos para devoluciones.');
        END IF;

        -- Validar prestamo existe y no tiene devolucion
        SELECT COUNT(*) INTO vCount FROM Devolucion WHERE idPrestamo = xID_PRESTAMO;
        IF vCount > 0 THEN
            RAISE_APPLICATION_ERROR(-20007, 'El prestamo ya tiene una devolucion.');
        END IF;
        
        -- Obtener diasRetraso para calculo de multa automatica
        SELECT diasRetraso INTO vDiasRetraso 
        FROM Prestamo WHERE id = xID_PRESTAMO;

        -- Generar ID de devolucion
        SELECT 'DV' || LPAD(SQ_DEVOLUCION.NEXTVAL, 3, '0') INTO vID FROM DUAL;

        -- Insertar devolucion
        INSERT INTO Devolucion(id, idPrestamo, fechaEstimada, observaciones, estadoEntrega)
        VALUES(vID, xID_PRESTAMO, SYSDATE, xOBSERVACIONES, xESTADO_ENTREGA);

        -- NOTA: El disparador TRG_Devolucion_EjemplarLiberar ya actualiza disponibilidad
        -- El disparador TRG_Multa_Retraso_AUTO ya crea multa si hay retraso
        -- Se elimina UPDATE manual para evitar conflicto con triggers

        COMMIT;
    END AD_DEVOLUCION;

    PROCEDURE MOD_DEVOLUCION(
        xID            IN VARCHAR2,
        xOBSERVACIONES IN VARCHAR2
    ) IS
        vFecha DATE;
    BEGIN
        SELECT fechaEstimada INTO vFecha FROM Devolucion WHERE id = xID;
        IF SYSDATE - vFecha > 1 THEN
            RAISE_APPLICATION_ERROR(-20006, 'Solo se puede modificar dentro de las 24h siguientes.');
        END IF;

        UPDATE Devolucion SET observaciones = xOBSERVACIONES WHERE id = xID;
        COMMIT;
    END MOD_DEVOLUCION;

    PROCEDURE ELI_DEVOLUCION(
        xID IN VARCHAR2
    ) IS
        vCount NUMBER;
    BEGIN
        SELECT COUNT(*) INTO vCount
        FROM Multa m
        JOIN Devolucion d ON d.id = m.idDevolucion
        WHERE d.id = xID AND m.estado = 'Pagada';
        IF vCount > 0 THEN
            RAISE_APPLICATION_ERROR(-20007, 'Existe una multa pagada asociada. No se puede eliminar.');
        END IF;

        DELETE FROM Devolucion WHERE id = xID;
        COMMIT;
    END ELI_DEVOLUCION;

    FUNCTION CO_DEVOLUCION(
        xESTADO_ENTREGA IN NUMBER
    ) RETURN SYS_REFCURSOR IS
        vCursor SYS_REFCURSOR;
    BEGIN
        OPEN vCursor FOR
            SELECT d.id, d.fechaEstimada, d.observaciones, d.estadoEntrega,
                   u.nombre, u.apellidos
            FROM Devolucion d
            JOIN Prestamo p ON p.id        = d.idPrestamo
            JOIN Cliente c  ON c.idUsuario = p.idCliente
            JOIN Usuario u  ON u.id        = c.idUsuario
            WHERE d.estadoEntrega = xESTADO_ENTREGA
            ORDER BY d.fechaEstimada ASC;
        RETURN vCursor;
    END CO_DEVOLUCION;

    -- -------------------------------------------------------
    -- MULTA
    -- -------------------------------------------------------
    PROCEDURE AD_MULTA(
        xID_DEVOLUCION   IN VARCHAR2,
        xMOTIVO          IN VARCHAR2,
        xMONTO_ACUMULADO IN NUMBER
    ) IS
        vEstado  NUMBER;
        vDias    NUMBER;
        vID      VARCHAR2(10);
        vCliente VARCHAR2(10);
    BEGIN
        SELECT p.diasRetraso, d.estadoEntrega, p.idCliente
        INTO vDias, vEstado, vCliente
        FROM Devolucion d
        JOIN Prestamo p ON p.id = d.idPrestamo
        WHERE d.id = xID_DEVOLUCION;

        IF vDias <= 0 AND vEstado = 1 THEN
            RAISE_APPLICATION_ERROR(-20008, 'No hay retraso ni dano fisico registrado.');
        END IF;

        SELECT 'MT' || LPAD(SQ_MULTA.NEXTVAL, 3, '0') INTO vID FROM DUAL;

        INSERT INTO Multa(id, idDevolucion, idCliente, montoAcumulado, motivo, estado)
        VALUES(vID, xID_DEVOLUCION, vCliente, xMONTO_ACUMULADO, xMOTIVO, 'Pendiente');

        COMMIT;
    END AD_MULTA;

    PROCEDURE MOD_MULTA(
        xID              IN VARCHAR2,
        xMONTO_ACUMULADO IN NUMBER,
        xESTADO          IN VARCHAR2
    ) IS
        vEstado VARCHAR2(20);
    BEGIN
        SELECT estado INTO vEstado FROM Multa WHERE id = xID;
        IF vEstado = 'Pagada' THEN
            RAISE_APPLICATION_ERROR(-20009, 'No se puede modificar una multa pagada.');
        END IF;

        UPDATE Multa
        SET montoAcumulado = xMONTO_ACUMULADO,
            estado         = xESTADO
        WHERE id = xID;
        COMMIT;
    END MOD_MULTA;

    PROCEDURE ELI_MULTA(
        xID       IN VARCHAR2,
        xID_ADMIN IN VARCHAR2
    ) IS
        vPermisos VARCHAR2(30);
        vEstado   VARCHAR2(20);
    BEGIN
        SELECT permisos INTO vPermisos
        FROM Administrador WHERE idUsuario = xID_ADMIN;
        IF vPermisos != 'Total' THEN
            RAISE_APPLICATION_ERROR(-20010, 'Se requiere permiso Total para eliminar multas.');
        END IF;

        SELECT estado INTO vEstado FROM Multa WHERE id = xID;
        IF vEstado != 'Anulada' THEN
            RAISE_APPLICATION_ERROR(-20011, 'La multa debe estar en estado Anulada (apelacion aprobada).');
        END IF;

        DELETE FROM Multa WHERE id = xID;
        COMMIT;
    END ELI_MULTA;

    FUNCTION CO_MULTA(
        xESTADO IN VARCHAR2
    ) RETURN SYS_REFCURSOR IS
        vCursor SYS_REFCURSOR;
    BEGIN
        OPEN vCursor FOR
            SELECT m.id, m.montoAcumulado, m.motivo, m.estado,
                   u.nombre, u.apellidos
            FROM Multa m
            JOIN Cliente c ON c.idUsuario = m.idCliente
            JOIN Usuario u ON u.id        = c.idUsuario
            WHERE m.estado = xESTADO
            ORDER BY m.montoAcumulado DESC;
        RETURN vCursor;
    END CO_MULTA;

    -- -------------------------------------------------------
    -- PAGO
    -- -------------------------------------------------------
    PROCEDURE AD_PAGO(
        xID_MULTA      IN VARCHAR2,
        xMONTO_ABONADO IN NUMBER,
        xMETODO_PAGO   IN VARCHAR2
    ) IS
        vMonto   NUMBER;
        vEstado  VARCHAR2(20);
        vID      VARCHAR2(10);
        vCliente VARCHAR2(10);
    BEGIN
        SELECT montoAcumulado, estado, idCliente
        INTO vMonto, vEstado, vCliente
        FROM Multa WHERE id = xID_MULTA;

        IF vEstado = 'Pagada' OR vMonto <= 0 THEN
            RAISE_APPLICATION_ERROR(-20012, 'La multa no tiene saldo pendiente.');
        END IF;

        SELECT 'PG' || LPAD(SQ_PAGO.NEXTVAL, 3, '0') INTO vID FROM DUAL;

        INSERT INTO Pago(id, idCliente, idMulta, estado, fechaPago, metodoPago)
        VALUES(vID, vCliente, xID_MULTA, 'Pendiente', SYSDATE, xMETODO_PAGO);

        IF xMONTO_ABONADO >= vMonto THEN
            UPDATE Multa SET estado = 'Pagada' WHERE id = xID_MULTA;
        ELSE
            UPDATE Multa SET montoAcumulado = vMonto - xMONTO_ABONADO WHERE id = xID_MULTA;
        END IF;

        COMMIT;
    END AD_PAGO;

    PROCEDURE MOD_PAGO(
        xID          IN VARCHAR2,
        xMETODO_PAGO IN VARCHAR2
    ) IS
    BEGIN
        UPDATE Pago SET metodoPago = xMETODO_PAGO WHERE id = xID;
        COMMIT;
    END MOD_PAGO;

    PROCEDURE ELI_PAGO(
        xID IN VARCHAR2
    ) IS
        vEstado VARCHAR2(20);
    BEGIN
        SELECT estado INTO vEstado FROM Pago WHERE id = xID;
        IF vEstado NOT IN ('Pendiente', 'Rechazado') THEN
            RAISE_APPLICATION_ERROR(-20013, 'Solo se pueden eliminar pagos en estado Pendiente o Rechazado.');
        END IF;

        DELETE FROM Pago WHERE id = xID;
        COMMIT;
    END ELI_PAGO;

    FUNCTION CO_PAGO(
        xESTADO IN VARCHAR2
    ) RETURN SYS_REFCURSOR IS
        vCursor SYS_REFCURSOR;
    BEGIN
        OPEN vCursor FOR
            SELECT p.id, p.estado, p.fechaPago, p.metodoPago,
                   u.nombre, u.apellidos
            FROM Pago p
            JOIN Cliente c ON c.idUsuario = p.idCliente
            JOIN Usuario u ON u.id        = c.idUsuario
            WHERE p.estado = xESTADO
            ORDER BY p.fechaPago ASC;
        RETURN vCursor;
    END CO_PAGO;

    -- -------------------------------------------------------
    -- VISTAS DE CONSULTA
    -- -------------------------------------------------------
    FUNCTION VE_EJEMPLARES_DISPONIBLES RETURN SYS_REFCURSOR IS
        vCursor SYS_REFCURSOR;
    BEGIN
        OPEN vCursor FOR
            SELECT e.id, e.estadoFisico, e.disponibilidad, e.localizacion
            FROM Ejemplar e
            WHERE e.disponibilidad = 1;
        RETURN vCursor;
    END VE_EJEMPLARES_DISPONIBLES;

    FUNCTION VE_PRESTAMOS_ACTIVOS RETURN SYS_REFCURSOR IS
        vCursor SYS_REFCURSOR;
    BEGIN
        OPEN vCursor FOR
            SELECT p.id, p.fechaPrestamo, p.diasRetraso,
                   u.nombre, u.apellidos, p.idEjemplar
            FROM Prestamo p
            JOIN Cliente c ON c.idUsuario = p.idCliente
            JOIN Usuario u ON u.id        = c.idUsuario
            WHERE NOT EXISTS (
                SELECT 1 FROM Devolucion d WHERE d.idPrestamo = p.id
            );
        RETURN vCursor;
    END VE_PRESTAMOS_ACTIVOS;

    FUNCTION VE_ESTADO_FISICO_EJEMPLARES RETURN SYS_REFCURSOR IS
        vCursor SYS_REFCURSOR;
    BEGIN
        OPEN vCursor FOR
            SELECT e.id, e.estadoFisico, e.disponibilidad, e.localizacion
            FROM Ejemplar e
            ORDER BY e.estadoFisico;
        RETURN vCursor;
    END VE_ESTADO_FISICO_EJEMPLARES;

    FUNCTION VE_MULTAS_GENERADAS(xESTADO IN VARCHAR2) RETURN SYS_REFCURSOR IS
        vCursor SYS_REFCURSOR;
    BEGIN
        OPEN vCursor FOR
            SELECT m.id, m.montoAcumulado, m.motivo, m.estado,
                   u.nombre, u.apellidos
            FROM Multa m
            JOIN Cliente c ON c.idUsuario = m.idCliente
            JOIN Usuario u ON u.id        = c.idUsuario
            WHERE m.estado = xESTADO
            ORDER BY m.montoAcumulado DESC;
        RETURN vCursor;
    END VE_MULTAS_GENERADAS;

    FUNCTION VE_DEVOLUCIONES_REGISTRADAS(xFECHA IN DATE) RETURN SYS_REFCURSOR IS
        vCursor SYS_REFCURSOR;
    BEGIN
        OPEN vCursor FOR
            SELECT d.id, d.fechaEstimada, d.observaciones, d.estadoEntrega,
                   u.nombre, u.apellidos
            FROM Devolucion d
            JOIN Prestamo p ON p.id        = d.idPrestamo
            JOIN Cliente c  ON c.idUsuario = p.idCliente
            JOIN Usuario u  ON u.id        = c.idUsuario
            WHERE TRUNC(d.fechaEstimada) = TRUNC(xFECHA)
            ORDER BY d.fechaEstimada ASC;
        RETURN vCursor;
    END VE_DEVOLUCIONES_REGISTRADAS;

END pkg_Bibliotecario;
/

-- ========================
-- PKG BODY: Cliente
-- ========================
CREATE OR REPLACE PACKAGE BODY pkg_Cliente AS

    FUNCTION VALIDAR_CLIENTE(xID IN VARCHAR2) RETURN NUMBER IS
        vEstado VARCHAR2(20);
        vFecha  DATE;
        vSaldo  NUMBER;
    BEGIN
        SELECT estado, fechaVencimiento, saldo
        INTO vEstado, vFecha, vSaldo
        FROM Cliente WHERE idUsuario = xID;

        IF vEstado = 'Activo' AND vFecha >= SYSDATE AND vSaldo >= 0 THEN
            RETURN 1;
        END IF;
        RETURN 0;
    END VALIDAR_CLIENTE;

    FUNCTION VERIFICAR_ESTADO_CLIENTE(xID_CLIENTE IN VARCHAR2) RETURN VARCHAR2 IS
        vEstado VARCHAR2(20);
    BEGIN
        SELECT estado INTO vEstado FROM Cliente WHERE idUsuario = xID_CLIENTE;
        RETURN vEstado;
    END VERIFICAR_ESTADO_CLIENTE;

    FUNCTION VERIFICAR_SALDO_CLIENTE(xID_CLIENTE IN VARCHAR2) RETURN NUMBER IS
        vSaldo NUMBER;
    BEGIN
        SELECT saldo INTO vSaldo FROM Cliente WHERE idUsuario = xID_CLIENTE;
        RETURN vSaldo;
    END VERIFICAR_SALDO_CLIENTE;

    FUNCTION VERIFICAR_VENCIMIENTO_CLIENTE(xID_CLIENTE IN VARCHAR2) RETURN DATE IS
        vFecha DATE;
    BEGIN
        SELECT fechaVencimiento INTO vFecha FROM Cliente WHERE idUsuario = xID_CLIENTE;
        RETURN vFecha;
    END VERIFICAR_VENCIMIENTO_CLIENTE;

    FUNCTION VE_DISPONIBILIDAD_LIBRO(xID_LIBRO IN VARCHAR2) RETURN SYS_REFCURSOR IS
        vCursor SYS_REFCURSOR;
    BEGIN
        OPEN vCursor FOR
            SELECT e.id, e.estadoFisico, e.disponibilidad, e.localizacion
            FROM Ejemplar e
            WHERE e.idEdicion IN (
                SELECT id FROM Edicion WHERE idLibro = xID_LIBRO
            );
        RETURN vCursor;
    END VE_DISPONIBILIDAD_LIBRO;

    FUNCTION VE_HISTORIAL_PRESTAMOS(xID_CLIENTE IN VARCHAR2) RETURN SYS_REFCURSOR IS
        vCursor SYS_REFCURSOR;
    BEGIN
        OPEN vCursor FOR
            SELECT p.id, p.fechaPrestamo, p.diasRetraso, p.idEjemplar
            FROM Prestamo p
            WHERE p.idCliente = xID_CLIENTE
            ORDER BY p.fechaPrestamo DESC;
        RETURN vCursor;
    END VE_HISTORIAL_PRESTAMOS;

    FUNCTION VE_PRESTAMOS_ACTIVOS_CLIENTE(xID_CLIENTE IN VARCHAR2) RETURN SYS_REFCURSOR IS
        vCursor SYS_REFCURSOR;
    BEGIN
        OPEN vCursor FOR
            SELECT p.id, p.fechaPrestamo, p.diasRetraso, p.idEjemplar
            FROM Prestamo p
            WHERE p.idCliente = xID_CLIENTE
              AND NOT EXISTS (
                  SELECT 1 FROM Devolucion d WHERE d.idPrestamo = p.id
              );
        RETURN vCursor;
    END VE_PRESTAMOS_ACTIVOS_CLIENTE;

    FUNCTION VE_MULTAS_PENDIENTES(xID_CLIENTE IN VARCHAR2) RETURN SYS_REFCURSOR IS
        vCursor SYS_REFCURSOR;
    BEGIN
        OPEN vCursor FOR
            SELECT m.id, m.montoAcumulado, m.motivo, m.estado
            FROM Multa m
            WHERE m.idCliente = xID_CLIENTE
              AND m.estado != 'Pagada'
            ORDER BY m.montoAcumulado DESC;
        RETURN vCursor;
    END VE_MULTAS_PENDIENTES;

    FUNCTION VE_ESTADO_PAGO_MULTA(xID_MULTA IN VARCHAR2) RETURN SYS_REFCURSOR IS
        vCursor SYS_REFCURSOR;
    BEGIN
        OPEN vCursor FOR
            SELECT p.id, p.estado, p.fechaPago, p.metodoPago,
                   m.montoAcumulado, m.motivo
            FROM Pago p
            JOIN Multa m ON m.id = p.idMulta
            WHERE p.idMulta = xID_MULTA
            ORDER BY p.fechaPago ASC;
        RETURN vCursor;
    END VE_ESTADO_PAGO_MULTA;

END pkg_Cliente;
/