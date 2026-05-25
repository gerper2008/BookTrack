---------------------------------------------------------------------------------------------
--- PRUEBAS: PoblarOK -> Ingreso de datos correctos
---------------------------------------------------------------------------------------------

-- [Editorial]
INSERT INTO Editorial VALUES ('ED001', 'Editorial Planeta', 'Colombia', 'contacto@planeta.co');

--DELETE FROM EDITORIAL;

-- [Libro]
INSERT INTO Libro VALUES ('LIB001', 'Cien años de soledad',  'ED001', '978-...',  1967, 'Novela');
INSERT INTO Libro VALUES ('LIB002', 'El amor en los tiempos del cólera', 'ED001', '978-...', 1985, 'Novela');
INSERT INTO Libro VALUES ('LIB003', 'La vorágine', 'ED001', '978-...', 1924, 'Novela');

--DELETE FROM LIBRO;

-- [Ejemplar]  <-- estos son los que FK_PRESTAMO_EJEMPLAR necesita
INSERT INTO Ejemplar VALUES ('EJ001', 'LIB001', 'Disponible', 'Bueno');
INSERT INTO Ejemplar VALUES ('EJ002', 'LIB002', 'Disponible', 'Regular');
INSERT INTO Ejemplar VALUES ('EJ003', 'LIB003', 'Disponible', 'Bueno');

--DELETE FROM EJEMPLAR;

-- [Usuarios base para Bibliotecario y Cliente]
INSERT INTO Usuario VALUES ('U100', 'bib1@lib.co', 'Bibliotecario', 'Laura',    'Gómez Ríos',   '3001112222');
INSERT INTO Usuario VALUES ('U101', 'bib2@lib.co', 'Bibliotecario', 'Carlos',   'Pérez Mora',   '3012223333');
INSERT INTO Usuario VALUES ('U102', 'cli1@lib.co', 'Lector',        'Andrés',   'Torres Vega',  '3023334444');
INSERT INTO Usuario VALUES ('U103', 'cli2@lib.co', 'Lector',        'Valentina','Ruiz Castro',  '3034445555');
INSERT INTO Usuario VALUES ('U104', 'cli3@lib.co', 'Lector',        'Felipe',   'Mora Soto',    '3045556666');

--DELETE FROM USUARIO;

-- [Bibliotecarios]
INSERT INTO Bibliotecario VALUES ('U100', 'Mañana',  'Operativo', 1);
INSERT INTO Bibliotecario VALUES ('U101', 'Tarde',   'Total',     1);

-- [Clientes]
INSERT INTO Cliente VALUES ('U102', 'Activo',    TO_DATE('30/06/2026','DD/MM/YYYY'), 0);
INSERT INTO Cliente VALUES ('U103', 'Activo',    TO_DATE('31/12/2026','DD/MM/YYYY'), 5000);
INSERT INTO Cliente VALUES ('U104', 'Suspendido',TO_DATE('01/03/2026','DD/MM/YYYY'), 12000);
--SELECT * FROM Bibliotecario;

-- [Préstamos]
INSERT INTO Prestamo VALUES ('PR001', TO_DATE('01/03/2026','DD/MM/YYYY'), 0,   'U100', 'U102', 'EJ001');
INSERT INTO Prestamo VALUES ('PR002', TO_DATE('10/03/2026','DD/MM/YYYY'), 3.5, 'U100', 'U103', 'EJ002');
INSERT INTO Prestamo VALUES ('PR003', TO_DATE('15/04/2026','DD/MM/YYYY'), 0,   'U101', 'U104', 'EJ003');

-- [Devoluciones]
INSERT INTO Devolucion VALUES ('DV001', 'PR001', TO_DATE('15/03/2026','DD/MM/YYYY'), 'U006', 1);
INSERT INTO Devolucion VALUES ('DV002', 'PR002', TO_DATE('25/03/2026','DD/MM/YYYY'), 'Libro con doblez en paginas', 0);
INSERT INTO Devolucion VALUES ('DV003', 'PR003', TO_DATE('30/04/2026','DD/MM/YYYY'), 'U006', 1);

-- [Multas]
INSERT INTO Multa VALUES ('MT001', 'DV002', 'U004', 17500, 'Retraso', 'Pendiente');
INSERT INTO Multa VALUES ('MT002', 'DV003', 'U005', 0,     'Otro',    'Anulada');

-- [Pagos]
INSERT INTO Pago VALUES ('PG001', 'U004', 'MT001', 'Completado', TO_DATE('02/04/2026','DD/MM/YYYY'), 'Efectivo');

COMMIT;
