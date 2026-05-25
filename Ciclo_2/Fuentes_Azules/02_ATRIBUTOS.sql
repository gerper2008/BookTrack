---------------------------------------------------------------------------------------------
--- PERSISTENCIA: ATRIBUTOS -> Definición de restricciones para un único atributo
---------------------------------------------------------------------------------------------

-- Bibliotecario
ALTER TABLE Bibliotecario ADD CONSTRAINT CHECK_Bibliotecario_jornada
    CHECK (jornada IN ('Mañana', 'Tarde', 'Noche', 'Completa'));
ALTER TABLE Bibliotecario ADD CONSTRAINT CHECK_Bibliotecario_permisos
    CHECK (permisos IN ('Solo Lectura', 'Operativo', 'Total'));
ALTER TABLE Bibliotecario ADD CONSTRAINT CHECK_Bibliotecario_disponibilidad
    CHECK (disponibilidad IN (0, 1));
ALTER TABLE Bibliotecario
MODIFY (
    jornada       NOT NULL,
    permisos      NOT NULL,
    disponibilidad NOT NULL
);

-- Cliente
ALTER TABLE Cliente ADD CONSTRAINT CHECK_Cliente_estado
    CHECK (estado IN ('Activo', 'Suspendido', 'Inactivo', 'Moroso'));
ALTER TABLE Cliente ADD CONSTRAINT CHECK_Cliente_fechaVencimiento
    CHECK (fechaVencimiento >= TO_DATE('01/01/2026', 'DD/MM/YYYY'));
ALTER TABLE Cliente ADD CONSTRAINT CHECK_Cliente_saldo
    CHECK (saldo >= 0);
ALTER TABLE Cliente
MODIFY (
    estado           NOT NULL,
    fechaVencimiento NOT NULL,
    saldo            NOT NULL
);

-- Prestamo
ALTER TABLE Prestamo ADD CONSTRAINT CHECK_Prestamo_fechaPrestamo
    CHECK (fechaPrestamo <= TO_DATE('31/12/2026', 'DD/MM/YYYY'));
ALTER TABLE Prestamo ADD CONSTRAINT CHECK_Prestamo_diasRetraso
    CHECK (diasRetraso >= 0);
ALTER TABLE Prestamo
MODIFY (
    fechaPrestamo NOT NULL,
    idCliente NOT NULL,
    idBibliotecario NOT NULL,
    idEjemplar NOT NULL
);

-- Devolucion
ALTER TABLE Devolucion ADD CONSTRAINT CHECK_Devolucion_observaciones
    CHECK (REGEXP_LIKE(observaciones, '^[A-Za-z0-9áéíóúÁÉÍÓÚüÜñÑ ,.-]+$'));
ALTER TABLE Devolucion ADD CONSTRAINT CHECK_Devolucion_fechaEstimada
    CHECK (fechaEstimada >= TO_DATE('01/01/2026', 'DD/MM/YYYY'));
ALTER TABLE Devolucion ADD CONSTRAINT CHECK_Devolucion_estadoEntrega
    CHECK (estadoEntrega IN (0, 1));
ALTER TABLE Devolucion
MODIFY (
    fechaEstimada NOT NULL,
    estadoEntrega NOT NULL
);

-- Multa
ALTER TABLE Multa ADD CONSTRAINT CHECK_Multa_montoAcumulado
    CHECK (montoAcumulado >= 0);
ALTER TABLE Multa ADD CONSTRAINT CHECK_Multa_motivo
    CHECK (motivo IN ('Retraso', 'Daño', 'Perdida', 'Otro'));
ALTER TABLE Multa ADD CONSTRAINT CHECK_Multa_estado
    CHECK (estado IN ('Pendiente', 'Pagada', 'Anulada'));
ALTER TABLE Multa
MODIFY (
    montoAcumulado NOT NULL,
    motivo         NOT NULL,
    estado         NOT NULL
);

-- Pago
ALTER TABLE Pago ADD CONSTRAINT CHECK_Pago_estado
    CHECK (estado IN ('Completado', 'Pendiente', 'Rechazado'));
ALTER TABLE Pago ADD CONSTRAINT CHECK_Pago_metodoPago
    CHECK (metodoPago IN ('Efectivo', 'Tarjeta', 'Transferencia', 'Otro'));
ALTER TABLE Pago ADD CONSTRAINT CHECK_Pago_fechaPago
    CHECK (fechaPago <= TO_DATE('31/12/2026', 'DD/MM/YYYY'));
ALTER TABLE Pago
MODIFY (
    estado     NOT NULL,
    fechaPago  NOT NULL,
    metodoPago NOT NULL
);