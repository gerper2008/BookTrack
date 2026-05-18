
-- ============================================================
-- 1. CATEGORIAS
-- ============================================================
BEGIN PC_CATEGORIA.AD_CATEGORIA('Tecnologia', 'Libros sobre informatica y software'); END;
/
BEGIN PC_CATEGORIA.AD_CATEGORIA('Arte',       'Libros sobre pintura y musica'); END;
/
BEGIN PC_CATEGORIA.AD_CATEGORIA('Derecho',    'Libros sobre leyes y jurisprudencia'); END;
/
 
-- ============================================================
-- 2. AUTORES
-- ============================================================
BEGIN PC_AUTOR.AD_AUTOR('Camilo',  'Torres Restrepo', 'Masculino', 'Colombiana');    END;
/
BEGIN PC_AUTOR.AD_AUTOR('Toni',    'Morrison',        'Femenino',  'Estadounidense'); END;
/
BEGIN PC_AUTOR.AD_AUTOR('Haruki',  'Murakami',        'Masculino', 'Japonesa');       END;
/
 
-- ============================================================
-- 3. EDITORIALES
-- ============================================================
BEGIN PC_EDITORIAL.AD_EDITORIAL('Tusquets', 'info@tusquets.com', '3400001111', 'Espana');   END;
/
BEGIN PC_EDITORIAL.AD_EDITORIAL('Debate',   'info@debate.com',   '3400002222', 'Espana');   END;
/
BEGIN PC_EDITORIAL.AD_EDITORIAL('Anagrama', 'info@anagrama.com', '3400003333', 'Espana');   END;
/
 

 
-- ============================================================
-- 4. LIBROS (usando CAT001, CAT002, CAT004 que existen)
-- ============================================================
BEGIN PC_LIBRO.AD_LIBRO('CAT001', 'El Coronel no tiene quien le escriba', 'Novela corta de Garcia Marquez',       TO_DATE('1961-01-01','YYYY-MM-DD'), 'Espanol'); END;
/
BEGIN PC_LIBRO.AD_LIBRO('CAT002', 'La Voragine',                           'Novela sobre la selva colombiana',     TO_DATE('1924-11-24','YYYY-MM-DD'), 'Espanol'); END;
/
BEGIN PC_LIBRO.AD_LIBRO('CAT004', 'El Ser y la Nada',                      'Tratado de ontologia fenomenologica',  TO_DATE('1943-01-01','YYYY-MM-DD'), 'Espanol'); END;
/
 

 
-- ============================================================
-- 5. LIBRO_AUTOR
-- ============================================================
BEGIN PC_LIBRO.AD_LIBRO_AUTOR('LIB005', 'AUT001'); END;
/
BEGIN PC_LIBRO.AD_LIBRO_AUTOR('LIB006', 'AUT002'); END;
/
BEGIN PC_LIBRO.AD_LIBRO_AUTOR('LIB007', 'AUT003'); END;
/
 
-- ============================================================
-- 6. EDICIONES
-- Libros nuevos LIB005-007 con editoriales nuevas EDT005-007
-- ============================================================
BEGIN PC_EDICION.AD_EDICION('LIB005', 'EDT005', TO_DATE('2001-03-10','YYYY-MM-DD'), 250); END;
/
BEGIN PC_EDICION.AD_EDICION('LIB006', 'EDT006', TO_DATE('2008-07-15','YYYY-MM-DD'), 310); END;
/
BEGIN PC_EDICION.AD_EDICION('LIB007', 'EDT007', TO_DATE('2012-09-20','YYYY-MM-DD'), 128); END;
/
 
-- Ver ids generados:
SELECT id FROM Edicion ORDER BY id DESC FETCH FIRST 3 ROWS ONLY;
 
-- ============================================================
-- 7. EJEMPLARES
-- Ediciones nuevas EDI004, EDI005, EDI006
-- ============================================================
BEGIN PC_EJEMPLAR.AD_EJEMPLAR('EDI004', 'Nuevo',      '1', 'Estante A dos', TO_DATE('2024-04-10','YYYY-MM-DD')); END;
/
BEGIN PC_EJEMPLAR.AD_EJEMPLAR('EDI005', 'Bueno',      '1', 'Estante B uno', TO_DATE('2024-05-15','YYYY-MM-DD')); END;
/
BEGIN PC_EJEMPLAR.AD_EJEMPLAR('EDI006', 'Desgastado', '0', 'Bodega norte',  TO_DATE('2023-12-20','YYYY-MM-DD')); END;
/
 
-- ============================================================
-- 8. COMPRAS
-- Proveedores nuevos PRV005-007
-- ============================================================
BEGIN PC_COMPRA.AD_COMPRA('PRV003', TO_DATE('2025-01-15','YYYY-MM-DD'), 500000, 'PENDIENTE'); END;
/
BEGIN PC_COMPRA.AD_COMPRA('PRV002', TO_DATE('2025-02-20','YYYY-MM-DD'), 320000, 'PENDIENTE'); END;
/
BEGIN PC_COMPRA.AD_COMPRA('PRV001', TO_DATE('2025-03-10','YYYY-MM-DD'), 780000, 'PENDIENTE'); END;
/
 
-- Ver ids generados:
SELECT id FROM Compra ORDER BY id DESC FETCH FIRST 3 ROWS ONLY;
 
-- ============================================================
-- 9. PRODUCTOS DE COMPRA
-- Compras nuevas COM009, COM010, COM011 y libros LIB005-007
-- ============================================================
BEGIN PC_COMPRA.AD_PRODUCTO_COMPRA('COM009', 'LIB005', 6, 83000); END;
/
BEGIN PC_COMPRA.AD_PRODUCTO_COMPRA('COM010', 'LIB006', 4, 80000); END;
/
BEGIN PC_COMPRA.AD_PRODUCTO_COMPRA('COM011', 'LIB007', 5, 45000); END;
/
-- NOTA: estos procedimientos solo funcionan la segunda vez.
-- Si se ejecutan de nuevo, los usuarios se duplican con nuevos ids
-- y los administradores fallan porque USR004-006 ya tienen registro
-- en la tabla Administrador (restriccion de PK).
-- ============================================================
-- 10. USUARIOS
-- ============================================================


BEGIN
    PC_USUARIO.AD_USUARIO(
        'quantum.nebula999@booktrack.com',
        'Lector',
        'Orion',
        'Valencrest',
        '3998887771'
    );
END;
/

BEGIN PC_USUARIO.AD_USUARIO('zz2@booktrack.com', 'Bibliotecario', 'Marcela', 'Suarez Lopez', '3600002222'); END;
/
BEGIN PC_USUARIO.AD_USUARIO('zz3@booktrack.com', 'Lector',        'Andres',  'Florez Pinto', '3600003333'); END;
/
 
-- Ver ids generados:
SELECT id FROM Usuario ORDER BY id DESC FETCH FIRST 3 ROWS ONLY;
 
-- ============================================================
-- 11. ADMINISTRADORES
-- Usuarios nuevos USR004, USR005, USR006
-- ============================================================
BEGIN PC_USUARIO.AD_ADMINISTRADOR('USR004', 'Operativo',   'Sede Central');   END;
/
BEGIN PC_USUARIO.AD_ADMINISTRADOR('USR005', 'Solo Lectura','Sede Occidente'); END;
/
BEGIN PC_USUARIO.AD_ADMINISTRADOR('USR006', 'Total',       'Sede Sur');       END;
/

