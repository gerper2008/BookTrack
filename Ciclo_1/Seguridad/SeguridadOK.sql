---------------------------------------------------------------------------------------------
--- SEGURIDAD OK: Ingreso de datos correctos usando los procedimientos del paquete
--- Datos diseñados para NO colisionar con triggers, tuplas ni acciones de referencia
---------------------------------------------------------------------------------------------

-- ============================================================
-- 1. USUARIOS Y ADMINISTRADOR
-- IDs generados por SYS_GUID() — se insertan y luego se consultan
-- rol debe ser: 'Administrador' | 'Lector' | 'Bibliotecario'
-- telefono: exactamente 10 dígitos numéricos
-- correo: formato válido
-- ============================================================
BEGIN PK_ADMINISTRADOR.AD_USUARIO('admin.garcia@booktrack.com', 'Administrador', 'Carlos',    'Garcia',   '3001234567'); END;
/
BEGIN PK_ADMINISTRADOR.AD_USUARIO('biblio.lopez@booktrack.com', 'Bibliotecario', 'Maria',     'Lopez',    '3109876543'); END;
/
BEGIN PK_ADMINISTRADOR.AD_USUARIO('cliente.torres@gmail.com',   'Lector',        'Santiago',  'Torres',   '3204567890'); END;
/

-- Registrar al administrador (recuperar su id primero)
DECLARE
    v_id Usuario.id%TYPE;
BEGIN
    SELECT id INTO v_id FROM Usuario WHERE correo = 'admin.garcia@booktrack.com';
    -- permisos: 'Solo Lectura' | 'Operativo' | 'Total'
    -- sede: solo letras y espacios
    PK_ADMINISTRADOR.AD_ADMINISTRADOR(v_id, 'Total', 'Sede Central');
END;
/

-- ============================================================
-- 2. CATEGORIAS
-- nombre: solo letras y espacios (CHECK_Categoria_nombre)
-- descripcion: solo letras y espacios (CHECK_Categoria_descripcion)
-- id generado automáticamente por TRG_Categoria_Generar_Id → CAT001, CAT002...
-- ============================================================
BEGIN PK_ADMINISTRADOR.AD_CATEGORIA('Ficcion',    'Obras de contenido imaginario y creativo'); END;
/
BEGIN PK_ADMINISTRADOR.AD_CATEGORIA('Ciencia',    'Textos de divulgacion y conocimiento cientifico'); END;
/
BEGIN PK_ADMINISTRADOR.AD_CATEGORIA('Historia',   'Relatos y analisis de eventos historicos'); END;
/

-- ============================================================
-- 3. AUTORES
-- nombre, apellidos, nacionalidad: solo letras y espacios
-- genero: 'Masculino' | 'Femenino' | 'Otro'
-- TUP6: nombre, apellidos y nacionalidad obligatorios
-- UQ: nombre + apellidos únicos
-- id → AUT001, AUT002...
-- ============================================================
BEGIN PK_ADMINISTRADOR.AD_AUTOR('Gabriel', 'Garcia Marquez', 'Masculino', 'Colombiana'); END;
/
BEGIN PK_ADMINISTRADOR.AD_AUTOR('Isabel',  'Allende Llona',  'Femenino',  'Chilena');    END;
/
BEGIN PK_ADMINISTRADOR.AD_AUTOR('Jorge',   'Amado Pereira',  'Masculino', 'Brasilena'); END;
/

-- ============================================================
-- 4. EDITORIALES
-- correo: formato válido y único
-- telefono: exactamente 10 dígitos y único
-- nombre, pais: solo letras y espacios
-- id → EDT001, EDT002...
-- ============================================================
BEGIN PK_ADMINISTRADOR.AD_EDITORIAL('Planeta',       'contacto@planeta.com',    '6013456789', 'Colombia'); END;
/
BEGIN PK_ADMINISTRADOR.AD_EDITORIAL('Alfaguara',     'info@alfaguara.com',       '6014567890', 'Espana');   END;
/
BEGIN PK_ADMINISTRADOR.AD_EDITORIAL('Fondo de Cultura', 'fce@fondoeditorial.com','6015678901', 'Mexico');   END;
/

-- ============================================================
-- 5. LIBROS
-- titulo, idioma: solo letras y espacios (TUP5: ambos obligatorios)
-- descripcion: solo letras y espacios
-- fecha_publicacion <= 31/12/2025
-- id → LIB001, LIB002...
-- TRG_Libro_Titulo_Sin_Ediciones: no modifica titulo si ya tiene ediciones
-- ============================================================
DECLARE
    v_cat VARCHAR2(10);
BEGIN
    SELECT id INTO v_cat FROM Categoria WHERE nombre = 'Ficcion';
    PK_ADMINISTRADOR.AD_LIBRO('Cien Anos de Soledad', TO_DATE('15/06/1967','DD/MM/YYYY'), 'Espanol', 'Novela magica sobre la familia Buendia', v_cat);
END;
/
DECLARE
    v_cat VARCHAR2(10);
BEGIN
    SELECT id INTO v_cat FROM Categoria WHERE nombre = 'Historia';
    PK_ADMINISTRADOR.AD_LIBRO('La Casa de los Espiritus', TO_DATE('20/03/1982','DD/MM/YYYY'), 'Espanol', 'Saga familiar en Chile durante el siglo XX', v_cat);
END;
/
DECLARE
    v_cat VARCHAR2(10);
BEGIN
    SELECT id INTO v_cat FROM Categoria WHERE nombre = 'Ciencia';
    PK_ADMINISTRADOR.AD_LIBRO('El Mundo de Sofia', TO_DATE('01/01/1991','DD/MM/YYYY'), 'Espanol', 'Novela sobre historia de la filosofia occidental', v_cat);
END;
/

-- ============================================================
-- 6. LIBRO_AUTOR (relaciones)
-- ============================================================
DECLARE
    v_libro VARCHAR2(10);
    v_autor VARCHAR2(10);
BEGIN
    SELECT id INTO v_libro FROM Libro WHERE titulo = 'Cien Anos de Soledad';
    SELECT id INTO v_autor FROM Autor WHERE nombre = 'Gabriel' AND apellidos = 'Garcia Marquez';
    PK_ADMINISTRADOR.AD_AUTOR_LIBRO(v_autor, v_libro);
END;
/
DECLARE
    v_libro VARCHAR2(10);
    v_autor VARCHAR2(10);
BEGIN
    SELECT id INTO v_libro FROM Libro WHERE titulo = 'La Casa de los Espiritus';
    SELECT id INTO v_autor FROM Autor WHERE nombre = 'Isabel' AND apellidos = 'Allende Llona';
    PK_ADMINISTRADOR.AD_AUTOR_LIBRO(v_autor, v_libro);
END;
/

-- ============================================================
-- 7. EDICIONES
-- paginas > 0
-- anio <= 31/12/2025
-- id → EDI001, EDI002...
-- TRG_Edicion_Origen_Sin_Ejemplares: no permite cambiar libro/editorial si tiene ejemplares
-- ============================================================
DECLARE
    v_libro   VARCHAR2(10);
    v_edit    VARCHAR2(10);
BEGIN
    SELECT id INTO v_libro FROM Libro     WHERE titulo  = 'Cien Anos de Soledad';
    SELECT id INTO v_edit  FROM Editorial WHERE nombre  = 'Planeta';
    PK_ADMINISTRADOR.AD_EDICION(v_libro, v_edit, TO_DATE('01/01/2010','DD/MM/YYYY'), 432);
END;
/
DECLARE
    v_libro   VARCHAR2(10);
    v_edit    VARCHAR2(10);
BEGIN
    SELECT id INTO v_libro FROM Libro     WHERE titulo = 'La Casa de los Espiritus';
    SELECT id INTO v_edit  FROM Editorial WHERE nombre = 'Alfaguara';
    PK_ADMINISTRADOR.AD_EDICION(v_libro, v_edit, TO_DATE('01/01/2015','DD/MM/YYYY'), 368);
END;
/
DECLARE
    v_libro   VARCHAR2(10);
    v_edit    VARCHAR2(10);
BEGIN
    SELECT id INTO v_libro FROM Libro     WHERE titulo = 'El Mundo de Sofia';
    SELECT id INTO v_edit  FROM Editorial WHERE nombre = 'Fondo de Cultura';
    PK_ADMINISTRADOR.AD_EDICION(v_libro, v_edit, TO_DATE('01/01/2018','DD/MM/YYYY'), 512);
END;
/

-- ============================================================
-- 8. EJEMPLARES
-- estadoFisico: 'Desgastado'|'Bueno'|'Dañado'|'Restaurado'|'Perdido'|'Nuevo'
-- TUP3: disponibilidad=0 NO puede tener estadoFisico='Nuevo'
-- disponibilidad: 1 = disponible, 0 = no disponible
-- fechaAdquisicion <= 31/12/2025
-- localizacion: solo letras y espacios
-- id → EJM001, EJM002...
-- TRG_Ejemplar_Disponible: no elimina si disponibilidad='DISPONIBLE'
-- ============================================================
DECLARE
    v_edicion VARCHAR2(10);
BEGIN
    SELECT e.id INTO v_edicion
    FROM Edicion e JOIN Libro l ON e.idLibro = l.id
    WHERE l.titulo = 'Cien Anos de Soledad' AND ROWNUM = 1;
    -- disponibilidad=1, estadoFisico='Nuevo' → válido (TUP3 solo prohíbe 0+'Nuevo')
    PK_ADMINISTRADOR.AD_EJEMPLAR(v_edicion, 'Nuevo',      1, 'Estante A',  TO_DATE('10/01/2024','DD/MM/YYYY'));
    PK_ADMINISTRADOR.AD_EJEMPLAR(v_edicion, 'Bueno',      1, 'Estante B',  TO_DATE('15/03/2023','DD/MM/YYYY'));
    -- disponibilidad=0, estadoFisico='Dañado' → válido (no es 'Nuevo')
    PK_ADMINISTRADOR.AD_EJEMPLAR(v_edicion, 'Dañado',     0, 'Deposito C', TO_DATE('20/05/2022','DD/MM/YYYY'));
END;
/
DECLARE
    v_edicion VARCHAR2(10);
BEGIN
    SELECT e.id INTO v_edicion
    FROM Edicion e JOIN Libro l ON e.idLibro = l.id
    WHERE l.titulo = 'La Casa de los Espiritus' AND ROWNUM = 1;
    PK_ADMINISTRADOR.AD_EJEMPLAR(v_edicion, 'Bueno',      1, 'Estante D',  TO_DATE('05/07/2023','DD/MM/YYYY'));
    PK_ADMINISTRADOR.AD_EJEMPLAR(v_edicion, 'Desgastado', 0, 'Deposito E', TO_DATE('01/02/2021','DD/MM/YYYY'));
END;
/

-- ============================================================
-- 9. PROVEEDORES
-- correo único, telefono 10 dígitos
-- nombre, apellidos, empresa: solo letras y espacios
-- id → PRV001, PRV002...
-- TRG_Proveedor_Baja_Sin_Compras: no elimina si tiene compras
-- ============================================================
BEGIN PK_ADMINISTRADOR.AD_PROVEEDOR('Juan',   'Ramirez Ospina', 'juan.ramirez@distrilibros.com', 'Distrilibros',  '3112345678'); END;
/
BEGIN PK_ADMINISTRADOR.AD_PROVEEDOR('Andrea', 'Mora Castillo',  'andrea.mora@librerianacional.com','Libreria Nacional','3223456789'); END;
/

-- ============================================================
-- 10. COMPRAS
-- estado: 'PENDIENTE' | 'COMPLETADO' | 'RECHAZADO'
-- TUP1: si COMPLETADO → total > 0
-- TUP2 (Producto_Compra): cantidad > 0 y precioUnidad > 0
-- fecha <= 31/12/2025
-- TRG_Compra_Estado_Inicial: si estado NULL → 'PENDIENTE'
-- id → COM001, COM002...
-- ============================================================
DECLARE
    v_prov VARCHAR2(10);
BEGIN
    SELECT id INTO v_prov FROM Proveedor WHERE correo = 'juan.ramirez@distrilibros.com';
    -- COMPLETADO con total > 0 → válido para TUP1
    PK_ADMINISTRADOR.AD_COMPRA(TO_DATE('10/03/2024','DD/MM/YYYY'), 850000, 'COMPLETADO', v_prov);
END;
/
DECLARE
    v_prov VARCHAR2(10);
BEGIN
    SELECT id INTO v_prov FROM Proveedor WHERE correo = 'andrea.mora@librerianacional.com';
    -- PENDIENTE con total >= 0 → válido
    PK_ADMINISTRADOR.AD_COMPRA(TO_DATE('15/04/2024','DD/MM/YYYY'), 0, 'PENDIENTE', v_prov);
END;
/

-- ============================================================
-- 11. PRODUCTOS DE COMPRA
-- cantidad > 0, precioUnidad > 0 (TUP2)
-- ============================================================
DECLARE
    v_compra VARCHAR2(10);
    v_libro  VARCHAR2(10);
BEGIN
    SELECT id INTO v_compra FROM Compra WHERE estado = 'COMPLETADO' AND ROWNUM = 1;
    SELECT id INTO v_libro  FROM Libro  WHERE titulo = 'Cien Anos de Soledad';
    PK_ADMINISTRADOR.AD_PRODUCTO_COMPRA(v_compra, v_libro, 5, 170000);
END;
/
DECLARE
    v_compra VARCHAR2(10);
    v_libro  VARCHAR2(10);
BEGIN
    SELECT id INTO v_compra FROM Compra WHERE estado = 'COMPLETADO' AND ROWNUM = 1;
    SELECT id INTO v_libro  FROM Libro  WHERE titulo = 'La Casa de los Espiritus';
    PK_ADMINISTRADOR.AD_PRODUCTO_COMPRA(v_compra, v_libro, 3, 95000);
END;
/

-- ============================================================
-- VERIFICACION FINAL — consultas de comprobacion
-- ============================================================
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_CATEGORIA();       DBMS_SQL.RETURN_RESULT(cur); END; /
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_CATALOGO_LIBROS(NULL, NULL); DBMS_SQL.RETURN_RESULT(cur); END; /
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_AUTOR(NULL, NULL); DBMS_SQL.RETURN_RESULT(cur); END; /
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_EDITORIAL(NULL);   DBMS_SQL.RETURN_RESULT(cur); END; /
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_EDICION();         DBMS_SQL.RETURN_RESULT(cur); END; /
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_EJEMPLAR();        DBMS_SQL.RETURN_RESULT(cur); END; /
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_PROVEEDOR();       DBMS_SQL.RETURN_RESULT(cur); END; /
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_COMPRA();          DBMS_SQL.RETURN_RESULT(cur); END; /
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_USUARIOS();        DBMS_SQL.RETURN_RESULT(cur); END; /
DECLARE cur SYS_REFCURSOR; BEGIN cur := PK_ADMINISTRADOR.CO_ADMINISTRADORES(); DBMS_SQL.RETURN_RESULT(cur); END; /
