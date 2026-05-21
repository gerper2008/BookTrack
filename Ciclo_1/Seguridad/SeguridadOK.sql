---------------------------------------------------------------------------------------------
--- SEGURIDAD OK: Casos válidos (solo actor ADMINISTRADOR)
--- Versión robusta para minimizar errores por re-ejecución.
---------------------------------------------------------------------------------------------
-- ORDEN RECOMENDADO ANTES DE ESTE SCRIPT:
-- 1) Seguridad/XSeguridad.sql            (opcional limpieza)
-- 2) Seguridad/ActoresE.sql
-- 3) Seguridad/ActoresI.sql
-- 4) Seguridad/Seguridad.sql
-- 5) Seguridad/SeguridadOK.sql

---------------------------------------------------------------------------------------------
-- 0) LIMPIEZA CONTROLADA DEL DATASET DE PRUEBA (prefijo / valores ZS)
---------------------------------------------------------------------------------------------
BEGIN
    -- Producto_Compra asociado a compras ZS
    DELETE FROM Producto_Compra
    WHERE idCompra IN (
        SELECT c.id
        FROM Compra c
        JOIN Proveedor p ON p.id = c.idProveedor
        WHERE p.correo IN ('zs.prov1@booktrack.com','zs.prov2@booktrack.com')
    );

    -- Compras ZS
    DELETE FROM Compra
    WHERE idProveedor IN (
        SELECT id FROM Proveedor
        WHERE correo IN ('zs.prov1@booktrack.com','zs.prov2@booktrack.com')
    );

    -- Ejemplares de ediciones ZS
    DELETE FROM Ejemplar
    WHERE idEdicion IN (
        SELECT e.id
        FROM Edicion e
        JOIN Libro l ON l.id = e.idLibro
        WHERE l.descripcion IN (
            'Libro de prueba seguridad ZS 1',
            'Libro de prueba seguridad ZS 2'
        )
    );

    -- Ediciones ZS
    DELETE FROM Edicion
    WHERE idLibro IN (
        SELECT id FROM Libro
        WHERE descripcion IN (
            'Libro de prueba seguridad ZS 1',
            'Libro de prueba seguridad ZS 2'
        )
    );

    -- Relaciones libro_autor ZS
    DELETE FROM Libro_Autor
    WHERE idLibro IN (
        SELECT id FROM Libro
        WHERE descripcion IN (
            'Libro de prueba seguridad ZS 1',
            'Libro de prueba seguridad ZS 2'
        )
    );

    -- Libros ZS
    DELETE FROM Libro
    WHERE descripcion IN (
        'Libro de prueba seguridad ZS 1',
        'Libro de prueba seguridad ZS 2'
    );

    -- Editoriales ZS
    DELETE FROM Editorial
    WHERE correo IN ('zs.edit1@booktrack.com','zs.edit2@booktrack.com');

    -- Autores ZS
    DELETE FROM Autor
    WHERE (nombre = 'AutorZS' AND apellidos = 'Uno')
       OR (nombre = 'AutorZS' AND apellidos = 'Dos');

    -- Categorías ZS
    DELETE FROM Categoria
    WHERE descripcion IN ('Categoria prueba seguridad ZS 1','Categoria prueba seguridad ZS 2');

    -- Administrador/Usuario ZS
    DELETE FROM Administrador
    WHERE idUsuario IN (
        SELECT id FROM Usuario
        WHERE correo IN ('zs.admin@booktrack.com')
    );

    DELETE FROM Usuario
    WHERE correo IN ('zs.admin@booktrack.com');

    -- Proveedores ZS
    DELETE FROM Proveedor
    WHERE correo IN ('zs.prov1@booktrack.com','zs.prov2@booktrack.com');

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

---------------------------------------------------------------------------------------------
-- 1) USUARIO ADMINISTRADOR
---------------------------------------------------------------------------------------------
BEGIN
    PK_ADMINISTRADOR.AD_USUARIO(
        'zs.admin@booktrack.com',
        'Administrador',
        'Zoraida',
        'Sanchez',
        '3005551111'
    );
EXCEPTION
    WHEN OTHERS THEN
        -- Si ya existe por correo único, continuar
        IF SQLCODE != -20027 THEN
            RAISE;
        END IF;
END;
/

---------------------------------------------------------------------------------------------
-- 2) REGISTRO EN ADMINISTRADOR
---------------------------------------------------------------------------------------------
DECLARE
    v_id_usuario Usuario.id%TYPE;
BEGIN
    SELECT id INTO v_id_usuario
    FROM Usuario
    WHERE correo = 'zs.admin@booktrack.com';

    PK_ADMINISTRADOR.AD_ADMINISTRADOR(
        v_id_usuario,
        'Total',
        'Sede Central'
    );
EXCEPTION
    WHEN OTHERS THEN
        -- Duplicado de administrador del mismo usuario
        IF SQLCODE != -20030 THEN
            RAISE;
        END IF;
END;
/

---------------------------------------------------------------------------------------------
-- 3) CATEGORIAS
---------------------------------------------------------------------------------------------
BEGIN
    PK_ADMINISTRADOR.AD_CATEGORIA('Seguridad ZS Uno', 'Categoria prueba seguridad ZS 1');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20001 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PK_ADMINISTRADOR.AD_CATEGORIA('Seguridad ZS Dos', 'Categoria prueba seguridad ZS 2');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20001 THEN
            RAISE;
        END IF;
END;
/

---------------------------------------------------------------------------------------------
-- 4) AUTORES
---------------------------------------------------------------------------------------------
BEGIN
    PK_ADMINISTRADOR.AD_AUTOR('AutorZS', 'Uno', 'Masculino', 'Colombiana');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20006 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PK_ADMINISTRADOR.AD_AUTOR('AutorZS', 'Dos', 'Femenino', 'Argentina');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20006 THEN
            RAISE;
        END IF;
END;
/

---------------------------------------------------------------------------------------------
-- 5) EDITORIALES
---------------------------------------------------------------------------------------------
BEGIN
    PK_ADMINISTRADOR.AD_EDITORIAL('Editorial ZS Uno', 'zs.edit1@booktrack.com', '3015551111', 'Colombia');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20011 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PK_ADMINISTRADOR.AD_EDITORIAL('Editorial ZS Dos', 'zs.edit2@booktrack.com', '3025552222', 'Argentina');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20011 THEN
            RAISE;
        END IF;
END;
/

---------------------------------------------------------------------------------------------
-- 6) LIBROS
---------------------------------------------------------------------------------------------
DECLARE
    v_cat1 Categoria.id%TYPE;
BEGIN
    SELECT id INTO v_cat1
    FROM Categoria
    WHERE descripcion = 'Categoria prueba seguridad ZS 1';

    PK_ADMINISTRADOR.AD_LIBRO(
        'Libro Seguridad ZS Uno',
        TO_DATE('01/01/2020','DD/MM/YYYY'),
        'Espanol',
        'Libro de prueba seguridad ZS 1',
        v_cat1
    );
END;
/
DECLARE
    v_cat2 Categoria.id%TYPE;
BEGIN
    SELECT id INTO v_cat2
    FROM Categoria
    WHERE descripcion = 'Categoria prueba seguridad ZS 2';

    PK_ADMINISTRADOR.AD_LIBRO(
        'Libro Seguridad ZS Dos',
        TO_DATE('01/06/2021','DD/MM/YYYY'),
        'Espanol',
        'Libro de prueba seguridad ZS 2',
        v_cat2
    );
END;
/

---------------------------------------------------------------------------------------------
-- 7) RELACION LIBRO_AUTOR
---------------------------------------------------------------------------------------------
DECLARE
    v_lib1 Libro.id%TYPE;
    v_lib2 Libro.id%TYPE;
    v_aut1 Autor.id%TYPE;
    v_aut2 Autor.id%TYPE;
BEGIN
    SELECT id INTO v_lib1 FROM Libro WHERE descripcion = 'Libro de prueba seguridad ZS 1';
    SELECT id INTO v_lib2 FROM Libro WHERE descripcion = 'Libro de prueba seguridad ZS 2';
    SELECT id INTO v_aut1 FROM Autor WHERE nombre = 'AutorZS' AND apellidos = 'Uno';
    SELECT id INTO v_aut2 FROM Autor WHERE nombre = 'AutorZS' AND apellidos = 'Dos';

    PK_ADMINISTRADOR.AD_AUTOR_LIBRO(v_aut1, v_lib1);
    PK_ADMINISTRADOR.AD_AUTOR_LIBRO(v_aut2, v_lib2);
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20009 THEN
            RAISE;
        END IF;
END;
/

---------------------------------------------------------------------------------------------
-- 8) EDICIONES
---------------------------------------------------------------------------------------------
DECLARE
    v_lib1 Libro.id%TYPE;
    v_lib2 Libro.id%TYPE;
    v_edt1 Editorial.id%TYPE;
    v_edt2 Editorial.id%TYPE;
BEGIN
    SELECT id INTO v_lib1 FROM Libro WHERE descripcion = 'Libro de prueba seguridad ZS 1';
    SELECT id INTO v_lib2 FROM Libro WHERE descripcion = 'Libro de prueba seguridad ZS 2';
    SELECT id INTO v_edt1 FROM Editorial WHERE correo = 'zs.edit1@booktrack.com';
    SELECT id INTO v_edt2 FROM Editorial WHERE correo = 'zs.edit2@booktrack.com';

    PK_ADMINISTRADOR.AD_EDICION(v_lib1, v_edt1, TO_DATE('01/02/2022','DD/MM/YYYY'), 220);
    PK_ADMINISTRADOR.AD_EDICION(v_lib2, v_edt2, TO_DATE('15/07/2023','DD/MM/YYYY'), 310);
END;
/

---------------------------------------------------------------------------------------------
-- 9) EJEMPLARES
---------------------------------------------------------------------------------------------
DECLARE
    v_edi1 Edicion.id%TYPE;
    v_edi2 Edicion.id%TYPE;
BEGIN
    SELECT e.id INTO v_edi1
    FROM Edicion e
    JOIN Libro l ON l.id = e.idLibro
    WHERE l.descripcion = 'Libro de prueba seguridad ZS 1'
      AND ROWNUM = 1;

    SELECT e.id INTO v_edi2
    FROM Edicion e
    JOIN Libro l ON l.id = e.idLibro
    WHERE l.descripcion = 'Libro de prueba seguridad ZS 2'
      AND ROWNUM = 1;

    PK_ADMINISTRADOR.AD_EJEMPLAR(v_edi1, 'Nuevo', 1, 'Estante ZS A', TO_DATE('01/03/2024','DD/MM/YYYY'));
    PK_ADMINISTRADOR.AD_EJEMPLAR(v_edi2, 'Bueno', 1, 'Estante ZS B', TO_DATE('10/04/2024','DD/MM/YYYY'));
END;
/

---------------------------------------------------------------------------------------------
-- 10) PROVEEDORES
---------------------------------------------------------------------------------------------
BEGIN
    PK_ADMINISTRADOR.AD_PROVEEDOR('Pedro', 'Zuluaga', 'zs.prov1@booktrack.com', 'Proveedor ZS 1', '3117771111');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20019 THEN
            RAISE;
        END IF;
END;
/
BEGIN
    PK_ADMINISTRADOR.AD_PROVEEDOR('Laura', 'Suarez', 'zs.prov2@booktrack.com', 'Proveedor ZS 2', '3127772222');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20019 THEN
            RAISE;
        END IF;
END;
/

---------------------------------------------------------------------------------------------
-- 11) COMPRAS
---------------------------------------------------------------------------------------------
DECLARE
    v_prv1 Proveedor.id%TYPE;
    v_prv2 Proveedor.id%TYPE;
BEGIN
    SELECT id INTO v_prv1 FROM Proveedor WHERE correo = 'zs.prov1@booktrack.com';
    SELECT id INTO v_prv2 FROM Proveedor WHERE correo = 'zs.prov2@booktrack.com';

    PK_ADMINISTRADOR.AD_COMPRA(TO_DATE('05/05/2024','DD/MM/YYYY'), 120000, 'PENDIENTE', v_prv1);
    PK_ADMINISTRADOR.AD_COMPRA(TO_DATE('06/05/2024','DD/MM/YYYY'), 80000, 'COMPLETADO', v_prv2);
END;
/

---------------------------------------------------------------------------------------------
-- 12) PRODUCTOS_COMPRA
---------------------------------------------------------------------------------------------
DECLARE
    v_comp1 Compra.id%TYPE;
    v_comp2 Compra.id%TYPE;
    v_lib1  Libro.id%TYPE;
    v_lib2  Libro.id%TYPE;
BEGIN
    SELECT c.id INTO v_comp1
    FROM Compra c
    JOIN Proveedor p ON p.id = c.idProveedor
    WHERE p.correo = 'zs.prov1@booktrack.com'
      AND ROWNUM = 1;

    SELECT c.id INTO v_comp2
    FROM Compra c
    JOIN Proveedor p ON p.id = c.idProveedor
    WHERE p.correo = 'zs.prov2@booktrack.com'
      AND ROWNUM = 1;

    SELECT id INTO v_lib1 FROM Libro WHERE descripcion = 'Libro de prueba seguridad ZS 1';
    SELECT id INTO v_lib2 FROM Libro WHERE descripcion = 'Libro de prueba seguridad ZS 2';

    PK_ADMINISTRADOR.AD_PRODUCTO_COMPRA(v_comp1, v_lib1, 2, 60000);
    PK_ADMINISTRADOR.AD_PRODUCTO_COMPRA(v_comp2, v_lib2, 1, 80000);
END;
/

COMMIT;

---------------------------------------------------------------------------------------------
-- CONSULTAS DE VERIFICACIÓN (EN COMENTARIOS)
---------------------------------------------------------------------------------------------
-- SELECT * FROM Usuario WHERE correo = 'zs.admin@booktrack.com';
-- SELECT * FROM Administrador WHERE idUsuario IN (SELECT id FROM Usuario WHERE correo='zs.admin@booktrack.com');
-- SELECT * FROM Categoria WHERE descripcion LIKE 'Categoria prueba seguridad ZS%';
-- SELECT * FROM Autor WHERE nombre = 'AutorZS';
-- SELECT * FROM Editorial WHERE correo IN ('zs.edit1@booktrack.com','zs.edit2@booktrack.com');
-- SELECT l.id, l.titulo, l.descripcion, c.nombre AS categoria
--   FROM Libro l LEFT JOIN Categoria c ON c.id = l.idCategoria
--  WHERE l.descripcion LIKE 'Libro de prueba seguridad ZS%';
-- SELECT la.idLibro, la.idAutor FROM Libro_Autor la
--  WHERE la.idLibro IN (SELECT id FROM Libro WHERE descripcion LIKE 'Libro de prueba seguridad ZS%');
-- SELECT * FROM Edicion WHERE idLibro IN (SELECT id FROM Libro WHERE descripcion LIKE 'Libro de prueba seguridad ZS%');
-- SELECT * FROM Ejemplar WHERE idEdicion IN (
--   SELECT e.id FROM Edicion e JOIN Libro l ON l.id = e.idLibro
--   WHERE l.descripcion LIKE 'Libro de prueba seguridad ZS%');
-- SELECT * FROM Proveedor WHERE correo IN ('zs.prov1@booktrack.com','zs.prov2@booktrack.com');
-- SELECT * FROM Compra WHERE idProveedor IN (SELECT id FROM Proveedor WHERE correo IN ('zs.prov1@booktrack.com','zs.prov2@booktrack.com'));
-- SELECT * FROM Producto_Compra WHERE idCompra IN (
--   SELECT c.id FROM Compra c JOIN Proveedor p ON p.id = c.idProveedor
--   WHERE p.correo IN ('zs.prov1@booktrack.com','zs.prov2@booktrack.com'));
