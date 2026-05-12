---------------------------------------------------------------------------------------------
--- DISPARADORES: Automatización y restricciones procedimentales
---------------------------------------------------------------------------------------------
-- ==========================================================================================
-- CU-1 (Mantener Categoría): COMO Administrador, QUIERO gestionar los géneros y
-- clasificaciones, PARA PODER organizar el catálogo por áreas temáticas.
-- ==========================================================================================
 -- DISP-01: Generar id de Categoria → CAT + 3 dígitos
CREATE OR REPLACE TRIGGER TRG_Categoria_Generar_Id
BEFORE INSERT ON Categoria
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID
    FROM Categoria;
    :NEW.id := 'CAT' || LPAD(lastID + 1, 3, '0');
END TRG_Categoria_Generar_Id;
/

-- DISP-02: Nombre de Categoria no duplicado
-- CORRECCION: en INSERT, :NEW.id aún no existe en tabla → se omite filtro de id en INSERT
CREATE OR REPLACE TRIGGER TRG_Categoria_Nombre_Unico
BEFORE INSERT OR UPDATE OF nombre ON Categoria
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    IF INSERTING THEN
        SELECT COUNT(*) INTO v_count
        FROM Categoria
        WHERE UPPER(nombre) = UPPER(:NEW.nombre);
    ELSE
        SELECT COUNT(*) INTO v_count
        FROM Categoria
        WHERE UPPER(nombre) = UPPER(:NEW.nombre)
        AND id != :OLD.id;
    END IF;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20042,
            'Ya existe una categoría con el nombre "' || :NEW.nombre || '" en el sistema.');
    END IF;
END TRG_Categoria_Nombre_Unico;
/

-- DISP-03: No eliminar Categoria si tiene Libros
CREATE OR REPLACE TRIGGER TRG_CATEGORIA_BAJA_SIN_LIBROS
BEFORE DELETE ON Categoria
FOR EACH ROW
DECLARE
    v_count NUMBER;
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Libro WHERE idCategoria = :OLD.id;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20040,
            'No se puede eliminar la categoria "' || :OLD.nombre ||
            '" porque tiene ' || v_count || ' libro(s) asociado(s).');
    END IF;
    ROLLBACK;
END TRG_CATEGORIA_BAJA_SIN_LIBROS;
/

-- DISP-04: Generar id de Libro → LIB + 3 dígitos
CREATE OR REPLACE TRIGGER TRG_Libro_Generar_Id
BEFORE INSERT ON Libro
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID FROM Libro;
    :NEW.id := 'LIB' || LPAD(lastID + 1, 3, '0');
END TRG_Libro_Generar_Id;
/

-- DISP-05: Verificar que idCategoria del Libro exista
CREATE OR REPLACE TRIGGER TRG_Libro_Categoria_Existe
BEFORE INSERT OR UPDATE OF idCategoria ON Libro
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Categoria WHERE id = :NEW.idCategoria;
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20041,
            'La categoría "' || :NEW.idCategoria || '" no existe en el catálogo.');
    END IF;
END TRG_Libro_Categoria_Existe;
/

-- DISP-06: No modificar titulo si tiene ediciones activas
CREATE OR REPLACE TRIGGER TRG_Libro_Titulo_Sin_Ediciones
BEFORE UPDATE OF titulo ON Libro
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Edicion WHERE idLibro = :OLD.id;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20020,
            'No se puede modificar el título del libro "' || :OLD.titulo ||
            '" porque tiene ' || v_count || ' edición(es) activa(s) registrada(s).');
    END IF;
END TRG_Libro_Titulo_Sin_Ediciones;
/

-- DISP-07: No eliminar Libro si tiene Ediciones
CREATE OR REPLACE TRIGGER TRG_LIBRO_BAJA_SIN_EDICIONES
BEFORE DELETE ON Libro
FOR EACH ROW
DECLARE
    v_count NUMBER;
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Edicion WHERE idLibro = :OLD.id;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20021,
            'No se puede eliminar el libro "' || :OLD.titulo ||
            '" porque posee ' || v_count || ' edicion(es) registrada(s).');
    END IF;
    ROLLBACK;
END TRG_LIBRO_BAJA_SIN_EDICIONES;
/
 
-- DISP-08: Generar id de Autor → AUT + 3 dígitos
CREATE OR REPLACE TRIGGER TRG_Autor_Generar_Id
BEFORE INSERT ON Autor
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID FROM Autor;
    :NEW.id := 'AUT' || LPAD(lastID + 1, 3, '0');
END TRG_Autor_Generar_Id;
/

-- DISP-09: Nombre + apellidos de Autor no duplicados
CREATE OR REPLACE TRIGGER TRG_Autor_Nombre_Unico
BEFORE INSERT OR UPDATE OF nombre, apellidos ON Autor
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    IF INSERTING THEN
        SELECT COUNT(*) INTO v_count
        FROM Autor
        WHERE UPPER(nombre) = UPPER(:NEW.nombre)
        AND   UPPER(apellidos) = UPPER(:NEW.apellidos);
    ELSE
        SELECT COUNT(*) INTO v_count
        FROM Autor
        WHERE UPPER(nombre) = UPPER(:NEW.nombre)
        AND   UPPER(apellidos) = UPPER(:NEW.apellidos)
        AND   id != :OLD.id;
    END IF;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20050,
            'Ya existe un autor con el nombre "' || :NEW.nombre ||
            ' ' || :NEW.apellidos || '" en el sistema.');
    END IF;
END TRG_Autor_Nombre_Unico;
/

-- DISP-10: Verificar que Autor exista antes de modificar
CREATE OR REPLACE TRIGGER TRG_Autor_Existe_Para_Modificar
BEFORE UPDATE ON Autor
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Autor WHERE id = :OLD.id;
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20051,
            'El autor con id "' || :OLD.id || '" no existe en el sistema.');
    END IF;
END TRG_Autor_Existe_Para_Modificar;
/

-- DISP-11: No eliminar Autor si tiene libros vinculados
CREATE OR REPLACE TRIGGER TRG_Autor_Baja_Sin_Libros
BEFORE DELETE ON Autor
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Libro_Autor WHERE idAutor = :OLD.id;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20052,
            'No se puede eliminar el autor "' || :OLD.nombre || ' ' || :OLD.apellidos ||
            '" porque tiene ' || v_count || ' libro(s) asociado(s).');
    END IF;
END TRG_Autor_Baja_Sin_Libros;
/

-- DISP-12: Generar id de Edicion → EDI + 3 dígitos
CREATE OR REPLACE TRIGGER TRG_Edicion_Generar_Id
BEFORE INSERT ON Edicion
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID FROM Edicion;
    :NEW.id := 'EDI' || LPAD(lastID + 1, 3, '0');
END TRG_Edicion_Generar_Id;
/

-- DISP-13: Verificar que idLibro de Edicion exista
CREATE OR REPLACE TRIGGER TRG_Edicion_Libro_Existe
BEFORE INSERT OR UPDATE OF idLibro ON Edicion
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Libro WHERE id = :NEW.idLibro;
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20060,
            'El libro con id "' || :NEW.idLibro || '" no existe en el catálogo.');
    END IF;
END TRG_Edicion_Libro_Existe;
/

-- DISP-14: Verificar que idEditorial de Edicion exista
CREATE OR REPLACE TRIGGER TRG_Edicion_Editorial_Existe
BEFORE INSERT OR UPDATE OF idEditorial ON Edicion
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Editorial WHERE id = :NEW.idEditorial;
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20061,
            'La editorial con id "' || :NEW.idEditorial || '" no existe en el sistema.');
    END IF;
END TRG_Edicion_Editorial_Existe;
/

-- DISP-15: No cambiar origen de Edicion si tiene Ejemplares
CREATE OR REPLACE TRIGGER TRG_Edicion_Origen_Sin_Ejemplares
BEFORE UPDATE OF idLibro, idEditorial ON Edicion
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    IF (:NEW.idLibro != :OLD.idLibro OR :NEW.idEditorial != :OLD.idEditorial) THEN
        SELECT COUNT(*) INTO v_count FROM Ejemplar WHERE idEdicion = :OLD.id;
        IF v_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20062,
                'No se puede cambiar el origen de la edición "' || :OLD.id ||
                '" porque posee ' || v_count || ' ejemplar(es) registrado(s).');
        END IF;
    END IF;
END TRG_Edicion_Origen_Sin_Ejemplares;
/

-- DISP-16: No eliminar Edicion si tiene Ejemplares
-- DISP-16: No eliminar Edicion si tiene Ejemplares
CREATE OR REPLACE TRIGGER TRG_EDICION_BAJA_SIN_EJEMPLARES
BEFORE DELETE ON Edicion
FOR EACH ROW
DECLARE
    v_count NUMBER;
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Ejemplar WHERE idEdicion = :OLD.id;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20063,
            'No se puede eliminar la edicion "' || :OLD.id ||
            '" porque posee ' || v_count || ' ejemplar(es) registrado(s).');
    END IF;
    ROLLBACK;
END TRG_EDICION_BAJA_SIN_EJEMPLARES;
/

-- DISP-17: Generar id de Editorial → EDT + 3 dígitos
CREATE OR REPLACE TRIGGER TRG_Editorial_Generar_Id
BEFORE INSERT ON Editorial
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID FROM Editorial;
    :NEW.id := 'EDT' || LPAD(lastID + 1, 3, '0');
END TRG_Editorial_Generar_Id;
/

-- DISP-18: Correo de Editorial no duplicado
CREATE OR REPLACE TRIGGER TRG_Editorial_Correo_Unico
BEFORE INSERT OR UPDATE OF correo ON Editorial
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    IF INSERTING THEN
        SELECT COUNT(*) INTO v_count
        FROM Editorial WHERE UPPER(correo) = UPPER(:NEW.correo);
    ELSE
        SELECT COUNT(*) INTO v_count
        FROM Editorial
        WHERE UPPER(correo) = UPPER(:NEW.correo) AND id != :OLD.id;
    END IF;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20070,
            'Ya existe una editorial con el correo "' || :NEW.correo || '" en el sistema.');
    END IF;
END TRG_Editorial_Correo_Unico;
/

-- DISP-19: Teléfono de Editorial no duplicado
CREATE OR REPLACE TRIGGER TRG_Editorial_Telefono_Unico
BEFORE INSERT OR UPDATE OF telefono ON Editorial
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    IF INSERTING THEN
        SELECT COUNT(*) INTO v_count
        FROM Editorial WHERE telefono = :NEW.telefono;
    ELSE
        SELECT COUNT(*) INTO v_count
        FROM Editorial WHERE telefono = :NEW.telefono AND id != :OLD.id;
    END IF;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20071,
            'Ya existe una editorial con el teléfono "' || :NEW.telefono || '" en el sistema.');
    END IF;
END TRG_Editorial_Telefono_Unico;
/

-- DISP-20: No eliminar Editorial si tiene ediciones
CREATE OR REPLACE TRIGGER TRG_Editorial_Baja_Sin_Ediciones
BEFORE DELETE ON Editorial
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Edicion WHERE idEditorial = :OLD.id;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20072,
            'No se puede eliminar la editorial "' || :OLD.nombre ||
            '" porque tiene ' || v_count || ' edición(es) registrada(s).');
    END IF;
END TRG_Editorial_Baja_Sin_Ediciones;
/

-- DISP-21: Generar id de Ejemplar → EJM + 3 dígitos
CREATE OR REPLACE TRIGGER TRG_Ejemplar_Generar_Id
BEFORE INSERT ON Ejemplar
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID FROM Ejemplar;
    :NEW.id := 'EJM' || LPAD(lastID + 1, 3, '0');
END TRG_Ejemplar_Generar_Id;
/

-- DISP-22: Generar id de Compra → COM + 3 dígitos
CREATE OR REPLACE TRIGGER TRG_Compra_Generar_Id
BEFORE INSERT ON Compra
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID FROM Compra;
    :NEW.id := 'COM' || LPAD(lastID + 1, 3, '0');
END TRG_Compra_Generar_Id;
/

-- DISP-23: Verificar que idProveedor de Compra exista
CREATE OR REPLACE TRIGGER TRG_Compra_Proveedor_Existe
BEFORE INSERT OR UPDATE OF idProveedor ON Compra
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Proveedor WHERE id = :NEW.idProveedor;
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20090,
            'El proveedor con id "' || :NEW.idProveedor || '" no existe en el sistema.');
    END IF;
END TRG_Compra_Proveedor_Existe;
/

-- DISP-24: Estado inicial de Compra = 'PENDIENTE'
CREATE OR REPLACE TRIGGER TRG_Compra_Estado_Inicial
BEFORE INSERT ON Compra
FOR EACH ROW
BEGIN
    :NEW.estado := 'PENDIENTE';
END TRG_Compra_Estado_Inicial;
/

-- DISP-25: Solo modificar Compra en estado PENDIENTE
CREATE OR REPLACE TRIGGER TRG_Compra_Modificar_Pendiente
BEFORE UPDATE OF total, idProveedor ON Compra
FOR EACH ROW
BEGIN
    IF :OLD.estado != 'PENDIENTE' THEN
        RAISE_APPLICATION_ERROR(-20091,
            'No se puede modificar la compra "' || :OLD.id ||
            '" porque su estado es "' || :OLD.estado ||
            '" (solo se permiten modificaciones en estado Pendiente).');
    END IF;
END TRG_Compra_Modificar_Pendiente;
/

-- DISP-26: No eliminar Compra si genero Ejemplares
CREATE OR REPLACE TRIGGER TRG_COMPRA_BAJA_SIN_EJEMPLARES
BEFORE DELETE ON Compra
FOR EACH ROW
DECLARE
    v_count NUMBER;
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Ejemplar EJ
    JOIN Edicion ED ON ED.id = EJ.idEdicion
    JOIN Producto_Compra PC ON PC.idLibro = ED.idLibro
    WHERE PC.idCompra = :OLD.id;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20092,
            'No se puede eliminar la compra "' || :OLD.id ||
            '" porque se han generado ' || v_count ||
            ' ejemplar(es) fisico(s) a partir de sus productos.');
    END IF;
    ROLLBACK;
END TRG_COMPRA_BAJA_SIN_EJEMPLARES;
/

-- DISP-27: Generar id de Proveedor → PRV + 3 dígitos
CREATE OR REPLACE TRIGGER TRG_Proveedor_Generar_Id
BEFORE INSERT ON Proveedor
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID FROM Proveedor;
    :NEW.id := 'PRV' || LPAD(lastID + 1, 3, '0');
END TRG_Proveedor_Generar_Id;
/

-- DISP-28: Correo de Proveedor no duplicado
-- CORRECCION: ORA-04091 → separar INSERT de UPDATE para no leer tabla mutante
CREATE OR REPLACE TRIGGER TRG_Proveedor_Correo_Unico
BEFORE INSERT OR UPDATE OF correo ON Proveedor
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    IF INSERTING THEN
        SELECT COUNT(*) INTO v_count
        FROM Proveedor WHERE UPPER(correo) = UPPER(:NEW.correo);
    ELSE
        SELECT COUNT(*) INTO v_count
        FROM Proveedor
        WHERE UPPER(correo) = UPPER(:NEW.correo) AND id != :OLD.id;
    END IF;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20100,
            'Ya existe un proveedor con el correo "' || :NEW.correo || '" en el sistema.');
    END IF;
END TRG_Proveedor_Correo_Unico;
/

-- DISP-29: No eliminar Proveedor si tiene Compras
CREATE OR REPLACE TRIGGER TRG_PROVEEDOR_BAJA_SIN_COMPRAS
BEFORE DELETE ON Proveedor
FOR EACH ROW
DECLARE
    v_count NUMBER;
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Compra WHERE idProveedor = :OLD.id;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20101,
            'No se puede eliminar el proveedor "' || :OLD.nombre || ' ' || :OLD.apellidos ||
            '" porque tiene ' || v_count || ' compra(s) registrada(s).');
    END IF;
    ROLLBACK;
END TRG_PROVEEDOR_BAJA_SIN_COMPRAS;
/
 
