-- ============================================================
-- CRUDOK - DATOS CORRECTOS (IDEMPOTENTE / RE-EJECUTABLE)
-- ============================================================
-- Objetivo:
-- - Ejecutar sin romper por duplicados en corridas repetidas.
-- - Evitar variables de sustitución (&...) en SQL Developer.
-- - Mantener pruebas válidas de inserción usando paquetes CRUD.
--
-- Recomendación de orden previo:
-- 1) CRUD_Ciclo1/01_CRUDE_Especificacion.sql
-- 2) CRUD_Ciclo1/02_CRUDI_Implementacion.sql
-- ============================================================

-- ============================================================
-- 1) CATEGORIAS (si ya existen, se ignora DUP_VAL_ON_INDEX)
-- ============================================================
BEGIN
    PC_CATEGORIA.AD_CATEGORIA('Tecnologia ZV', 'Libros sobre informatica y software');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20101 THEN
            RAISE;
        END IF;
END;
/


BEGIN
    PC_CATEGORIA.AD_CATEGORIA('Arte ZV', 'Libros sobre pintura y musica');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20101 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_CATEGORIA.AD_CATEGORIA('Derecho ZV', 'Libros sobre leyes y jurisprudencia');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20101 THEN
            RAISE;
        END IF;
END;
/

-- ============================================================
-- 2) AUTORES (si ya existen, se ignora error envuelto por paquete)
-- ============================================================
BEGIN
    PC_AUTOR.AD_AUTOR('Camilo ZV', 'Torres Restrepo ZV', 'Masculino', 'Colombiana');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20111 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_AUTOR.AD_AUTOR('Toni ZV', 'Morrison ZV', 'Femenino', 'Estadounidense');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20111 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_AUTOR.AD_AUTOR('Haruki ZV', 'Murakami ZV', 'Masculino', 'Japonesa');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20111 THEN
            RAISE;
        END IF;
END;
/

-- ============================================================
-- 3) EDITORIALES
-- ============================================================
BEGIN
    PC_EDITORIAL.AD_EDITORIAL('Tusquets ZV', 'zv.tusquets1@booktrack.com', '3401001111', 'Espana');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20121 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_EDITORIAL.AD_EDITORIAL('Debate ZV', 'zv.debate1@booktrack.com', '3401002222', 'Espana');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20121 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_EDITORIAL.AD_EDITORIAL('Anagrama ZV', 'zv.anagrama1@booktrack.com', '3401003333', 'Espana');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20121 THEN
            RAISE;
        END IF;
END;
/

-- ============================================================
-- 4) LIBROS
-- ============================================================
BEGIN
    PC_LIBRO.AD_LIBRO('CAT001', 'El Coronel ZV', 'Novela corta de prueba', TO_DATE('1961-01-01','YYYY-MM-DD'), 'Espanol');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20131 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_LIBRO.AD_LIBRO('CAT002', 'La Voragine ZV', 'Novela de prueba', TO_DATE('1924-11-24','YYYY-MM-DD'), 'Espanol');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20131 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_LIBRO.AD_LIBRO('CAT003', 'El Ser y la Nada ZV', 'Tratado de prueba', TO_DATE('1943-01-01','YYYY-MM-DD'), 'Espanol');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20131 THEN
            RAISE;
        END IF;
END;
/

-- ============================================================
-- 5) LIBRO_AUTOR (base estable, ignora duplicados)
-- ============================================================
BEGIN
    PC_LIBRO.AD_LIBRO_AUTOR('LIB001', 'AUT001');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20134 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_LIBRO.AD_LIBRO_AUTOR('LIB002', 'AUT002');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20134 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_LIBRO.AD_LIBRO_AUTOR('LIB003', 'AUT003');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20134 THEN
            RAISE;
        END IF;
END;
/

-- ============================================================
-- 6) EDICIONES
-- ============================================================
BEGIN
    PC_EDICION.AD_EDICION('LIB001', 'EDT001', TO_DATE('2001-03-10','YYYY-MM-DD'), 250);
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20141 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_EDICION.AD_EDICION('LIB002', 'EDT002', TO_DATE('2008-07-15','YYYY-MM-DD'), 310);
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20141 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_EDICION.AD_EDICION('LIB003', 'EDT003', TO_DATE('2012-09-20','YYYY-MM-DD'), 128);
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20141 THEN
            RAISE;
        END IF;
END;
/

-- ============================================================
-- 7) EJEMPLARES
-- ============================================================
BEGIN
    PC_EJEMPLAR.AD_EJEMPLAR('EDI001', 'Nuevo', '1', 'Estante ZV A1', TO_DATE('2024-04-10','YYYY-MM-DD'));
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20151 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_EJEMPLAR.AD_EJEMPLAR('EDI002', 'Bueno', '1', 'Estante ZV B1', TO_DATE('2024-05-15','YYYY-MM-DD'));
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20151 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_EJEMPLAR.AD_EJEMPLAR('EDI003', 'Desgastado', '0', 'Bodega ZV N1', TO_DATE('2023-12-20','YYYY-MM-DD'));
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20151 THEN
            RAISE;
        END IF;
END;
/

-- ============================================================
-- 8) COMPRAS
-- ============================================================
BEGIN
    PC_COMPRA.AD_COMPRA('PRV001', TO_DATE('2025-01-15','YYYY-MM-DD'), 500000, 'PENDIENTE');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20171 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_COMPRA.AD_COMPRA('PRV002', TO_DATE('2025-02-20','YYYY-MM-DD'), 320000, 'PENDIENTE');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20171 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_COMPRA.AD_COMPRA('PRV003', TO_DATE('2025-03-10','YYYY-MM-DD'), 780000, 'PENDIENTE');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20171 THEN
            RAISE;
        END IF;
END;
/

-- ============================================================
-- 9) PRODUCTOS DE COMPRA
-- ============================================================
BEGIN
    PC_COMPRA.AD_PRODUCTO_COMPRA('COM001', 'LIB001', 6, 83000);
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20174 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_COMPRA.AD_PRODUCTO_COMPRA('COM002', 'LIB002', 4, 80000);
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20174 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_COMPRA.AD_PRODUCTO_COMPRA('COM003', 'LIB003', 5, 45000);
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20174 THEN
            RAISE;
        END IF;
END;
/

-- ============================================================
-- 10) USUARIOS
-- ============================================================
BEGIN
    PC_USUARIO.AD_USUARIO('zv.user1a@booktrack.com', 'Lector', 'Orion', 'Valencrest', '3998887771');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20181 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_USUARIO.AD_USUARIO('zv.user2a@booktrack.com', 'Bibliotecario', 'Marcela', 'Suarez Lopez', '3600002222');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20181 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_USUARIO.AD_USUARIO('zv.user3a@booktrack.com', 'Lector', 'Andres', 'Florez Pinto', '3600003333');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20181 THEN
            RAISE;
        END IF;
END;
/

-- ============================================================
-- 11) ADMINISTRADORES (usuarios base)
-- ============================================================
BEGIN
    PC_USUARIO.AD_ADMINISTRADOR('USR001', 'Operativo', 'Sede Central');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20184 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_USUARIO.AD_ADMINISTRADOR('USR002', 'Total', 'Sede Occidente');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20184 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PC_USUARIO.AD_ADMINISTRADOR('USR003', 'Total', 'Sede Sur');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20184 THEN
            RAISE;
        END IF;
END;
/
