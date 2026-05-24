---------------------------------------------------------------------------------------------
--- DISPARADORES: Automatización y restricciones procedimentales
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-- DISP-01: Generar id de Categoria → CAT + 3 dígitos
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Categoria_Generar_Id
BEFORE INSERT ON Categoria
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    IF :NEW.id IS NULL THEN
        SELECT NVL(MAX(CASE
            WHEN REGEXP_LIKE(SUBSTR(id, 4), '^\d+$')
            THEN TO_NUMBER(SUBSTR(id, 4))
            ELSE 0
            END), 0)
        INTO lastID
        FROM Categoria;
        :NEW.id := 'CAT' || LPAD(lastID + 1, 3, '0');
    END IF;
END TRG_Categoria_Generar_Id;
/

---------------------------------------------------------------------------------------------
-- DISP-02: Generar id de Libro → LIB + 3 dígitos
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Libro_Generar_Id
BEFORE INSERT ON Libro
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    IF :NEW.id IS NULL THEN
        SELECT NVL(MAX(CASE
            WHEN REGEXP_LIKE(SUBSTR(id, 4), '^\d+$')
            THEN TO_NUMBER(SUBSTR(id, 4))
            ELSE 0
            END), 0)
        INTO lastID
        FROM Libro;
        :NEW.id := 'LIB' || LPAD(lastID + 1, 3, '0');
    END IF;
END TRG_Libro_Generar_Id;
/

---------------------------------------------------------------------------------------------
-- DISP-04: Generar id de Autor → AUT + 3 dígitos
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Autor_Generar_Id
BEFORE INSERT ON Autor
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    IF :NEW.id IS NULL THEN
        SELECT NVL(MAX(CASE
            WHEN REGEXP_LIKE(SUBSTR(id, 4), '^\d+$')
            THEN TO_NUMBER(SUBSTR(id, 4))
            ELSE 0
            END), 0)
        INTO lastID
        FROM Autor;
        :NEW.id := 'AUT' || LPAD(lastID + 1, 3, '0');
    END IF;
END TRG_Autor_Generar_Id;
/

---------------------------------------------------------------------------------------------
-- DISP-05: Generar id de Edicion → EDI + 3 dígitos
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Edicion_Generar_Id
BEFORE INSERT ON Edicion
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    IF :NEW.id IS NULL THEN
        SELECT NVL(MAX(CASE
            WHEN REGEXP_LIKE(SUBSTR(id, 4), '^\d+$')
            THEN TO_NUMBER(SUBSTR(id, 4))
            ELSE 0
            END), 0)
        INTO lastID
        FROM Edicion;
        :NEW.id := 'EDI' || LPAD(lastID + 1, 3, '0');
    END IF;
END TRG_Edicion_Generar_Id;
/

---------------------------------------------------------------------------------------------
-- DISP-08: Generar id de Editorial → EDT + 3 dígitos
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Editorial_Generar_Id
BEFORE INSERT ON Editorial
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    IF :NEW.id IS NULL THEN
        SELECT NVL(MAX(CASE
            WHEN REGEXP_LIKE(SUBSTR(id, 4), '^\d+$')
            THEN TO_NUMBER(SUBSTR(id, 4))
            ELSE 0
            END), 0)
        INTO lastID
        FROM Editorial;
        :NEW.id := 'EDT' || LPAD(lastID + 1, 3, '0');
    END IF;
END TRG_Editorial_Generar_Id;
/

---------------------------------------------------------------------------------------------
-- DISP-10: Generar id de Ejemplar → EJM + 3 dígitos
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Ejemplar_Generar_Id
BEFORE INSERT ON Ejemplar
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    IF :NEW.id IS NULL THEN
        SELECT NVL(MAX(CASE
            WHEN REGEXP_LIKE(SUBSTR(id, 4), '^\d+$')
            THEN TO_NUMBER(SUBSTR(id, 4))
            ELSE 0
            END), 0)
        INTO lastID
        FROM Ejemplar;
        :NEW.id := 'EJM' || LPAD(lastID + 1, 3, '0');
    END IF;
END TRG_Ejemplar_Generar_Id;
/

---------------------------------------------------------------------------------------------
-- DISP-12: Generar id de Compra → COM + 3 dígitos
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Compra_Generar_Id
BEFORE INSERT ON Compra
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    IF :NEW.id IS NULL THEN
        SELECT NVL(MAX(CASE
            WHEN REGEXP_LIKE(SUBSTR(id, 4), '^\d+$')
            THEN TO_NUMBER(SUBSTR(id, 4))
            ELSE 0
            END), 0)
        INTO lastID
        FROM Compra;
        :NEW.id := 'COM' || LPAD(lastID + 1, 3, '0');
    END IF;
END TRG_Compra_Generar_Id;
/

---------------------------------------------------------------------------------------------
-- DISP-13: Estado inicial de Compra = 'PENDIENTE'
-- Solo aplica cuando NO viene un ID explícito (inserción de usuario final).
-- Los casos NO OK insertan con ID explícito tipo COMZV8x para poder
-- manipular el estado manualmente en pasos posteriores del test.
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Compra_Estado_Inicial
BEFORE INSERT ON Compra
FOR EACH ROW
BEGIN
    -- Forzar PENDIENTE solo en inserciones sin ID explícito (flujo normal)
    IF :NEW.id IS NULL THEN
        :NEW.estado := 'PENDIENTE';
    END IF;
END TRG_Compra_Estado_Inicial;
/

---------------------------------------------------------------------------------------------
-- DISP-16: Generar id de Proveedor → PRV + 3 dígitos
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Proveedor_Generar_Id
BEFORE INSERT ON Proveedor
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    IF :NEW.id IS NULL THEN
        SELECT NVL(MAX(CASE
            WHEN REGEXP_LIKE(SUBSTR(id, 4), '^\d+$')
            THEN TO_NUMBER(SUBSTR(id, 4))
            ELSE 0
            END), 0)
        INTO lastID
        FROM Proveedor;
        :NEW.id := 'PRV' || LPAD(lastID + 1, 3, '0');
    END IF;
END TRG_Proveedor_Generar_Id;
/
---------------------------------------------------------------------------------------------
-- DISP-17: No eliminar Proveedor si tiene Compras
---------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_Proveedor_Baja_Sin_Compras
BEFORE DELETE ON Proveedor
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM Compra
    WHERE idProveedor = :OLD.id;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20101,
            'No se puede eliminar el proveedor "' || :OLD.nombre || ' ' || :OLD.apellidos ||
            '" porque tiene ' || v_count || ' compra(s) registrada(s).'
        );
    END IF;
END TRG_Proveedor_Baja_Sin_Compras;
/

