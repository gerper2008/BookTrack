---------------------------------------------------------------------------------------------
--- PRUEBAS: DISPARADORES_OK -> Inserción válida que demuestra cada disparador
---------------------------------------------------------------------------------------------

-- Prerequisitos base (si no fueron insertados en TUPLAS_OK)
INSERT INTO Usuario VALUES ('U010', 'base1@lib.co', 'Bibliotecario', 'Base', 'Uno', '3000000001');
INSERT INTO Usuario VALUES ('U011', 'base2@lib.co', 'Lector', 'Base', 'Dos', '3000000002');
INSERT INTO Bibliotecario VALUES ('U010', 'Mañana', 'Operativo', 1);
INSERT INTO Cliente VALUES ('U011', 'Activo', TO_DATE('31/12/2026','DD/MM/YYYY'), 30000);

---------------------------------------------------------------------------------------------
-- [TRG-01] TRG_Prestamo_ID
-- Se inserta sin proporcionar id -> el trigger asigna PR001 automaticamente
---------------------------------------------------------------------------------------------
INSERT INTO Usuario VALUES ('U100', 'trg1@lib.co', 'Lector', 'Trigger', 'Uno', '3000000100');
INSERT INTO Cliente  VALUES ('U100', 'Activo', TO_DATE('31/12/2026','DD/MM/YYYY'), 0);
 
INSERT INTO Prestamo (fechaPrestamo, diasRetraso, idBibliotecario, idCliente, idEjemplar)
VALUES (TO_DATE('02/05/2025','DD/MM/YYYY'), 0, 'U010', 'U100', NULL);

-- Verificacion: id generado con formato PR + 3 digitos
SELECT id, fechaPrestamo, idCliente
FROM   Prestamo
WHERE  idCliente = 'U100'
ORDER  BY id DESC
FETCH  FIRST 1 ROWS ONLY;

---------------------------------------------------------------------------------------------
-- [TRG-02] TRG_Devolucion_ID
-- Se inserta sin proporcionar id -> el trigger asigna DV001 automaticamente
---------------------------------------------------------------------------------------------
INSERT INTO Devolucion (idPrestamo, fechaEstimada, observaciones, estadoEntrega)
VALUES (
    (SELECT id FROM Prestamo WHERE idCliente = 'U100' ORDER BY id DESC FETCH FIRST 1 ROWS ONLY),
    TO_DATE('17/05/2025','DD/MM/YYYY'),
    NULL,
    1
);

-- Verificacion: id generado con formato DV + 3 digitos
SELECT id, idPrestamo, estadoEntrega
FROM   Devolucion
ORDER  BY id DESC
FETCH  FIRST 1 ROWS ONLY;

---------------------------------------------------------------------------------------------
-- [TRG-03] TRG_Multa_ID
-- Se inserta Multa sin id -> el trigger asigna MT001 automaticamente
---------------------------------------------------------------------------------------------
INSERT INTO Usuario VALUES ('U101', 'trg3@lib.co', 'Lector', 'Trigger', 'Tres', '3000000101');
INSERT INTO Cliente VALUES ('U101', 'Activo', TO_DATE('31/12/2026','DD/MM/YYYY'), 20000);

INSERT INTO Prestamo (fechaPrestamo, diasRetraso, idBibliotecario, idCliente, idEjemplar)
VALUES (TO_DATE('01/03/2025','DD/MM/YYYY'), 4, 'U010', 'U101', NULL);

INSERT INTO Devolucion (idPrestamo, fechaEstimada, observaciones, estadoEntrega)
VALUES (
    (SELECT id FROM Prestamo WHERE idCliente = 'U101' AND ROWNUM = 1),
    TO_DATE('10/03/2025','DD/MM/YYYY'),
    'Devolucion con retraso manual',
    1
);

INSERT INTO Multa (idDevolucion, idCliente, montoAcumulado, motivo, estado)
VALUES (
    (SELECT id FROM Devolucion
     WHERE idPrestamo = (SELECT id FROM Prestamo WHERE idCliente = 'U101' AND ROWNUM = 1)
     AND ROWNUM = 1),
    'U101', 12000, 'Retraso', 'Pendiente'
);

-- Verificacion: id generado con formato MT + 3 digitos
SELECT id, motivo, montoAcumulado, estado
FROM   Multa
ORDER  BY id DESC
FETCH  FIRST 1 ROWS ONLY;

---------------------------------------------------------------------------------------------
-- [TRG-04] TRG_Pago_ID
-- Se inserta Pago sin id -> el trigger asigna PG001 automaticamente
---------------------------------------------------------------------------------------------
INSERT INTO Pago (idCliente, idMulta, estado, fechaPago, metodoPago)
VALUES (
    'U101',
    (SELECT id FROM Multa WHERE idCliente = 'U101' AND ROWNUM = 1),
    'Completado',
    TO_DATE('15/03/2025','DD/MM/YYYY'),
    'Efectivo'
);

-- Verificacion: id generado con formato PG + 3 digitos
SELECT id, estado, metodoPago
FROM   Pago
ORDER  BY id DESC
FETCH  FIRST 1 ROWS ONLY;

---------------------------------------------------------------------------------------------
-- [TRG-05] TRG_Devolucion_Fecha
-- fechaEstimada posterior a fechaPrestamo -> insercion valida sin error
-- Prestamo: 01/04/2025  |  fechaEstimada: 15/04/2025 -> OK
---------------------------------------------------------------------------------------------
INSERT INTO Usuario VALUES ('U102', 'trg5@lib.co', 'Lector', 'Trigger', 'Cinco', '3000000102');
INSERT INTO Cliente VALUES ('U102', 'Activo', TO_DATE('31/12/2026','DD/MM/YYYY'), 0);

INSERT INTO Prestamo (fechaPrestamo, diasRetraso, idBibliotecario, idCliente, idEjemplar)
VALUES (TO_DATE('01/04/2025','DD/MM/YYYY'), 0, 'U010', 'U102', NULL);

INSERT INTO Devolucion (idPrestamo, fechaEstimada, observaciones, estadoEntrega)
VALUES (
    (SELECT id FROM Prestamo WHERE idCliente = 'U102' AND ROWNUM = 1),
    TO_DATE('15/04/2025','DD/MM/YYYY'),   -- posterior a 01/04/2025 -> valido
    NULL,
    1
);

-- Verificacion: la devolucion existe con fecha posterior al prestamo
SELECT d.id, d.fechaEstimada, p.fechaPrestamo
FROM   Devolucion d
JOIN   Prestamo   p ON p.id = d.idPrestamo
WHERE  p.idCliente = 'U102';

---------------------------------------------------------------------------------------------
-- [TRG-06] TRG_Multa_RetrasoAuto
-- Devolucion con estadoEntrega = 0 y diasRetraso > 0 -> multa generada automaticamente
---------------------------------------------------------------------------------------------
INSERT INTO Usuario VALUES ('U103', 'trg6@lib.co', 'Lector', 'Trigger', 'Seis', '3000000103');
INSERT INTO Cliente VALUES ('U103', 'Activo', TO_DATE('31/12/2026','DD/MM/YYYY'), 0);

INSERT INTO Prestamo (fechaPrestamo, diasRetraso, idBibliotecario, idCliente, idEjemplar)
VALUES (TO_DATE('05/04/2025','DD/MM/YYYY'), 3, 'U010', 'U103', NULL);

-- Al insertar esta devolucion con estadoEntrega=0, el trigger crea la multa (3 dias * 3000 = 9000)
INSERT INTO Devolucion (idPrestamo, fechaEstimada, observaciones, estadoEntrega)
VALUES (
    (SELECT id FROM Prestamo WHERE idCliente = 'U103' AND ROWNUM = 1),
    TO_DATE('12/04/2025','DD/MM/YYYY'),
    'No entrego a tiempo',
    0
);

-- Verificacion: multa creada automaticamente por el trigger
SELECT m.id, m.motivo, m.montoAcumulado, m.estado, m.idCliente
FROM   Multa    m
JOIN   Devolucion d ON d.id = m.idDevolucion
JOIN   Prestamo   p ON p.id = d.idPrestamo
WHERE  p.idCliente = 'U103';

---------------------------------------------------------------------------------------------
-- [TRG-07] TRG_Multa_PagadaEstado
-- Pago Completado -> multa cambia a 'Pagada' y saldo del cliente se descuenta
---------------------------------------------------------------------------------------------
INSERT INTO Usuario VALUES ('U104', 'trg7@lib.co', 'Lector', 'Trigger', 'Siete', '3000000104');
INSERT INTO Cliente VALUES ('U104', 'Activo', TO_DATE('31/12/2026','DD/MM/YYYY'), 25000);

INSERT INTO Prestamo (fechaPrestamo, diasRetraso, idBibliotecario, idCliente, idEjemplar)
VALUES (TO_DATE('01/02/2025','DD/MM/YYYY'), 2, 'U010', 'U104', NULL);

INSERT INTO Devolucion (idPrestamo, fechaEstimada, observaciones, estadoEntrega)
VALUES (
    (SELECT id FROM Prestamo WHERE idCliente = 'U104' AND ROWNUM = 1),
    TO_DATE('10/02/2025','DD/MM/YYYY'),
    'Entrega tardia',
    1
);

-- Multa manual de 6000
INSERT INTO Multa (idDevolucion, idCliente, montoAcumulado, motivo, estado)
VALUES (
    (SELECT id FROM Devolucion
     WHERE idPrestamo = (SELECT id FROM Prestamo WHERE idCliente = 'U104' AND ROWNUM = 1)
     AND ROWNUM = 1),
    'U104', 6000, 'Retraso', 'Pendiente'
);

-- Al insertar este pago Completado, el trigger actualiza Multa -> Pagada y saldo 25000-6000=19000
INSERT INTO Pago (idCliente, idMulta, estado, fechaPago, metodoPago)
VALUES (
    'U104',
    (SELECT id FROM Multa WHERE idCliente = 'U104' AND ROWNUM = 1),
    'Completado',
    TO_DATE('15/02/2025','DD/MM/YYYY'),
    'Tarjeta'
);

-- Verificacion: multa = Pagada, saldo cliente = 19000
SELECT m.id, m.estado AS estado_multa
FROM   Multa m WHERE m.idCliente = 'U104';

SELECT idUsuario, saldo FROM Cliente WHERE idUsuario = 'U104';

---------------------------------------------------------------------------------------------
-- [TRG-08a] TRG_Prestamo_EjemplarOcupar
-- Al insertar prestamo, el ejemplar pasa a disponibilidad = 0
---------------------------------------------------------------------------------------------
-- Prerequisito: ejemplar existente con disponibilidad = 1
INSERT INTO Prestamo (fechaPrestamo, diasRetraso, idBibliotecario, idCliente, idEjemplar)
VALUES (
    TO_DATE('10/05/2025','DD/MM/YYYY'),
    0,
    'U010',
    'U011',
    (SELECT id FROM Ejemplar WHERE disponibilidad = 1 AND ROWNUM = 1)
);

-- Verificacion: disponibilidad = 0
SELECT p.idEjemplar AS id_ejemplar, e.disponibilidad
FROM   Prestamo p
JOIN   Ejemplar e ON e.id = p.idEjemplar
WHERE  p.idCliente = 'U011'
  AND  p.fechaPrestamo = TO_DATE('10/05/2025','DD/MM/YYYY')
  AND  ROWNUM = 1;

---------------------------------------------------------------------------------------------
-- [TRG-08b] TRG_Devolucion_EjemplarLiberar
-- Al insertar devolucion con estadoEntrega = 1, el ejemplar vuelve a disponibilidad = 1
---------------------------------------------------------------------------------------------
INSERT INTO Devolucion (idPrestamo, fechaEstimada, observaciones, estadoEntrega)
VALUES (
    (SELECT id FROM Prestamo WHERE idEjemplar = (
         SELECT id FROM Ejemplar WHERE disponibilidad = 0 AND ROWNUM = 1
     ) ORDER BY id DESC FETCH FIRST 1 ROWS ONLY),
    TO_DATE('25/05/2025','DD/MM/YYYY'),
    NULL,
    1
);

-- Verificacion: disponibilidad = 1 (liberado por trigger)
SELECT e.id, e.disponibilidad
FROM   Ejemplar e
WHERE  e.id = (
    SELECT p.idEjemplar
    FROM   Prestamo p
    WHERE  p.idCliente = 'U011'
      AND  p.fechaPrestamo = TO_DATE('10/05/2025','DD/MM/YYYY')
      AND  ROWNUM = 1
);

---------------------------------------------------------------------------------------------
-- [TRG-09] TRG_Cliente_EstadoMoroso
-- Al insertar Multa Pendiente, el cliente pasa a estado 'Moroso' automaticamente
---------------------------------------------------------------------------------------------
INSERT INTO Usuario VALUES ('U105', 'trg9@lib.co', 'Lector', 'Trigger', 'Nueve', '3000000105');
INSERT INTO Cliente VALUES ('U105', 'Activo', TO_DATE('31/12/2026','DD/MM/YYYY'), 10000);

INSERT INTO Prestamo (fechaPrestamo, diasRetraso, idBibliotecario, idCliente, idEjemplar)
VALUES (TO_DATE('01/01/2025','DD/MM/YYYY'), 7, 'U010', 'U105', NULL);

INSERT INTO Devolucion (idPrestamo, fechaEstimada, observaciones, estadoEntrega)
VALUES (
    (SELECT id FROM Prestamo WHERE idCliente = 'U105' AND ROWNUM = 1),
    TO_DATE('15/01/2025','DD/MM/YYYY'),
    'Devolucion tardia grave',
    1
);

-- Al insertar esta multa Pendiente, el trigger pone al cliente en 'Moroso'
INSERT INTO Multa (idDevolucion, idCliente, montoAcumulado, motivo, estado)
VALUES (
    (SELECT id FROM Devolucion
     WHERE idPrestamo = (SELECT id FROM Prestamo WHERE idCliente = 'U105' AND ROWNUM = 1)
     AND ROWNUM = 1),
    'U105', 21000, 'Retraso', 'Pendiente'
);

-- Verificacion: estado del cliente = 'Moroso'
SELECT idUsuario, estado FROM Cliente WHERE idUsuario = 'U105';

COMMIT;
