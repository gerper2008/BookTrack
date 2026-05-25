---------------------------------------------------------------------------------------------
--- PRUEBAS: XPoblar -> Eliminación de datos
---------------------------------------------------------------------------------------------

-- [Orden inverso a dependencias FK para evitar violaciones de integridad]

-- Pagos
DELETE FROM Pago WHERE id = 'PG001';

-- Multas
DELETE FROM Multa WHERE id IN ('MT001', 'MT002');

-- Devoluciones
DELETE FROM Devolucion WHERE id IN ('DV001', 'DV002', 'DV003');

-- Préstamos
DELETE FROM Prestamo WHERE id IN ('PR001', 'PR002', 'PR003');

-- Clientes y Bibliotecarios
DELETE FROM Cliente       WHERE idUsuario IN ('U006', 'U007', 'U008');
DELETE FROM Bibliotecario WHERE idUsuario IN ('U001', 'U002');

-- Usuarios base del ciclo 2
DELETE FROM Usuario WHERE id IN ('U001', 'U002', 'U003', 'U004', 'U005', 'U006', 'U007', 'U008');

COMMIT;