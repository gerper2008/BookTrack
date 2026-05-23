---------------------------------------------------------------------------------------------
--- PRUEBAS: PoblarOK -> Ingreso de datos correctos
---------------------------------------------------------------------------------------------

-- [Usuarios base para Bibliotecario y Cliente]
INSERT INTO Usuario VALUES ('U001', 'bib1@lib.co', 'Bibliotecario', 'Laura',    'Gómez Ríos',   '3001112222');
INSERT INTO Usuario VALUES ('U002', 'bib2@lib.co', 'Bibliotecario', 'Carlos',   'Pérez Mora',   '3012223333');
INSERT INTO Usuario VALUES ('U003', 'cli1@lib.co', 'Lector',        'Andrés',   'Torres Vega',  '3023334444');
INSERT INTO Usuario VALUES ('U004', 'cli2@lib.co', 'Lector',        'Valentina','Ruiz Castro',  '3034445555');
INSERT INTO Usuario VALUES ('U005', 'cli3@lib.co', 'Lector',        'Felipe',   'Mora Soto',    '3045556666');

-- [Bibliotecarios]
INSERT INTO Bibliotecario VALUES ('U001', 'Mañana',  'Operativo', 1);
INSERT INTO Bibliotecario VALUES ('U002', 'Tarde',   'Total',     1);

-- [Clientes]
INSERT INTO Cliente VALUES ('U003', 'Activo',    TO_DATE('30/06/2026','DD/MM/YYYY'), 0);
INSERT INTO Cliente VALUES ('U004', 'Activo',    TO_DATE('31/12/2025','DD/MM/YYYY'), 5000);
INSERT INTO Cliente VALUES ('U005', 'Suspendido',TO_DATE('01/03/2025','DD/MM/YYYY'), 12000);

-- [Préstamos]
INSERT INTO Prestamo VALUES ('PR001', TO_DATE('01/03/2025','DD/MM/YYYY'), 0,   'U001', 'U003', 'EJ001');
INSERT INTO Prestamo VALUES ('PR002', TO_DATE('10/03/2025','DD/MM/YYYY'), 3.5, 'U002', 'U004', 'EJ002');
INSERT INTO Prestamo VALUES ('PR003', TO_DATE('15/04/2025','DD/MM/YYYY'), 0,   'U001', 'U005', 'EJ003');

-- [Devoluciones]
INSERT INTO Devolucion VALUES ('DV001', 'PR001', TO_DATE('15/03/2025','DD/MM/YYYY'), NULL, 1);
INSERT INTO Devolucion VALUES ('DV002', 'PR002', TO_DATE('25/03/2025','DD/MM/YYYY'), 'Libro con doblez en paginas', 0);
INSERT INTO Devolucion VALUES ('DV003', 'PR003', TO_DATE('30/04/2025','DD/MM/YYYY'), NULL, 1);

-- [Multas]
INSERT INTO Multa VALUES ('MT001', 'DV002', 'U004', 17500, 'Retraso', 'Pendiente');
INSERT INTO Multa VALUES ('MT002', 'DV003', 'U005', 0,     'Otro',    'Anulada');

-- [Pagos]
INSERT INTO Pago VALUES ('PG001', 'U004', 'MT001', 'Completado', TO_DATE('02/04/2025','DD/MM/YYYY'), 'Efectivo');

COMMIT;
