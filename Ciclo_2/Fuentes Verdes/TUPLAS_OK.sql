---------------------------------------------------------------------------------------------
--- PRUEBAS: TUPLAS_OK -> Inserción válida por cada restricción de tupla
---------------------------------------------------------------------------------------------

-- Prerequisitos: usuarios y roles base para FK
INSERT INTO Usuario VALUES ('U010', 'base1@lib.co', 'Bibliotecario', 'Base',     'Uno',    '3000000001');
INSERT INTO Usuario VALUES ('U011', 'base2@lib.co', 'Lector',        'Base',     'Dos',    '3000000002');
INSERT INTO Usuario VALUES ('U012', 'base3@lib.co', 'Lector',        'Base',     'Tres',   '3000000003');
INSERT INTO Usuario VALUES ('U013', 'base4@lib.co', 'Lector',        'Inactivo', 'Test',   '3000000004');
INSERT INTO Bibliotecario VALUES ('U010', 'Mañana', 'Operativo', 1);

---------------------------------------------------------------------------------------------
-- [TUP-01] CHECK_Prestamo_Retraso_Coherencia
-- diasRetraso >= 0 -> insertar prestamo con diasRetraso = 0 (sin retraso, valido)
---------------------------------------------------------------------------------------------
INSERT INTO Cliente VALUES ('U011', 'Activo', TO_DATE('31/12/2026','DD/MM/YYYY'), 0);

INSERT INTO Prestamo (fechaPrestamo, diasRetraso, idBibliotecario, idCliente, idEjemplar)
VALUES (TO_DATE('01/05/2025','DD/MM/YYYY'), 0, 'U010', 'U011', NULL);

SELECT id, diasRetraso FROM Prestamo WHERE diasRetraso = 0 AND idCliente = 'U011';

---------------------------------------------------------------------------------------------
-- [TUP-02] CHECK_Devolucion_EstadoObs
-- estadoEntrega = 1 (entrega correcta) sin observaciones -> valido
---------------------------------------------------------------------------------------------
INSERT INTO Devolucion (idPrestamo, fechaEstimada, observaciones, estadoEntrega)
VALUES (
    (SELECT id FROM Prestamo WHERE idCliente = 'U011' AND ROWNUM = 1),
    TO_DATE('15/05/2025','DD/MM/YYYY'),
    NULL,
    1
);

SELECT id, estadoEntrega, observaciones FROM Devolucion WHERE estadoEntrega = 1;

---------------------------------------------------------------------------------------------
-- [TUP-03] CHECK_Multa_RetrasoMonto
-- motivo = 'Retraso' con montoAcumulado > 0 -> cumple la restriccion
---------------------------------------------------------------------------------------------
INSERT INTO Cliente VALUES ('U012', 'Activo', TO_DATE('31/12/2026','DD/MM/YYYY'), 50000);

INSERT INTO Prestamo (fechaPrestamo, diasRetraso, idBibliotecario, idCliente, idEjemplar)
VALUES (TO_DATE('01/04/2025','DD/MM/YYYY'), 5, 'U010', 'U012', NULL);

INSERT INTO Devolucion (idPrestamo, fechaEstimada, observaciones, estadoEntrega)
VALUES (
    (SELECT id FROM Prestamo WHERE idCliente = 'U012' AND ROWNUM = 1),
    TO_DATE('10/04/2025','DD/MM/YYYY'),
    'Entrega con dias de retraso',
    0
);

INSERT INTO Multa (idDevolucion, idCliente, montoAcumulado, motivo, estado)
VALUES (
    (SELECT id FROM Devolucion
     WHERE idPrestamo = (SELECT id FROM Prestamo WHERE idCliente = 'U012' AND ROWNUM = 1)
     AND ROWNUM = 1),
    'U012', 15000, 'Retraso', 'Pendiente'
);

SELECT id, motivo, montoAcumulado FROM Multa WHERE motivo = 'Retraso' AND montoAcumulado > 0;

---------------------------------------------------------------------------------------------
-- [TUP-04] CHECK_Multa_AnuladaMonto
-- estado = 'Anulada' con montoAcumulado = 0 -> cumple la restriccion
---------------------------------------------------------------------------------------------
INSERT INTO Multa (idDevolucion, idCliente, montoAcumulado, motivo, estado)
VALUES (
    (SELECT id FROM Devolucion WHERE estadoEntrega = 1 AND ROWNUM = 1),
    'U011', 0, 'Otro', 'Anulada'
);

SELECT id, estado, montoAcumulado FROM Multa WHERE estado = 'Anulada' AND montoAcumulado = 0;

---------------------------------------------------------------------------------------------
-- [TUP-05] CHECK_Pago_RechazoMetodo
-- estado = 'Rechazado' con metodoPago = 'Efectivo' -> permitido (no es Transferencia)
---------------------------------------------------------------------------------------------
INSERT INTO Pago (idCliente, idMulta, estado, fechaPago, metodoPago)
VALUES (
    'U012',
    (SELECT id FROM Multa WHERE motivo = 'Retraso' AND idCliente = 'U012' AND ROWNUM = 1),
    'Rechazado',
    TO_DATE('20/04/2025','DD/MM/YYYY'),
    'Efectivo'
);

SELECT id, estado, metodoPago FROM Pago WHERE estado = 'Rechazado' AND metodoPago = 'Efectivo';

---------------------------------------------------------------------------------------------
-- [TUP-06] CHECK_Cliente_InactivoSaldo
-- estado = 'Inactivo' con saldo = 0 -> cumple la restriccion
---------------------------------------------------------------------------------------------
INSERT INTO Cliente VALUES ('U013', 'Inactivo', TO_DATE('01/01/2025','DD/MM/YYYY'), 0);

SELECT idUsuario, estado, saldo FROM Cliente WHERE estado = 'Inactivo' AND saldo = 0;

COMMIT;
