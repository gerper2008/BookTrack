---------------------------------------------------------------------------------------------
-- TUPLAS OK
---------------------------------------------------------------------------------------------

-- TUP1 OK: Compra COMPLETADO con total > 0
INSERT INTO Compra
VALUES ('COM004', TO_DATE('2024-07-01','YYYY-MM-DD'), 200000.00, 'COMPLETADO', 'PRV001');

-- TUP1 OK: Compra PENDIENTE con total >= 0
INSERT INTO Compra
VALUES ('COM005', TO_DATE('2024-08-10','YYYY-MM-DD'), 50000.00, 'PENDIENTE', 'PRV002');

-- TUP2 OK: cantidad > 0 y precioUnidad > 0
INSERT INTO Producto_Compra
VALUES ('PC004', 4, 55000.00, 'COM004', 'LIB001');

-- TUP3 OK: disponibilidad = 1 con estadoFisico = Nuevo
INSERT INTO Ejemplar
VALUES (
    'EJM004',
    'EDI001',
    'Nuevo',
    1,
    'Estante C dos',
    TO_DATE('2024-01-15','YYYY-MM-DD')
);

-- TUP5 OK: titulo e idioma NO NULL
INSERT INTO Libro
VALUES (
    'LIB004',
    'El Amor en los Tiempos del Colera',
    TO_DATE('1985-09-05','YYYY-MM-DD'),
    'Espanol',
    'Romance clasico latinoamericano',
    'CAT001'
);


-- DELETE FROM Producto_Compra
-- WHERE id IN ('PC004');
-- DELETE FROM Ejemplar
-- WHERE id IN ('EJM004');
-- DELETE FROM Compra
-- WHERE id IN ('COM004', 'COM005');
-- DELETE FROM Libro
-- WHERE id IN ('LIB004');

---------------------------------------------------------------------------------------------
-- TUPLAS NO OK
-- Intentos incorrectos respecto a restricciones de tupla
---------------------------------------------------------------------------------------------

-- TUP1 NO OK: Compra COMPLETADO con total = 0
-- Error esperado:
-- ORA-02290 -> CH_Compra_estado_total
UPDATE Compra
SET estado = 'COMPLETADO',
    total = 0
WHERE id = 'COM005';

-- TUP2 NO OK: cantidad = 0
-- Error esperado:
-- ORA-02290 -> CH_ProductoCompra_importe
INSERT INTO Producto_Compra
VALUES ('PC999', 0, 50000, 'COM004', 'LIB001');

-- TUP2 NO OK: precioUnidad negativo
-- Error esperado:
-- ORA-02290 -> CH_ProductoCompra_importe
INSERT INTO Producto_Compra
VALUES ('PC998', 2, -1000, 'COM004', 'LIB001');

-- TUP3 NO OK: disponibilidad = 0 y estadoFisico = Nuevo
-- Error esperado:
-- ORA-02290 -> CH_Ejemplar_nuevo_disponible
INSERT INTO Ejemplar
VALUES (
    'EJM999',
    'EDI001',
    'Nuevo',
    0,
    'Bodega',
    TO_DATE('2024-01-01','YYYY-MM-DD')
);

-- TUP5 NO OK: titulo NULL
-- Error esperado:
-- ORA-02290 -> CH_Libro_titulo_idioma
INSERT INTO Libro
VALUES (
    'LIB999',
    NULL,
    TO_DATE('2020-01-01','YYYY-MM-DD'),
    'Espanol',
    'Sin titulo',
    'CAT001'
);
