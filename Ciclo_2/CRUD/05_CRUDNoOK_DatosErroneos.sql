-- ============================================================
-- CRUDNoOK - INTENTO DE INGRESO DE DATOS ERRONEOS (DETERMINISTICO)
-- Estos casos deben FALLAR por restricciones de negocio/integridad.
-- ============================================================

-- ============================================================
-- PRESTAMO
-- ============================================================

-- NoOK-01: Prestamo con idCliente NULL
BEGIN PC_PRESTAMO.AD_PRESTAMO(NULL, 'EJM001', TO_DATE('2025-01-10', 'YYYY-MM-DD')); END;
/

-- NoOK-02: Prestamo con idEjemplar NULL
BEGIN PC_PRESTAMO.AD_PRESTAMO('USR001', NULL, TO_DATE('2025-01-10', 'YYYY-MM-DD')); END;
/

-- NoOK-03: Prestamo con Cliente inexistente
BEGIN PC_PRESTAMO.AD_PRESTAMO('USR999', 'EJM001', TO_DATE('2025-01-10', 'YYYY-MM-DD')); END;
/

-- NoOK-04: Prestamo con Ejemplar inexistente
BEGIN PC_PRESTAMO.AD_PRESTAMO('USR001', 'EJM999', TO_DATE('2025-01-10', 'YYYY-MM-DD')); END;
/

-- NoOK-05: Prestamo con Ejemplar no disponible (disponibilidad = 0)
BEGIN PC_PRESTAMO.AD_PRESTAMO('USR001', 'EJM003', TO_DATE('2025-01-10', 'YYYY-MM-DD')); END;
/

-- NoOK-06: Prestamo con fechaPrestamo NULL
BEGIN PC_PRESTAMO.AD_PRESTAMO('USR001', 'EJM001', NULL); END;
/

-- NoOK-07: Modificar Prestamo con id inexistente
BEGIN PC_PRESTAMO.MOD_PRESTAMO('PR999', TO_DATE('2025-06-01', 'YYYY-MM-DD')); END;
/

-- NoOK-08: Eliminar Prestamo sin autorizacion de Administrador (idAdmin NULL)
BEGIN PC_PRESTAMO.ELI_PRESTAMO('PR001', NULL); END;
/

-- NoOK-09: Eliminar Prestamo con Administrador inexistente
BEGIN PC_PRESTAMO.ELI_PRESTAMO('PR001', 'USR999'); END;
/

-- ============================================================
-- DEVOLUCION
-- ============================================================

-- NoOK-10: Devolucion con idPrestamo NULL
BEGIN PC_DEVOLUCION.AD_DEVOLUCION(NULL, TRUE, 'Sin prestamo'); END;
/

-- NoOK-11: Devolucion con Prestamo inexistente
BEGIN PC_DEVOLUCION.AD_DEVOLUCION('PR999', TRUE, 'Prestamo no existe'); END;
/

-- NoOK-12: Devolucion con fechaEstimada anterior a fechaPrestamo (violacion TRG_Devolucion_Fecha)
-- Se inserta con una fecha ya vencida respecto al prestamo de referencia
BEGIN PC_DEVOLUCION.AD_DEVOLUCION('PR001', TRUE, 'Fecha invalida'); END;
/

-- NoOK-13: Devolucion duplicada sobre el mismo Prestamo (FK unica)
BEGIN PC_DEVOLUCION.AD_DEVOLUCION('PR001', FALSE, 'Segunda devolucion del mismo prestamo'); END;
/

-- NoOK-14: Modificar observaciones con caracteres invalidos (violacion CHECK_Devolucion_observaciones)
BEGIN PC_DEVOLUCION.MOD_DEVOLUCION('DV001', '!!!Caracter@Invalido###'); END;
/

-- NoOK-15: Eliminar Devolucion con Multa en estado Pagada asociada
BEGIN PC_DEVOLUCION.ELI_DEVOLUCION('DV002'); END;
/

-- ============================================================
-- MULTA
-- ============================================================

-- NoOK-16: Multa con idDevolucion NULL
BEGIN PC_MULTA.AD_MULTA(NULL, 'Retraso', 9000); END;
/

-- NoOK-17: Multa con Devolucion inexistente
BEGIN PC_MULTA.AD_MULTA('DV999', 'Daño', 15000); END;
/

-- NoOK-18: Multa con motivo invalido (violacion CHECK_Multa_motivo)
BEGIN PC_MULTA.AD_MULTA('DV002', 'Vandalismo', 30000); END;
/

-- NoOK-19: Multa de tipo Retraso con monto = 0 (violacion CHECK_Multa_RetrasoMonto)
BEGIN PC_MULTA.AD_MULTA('DV003', 'Retraso', 0); END;
/

-- NoOK-20: Multa con monto negativo (violacion CHECK_Multa_montoAcumulado)
BEGIN PC_MULTA.AD_MULTA('DV002', 'Daño', -5000); END;
/

-- NoOK-21: Modificar monto de Multa en estado Pagada
BEGIN PC_MULTA.MOD_MULTA('MT001', 99000, 'Pagada'); END;
/

-- NoOK-22: Modificar estado a valor invalido (violacion CHECK_Multa_estado)
BEGIN PC_MULTA.MOD_MULTA('MT002', 9000, 'Perdonada'); END;
/

-- NoOK-23: Eliminar Multa sin autorizacion de Administrador (idAdmin NULL)
BEGIN PC_MULTA.ELI_MULTA('MT002', NULL); END;
/

-- NoOK-24: Eliminar Multa con Administrador inexistente
BEGIN PC_MULTA.ELI_MULTA('MT002', 'USR999'); END;
/

-- ============================================================
-- PAGO
-- ============================================================

-- NoOK-25: Pago con idMulta NULL
BEGIN PC_PAGO.AD_PAGO(NULL, 45000, 'Efectivo'); END;
/

-- NoOK-26: Pago con Multa inexistente
BEGIN PC_PAGO.AD_PAGO('MT999', 45000, 'Efectivo'); END;
/

-- NoOK-27: Pago con metodoPago invalido (violacion CHECK_Pago_metodoPago)
BEGIN PC_PAGO.AD_PAGO('MT002', 9000, 'Criptomoneda'); END;
/

-- NoOK-28: Pago con Transferencia en estado Rechazado (violacion CHECK_Pago_RechazoMetodo)
-- Insercion directa para forzar el estado sin pasar por el paquete
INSERT INTO Pago(id, idCliente, idMulta, estado, fechaPago, metodoPago)
VALUES ('PGZV1', 'USR001', 'MT003', 'Rechazado', SYSDATE, 'Transferencia');
/

-- NoOK-29: Pago con monto abonado NULL
BEGIN PC_PAGO.AD_PAGO('MT003', NULL, 'Efectivo'); END;
/

-- NoOK-30: Modificar metodoPago de un Pago Completado ya conciliado
BEGIN PC_PAGO.MOD_PAGO('PG001', 'Otro'); END;
/

-- NoOK-31: Eliminar Pago en estado Completado
BEGIN PC_PAGO.ELI_PAGO('PG001'); END;
/
