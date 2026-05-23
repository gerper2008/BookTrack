---------------------------------------------------------------------------------------------
--- AUTOMATIZACIÓN: DISPARADORES -> Definición de disparadores
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-- [TRG-01] TRG_Prestamo_ID
-- Autogenera el ID de Prestamo con formato PR + secuencia de 3 dígitos
---------------------------------------------------------------------------------------------
CREATE SEQUENCE SEQ_Prestamo START WITH 1 INCREMENT BY 1 NOCACHE;

CREATE OR REPLACE TRIGGER TRG_Prestamo_ID
BEFORE INSERT ON Prestamo
FOR EACH ROW
BEGIN
    IF :NEW.id IS NULL THEN
        :NEW.id := 'PR' || LPAD(SEQ_Prestamo.NEXTVAL, 3, '0');
    END IF;
END;
/

---------------------------------------------------------------------------------------------
-- [TRG-02] TRG_Devolucion_ID
-- Autogenera el ID de Devolucion con formato DV + secuencia de 3 dígitos
---------------------------------------------------------------------------------------------
CREATE SEQUENCE SEQ_Devolucion START WITH 1 INCREMENT BY 1 NOCACHE;

CREATE OR REPLACE TRIGGER TRG_Devolucion_ID
BEFORE INSERT ON Devolucion
FOR EACH ROW
BEGIN
    IF :NEW.id IS NULL THEN
        :NEW.id := 'DV' || LPAD(SEQ_Devolucion.NEXTVAL, 3, '0');
    END IF;
END;
/

---------------------------------------------------------------------------------------------
-- [TRG-03] TRG_Multa_ID
-- Autogenera el ID de Multa con formato MT + secuencia de 3 dígitos
---------------------------------------------------------------------------------------------
CREATE SEQUENCE SEQ_Multa START WITH 1 INCREMENT BY 1 NOCACHE;

CREATE OR REPLACE TRIGGER TRG_Multa_ID
BEFORE INSERT ON Multa
FOR EACH ROW
BEGIN
    IF :NEW.id IS NULL THEN
        :NEW.id := 'MT' || LPAD(SEQ_Multa.NEXTVAL, 3, '0');
    END IF;
END;
/

---------------------------------------------------------------------------------------------
-- [TRG-04] TRG_Pago_ID
-- Autogenera el ID de Pago con formato PG + secuencia de 3 dígitos
---------------------------------------------------------------------------------------------
CREATE SEQUENCE SEQ_Pago START WITH 1 INCREMENT BY 1 NOCACHE;

CREATE OR REPLACE TRIGGER TRG_Pago_ID
BEFORE INSERT ON Pago
FOR EACH ROW
BEGIN
    IF :NEW.id IS NULL THEN
        :NEW.id := 'PG' || LPAD(SEQ_Pago.NEXTVAL, 3, '0');
    END IF;
END;
/

---------------------------------------------------------------------------------------------
-- [TRG-05] TRG_Devolucion_Fecha
-- Valida que fechaEstimada de la Devolucion sea posterior a la fechaPrestamo del Prestamo
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Devolucion_Fecha
BEFORE INSERT OR UPDATE ON Devolucion
FOR EACH ROW
DECLARE
    v_fechaPrestamo Prestamo.fechaPrestamo%TYPE;
BEGIN
    SELECT fechaPrestamo
    INTO   v_fechaPrestamo
    FROM   Prestamo
    WHERE  id = :NEW.idPrestamo;

    IF :NEW.fechaEstimada <= v_fechaPrestamo THEN
        RAISE_APPLICATION_ERROR(
            -20101,
            'La fechaEstimada de la devolucion debe ser posterior a la fechaPrestamo del prestamo.'
        );
    END IF;
END;
/

---------------------------------------------------------------------------------------------
-- [TRG-06] TRG_Multa_RetrasoAuto
-- Al insertar una Devolucion con estadoEntrega = 0 y cuyo Prestamo tiene diasRetraso > 0,
-- genera automáticamente una Multa de tipo 'Retraso' con monto = diasRetraso * 3000
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Multa_RetrasoAuto
AFTER INSERT ON Devolucion
FOR EACH ROW
DECLARE
    v_diasRetraso  Prestamo.diasRetraso%TYPE;
    v_idCliente    Prestamo.idCliente%TYPE;
    v_monto        NUMBER(10,2);
BEGIN
    SELECT diasRetraso, idCliente
    INTO   v_diasRetraso, v_idCliente
    FROM   Prestamo
    WHERE  id = :NEW.idPrestamo;

    IF :NEW.estadoEntrega = 0 AND v_diasRetraso > 0 THEN
        v_monto := v_diasRetraso * 3000;
        INSERT INTO Multa (id, idDevolucion, idCliente, montoAcumulado, motivo, estado)
        VALUES (NULL, :NEW.id, v_idCliente, v_monto, 'Retraso', 'Pendiente');
    END IF;
END;
/

---------------------------------------------------------------------------------------------
-- [TRG-07] TRG_Multa_PagadaEstado
-- Al insertar un Pago con estado 'Completado', actualiza el estado de la Multa a 'Pagada'
-- y descuenta el montoAcumulado del saldo del Cliente
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Multa_PagadaEstado
AFTER INSERT ON Pago
FOR EACH ROW
DECLARE
    v_monto Multa.montoAcumulado%TYPE;
BEGIN
    IF :NEW.estado = 'Completado' THEN
        SELECT montoAcumulado
        INTO   v_monto
        FROM   Multa
        WHERE  id = :NEW.idMulta;

        UPDATE Multa
        SET    estado = 'Pagada'
        WHERE  id = :NEW.idMulta;

        UPDATE Cliente
        SET    saldo = saldo - v_monto
        WHERE  idUsuario = :NEW.idCliente;
    END IF;
END;
/

---------------------------------------------------------------------------------------------
-- [TRG-08] TRG_Ejemplar_Disponibilidad
-- Al registrar un Prestamo, marca el Ejemplar como no disponible (disponibilidad = 0)
-- Al registrar una Devolucion con estadoEntrega = 1, lo marca disponible (disponibilidad = 1)
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Prestamo_EjemplarOcupar
AFTER INSERT ON Prestamo
FOR EACH ROW
BEGIN
    UPDATE Ejemplar
    SET    disponibilidad = 0
    WHERE  id = :NEW.idEjemplar;
END;
/

CREATE OR REPLACE TRIGGER TRG_Devolucion_EjemplarLiberar
AFTER INSERT ON Devolucion
FOR EACH ROW
DECLARE
    v_idEjemplar Prestamo.idEjemplar%TYPE;
BEGIN
    IF :NEW.estadoEntrega = 1 THEN
        SELECT idEjemplar
        INTO   v_idEjemplar
        FROM   Prestamo
        WHERE  id = :NEW.idPrestamo;

        UPDATE Ejemplar
        SET    disponibilidad = 1
        WHERE  id = v_idEjemplar;
    END IF;
END;
/

---------------------------------------------------------------------------------------------
-- [TRG-09] TRG_Cliente_EstadoMoroso
-- Al insertar o actualizar una Multa como 'Pendiente', cambia el estado del Cliente a 'Moroso'
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Cliente_EstadoMoroso
AFTER INSERT OR UPDATE OF estado ON Multa
FOR EACH ROW
BEGIN
    IF :NEW.estado = 'Pendiente' AND :NEW.idCliente IS NOT NULL THEN
        UPDATE Cliente
        SET    estado = 'Moroso'
        WHERE  idUsuario = :NEW.idCliente
          AND  estado NOT IN ('Suspendido', 'Inactivo');
    END IF;

    IF :NEW.estado = 'Pagada' AND :NEW.idCliente IS NOT NULL THEN
        -- Reactiva cliente si ya no tiene multas pendientes
        DECLARE
            v_pendientes NUMBER;
        BEGIN
            SELECT COUNT(*)
            INTO   v_pendientes
            FROM   Multa
            WHERE  idCliente = :NEW.idCliente
              AND  estado    = 'Pendiente'
              AND  id       <> :NEW.id;

            IF v_pendientes = 0 THEN
                UPDATE Cliente
                SET    estado = 'Activo'
                WHERE  idUsuario = :NEW.idCliente
                  AND  estado    = 'Moroso';
            END IF;
        END;
    END IF;
END;
/
