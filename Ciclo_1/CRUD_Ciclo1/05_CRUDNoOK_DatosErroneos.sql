
-- ============================================================
-- CRUDNoOK - INTENTO DE INGRESO DE DATOS ERRONEOS
-- ============================================================

-- NoOK-01: Categoria con nombre NULL
BEGIN PC_CATEGORIA.AD_CATEGORIA(NULL, 'Sin nombre'); END;
/

-- NoOK-02: Categoria duplicada
BEGIN PC_CATEGORIA.AD_CATEGORIA('Historia', 'Duplicado'); END;
/

-- NoOK-03: Autor con nombre NULL
BEGIN PC_AUTOR.AD_AUTOR(NULL, 'Apellido', 'M', 'Colombiana'); END;
/

-- NoOK-04: Autor con apellidos NULL
BEGIN PC_AUTOR.AD_AUTOR('Nombre', NULL, 'M', 'Colombiana'); END;
/

-- NoOK-05: Editorial con nombre NULL
BEGIN PC_EDITORIAL.AD_EDITORIAL(NULL, 'test@edit.com', '3001111111', 'Colombia'); END;
/

-- NoOK-06: Editorial con correo duplicado
BEGIN PC_EDITORIAL.AD_EDITORIAL('Editorial Duplicada', 'penguin@editorial.com', '3001111111', 'Colombia'); END;
/

-- NoOK-07: Libro con titulo NULL
BEGIN PC_LIBRO.AD_LIBRO('CAT001', NULL, 'Sin titulo', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol'); END;
/

-- NoOK-08: Libro con categoria inexistente
BEGIN PC_LIBRO.AD_LIBRO('CAT999', 'Libro Invalido', 'Test', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol'); END;
/

-- NoOK-09: Libro_Autor con autor inexistente
BEGIN PC_LIBRO.AD_LIBRO_AUTOR('LIB001', 'AUT999'); END;
/

-- NoOK-10: Libro_Autor con libro inexistente
BEGIN PC_LIBRO.AD_LIBRO_AUTOR('LIB999', 'AUT001'); END;
/

-- NoOK-11: Edicion con libro inexistente
BEGIN PC_EDICION.AD_EDICION('LIB999', 'EDT001', TO_DATE('2000-01-01','YYYY-MM-DD'), 300); END;
/

-- NoOK-12: Edicion con editorial inexistente
BEGIN PC_EDICION.AD_EDICION('LIB001', 'EDT999', TO_DATE('2000-01-01','YYYY-MM-DD'), 300); END;
/

-- NoOK-13: Edicion con paginas > 999
BEGIN PC_EDICION.AD_EDICION('LIB001', 'EDT001', TO_DATE('2000-01-01','YYYY-MM-DD'), 1500); END;
/

-- NoOK-14: Ejemplar con edicion inexistente
BEGIN PC_EJEMPLAR.AD_EJEMPLAR('EDI999', 'Bueno', '1', 'Estante A', TO_DATE('2023-01-01','YYYY-MM-DD')); END;
/

-- NoOK-15: Ejemplar con estadoFisico NULL
BEGIN PC_EJEMPLAR.AD_EJEMPLAR('EDI001', NULL, '1', 'Estante A', TO_DATE('2023-01-01','YYYY-MM-DD')); END;
/

-- NoOK-16: Proveedor con nombre NULL
BEGIN PC_PROVEEDOR.AD_PROVEEDOR(NULL, 'Lopez', 'test@prov.com', 'Empresa X', '3001111111'); END;
/

-- NoOK-17: Compra con proveedor inexistente
BEGIN PC_COMPRA.AD_COMPRA('PRV999', TO_DATE('2024-01-01','YYYY-MM-DD'), 500000, 'Pendiente'); END;
/

-- NoOK-18: Compra con total NULL
BEGIN PC_COMPRA.AD_COMPRA('PRV001', TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 'Pendiente'); END;
/

-- NoOK-19: Producto_Compra con compra inexistente
BEGIN PC_COMPRA.AD_PRODUCTO_COMPRA('COM999', 'LIB001', 2, 50000); END;
/

-- NoOK-20: Producto_Compra con libro inexistente
BEGIN PC_COMPRA.AD_PRODUCTO_COMPRA('COM001', 'LIB999', 2, 50000); END;
/

-- NoOK-21: Producto_Compra con cantidad NULL
BEGIN PC_COMPRA.AD_PRODUCTO_COMPRA('COM001', 'LIB001', NULL, 50000); END;
/

-- NoOK-22: Usuario con correo NULL
BEGIN PC_USUARIO.AD_USUARIO(NULL, 'Administrador', 'Test', 'User', '3001111111'); END;
/

-- NoOK-23: Usuario con correo duplicado
BEGIN PC_USUARIO.AD_USUARIO('admin@booktrack.com', 'Administrador', 'Otro', 'Usuario', '3001111111'); END;
/

-- NoOK-24: Administrador con usuario inexistente
BEGIN PC_USUARIO.AD_ADMINISTRADOR('USR999', 'FULL_ACCESS', 'Sede Sur'); END;
/

-- NoOK-25: Modificar titulo de libro con ediciones
BEGIN PC_LIBRO.MOD_LIBRO('LIB001', 'CAT001', 'Nuevo Titulo Invalido', 'Cambio prohibido', 'Espanol'); END;
/

