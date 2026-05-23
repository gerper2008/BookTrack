---------------------------------------------------------------------------------------------
--- PERSISTENCIA: PRIMARIAS -> Definición de claves primarias
---------------------------------------------------------------------------------------------
ALTER TABLE Bibliotecario ADD PRIMARY KEY (idUsuario);
ALTER TABLE Cliente       ADD PRIMARY KEY (idUsuario);
ALTER TABLE Prestamo      ADD PRIMARY KEY (id);
ALTER TABLE Devolucion    ADD PRIMARY KEY (id);
ALTER TABLE Multa         ADD PRIMARY KEY (id);
ALTER TABLE Pago          ADD PRIMARY KEY (id);

---------------------------------------------------------------------------------------------
--- PERSISTENCIA: UNICAS -> Definición de claves únicas
---------------------------------------------------------------------------------------------
-- Devolución es 1:1 con Préstamo
ALTER TABLE Devolucion ADD CONSTRAINT UQ_Devolucion_Prestamo UNIQUE (idPrestamo);

-- Multa vinculada 1:1 con Devolución (una devolución genera a lo sumo una multa)
ALTER TABLE Multa ADD CONSTRAINT UQ_Multa_Devolucion UNIQUE (idDevolucion);

-- Un pago corresponde a una única multa
ALTER TABLE Pago ADD CONSTRAINT UQ_Pago_Multa UNIQUE (idMulta);

---------------------------------------------------------------------------------------------
--- PERSISTENCIA: FORANEAS -> Definición lógica de relaciones
--- (Documentación, no ejecutar. Las relaciones reales están en ACCIONES)
---------------------------------------------------------------------------------------------
-- Bibliotecario.idUsuario  → Usuario(id)
-- Cliente.idUsuario        → Usuario(id)
-- Prestamo.idBibliotecario → Bibliotecario(idUsuario)
-- Prestamo.idCliente       → Cliente(idUsuario)
-- Prestamo.idEjemplar      → Ejemplar(id)
-- Devolucion.idPrestamo    → Prestamo(id)
-- Multa.idDevolucion       → Devolucion(id)
-- Multa.idCliente          → Cliente(idUsuario)
-- Pago.idCliente           → Cliente(idUsuario)
-- Pago.idMulta             → Multa(id)
