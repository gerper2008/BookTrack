---------------------------------------------------------------------------------------------
--- PRUEBAS: XPoblar -> Eliminación de datos
---------------------------------------------------------------------------------------------
-- [Orden inverso a dependencias FK para evitar violaciones de integridad]

-- [Pago]
DELETE FROM Pago WHERE id = 'PG001';

-- [Multa]
DELETE FROM Multa WHERE id IN ('MT001', 'MT002');

-- [Devolucion]
DELETE FROM Devolucion WHERE id IN ('DV001', 'DV002', 'DV003');

-- [Prestamo]
DELETE FROM Prestamo WHERE id IN ('PR001', 'PR002', 'PR003');

-- [Cliente y Bibliotecario]  <- antes que Usuario
DELETE FROM Cliente       WHERE idUsuario IN ('U102', 'U103', 'U104');
DELETE FROM Bibliotecario WHERE idUsuario IN ('U100', 'U101');

-- [Administrador]
DELETE FROM Administrador WHERE idUsuario IN ('U100', 'U101');

-- [Usuario]
DELETE FROM Usuario WHERE id IN ('U100', 'U101', 'U102', 'U103', 'U104');

-- [Producto_Compra]
DELETE FROM Producto_Compra WHERE id IN ('PC001', 'PC002', 'PC003');

-- [Compra]
DELETE FROM Compra WHERE id IN ('COM001', 'COM002');

-- [Proveedor]
DELETE FROM Proveedor WHERE id = 'PRV001';

-- [Ejemplar]
DELETE FROM Ejemplar WHERE id IN ('EJ001', 'EJ002', 'EJ003');

-- [Edicion]
DELETE FROM Edicion WHERE id IN ('EDC001', 'EDC002', 'EDC003');

-- [Libro_Autor]
DELETE FROM Libro_Autor WHERE idLibro IN ('LIB001', 'LIB002', 'LIB003');

-- [Libro]
DELETE FROM Libro WHERE id IN ('LIB001', 'LIB002', 'LIB003');

-- [Autor]
DELETE FROM Autor WHERE id IN ('AUT001', 'AUT002');

-- [Categoria]
DELETE FROM Categoria WHERE id = 'CAT001';

-- [Editorial]
DELETE FROM Editorial WHERE id = 'ED001';

COMMIT;