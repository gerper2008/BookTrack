
-- ============================================================
-- CRUDNoOK - INTENTO DE INGRESO DE DATOS ERRONEOS
-- ============================================================

-- NoOK-01: Categoria con nombre NULL (NOT NULL)
BEGIN PC_CATEGORIA.AD_CATEGORIA(NULL, 'Sin nombre'); END;
/
-- NoOK-02: Categoria con nombre que excede 50 caracteres
BEGIN PC_CATEGORIA.AD_CATEGORIA('NombreDeCategoriaMuyLargoQueExcedeElLimitePermitidoEnLaTablaCategoria', 'Test'); END;
/
-- NoOK-03: Autor con nombre NULL (NOT NULL)
BEGIN PC_AUTOR.AD_AUTOR(NULL, 'Apellido', 'M', 'Colombiana'); END;
/
-- NoOK-04: Autor con apellidos NULL (NOT NULL)
BEGIN PC_AUTOR.AD_AUTOR('Nombre', NULL, 'M', 'Colombiana'); END;
/
-- NoOK-05: Editorial con nombre NULL (NOT NULL)
BEGIN PC_EDITORIAL.AD_EDITORIAL(NULL, 'test@edit.com', '3001111111', 'Colombia'); END;
/
-- NoOK-06: Editorial con correo que excede 100 caracteres
BEGIN PC_EDITORIAL.AD_EDITORIAL('Editorial Test', 'correo_muy_largo_que_excede_el_limite_maximo_permitido_en_la_columna_correo_de_editorial@dominio.com.co', '3001111111', 'Colombia'); END;
/
-- NoOK-07: Libro con titulo NULL (NOT NULL)
BEGIN PC_LIBRO.AD_LIBRO('CAT001', NULL, 'Sin titulo', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol'); END;
/
-- NoOK-08: Libro con idCategoria inexistente (FK violation)
BEGIN PC_LIBRO.AD_LIBRO('CATXXX', 'Libro Invalido', NULL, TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol'); END;
/
-- NoOK-09: Asociar idAutor inexistente a libro (FK violation)
BEGIN PC_LIBRO.AD_LIBRO_AUTOR('LIB001', 'AUTXXX'); END;
/
-- NoOK-10: Asociar idLibro inexistente a autor (FK violation)
BEGIN PC_LIBRO.AD_LIBRO_AUTOR('LIBXXX', 'AUT001'); END;
/
-- NoOK-11: Edicion con idLibro inexistente (FK violation)
BEGIN PC_EDICION.AD_EDICION('LIBXXX', 'EDI001', TO_DATE('2000-01-01','YYYY-MM-DD'), 300); END;
/
-- NoOK-12: Edicion con idEditorial inexistente (FK violation)
BEGIN PC_EDICION.AD_EDICION('LIB001', 'EDIXXX', TO_DATE('2000-01-01','YYYY-MM-DD'), 300); END;
/
-- NoOK-13: Edicion con paginas fuera del rango NUMBER(3) -> > 999
BEGIN PC_EDICION.AD_EDICION('LIB001', 'EDI001', TO_DATE('2000-01-01','YYYY-MM-DD'), 1500); END;
/
-- NoOK-14: Ejemplar con idEdicion inexistente (FK violation)
BEGIN PC_EJEMPLAR.AD_EJEMPLAR('EDCXXX', 'Bueno', '1', 'Estante A', TO_DATE('2023-01-01','YYYY-MM-DD')); END;
/
-- NoOK-15: Ejemplar con estadoFisico NULL (NOT NULL)
BEGIN PC_EJEMPLAR.AD_EJEMPLAR('EDC001', NULL, '1', 'Estante A', TO_DATE('2023-01-01','YYYY-MM-DD')); END;
/
-- NoOK-16: Proveedor con nombre NULL (NOT NULL)
BEGIN PC_PROVEEDOR.AD_PROVEEDOR(NULL, 'Lopez', 'test@prov.com', 'Empresa X', '3001111111'); END;
/
-- NoOK-17: Proveedor con telefono que excede 10 caracteres
BEGIN PC_PROVEEDOR.AD_PROVEEDOR('Test', 'Proveedor', 'test2@prov.com', 'Empresa X', '31098765431234'); END;
/
-- NoOK-18: Compra con idProveedor inexistente (FK violation)
BEGIN PC_COMPRA.AD_COMPRA('PROXXX', TO_DATE('2024-01-01','YYYY-MM-DD'), 500000, 'Pendiente'); END;
/
-- NoOK-19: Compra con total NULL (NOT NULL)
BEGIN PC_COMPRA.AD_COMPRA('PRO001', TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 'Pendiente'); END;
/
-- NoOK-20: Producto_Compra con idCompra inexistente (FK violation)
BEGIN PC_COMPRA.AD_PRODUCTO_COMPRA('COMXXX', 'LIB001', 2, 50000); END;
/
-- NoOK-21: Producto_Compra con idLibro inexistente (FK violation)
BEGIN PC_COMPRA.AD_PRODUCTO_COMPRA('COM001', 'LIBXXX', 2, 50000); END;
/
-- NoOK-22: Producto_Compra con cantidad NULL (NOT NULL)
BEGIN PC_COMPRA.AD_PRODUCTO_COMPRA('COM001', 'LIB001', NULL, 50000); END;
/
-- NoOK-23: Usuario con correo NULL (NOT NULL)
BEGIN PC_USUARIO.AD_USUARIO(NULL, 'Administrador', 'Test', 'User', '3001111111'); END;
/
-- NoOK-24: Administrador con idUsuario inexistente (FK violation) y permiso invalido (CHECK: Solo Lectura|Operativo|Total)
BEGIN PC_USUARIO.AD_ADMINISTRADOR('USRXXX', 'FULL_ACCESS', 'Sede Sur'); END;
/
-- NoOK-25: Eliminar categoria con libros asociados (FK violation)
BEGIN PC_CATEGORIA.ELI_CATEGORIA('CAT001'); END;
/

-- ============================================================
-- LIMPIEZA DE DATOS - BOOKTRACK CICLO 1
-- (Respetar orden por FK: hijos primero, padres al final)
-- ============================================================

-- 1. Tablas hijas sin dependientes
DELETE FROM Libro_Autor;
DELETE FROM Producto_Compra;

-- 2. Ejemplar (depende de Edicion)
DELETE FROM Ejemplar;

-- 3. Edicion (depende de Libro y Editorial)
DELETE FROM Edicion;

-- 4. Compra (depende de Proveedor)
DELETE FROM Compra;

-- 5. Libro (depende de Categoria)
DELETE FROM Libro;

-- 6. Administrador (depende de Usuario)
DELETE FROM Administrador;

-- 7. Tablas raiz
DELETE FROM Categoria;
DELETE FROM Autor;
DELETE FROM Editorial;
DELETE FROM Proveedor;
DELETE FROM Usuario;

COMMIT;
