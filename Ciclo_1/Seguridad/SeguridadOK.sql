---------------------------------------------------------------------------------------------
--- SEGURIDAD OK: Ingreso de datos correctos para el actor ADMINISTRADOR
--- Generado desde cero a partir del DDL (tablas, atributos, llaves, tuplas, disparadores)
---
--- NOTAS IMPORTANTES DEL DDL:
---   · Usuario y Producto_Compra generan su id internamente en ActoresI.sql
---     con el mismo patrón MAX(SUBSTR(id,4))+1 que usan los demás triggers.
---   · disponibilidad es CHAR(1): valores '1' (disponible) y '0' (no disponible).
---   · CHECK_Compra_total exige total > 0 siempre (aplica también a PENDIENTE).
---   · TUP3: prohíbe disponibilidad='0' AND estadoFisico='Nuevo'.
---   · UQ: Categoria.nombre, Editorial.correo, Editorial.telefono,
---         Proveedor.correo, Usuario.correo, Autor(nombre+apellidos) son únicos.
---------------------------------------------------------------------------------------------

-- ============================================================
-- 0. LIMPIEZA PREVIA
-- Permite re-ejecutar el script sin errores de duplicados.
-- Orden inverso de dependencias FK.
-- ============================================================
BEGIN
    -- Productos de compra
    DELETE FROM Producto_Compra
    WHERE idCompra IN (
        SELECT c.id FROM Compra c
        JOIN Proveedor p ON c.idProveedor = p.id
        WHERE p.correo IN ('juan.ramirez@distrilibros.com',
                           'andrea.mora@librerianacional.com',
                           'pedro.gil@sudamericana.com')
    );

    -- Compras
    DELETE FROM Compra
    WHERE idProveedor IN (
        SELECT id FROM Proveedor
        WHERE correo IN ('juan.ramirez@distrilibros.com',
                         'andrea.mora@librerianacional.com',
                         'pedro.gil@sudamericana.com')
    );

    -- Proveedores
    DELETE FROM Proveedor
    WHERE correo IN ('juan.ramirez@distrilibros.com',
                     'andrea.mora@librerianacional.com',
                     'pedro.gil@sudamericana.com');

    -- Ejemplares de las ediciones de este script
    DELETE FROM Ejemplar
    WHERE idEdicion IN (
        SELECT e.id FROM Edicion e
        JOIN Editorial ed ON e.idEditorial = ed.id
        WHERE ed.correo IN ('ventas@norteamerica.com',
                            'info@surbooks.com',
                            'contacto@iberica.com')
    );

    -- Ediciones de este script
    DELETE FROM Edicion
    WHERE idEditorial IN (
        SELECT id FROM Editorial
        WHERE correo IN ('ventas@norteamerica.com',
                         'info@surbooks.com',
                         'contacto@iberica.com')
    );

    -- Relaciones libro-autor de los libros de este script
    DELETE FROM Libro_Autor
    WHERE idLibro IN (
        SELECT id FROM Libro
        WHERE descripcion IN (
            'Relato epico de varias generaciones en Macondo',
            'Novela historica sobre una familia chilena',
            'Introduccion a la filosofia narrada como novela'
        )
    );

    -- Libros (identificados por descripcion unica)
    DELETE FROM Libro
    WHERE descripcion IN (
        'Relato epico de varias generaciones en Macondo',
        'Novela historica sobre una familia chilena',
        'Introduccion a la filosofia narrada como novela'
    );

    -- Editoriales
    DELETE FROM Editorial
    WHERE correo IN ('ventas@norteamerica.com',
                     'info@surbooks.com',
                     'contacto@iberica.com');

    -- Autores
    DELETE FROM Autor
    WHERE (nombre = 'Gabriel' AND apellidos = 'Garcia Marquez')
       OR (nombre = 'Isabel'  AND apellidos = 'Allende Llona')
       OR (nombre = 'Jostein' AND apellidos = 'Gaarder');

    -- Categorias (por descripcion para no romper otras con mismo nombre)
    DELETE FROM Categoria
    WHERE descripcion IN (
        'Literatura de ficcion e imaginacion',
        'Ciencia y pensamiento cientifico',
        'Filosofia y reflexion humana'
    );

    -- Administrador y Usuario
    DELETE FROM Administrador
    WHERE idUsuario IN (
        SELECT id FROM Usuario
        WHERE correo IN ('carlos.garcia@biblioteca.com',
                         'maria.lopez@biblioteca.com',
                         'santiago.torres@biblioteca.com')
    );
    DELETE FROM Usuario
    WHERE correo IN ('carlos.garcia@biblioteca.com',
                     'maria.lopez@biblioteca.com',
                     'santiago.torres@biblioteca.com');

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('=== Limpieza previa completada ===');
END;
/

-- ============================================================
-- 1. USUARIOS
-- CHECK_Usuario_nombre/apellidos : solo letras y espacios (con tildes)
-- CHECK_Usuario_correo           : formato email valido
-- CHECK_Usuario_telefono         : exactamente 10 digitos
-- CHECK_Usuario_rol              : 'Administrador' | 'Lector' | 'Bibliotecario'
-- UQ: correo unico
-- id generado por AD_USUARIO internamente → USR001, USR002...
-- ============================================================
BEGIN
    PK_ADMINISTRADOR.AD_USUARIO(
        'carlos.garcia@biblioteca.com',  -- correo
        'Administrador',                 -- rol
        'Carlos',                        -- nombre
        'Garcia Mendoza',                -- apellidos
        '3001234567'                     -- telefono: 10 digitos
    );
END;
/
BEGIN
    PK_ADMINISTRADOR.AD_USUARIO(
        'maria.lopez@biblioteca.com',
        'Bibliotecario',
        'Maria',
        'Lopez Ruiz',
        '3109876543'
    );
END;
/
BEGIN
    PK_ADMINISTRADOR.AD_USUARIO(
        'santiago.torres@biblioteca.com',
        'Lector',
        'Santiago',
        'Torres Pena',
        '3204561234'
    );
END;
/

-- ============================================================
-- 2. ADMINISTRADOR
-- CHECK_Administrador_permisos : 'Solo Lectura' | 'Operativo' | 'Total'
-- CHECK_Administrador_sede     : solo letras y espacios
-- FK: idUsuario debe existir en Usuario
-- Se recupera el id por correo unico → una sola fila garantizada
-- ============================================================
DECLARE
    v_id Usuario.id%TYPE;
BEGIN
    SELECT id INTO v_id
    FROM Usuario
    WHERE correo = 'carlos.garcia@biblioteca.com';

    PK_ADMINISTRADOR.AD_ADMINISTRADOR(
        v_id,           -- idUsuario
        'Total',        -- permisos
        'Sede Central'  -- sede: solo letras y espacios
    );
END;
/

-- ============================================================
-- 3. CATEGORIAS
-- CHECK_Categoria_nombre      : solo letras y espacios
-- CHECK_Categoria_descripcion : solo letras y espacios
-- UQ: nombre unico
-- id → CAT### generado por TRG_Categoria_Generar_Id
-- ============================================================
BEGIN PK_ADMINISTRADOR.AD_CATEGORIA('Ficcion',   'Literatura de ficcion e imaginacion');   END;
/
BEGIN PK_ADMINISTRADOR.AD_CATEGORIA('Ciencia',   'Ciencia y pensamiento cientifico');       END;
/
BEGIN PK_ADMINISTRADOR.AD_CATEGORIA('Filosofia', 'Filosofia y reflexion humana');           END;
/

-- ============================================================
-- 4. AUTORES
-- CHECK_Autor_nombre/apellidos/nacionalidad : solo letras y espacios
-- CHECK_Autor_genero : 'Masculino' | 'Femenino' | 'Otro'
-- TUP6: nombre, apellidos y nacionalidad obligatorios (NOT NULL)
-- UQ: nombre + apellidos unicos (UQ_Autor_Nombre_Apellidos)
-- id → AUT### generado por TRG_Autor_Generar_Id
-- ============================================================
BEGIN PK_ADMINISTRADOR.AD_AUTOR('Gabriel', 'Garcia Marquez', 'Masculino', 'Colombiana'); END;
/
BEGIN PK_ADMINISTRADOR.AD_AUTOR('Isabel',  'Allende Llona',  'Femenino',  'Chilena');    END;
/
BEGIN PK_ADMINISTRADOR.AD_AUTOR('Jostein', 'Gaarder',        'Masculino', 'Noruega');    END;
/

-- ============================================================
-- 5. EDITORIALES
-- CHECK_Editorial_correo   : formato email valido y unico
-- CHECK_Editorial_telefono : 10 digitos y unico
-- CHECK_Editorial_nombre   : solo letras y espacios
-- CHECK_Editorial_pais     : solo letras y espacios
-- UQ: correo unico | telefono unico
-- id → EDT### generado por TRG_Editorial_Generar_Id
-- ============================================================
BEGIN PK_ADMINISTRADOR.AD_EDITORIAL('Norteamerica Libros', 'ventas@norteamerica.com',  '6011112233', 'Colombia');  END;
/
BEGIN PK_ADMINISTRADOR.AD_EDITORIAL('Sur Books',           'info@surbooks.com',         '6024445566', 'Argentina'); END;
/
BEGIN PK_ADMINISTRADOR.AD_EDITORIAL('Iberica Editorial',   'contacto@iberica.com',      '6037778899', 'Espana');    END;
/

-- ============================================================
-- 6. LIBROS
-- CHECK_Libro_titulo/idioma/descripcion : solo letras y espacios
-- CHECK_Libro_fecha_publicacion         : <= 31/12/2025
-- TUP5: titulo e idioma obligatorios (NOT NULL)
-- FK: idCategoria debe existir en Categoria
-- id → LIB### generado por TRG_Libro_Generar_Id
-- Se busca categoria por descripcion unica de este script → una fila garantizada
-- ============================================================
DECLARE
    v_cat VARCHAR2(10);
BEGIN
    SELECT id INTO v_cat FROM Categoria
    WHERE descripcion = 'Literatura de ficcion e imaginacion';

    PK_ADMINISTRADOR.AD_LIBRO(
        'Cien Anos de Soledad',
        TO_DATE('05/06/1967', 'DD/MM/YYYY'),
        'Espanol',
        'Relato epico de varias generaciones en Macondo',  -- descripcion unica en este script
        v_cat
    );
END;
/
DECLARE
    v_cat VARCHAR2(10);
BEGIN
    SELECT id INTO v_cat FROM Categoria
    WHERE descripcion = 'Literatura de ficcion e imaginacion';

    PK_ADMINISTRADOR.AD_LIBRO(
        'La Casa de los Espiritus',
        TO_DATE('20/03/1982', 'DD/MM/YYYY'),
        'Espanol',
        'Novela historica sobre una familia chilena',
        v_cat
    );
END;
/
DECLARE
    v_cat VARCHAR2(10);
BEGIN
    SELECT id INTO v_cat FROM Categoria
    WHERE descripcion = 'Filosofia y reflexion humana';

    PK_ADMINISTRADOR.AD_LIBRO(
        'El Mundo de Sofia',
        TO_DATE('01/03/1991', 'DD/MM/YYYY'),
        'Espanol',
        'Introduccion a la filosofia narrada como novela',
        v_cat
    );
END;
/

-- ============================================================
-- 7. LIBRO_AUTOR
-- FK: idLibro en Libro, idAutor en Autor
-- PK compuesta (idLibro, idAutor): par no repetido
-- Se busca libro por descripcion unica y autor por nombre+apellidos (UQ)
-- ============================================================
DECLARE
    v_libro VARCHAR2(10);
    v_autor VARCHAR2(10);
BEGIN
    SELECT id INTO v_libro FROM Libro
    WHERE descripcion = 'Relato epico de varias generaciones en Macondo';
    SELECT id INTO v_autor FROM Autor
    WHERE nombre = 'Gabriel' AND apellidos = 'Garcia Marquez';
    PK_ADMINISTRADOR.AD_AUTOR_LIBRO(v_autor, v_libro);
END;
/
DECLARE
    v_libro VARCHAR2(10);
    v_autor VARCHAR2(10);
BEGIN
    SELECT id INTO v_libro FROM Libro
    WHERE descripcion = 'Novela historica sobre una familia chilena';
    SELECT id INTO v_autor FROM Autor
    WHERE nombre = 'Isabel' AND apellidos = 'Allende Llona';
    PK_ADMINISTRADOR.AD_AUTOR_LIBRO(v_autor, v_libro);
END;
/
DECLARE
    v_libro VARCHAR2(10);
    v_autor VARCHAR2(10);
BEGIN
    SELECT id INTO v_libro FROM Libro
    WHERE descripcion = 'Introduccion a la filosofia narrada como novela';
    SELECT id INTO v_autor FROM Autor
    WHERE nombre = 'Jostein' AND apellidos = 'Gaarder';
    PK_ADMINISTRADOR.AD_AUTOR_LIBRO(v_autor, v_libro);
END;
/

-- ============================================================
-- 8. EDICIONES
-- CHECK_Edicion_anio    : <= 31/12/2025
-- CHECK_Edicion_paginas : > 0  (NUMBER(3) → maximo 999)
-- FK: idLibro en Libro, idEditorial en Editorial
-- id → EDI### generado por TRG_Edicion_Generar_Id
-- Se busca por descripcion (libro) y correo (editorial), ambos unicos
-- ============================================================
DECLARE
    v_libro VARCHAR2(10);
    v_edit  VARCHAR2(10);
BEGIN
    SELECT id INTO v_libro FROM Libro     WHERE descripcion = 'Relato epico de varias generaciones en Macondo';
    SELECT id INTO v_edit  FROM Editorial WHERE correo = 'ventas@norteamerica.com';
    PK_ADMINISTRADOR.AD_EDICION(v_libro, v_edit, TO_DATE('01/01/2005', 'DD/MM/YYYY'), 432);
END;
/
DECLARE
    v_libro VARCHAR2(10);
    v_edit  VARCHAR2(10);
BEGIN
    SELECT id INTO v_libro FROM Libro     WHERE descripcion = 'Novela historica sobre una familia chilena';
    SELECT id INTO v_edit  FROM Editorial WHERE correo = 'info@surbooks.com';
    PK_ADMINISTRADOR.AD_EDICION(v_libro, v_edit, TO_DATE('15/06/2010', 'DD/MM/YYYY'), 368);
END;
/
DECLARE
    v_libro VARCHAR2(10);
    v_edit  VARCHAR2(10);
BEGIN
    SELECT id INTO v_libro FROM Libro     WHERE descripcion = 'Introduccion a la filosofia narrada como novela';
    SELECT id INTO v_edit  FROM Editorial WHERE correo = 'contacto@iberica.com';
    PK_ADMINISTRADOR.AD_EDICION(v_libro, v_edit, TO_DATE('20/03/2018', 'DD/MM/YYYY'), 512);
END;
/

-- ============================================================
-- 9. EJEMPLARES
-- disponibilidad             : CHAR(1) → '1' disponible | '0' no disponible
-- CHECK_Ejemplar_estadoFisico: 'Desgastado'|'Bueno'|'Dañado'|'Restaurado'|'Perdido'|'Nuevo'
-- CHECK_Ejemplar_localizacion: solo letras y espacios
-- CHECK_Ejemplar_fechaAdquisicion: <= 31/12/2025
-- TUP3: disponibilidad='0' AND estadoFisico='Nuevo' → PROHIBIDO
-- Se busca edicion por correo unico de editorial → una sola fila garantizada
-- ============================================================
DECLARE
    v_edicion VARCHAR2(10);
BEGIN
    SELECT e.id INTO v_edicion
    FROM Edicion e
    JOIN Editorial ed ON e.idEditorial = ed.id
    WHERE ed.correo = 'ventas@norteamerica.com';

    PK_ADMINISTRADOR.AD_EJEMPLAR(v_edicion, 'Nuevo',      '1', 'Estante A',  TO_DATE('10/01/2024', 'DD/MM/YYYY'));
    PK_ADMINISTRADOR.AD_EJEMPLAR(v_edicion, 'Bueno',      '1', 'Estante B',  TO_DATE('15/03/2023', 'DD/MM/YYYY'));
    PK_ADMINISTRADOR.AD_EJEMPLAR(v_edicion, 'Dañado',     '0', 'Deposito C', TO_DATE('20/05/2022', 'DD/MM/YYYY'));
END;
/
DECLARE
    v_edicion VARCHAR2(10);
BEGIN
    SELECT e.id INTO v_edicion
    FROM Edicion e
    JOIN Editorial ed ON e.idEditorial = ed.id
    WHERE ed.correo = 'info@surbooks.com';

    PK_ADMINISTRADOR.AD_EJEMPLAR(v_edicion, 'Restaurado', '1', 'Estante D',  TO_DATE('05/07/2023', 'DD/MM/YYYY'));
    PK_ADMINISTRADOR.AD_EJEMPLAR(v_edicion, 'Desgastado', '0', 'Deposito E', TO_DATE('01/02/2021', 'DD/MM/YYYY'));
END;
/
DECLARE
    v_edicion VARCHAR2(10);
BEGIN
    SELECT e.id INTO v_edicion
    FROM Edicion e
    JOIN Editorial ed ON e.idEditorial = ed.id
    WHERE ed.correo = 'contacto@iberica.com';

    PK_ADMINISTRADOR.AD_EJEMPLAR(v_edicion, 'Perdido',    '0', 'Deposito F', TO_DATE('10/08/2020', 'DD/MM/YYYY'));
END;
/

-- ============================================================
-- 10. PROVEEDORES
-- CHECK_Proveedor_correo/nombre/apellidos/empresa : letras y espacios / email
-- CHECK_Proveedor_telefono : 10 digitos
-- UQ: correo unico
-- id → PRV### generado por TRG_Proveedor_Generar_Id
-- ============================================================
BEGIN PK_ADMINISTRADOR.AD_PROVEEDOR('Juan',   'Ramirez Ospina', 'juan.ramirez@distrilibros.com',    'Distrilibros',      '3112345678'); END;
/
BEGIN PK_ADMINISTRADOR.AD_PROVEEDOR('Andrea', 'Mora Castillo',  'andrea.mora@librerianacional.com', 'Libreria Nacional', '3223456789'); END;
/
BEGIN PK_ADMINISTRADOR.AD_PROVEEDOR('Pedro',  'Gil Suarez',     'pedro.gil@sudamericana.com',       'Editorial Sudamericana', '3006667788'); END;
/

-- ============================================================
-- 11. COMPRAS
-- CHECK_Compra_estado : 'PENDIENTE' | 'COMPLETADO' | 'RECHAZADO'
-- CHECK_Compra_total  : total > 0 (aplica a todos los estados)
-- CHECK_Compra_fecha  : <= 31/12/2025
-- FK: idProveedor en Proveedor
-- id → COM### generado por TRG_Compra_Generar_Id
-- Se busca proveedor por correo unico → una sola fila garantizada
-- ============================================================
DECLARE
    v_prov VARCHAR2(10);
BEGIN
    SELECT id INTO v_prov FROM Proveedor WHERE correo = 'juan.ramirez@distrilibros.com';
    PK_ADMINISTRADOR.AD_COMPRA(TO_DATE('10/03/2024', 'DD/MM/YYYY'), 850000, 'COMPLETADO', v_prov);
END;
/
DECLARE
    v_prov VARCHAR2(10);
BEGIN
    SELECT id INTO v_prov FROM Proveedor WHERE correo = 'andrea.mora@librerianacional.com';
    PK_ADMINISTRADOR.AD_COMPRA(TO_DATE('15/04/2024', 'DD/MM/YYYY'), 320000, 'PENDIENTE', v_prov);
END;
/
DECLARE
    v_prov VARCHAR2(10);
BEGIN
    SELECT id INTO v_prov FROM Proveedor WHERE correo = 'pedro.gil@sudamericana.com';
    PK_ADMINISTRADOR.AD_COMPRA(TO_DATE('20/06/2024', 'DD/MM/YYYY'), 95000, 'RECHAZADO', v_prov);
END;
/

-- ============================================================
-- 12. PRODUCTOS DE COMPRA
-- CHECK_Producto_Compra_cantidad    : cantidad > 0
-- CHECK_Producto_Compra_precioUnidad: precioUnidad > 0
-- TUP2: cantidad > 0 AND precioUnidad > 0
-- FK: idCompra en Compra, idLibro en Libro
-- id → PCO### generado por AD_PRODUCTO_COMPRA internamente
-- Se busca compra por correo unico de proveedor → una fila por proveedor
-- ============================================================
DECLARE
    v_compra VARCHAR2(10);
    v_libro  VARCHAR2(10);
BEGIN
    SELECT c.id INTO v_compra FROM Compra c
    JOIN Proveedor p ON c.idProveedor = p.id
    WHERE p.correo = 'juan.ramirez@distrilibros.com';

    SELECT id INTO v_libro FROM Libro
    WHERE descripcion = 'Relato epico de varias generaciones en Macondo';

    PK_ADMINISTRADOR.AD_PRODUCTO_COMPRA(v_compra, v_libro, 5, 170000);  -- 5 x 170000 = 850000
END;
/
DECLARE
    v_compra VARCHAR2(10);
    v_libro  VARCHAR2(10);
BEGIN
    SELECT c.id INTO v_compra FROM Compra c
    JOIN Proveedor p ON c.idProveedor = p.id
    WHERE p.correo = 'andrea.mora@librerianacional.com';

    SELECT id INTO v_libro FROM Libro
    WHERE descripcion = 'Novela historica sobre una familia chilena';

    PK_ADMINISTRADOR.AD_PRODUCTO_COMPRA(v_compra, v_libro, 4, 80000);   -- 4 x 80000 = 320000
END;
/
DECLARE
    v_compra VARCHAR2(10);
    v_libro  VARCHAR2(10);
BEGIN
    SELECT c.id INTO v_compra FROM Compra c
    JOIN Proveedor p ON c.idProveedor = p.id
    WHERE p.correo = 'pedro.gil@sudamericana.com';

    SELECT id INTO v_libro FROM Libro
    WHERE descripcion = 'Introduccion a la filosofia narrada como novela';

    PK_ADMINISTRADOR.AD_PRODUCTO_COMPRA(v_compra, v_libro, 1, 95000);   -- 1 x 95000 = 95000
END;
/

-- ============================================================
-- VERIFICACION FINAL
-- ============================================================
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_CATEGORIA();                 DBMS_SQL.RETURN_RESULT(cur); END;
/
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_CATALOGO_LIBROS(NULL, NULL); DBMS_SQL.RETURN_RESULT(cur); END;
/
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_AUTOR(NULL, NULL);           DBMS_SQL.RETURN_RESULT(cur); END;
/
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_EDITORIAL(NULL);             DBMS_SQL.RETURN_RESULT(cur); END;
/
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_EDICION();                   DBMS_SQL.RETURN_RESULT(cur); END;
/
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_EJEMPLAR();                  DBMS_SQL.RETURN_RESULT(cur); END;
/
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_PROVEEDOR();                 DBMS_SQL.RETURN_RESULT(cur); END;
/
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_COMPRA();                    DBMS_SQL.RETURN_RESULT(cur); END;
/
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_USUARIOS();                  DBMS_SQL.RETURN_RESULT(cur); END;
/
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_ADMINISTRADORES();           DBMS_SQL.RETURN_RESULT(cur); END;
/
