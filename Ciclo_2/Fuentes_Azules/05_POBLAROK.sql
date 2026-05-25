---------------------------------------------------------------------------------------------
--- PRUEBAS: PoblarOK -> Ingreso de datos correctos
---------------------------------------------------------------------------------------------

-- [Editorial]
INSERT INTO Editorial VALUES ('ED001', 'contacto@planeta.co', '3001234567', 'Editorial Planeta', 'Colombia');

-- [Categoria]
INSERT INTO Categoria VALUES ('CAT001', 'Literatura', 'Novelas y narrativa general');

-- [Autor]
INSERT INTO Autor VALUES ('AUT001', 'Gabriel',       'Garcia Marquez', 'Masculino', 'Colombiana');
INSERT INTO Autor VALUES ('AUT002', 'Jose Eustasio', 'Rivera',         'Masculino', 'Colombiana');

-- [Libro]
INSERT INTO Libro VALUES ('LIB001', 'Cien anos de soledad',
    TO_DATE('05/06/1967','DD/MM/YYYY'), 'Espanol', 'Obra cumbre del realismo magico', 'CAT001');
INSERT INTO Libro VALUES ('LIB002', 'El amor en los tiempos del colera',
    TO_DATE('05/09/1985','DD/MM/YYYY'), 'Espanol', 'Historia de amor de toda una vida', 'CAT001');
INSERT INTO Libro VALUES ('LIB003', 'La voragine',
    TO_DATE('25/11/1924','DD/MM/YYYY'), 'Espanol', 'Novela de la selva colombiana', 'CAT001');

-- [Libro_Autor]
INSERT INTO Libro_Autor VALUES ('LIB001', 'AUT001');
INSERT INTO Libro_Autor VALUES ('LIB002', 'AUT001');
INSERT INTO Libro_Autor VALUES ('LIB003', 'AUT002');

-- [Edicion]
INSERT INTO Edicion VALUES ('EDC001', 'LIB001', 'ED001', TO_DATE('01/01/2010','DD/MM/YYYY'), 471);
INSERT INTO Edicion VALUES ('EDC002', 'LIB002', 'ED001', TO_DATE('01/01/2012','DD/MM/YYYY'), 490);
INSERT INTO Edicion VALUES ('EDC003', 'LIB003', 'ED001', TO_DATE('01/01/2008','DD/MM/YYYY'), 231);

-- [Ejemplar]  <- 'Regular' no es valor válido; se usa 'Desgastado'
INSERT INTO Ejemplar VALUES ('EJ001', 'EDC001', 'Bueno',      1, 'Estante A1', TO_DATE('15/01/2023','DD/MM/YYYY'));
INSERT INTO Ejemplar VALUES ('EJ002', 'EDC002', 'Desgastado', 1, 'Estante A2', TO_DATE('20/03/2023','DD/MM/YYYY'));
INSERT INTO Ejemplar VALUES ('EJ003', 'EDC003', 'Bueno',      1, 'Estante B1', TO_DATE('10/06/2023','DD/MM/YYYY'));

-- [Usuario]
INSERT INTO Usuario VALUES ('U100', 'bib1@lib.co', 'Bibliotecario', 'Laura',     'Gomez Rios',   '3001112222');
INSERT INTO Usuario VALUES ('U101', 'bib2@lib.co', 'Bibliotecario', 'Carlos',    'Perez Mora',   '3012223333');
INSERT INTO Usuario VALUES ('U102', 'cli1@lib.co', 'Lector',        'Andres',    'Torres Vega',  '3023334444');
INSERT INTO Usuario VALUES ('U103', 'cli2@lib.co', 'Lector',        'Valentina', 'Ruiz Castro',  '3034445555');
INSERT INTO Usuario VALUES ('U104', 'cli3@lib.co', 'Lector',        'Felipe',    'Mora Soto',    '3045556666');

-- [Administrador]
INSERT INTO Administrador VALUES ('U100', 'Operativo', 'Sede Norte');
INSERT INTO Administrador VALUES ('U101', 'Total',     'Sede Centro');

-- [Bibliotecario]
INSERT INTO Bibliotecario VALUES ('U100', 'Manana', 'Operativo', 1);
INSERT INTO Bibliotecario VALUES ('U101', 'Tarde',  'Total',     1);

-- [Cliente]
INSERT INTO Cliente VALUES ('U102', 'Activo',     TO_DATE('30/06/2026','DD/MM/YYYY'),  0);
INSERT INTO Cliente VALUES ('U103', 'Activo',     TO_DATE('31/12/2026','DD/MM/YYYY'),  5000);
INSERT INTO Cliente VALUES ('U104', 'Suspendido', TO_DATE('01/03/2026','DD/MM/YYYY'),  12000);

-- [Prestamo]
INSERT INTO Prestamo VALUES ('PR001', TO_DATE('01/03/2026','DD/MM/YYYY'), 0,   'U100', 'U102', 'EJ001');
INSERT INTO Prestamo VALUES ('PR002', TO_DATE('10/03/2026','DD/MM/YYYY'), 3.5, 'U100', 'U103', 'EJ002');
INSERT INTO Prestamo VALUES ('PR003', TO_DATE('15/04/2026','DD/MM/YYYY'), 0,   'U101', 'U104', 'EJ003');

-- [Devolucion]
INSERT INTO Devolucion VALUES ('DV001', 'PR001', TO_DATE('15/03/2026','DD/MM/YYYY'), 'Sin novedad',                 1);
INSERT INTO Devolucion VALUES ('DV002', 'PR002', TO_DATE('25/03/2026','DD/MM/YYYY'), 'Libro con doblez en paginas', 0);
INSERT INTO Devolucion VALUES ('DV003', 'PR003', TO_DATE('30/04/2026','DD/MM/YYYY'), 'Sin novedad',                 1);

-- [Multa]
INSERT INTO Multa VALUES ('MT001', 'DV002', 'U103', 17500, 'Retraso', 'Pendiente');
INSERT INTO Multa VALUES ('MT002', 'DV003', 'U104', 0,     'Otro',    'Anulada');

-- [Pago]
INSERT INTO Pago VALUES ('PG001', 'U103', 'MT001', 'Completado', TO_DATE('02/04/2026','DD/MM/YYYY'), 'Efectivo');

-- [Proveedor]
INSERT INTO Proveedor VALUES ('PRV001', 'ventas@distlib.co', 'Marco', 'Salcedo Torres', 'Distribuidora Libros SAS', '3109876543');

-- [Compra]  <- estado debe ser 'COMPLETADO' en mayusculas (CHECK_Compra_estado)
INSERT INTO Compra VALUES ('COM001', TO_DATE('10/01/2023','DD/MM/YYYY'), 450000, 'COMPLETADO', 'PRV001');
INSERT INTO Compra VALUES ('COM002', TO_DATE('05/03/2023','DD/MM/YYYY'), 280000, 'COMPLETADO', 'PRV001');

-- [Producto_Compra]
INSERT INTO Producto_Compra VALUES ('PC001', 3, 75000, 'COM001', 'LIB001');
INSERT INTO Producto_Compra VALUES ('PC002', 2, 80000, 'COM001', 'LIB002');
INSERT INTO Producto_Compra VALUES ('PC003', 4, 70000, 'COM002', 'LIB003');

COMMIT;