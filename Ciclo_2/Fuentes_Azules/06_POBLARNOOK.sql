---------------------------------------------------------------------------------------------
--- PRUEBAS: PoblarNoOK -> Intento de ingreso de datos erróneos
--- Protegidos por: tipos de datos, nulidades, PK, UQ y FK
---------------------------------------------------------------------------------------------

-- [NoOK-01] CHECK: jornada inválida en Bibliotecario
INSERT INTO Bibliotecario VALUES ('U001', 'Nocturna', 'Operativo', 1);
-- Falla: CHECK_Bibliotecario_jornada (valor fuera de dominio)

-- [NoOK-02] NOT NULL: permisos nulo en Bibliotecario
INSERT INTO Bibliotecario VALUES ('U002', 'Mañana', NULL, 1);
-- Falla: NOT NULL sobre permisos

-- [NoOK-03] CHECK: estado de cliente inválido
INSERT INTO Cliente VALUES ('U003', 'Bloqueado', TO_DATE('01/01/2026','DD/MM/YYYY'), 0);
-- Falla: CHECK_Cliente_estado (valor fuera de dominio)

-- [NoOK-04] CHECK: saldo negativo en Cliente
INSERT INTO Cliente VALUES ('U004', 'Activo', TO_DATE('01/01/2026','DD/MM/YYYY'), -500);
-- Falla: CHECK_Cliente_saldo (saldo < 0)

-- [NoOK-05] NOT NULL: fechaPrestamo nula
INSERT INTO Prestamo VALUES ('PR099', NULL, 0, 'U001', 'U003', 'EJ001');
-- Falla: NOT NULL sobre fechaPrestamo

-- [NoOK-06] FK: Préstamo con idBibliotecario inexistente
INSERT INTO Prestamo VALUES ('PR099', TO_DATE('01/01/2025','DD/MM/YYYY'), 0, 'U999', 'U003', 'EJ001');
-- Falla: FK_Prestamo_Bibliotecario (U999 no existe en Bibliotecario)

-- [NoOK-07] FK: Préstamo con idCliente inexistente
INSERT INTO Prestamo VALUES ('PR099', TO_DATE('01/01/2025','DD/MM/YYYY'), 0, 'U001', 'U999', 'EJ001');
-- Falla: FK_Prestamo_Cliente (U999 no existe en Cliente)

-- [NoOK-08] PK: id duplicado en Devolucion
INSERT INTO Devolucion VALUES ('DV001', 'PR003', TO_DATE('01/05/2025','DD/MM/YYYY'), NULL, 1);
-- Falla: PRIMARY KEY (DV001 ya existe)

-- [NoOK-09] UQ: idPrestamo duplicado en Devolucion (1 préstamo → 1 devolución)
INSERT INTO Devolucion VALUES ('DV099', 'PR001', TO_DATE('01/05/2025','DD/MM/YYYY'), NULL, 1);
-- Falla: UQ_Devolucion_Prestamo (PR001 ya tiene devolución DV001)

-- [NoOK-10] CHECK: motivo de multa inválido
INSERT INTO Multa VALUES ('MT099', 'DV001', 'U003', 500, 'Extravío', 'Pendiente');
-- Falla: CHECK_Multa_motivo (valor fuera de dominio)

-- [NoOK-11] CHECK: estado de multa inválido
INSERT INTO Multa VALUES ('MT099', 'DV001', 'U003', 500, 'Retraso', 'En proceso');
-- Falla: CHECK_Multa_estado (valor fuera de dominio)

-- [NoOK-12] CHECK: montoAcumulado negativo
INSERT INTO Multa VALUES ('MT099', 'DV001', 'U003', -200, 'Retraso', 'Pendiente');
-- Falla: CHECK_Multa_montoAcumulado (monto < 0)

-- [NoOK-13] NOT NULL: estado nulo en Pago
INSERT INTO Pago VALUES ('PG099', 'U003', 'MT001', NULL, TO_DATE('01/04/2025','DD/MM/YYYY'), 'Efectivo');
-- Falla: NOT NULL sobre estado

-- [NoOK-14] CHECK: metodoPago inválido
INSERT INTO Pago VALUES ('PG099', 'U003', 'MT001', 'Completado', TO_DATE('01/04/2025','DD/MM/YYYY'), 'Cripto');
-- Falla: CHECK_Pago_metodoPago (valor fuera de dominio)

-- [NoOK-15] FK: Pago con idMulta inexistente
INSERT INTO Pago VALUES ('PG099', 'U003', 'MT999', 'Completado', TO_DATE('01/04/2025','DD/MM/YYYY'), 'Efectivo');
-- Falla: FK_Pago_Multa (MT999 no existe en Multa)
