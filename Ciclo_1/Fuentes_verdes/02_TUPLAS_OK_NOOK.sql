---------------------------------------------------------------------------------------------
-- TUPLAS OK / NO OK (CORREGIDO PARA EVITAR COLISIONES CON TRIGGERS)
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-- TUPLAS OK - CASOS QUE DEBEN PASAR
---------------------------------------------------------------------------------------------

-- TUP1 OK: Compra con total > 0 en estado PENDIENTE (inicial)
-- La Compra siempre inicia en PENDIENTE (DISP-13), luego actualizamos a COMPLETADO
INSERT INTO Compra (id, fecha, total, estado, idProveedor)
VALUES ('COM099', TO_DATE('2024-07-01','YYYY-MM-DD'), 200000.00, 'PENDIENTE', 'PRVZV01');

-- Ahora actualizamos a COMPLETADO (DISP-14 permite updates cuando esta en PENDIENTE)
UPDATE Compra SET estado = 'COMPLETADO' WHERE id = 'COM099';
-- Verificar que quedó en COMPLETADO
--SELECT id, estado, total FROM Compra WHERE id = 'COM099';

-- TUP1 OK (alternativo): Compra PENDIENTE con total >= 0
INSERT INTO Compra (id, fecha, total, estado, idProveedor)
VALUES ('COM100', TO_DATE('2024-08-10','YYYY-MM-DD'), 50000.00, 'PENDIENTE', 'PRVZV01');

-- TUP2 OK: Producto_Compra con cantidad > 0 y precioUnidad > 0
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro)
VALUES ('PCZV02', 4, 55000.00, 'COM099', 'LIBZV01');

-- TUP3 OK: Ejemplar disponible (disponibilidad = 1) con estadoFisico = Nuevo
INSERT INTO Ejemplar (id, idEdicion, estadoFisico, disponibilidad, localizacion, fechaAdquisicion)
VALUES ('EJMZV02', 'EDIZV01', 'Nuevo', 1, 'Estante ZV', TO_DATE('2024-01-15','YYYY-MM-DD'));

-- TUP5 OK: Libro con titulo e idioma NO nulos
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria)
VALUES ('LIBZV03', 'Libro Tupla OK', TO_DATE('1985-09-05','YYYY-MM-DD'), 'Espanol', 'Romance', 'CATZV01');

---------------------------------------------------------------------------------------------
-- TUPLAS NO OK - CASOS QUE DEBEN FALLAR
---------------------------------------------------------------------------------------------

-- TUP1 NO OK: Compra COMPLETADO con total = 0
-- Error esperado: ORA-02290 (CH_Compra_estado_total)
-- Este UPDATE debe fallar
UPDATE Compra SET estado = 'COMPLETADO', total = 0 WHERE id = 'COM100';

-- TUP2 NO OK: cantidad = 0
-- Error esperado: ORA-02290 (CH_ProductoCompra_importe)
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro)
VALUES ('PCZV99', 0, 50000, 'COMZV01', 'LIBZV01');

-- TUP2 NO OK: precioUnidad negativo
-- Error esperado: ORA-02290
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro)
VALUES ('PCZV98', 2, -1000, 'COMZV01', 'LIBZV01');

-- TUP3 NO OK: disponibilidad = 0 Y estadoFisico = Nuevo
-- Error esperado: ORA-02290 (CH_Ejemplar_nuevo_disponible)
INSERT INTO Ejemplar (id, idEdicion, estadoFisico, disponibilidad, localizacion, fechaAdquisicion)
VALUES ('EJMZV99', 'EDIZV01', 'Nuevo', 0, 'Bodega', TO_DATE('2024-01-01','YYYY-MM-DD'));

-- TUP5 NO OK: titulo NULL
-- Error esperado: ORA-01400 o CHECK
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria)
VALUES ('LIBZV99', NULL, TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol', 'Sin titulo', 'CATZV01');