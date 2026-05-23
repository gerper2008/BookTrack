---------------------------------------------------------------------------------------------
--- RESTRICCIONES: TUPLAS -> Restricciones que implican más de un atributo
---------------------------------------------------------------------------------------------

-- [TUP-01] Prestamo: fechaPrestamo debe ser anterior o igual a fechaEstimada de su Devolucion
-- No aplica directo en Prestamo (fechaEstimada está en Devolucion), se controla en disparador.
-- Restricción interna: diasRetraso solo puede ser > 0 si el préstamo tiene devolución asociada
ALTER TABLE Prestamo ADD CONSTRAINT CHECK_Prestamo_Retraso_Coherencia
    CHECK (diasRetraso >= 0);

-- [TUP-02] Devolucion: fechaEstimada debe ser posterior a la fechaPrestamo del préstamo asociado
-- No ejecutable como CHECK puro (involucra otra tabla), se complementa con disparador TRG_Dev_Fecha.
-- Restricción interna: estadoEntrega = 0 puede tener observaciones opcionales
ALTER TABLE Devolucion ADD CONSTRAINT CHECK_Devolucion_EstadoObs
    CHECK (
        estadoEntrega = 1
        OR (estadoEntrega = 0)
    );

-- [TUP-03] Multa: si motivo = 'Retraso', montoAcumulado debe ser mayor a 0
ALTER TABLE Multa ADD CONSTRAINT CHECK_Multa_RetrasoMonto
    CHECK (
        motivo <> 'Retraso'
        OR montoAcumulado > 0
    );

-- [TUP-04] Multa: estado 'Pagada' implica que existe un pago (se refuerza en disparador)
-- Restricción interna: multa anulada no puede tener monto > 0
ALTER TABLE Multa ADD CONSTRAINT CHECK_Multa_AnuladaMonto
    CHECK (
        estado <> 'Anulada'
        OR montoAcumulado = 0
    );

-- [TUP-05] Pago: fechaPago debe ser posterior al registro de la multa asociada
-- No ejecutable como CHECK puro (involucra otra tabla), complementado con disparador TRG_Pago_Fecha.
-- Restricción interna: estado 'Rechazado' no puede coexistir con metodoPago 'Transferencia' 
--   (regla de negocio: transferencias no se rechazan en este sistema, se anulan)
ALTER TABLE Pago ADD CONSTRAINT CHECK_Pago_RechazoMetodo
    CHECK (
        estado <> 'Rechazado'
        OR metodoPago <> 'Transferencia'
    );

-- [TUP-06] Cliente: fechaVencimiento debe ser mayor a la fecha de creación (mínimo 1 mes futuro)
-- Restricción interna: cliente Suspendido puede tener saldo > 0 (deuda pendiente)
-- Restricción: cliente Inactivo debe tener saldo = 0
ALTER TABLE Cliente ADD CONSTRAINT CHECK_Cliente_InactivoSaldo
    CHECK (
        estado <> 'Inactivo'
        OR saldo = 0
    );
