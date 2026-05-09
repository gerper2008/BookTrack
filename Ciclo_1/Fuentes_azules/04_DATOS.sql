---------------------------------------------------------------------------------------------
--- PRUEBAS: PoblarOK -> Ingreso de datos correctos
---------------------------------------------------------------------------------------------

-- Categoria
INSERT INTO Categoria VALUES ('CAT001', 'Ficcion', 'Novelas y cuentos de ficcion literaria');
INSERT INTO Categoria VALUES ('CAT002', 'Historia', 'Libros sobre historia universal y colombiana');
INSERT INTO Categoria VALUES ('CAT003', 'Tecnologia', 'Libros de informatica y programacion');

-- Editorial
INSERT INTO Editorial VALUES ('ED001', 'contacto@planeta.com', '3001234567', 'Planeta', 'Colombia');
INSERT INTO Editorial VALUES ('ED002', 'info@norma.com', '3107654321', 'Norma', 'Colombia');
INSERT INTO Editorial VALUES ('ED003', 'hola@penguin.com', '3209876543', 'Penguin', 'Argentina');

-- Autor
INSERT INTO Autor VALUES ('AUT001', 'Gabriel',    'Garcia Marquez', 'Masculino', 'Colombiana');
INSERT INTO Autor VALUES ('AUT002', 'Jorge Luis', 'Borges',         'Masculino', 'Argentina');
INSERT INTO Autor VALUES ('AUT003', 'Isabel',     'Allende',        'Femenino',  'Chilena');

-- Libro
INSERT INTO Libro VALUES ('LIB001', 'Cien Anos de Soledad',    TO_DATE('1967-06-05','YYYY-MM-DD'), 'Espanol', 'Novela del realismo magico colombiano',    'CAT001');
INSERT INTO Libro VALUES ('LIB002', 'Ficciones',               TO_DATE('1944-01-01','YYYY-MM-DD'), 'Espanol', 'Coleccion de cuentos fantasticos de Borges','CAT001');
INSERT INTO Libro VALUES ('LIB003', 'La Casa de los Espiritus',TO_DATE('1982-10-01','YYYY-MM-DD'), 'Espanol', 'Saga familiar con elementos magicos chilenos','CAT001');

-- Edicion (id, año, paginas, id_libro, id_editorial)
INSERT INTO Edicion VALUES ('EDI001', TO_DATE('2000-01-01','YYYY-MM-DD'), 432, 'LIB001', 'ED001');
INSERT INTO Edicion VALUES ('EDI002', TO_DATE('2005-06-15','YYYY-MM-DD'), 200, 'LIB002', 'ED002');
INSERT INTO Edicion VALUES ('EDI003', TO_DATE('2010-03-20','YYYY-MM-DD'), 350, 'LIB003', 'ED003');

-- Ejemplar (id, estado_fisico, disponibilidad, localizacion, fecha_adquisicion, id_edicion)
INSERT INTO Ejemplar VALUES ('EJE001', 'Nuevo',   1, 'Estante A uno',  TO_DATE('2021-01-10','YYYY-MM-DD'), 'EDI001');
INSERT INTO Ejemplar VALUES ('EJE002', 'Bueno',   1, 'Estante B tres', TO_DATE('2020-05-22','YYYY-MM-DD'), 'EDI002');
INSERT INTO Ejemplar VALUES ('EJE003', 'Dañado',  0, 'Bodega central', TO_DATE('2019-08-15','YYYY-MM-DD'), 'EDI003');

-- Proveedor
INSERT INTO Proveedor VALUES ('PRV001', 'ventas@distribuidora.com', 'Carlos', 'Ramirez Torres',  'Distribuidora Nacional',  '3151112233');
INSERT INTO Proveedor VALUES ('PRV002', 'pedidos@libros.com',       'Maria',  'Lopez Ruiz',       'Libros y Mas',            '3004445566');
INSERT INTO Proveedor VALUES ('PRV003', 'contacto@editorial.com',   'Pedro',  'Suarez Gil',       'Editorial Sudamericana',  '3006667788');

-- Usuario
INSERT INTO Usuario VALUES ('USR001', 'admin@biblioteca.com',  'Administrador', 'Ana',   'Martinez Gil',  '3001234567');
INSERT INTO Usuario VALUES ('USR002', 'biblio@biblioteca.com', 'Bibliotecario', 'Luis',  'Torres Pena',   '3109876543');
INSERT INTO Usuario VALUES ('USR003', 'lector@gmail.com',      'Lector',        'Sofia', 'Herrera Diaz',  '3207778899');

-- Administrador
INSERT INTO Administrador VALUES ('USR001', 'Total', 'Sede Central Bogota');

-- Compra
INSERT INTO Compra VALUES ('CMP001', TO_DATE('2024-01-15','YYYY-MM-DD'), 350000.00, 'COMPLETADO', 'PRV001');
INSERT INTO Compra VALUES ('CMP002', TO_DATE('2024-03-10','YYYY-MM-DD'), 180000.00, 'COMPLETADO', 'PRV002');
INSERT INTO Compra VALUES ('CMP003', TO_DATE('2024-06-20','YYYY-MM-DD'),  95000.00, 'PENDIENTE',  'PRV003');

-- Producto_Compra (id, cantidad, precio_unidad, id_compra, id_libro)
INSERT INTO Producto_Compra VALUES ('PC001', 5, 70000.00, 'CMP001', 'LIB001');
INSERT INTO Producto_Compra VALUES ('PC002', 3, 60000.00, 'CMP002', 'LIB002');
INSERT INTO Producto_Compra VALUES ('PC003', 2, 47500.00, 'CMP003', 'LIB003');


---------------------------------------------------------------------------------------------
--- PRUEBAS: PoblarNoOK -> Intento de ingreso de datos erroneos protegidos
---------------------------------------------------------------------------------------------

-- ===== VIOLACIONES DE CLAVE PRIMARIA (PK duplicada) =====

-- PK duplicada en Categoria
INSERT INTO Categoria VALUES ('CAT001', 'Duplicado', 'Viola PRIMARY KEY de Categoria');

-- PK duplicada en Autor
INSERT INTO Autor VALUES ('AUT001', 'Clon', 'Apellido', 'Masculino', 'Colombiana');

-- PK duplicada en Libro
INSERT INTO Libro VALUES ('LIB001', 'Titulo clon', TO_DATE('2000-01-01','YYYY-MM-DD'), 'Espanol', 'Viola PRIMARY KEY de Libro', 'CAT001');

-- PK duplicada en Editorial
INSERT INTO Editorial VALUES ('ED001', 'nuevo@correo.com', '3000000001', 'Editorial Clon', 'Mexico');

-- ===== VIOLACIONES DE CLAVE FORANEA (FK a registro inexistente) =====

-- Libro con id_categoria que no existe
INSERT INTO Libro VALUES ('LIB099', 'Libro Huerfano', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol', 'Sin categoria valida', 'CAT999');

-- Edicion con id_libro que no existe
INSERT INTO Edicion VALUES ('EDI099', TO_DATE('2024-01-01','YYYY-MM-DD'), 100, 'LIB999', 'ED001');

-- Edicion con id_editorial que no existe
INSERT INTO Edicion VALUES ('EDI098', TO_DATE('2024-01-01','YYYY-MM-DD'), 200, 'LIB001', 'ED999');

-- Ejemplar con id_edicion que no existe
INSERT INTO Ejemplar VALUES ('EJE099', 'Nuevo', 1, 'Estante Z nueve', TO_DATE('2024-01-01','YYYY-MM-DD'), 'EDI999');

-- Compra con id_proveedor que no existe
INSERT INTO Compra VALUES ('CMP099', TO_DATE('2024-06-01','YYYY-MM-DD'), 99999.00, 'COMPLETADO', 'PRV999');

-- Producto_Compra con id_compra que no existe
INSERT INTO Producto_Compra VALUES ('PC099', 1, 50000.00, 'CMP999', 'LIB001');

-- Producto_Compra con id_libro que no existe
INSERT INTO Producto_Compra VALUES ('PC098', 1, 50000.00, 'CMP001', 'LIB999');

-- Administrador con id_usuario que no existe
INSERT INTO Administrador VALUES ('USR999', 'Total', 'Sede Norte');

-- ===== VIOLACIONES DE CLAVE UNICA (UNIQUE) =====

-- Correo duplicado en Usuario
INSERT INTO Usuario VALUES ('USR099', 'admin@biblioteca.com', 'Lector', 'Intruso', 'Apellido', '3000000000');

-- Correo duplicado en Editorial
INSERT INTO Editorial VALUES ('ED099', 'contacto@planeta.com', '3000000002', 'Editorial Pirata', 'Peru');

-- Telefono duplicado en Editorial
INSERT INTO Editorial VALUES ('ED098', 'diferente@correo.com', '3001234567', 'Editorial Copia', 'Chile');

-- Correo duplicado en Proveedor
INSERT INTO Proveedor VALUES ('PRV099', 'ventas@distribuidora.com', 'Pirata', 'Nombre Falso', 'Empresa Clon', '3199999999');

-- ===== VIOLACIONES DE CHECK (tipos y formatos) =====

-- Rol invalido en Usuario  (valores validos: 'Administrador', 'Lector', 'Bibliotecario')
INSERT INTO Usuario VALUES ('USR098', 'valido@correo.com', 'X', 'Nombre', 'Apellido', '3001112222');

-- Genero invalido en Autor  (valores validos: 'Masculino', 'Femenino', 'Otro')
INSERT INTO Autor VALUES ('AUT099', 'Nombre', 'Apellido', 'Transgenero', 'Colombiana');

-- Paginas negativas en Edicion
INSERT INTO Edicion VALUES ('EDI097', TO_DATE('2020-01-01','YYYY-MM-DD'), -10, 'LIB001', 'ED001');

-- Precio negativo en Producto_Compra
INSERT INTO Producto_Compra VALUES ('PC097', 3, -5000.00, 'CMP001', 'LIB001');

-- Cantidad cero en Producto_Compra
INSERT INTO Producto_Compra VALUES ('PC096', 0, 50000.00, 'CMP001', 'LIB001');

-- Total negativo en Compra
INSERT INTO Compra VALUES ('CMP098', TO_DATE('2024-01-01','YYYY-MM-DD'), -100.00, 'PENDIENTE', 'PRV001');

-- Estado invalido en Compra  (valores validos: 'PENDIENTE', 'COMPLETADO', 'RECHAZADO')
INSERT INTO Compra VALUES ('CMP097', TO_DATE('2024-01-01','YYYY-MM-DD'), 50000.00, 'CO', 'PRV001');

-- Correo con formato invalido en Editorial
INSERT INTO Editorial VALUES ('ED097', 'correo_sin_arroba', '3001234999', 'Editorial Mala', 'Bolivia');

-- Telefono con letras en Usuario
INSERT INTO Usuario VALUES ('USR097', 'nuevo@correo.com', 'Administrador', 'Nombre', 'Apellido', 'ABCD123456');

-- Estado fisico invalido en Ejemplar
-- (valores validos: 'Desgastado', 'Bueno', 'Dañado', 'Restaurado', 'Perdido', 'Nuevo')
INSERT INTO Ejemplar VALUES ('EJE098', 'XX', 1, 'Estante Q', TO_DATE('2023-01-01','YYYY-MM-DD'), 'EDI001');

-- Fecha de publicacion futura en Libro
INSERT INTO Libro VALUES ('LIB098', 'Libro Futuro', TO_DATE('2099-01-01','YYYY-MM-DD'), 'Espanol', 'Fecha invalida futura', 'CAT001');

-- Permisos invalidos en Administrador  (valores validos: 'Solo Lectura', 'Operativo', 'Total')
INSERT INTO Administrador VALUES ('USR002', 'X', 'Sede Sur');
