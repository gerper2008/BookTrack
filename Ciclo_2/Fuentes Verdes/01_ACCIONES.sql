---------------------------------------------------------------------------------------------
--- ACCIONES: Definición de acciones de referencia
---------------------------------------------------------------------------------------------

-- Bibliotecario.idUsuario → Usuario(id) - ON DELETE CASCADE
-- Si se elimina el usuario, su registro de bibliotecario se elimina en cascada
ALTER TABLE Bibliotecario ADD CONSTRAINT FK_Bibliotecario_Usuario
    FOREIGN KEY (idUsuario) REFERENCES Usuario(id) ON DELETE CASCADE;

-- Cliente.idUsuario → Usuario(id) - ON DELETE CASCADE
-- Si se elimina el usuario, su registro de cliente se elimina en cascada
ALTER TABLE Cliente ADD CONSTRAINT FK_Cliente_Usuario
    FOREIGN KEY (idUsuario) REFERENCES Usuario(id) ON DELETE CASCADE;

-- Prestamo.idBibliotecario → Bibliotecario(idUsuario) - ON DELETE SET NULL
-- Si se elimina el bibliotecario, el préstamo conserva el registro con FK nula
ALTER TABLE Prestamo ADD CONSTRAINT FK_Prestamo_Bibliotecario
    FOREIGN KEY (idBibliotecario) REFERENCES Bibliotecario(idUsuario) ON DELETE SET NULL;

-- Prestamo.idCliente → Cliente(idUsuario) - ON DELETE SET NULL
-- Si se elimina el cliente, el préstamo conserva el registro con FK nula
ALTER TABLE Prestamo ADD CONSTRAINT FK_Prestamo_Cliente
    FOREIGN KEY (idCliente) REFERENCES Cliente(idUsuario) ON DELETE SET NULL;

-- Prestamo.idEjemplar → Ejemplar(id) - ON DELETE SET NULL
-- Si se elimina el ejemplar, el préstamo conserva el registro con FK nula
ALTER TABLE Prestamo ADD CONSTRAINT FK_Prestamo_Ejemplar
    FOREIGN KEY (idEjemplar) REFERENCES Ejemplar(id) ON DELETE SET NULL;

-- Devolucion.idPrestamo → Prestamo(id) - ON DELETE CASCADE
-- Si se elimina el préstamo, su devolución asociada se elimina en cascada
ALTER TABLE Devolucion ADD CONSTRAINT FK_Devolucion_Prestamo
    FOREIGN KEY (idPrestamo) REFERENCES Prestamo(id) ON DELETE CASCADE;

-- Multa.idDevolucion → Devolucion(id) - ON DELETE CASCADE
-- Si se elimina la devolución, la multa asociada se elimina en cascada
ALTER TABLE Multa ADD CONSTRAINT FK_Multa_Devolucion
    FOREIGN KEY (idDevolucion) REFERENCES Devolucion(id) ON DELETE CASCADE;

-- Multa.idCliente → Cliente(idUsuario) - ON DELETE SET NULL
-- Si se elimina el cliente, la multa conserva el registro con FK nula
ALTER TABLE Multa ADD CONSTRAINT FK_Multa_Cliente
    FOREIGN KEY (idCliente) REFERENCES Cliente(idUsuario) ON DELETE SET NULL;

-- Pago.idCliente → Cliente(idUsuario) - ON DELETE SET NULL
-- Si se elimina el cliente, el pago conserva el registro con FK nula
ALTER TABLE Pago ADD CONSTRAINT FK_Pago_Cliente
    FOREIGN KEY (idCliente) REFERENCES Cliente(idUsuario) ON DELETE SET NULL;

-- Pago.idMulta → Multa(id) - ON DELETE CASCADE
-- Si se elimina la multa, el pago asociado se elimina en cascada
ALTER TABLE Pago ADD CONSTRAINT FK_Pago_Multa
    FOREIGN KEY (idMulta) REFERENCES Multa(id) ON DELETE CASCADE;

---------------------------------------------------------------------------------------------
--- Eliminar Acciones
---------------------------------------------------------------------------------------------
ALTER TABLE Pago          DROP CONSTRAINT FK_Pago_Multa;
ALTER TABLE Pago          DROP CONSTRAINT FK_Pago_Cliente;
ALTER TABLE Multa         DROP CONSTRAINT FK_Multa_Cliente;
ALTER TABLE Multa         DROP CONSTRAINT FK_Multa_Devolucion;
ALTER TABLE Devolucion    DROP CONSTRAINT FK_Devolucion_Prestamo;
ALTER TABLE Prestamo      DROP CONSTRAINT FK_Prestamo_Ejemplar;
ALTER TABLE Prestamo      DROP CONSTRAINT FK_Prestamo_Cliente;
ALTER TABLE Prestamo      DROP CONSTRAINT FK_Prestamo_Bibliotecario;
ALTER TABLE Cliente       DROP CONSTRAINT FK_Cliente_Usuario;
ALTER TABLE Bibliotecario DROP CONSTRAINT FK_Bibliotecario_Usuario;
