---------------------------------------------------------------------------------------------
--- DISPARADORES: Automatización y restricciones procedimentales
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-- [TRG-01] Generar id de Prestamo → PR + 3 dígitos
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Prestamo_Generar_Id
BEFORE INSERT ON Prestamo
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    IF :NEW.id IS NULL THEN
        SELECT NVL(MAX(CASE
                WHEN REGEXP_LIKE(SUBSTR(id, 3), '^\d+$')
                THEN TO_NUMBER(SUBSTR(id, 3))
                ELSE 0
               END), 0)
        INTO lastID
        FROM Prestamo;
        :NEW.id := 'PR' || LPAD(lastID + 1, 3, '0');
    END IF;
END TRG_Prestamo_Generar_Id;
/

---------------------------------------------------------------------------------------------
-- [TRG-02] Generar id de Devolucion → DV + 3 dígitos
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Devolucion_Generar_Id
BEFORE INSERT ON Devolucion
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    IF :NEW.id IS NULL THEN
        SELECT NVL(MAX(CASE
                WHEN REGEXP_LIKE(SUBSTR(id, 3), '^\d+$')
                THEN TO_NUMBER(SUBSTR(id, 3))
                ELSE 0
               END), 0)
        INTO lastID
        FROM Devolucion;
        :NEW.id := 'DV' || LPAD(lastID + 1, 3, '0');
    END IF;
END TRG_Devolucion_Generar_Id;
/

---------------------------------------------------------------------------------------------
-- [TRG-03] Generar id de Multa → MT + 3 dígitos
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Multa_Generar_Id
BEFORE INSERT ON Multa
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    IF :NEW.id IS NULL THEN
        SELECT NVL(MAX(CASE
                WHEN REGEXP_LIKE(SUBSTR(id, 3), '^\d+$')
                THEN TO_NUMBER(SUBSTR(id, 3))
                ELSE 0
               END), 0)
        INTO lastID
        FROM Multa;
        :NEW.id := 'MT' || LPAD(lastID + 1, 3, '0');
    END IF;
END TRG_Multa_Generar_Id;
/

---------------------------------------------------------------------------------------------
-- [TRG-04] Generar id de Pago → PG + 3 dígitos
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Pago_Generar_Id
BEFORE INSERT ON Pago
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    IF :NEW.id IS NULL THEN
        SELECT NVL(MAX(CASE
                WHEN REGEXP_LIKE(SUBSTR(id, 3), '^\d+$')
                THEN TO_NUMBER(SUBSTR(id, 3))
                ELSE 0
               END), 0)
        INTO lastID
        FROM Pago;
        :NEW.id := 'PG' || LPAD(lastID + 1, 3, '0');
    END IF;
END TRG_Pago_Generar_Id;
/

---------------------------------------------------------------------------------------------
-- [TRG-05] Validar fechaEstimada de Devolucion posterior a fechaPrestamo
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
END TRG_Devolucion_Fecha;
/

---------------------------------------------------------------------------------------------
-- [TRG-06] Generar Multa de tipo 'Retraso' automáticamente al insertar Devolucion
-- con estadoEntrega = 0 y diasRetraso > 0. Monto = diasRetraso * 3000
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
END TRG_Multa_RetrasoAuto;
/

---------------------------------------------------------------------------------------------
-- [TRG-07] Al insertar Pago con estado 'Completado', marca la Multa como 'Pagada'
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
END TRG_Multa_PagadaEstado;
/

---------------------------------------------------------------------------------------------
-- [TRG-08A] Al registrar un Prestamo, marca el Ejemplar como no disponible
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Prestamo_EjemplarOcupar
AFTER INSERT ON Prestamo
FOR EACH ROW
BEGIN
    UPDATE Ejemplar
    SET    disponibilidad = 0
    WHERE  id = :NEW.idEjemplar;
END TRG_Prestamo_EjemplarOcupar;
/

---------------------------------------------------------------------------------------------
-- [TRG-08B] Al registrar una Devolucion con estadoEntrega = 1, libera el Ejemplar
---------------------------------------------------------------------------------------------
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
END TRG_Devolucion_EjemplarLiberar;
/

---------------------------------------------------------------------------------------------
-- [TRG-09] Al insertar o actualizar una Multa como 'Pendiente', cambia el estado
-- del Cliente a 'Moroso'. Si se paga y no quedan multas pendientes, reactiva al Cliente
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
END TRG_Cliente_EstadoMoroso;
/