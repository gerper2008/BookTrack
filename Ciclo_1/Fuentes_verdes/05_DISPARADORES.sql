---------------------------------------------------------------------------------------------
--- DISPARADORES: Automatización y restricciones procedimentales
---------------------------------------------------------------------------------------------

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

-- DISP-02: Generar id de Libro → LIB + 3 dígitos
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

-- DISP-03: No modificar titulo si tiene ediciones activas
-- Este se implementa ya que na vez un libro tiene ediciones registradas, su título
-- pasa a formar parte de su identidad histórica, si se modifica pierde consistencia
-- y trazabilidad en las ediciones asociadas
CREATE OR REPLACE TRIGGER TRG_Libro_Titulo_Sin_Ediciones
BEFORE UPDATE OF titulo ON Libro
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM Edicion
    WHERE idLibro = :OLD.id;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20020,
            'No se puede modificar el título del libro "' || :OLD.titulo ||
            '" porque tiene ' || v_count || ' edición(es) registrada(s).');
    END IF;
END TRG_Libro_Titulo_Sin_Ediciones;
/

-- DISP-04: Generar id de Autor → AUT + 3 dígitos
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

-- DISP-05: Generar id de Edicion → EDI + 3 dígitos
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

-- DISP-06: Impide cambiar el libro o la editorial de una edición
-- cuando ya existen ejemplares asociados, preservando su trazabilidad.
CREATE OR REPLACE TRIGGER TRG_Edicion_Origen_Sin_Ejemplares
BEFORE UPDATE OF idLibro, idEditorial ON Edicion
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM Ejemplar
    WHERE idEdicion = :OLD.id;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20030,
            'No se puede modificar el libro o la editorial de la edición "' 
            || :OLD.id ||
            '" porque posee ' || v_count || ' ejemplar(es) registrado(s).'
        );
    END IF;
END TRG_Edicion_Origen_Sin_Ejemplares;
/

-- DISP-07: No eliminar Edicion si tiene Ejemplares
CREATE OR REPLACE TRIGGER TRG_Edicion_Baja_Sin_Ejemplares
BEFORE DELETE ON Edicion
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM Ejemplar
    WHERE idEdicion = :OLD.id;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20063,
            'No se puede eliminar la edición "' || :OLD.id ||
            '" porque posee ' || v_count ||
            ' ejemplar(es) registrado(s).'
        );
    END IF;
END TRG_Edicion_Baja_Sin_Ejemplares;
/

-- DISP-08: Generar id de Editorial → EDT + 3 dígitos
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

-- DISP-09: No eliminar Editorial si tiene ediciones
-- CREATE OR REPLACE TRIGGER TRG_Editorial_Baja_Sin_Ediciones
-- BEFORE DELETE ON Editorial
-- FOR EACH ROW
-- DECLARE
--     v_count NUMBER;
-- BEGIN
--     SELECT COUNT(*)
--     INTO v_count
--     FROM Edicion
--     WHERE idEditorial = :OLD.id;

--     IF v_count > 0 THEN
--         RAISE_APPLICATION_ERROR(
--             -20072,
--             'No se puede eliminar la editorial "' || :OLD.nombre ||
--             '" porque tiene ' || v_count || ' edición(es) registrada(s).'
--         );
--     END IF;
-- END TRG_Editorial_Baja_Sin_Ediciones;
-- /

-- DISP-10: Generar id de Ejemplar → EJM + 3 dígitos
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

-- DISP-11: Impide eliminar un ejemplar si se encuentra disponible
CREATE OR REPLACE TRIGGER TRG_Ejemplar_Disponible
BEFORE DELETE ON Ejemplar
FOR EACH ROW
BEGIN
    IF :OLD.disponibilidad = 1 THEN
        RAISE_APPLICATION_ERROR(
            -20040,
            'No se puede eliminar el ejemplar "' || :OLD.id ||
            '" porque actualmente se encuentra disponible.'
        );
    END IF;
END TRG_Ejemplar_Disponible;
/

-- DISP-12: Generar id de Compra → COM + 3 dígitos
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

-- DISP-13: Estado inicial de Compra = 'PENDIENTE' (siempre, sin importar el valor ingresado)
CREATE OR REPLACE TRIGGER TRG_Compra_Estado_Inicial
BEFORE INSERT ON Compra
FOR EACH ROW
BEGIN
    :NEW.estado := 'PENDIENTE';
END TRG_Compra_Estado_Inicial;
/

-- DISP-14: Impide modificar una Compra si no está en estado PENDIENTE
-- La restricción correcta es: solo se puede modificar una compra en estado PENDIENTE.
CREATE OR REPLACE TRIGGER TRG_Compra_Modificacion_Sin_Ejemplares
BEFORE UPDATE ON Compra
FOR EACH ROW
BEGIN
    IF :OLD.estado != 'PENDIENTE' THEN
        RAISE_APPLICATION_ERROR(
            -20060,
            'No se puede modificar la compra "' || :OLD.id ||
            '" porque su estado actual es "' || :OLD.estado || '" (solo se permite en PENDIENTE).'
        );
    END IF;
END TRG_Compra_Modificacion_Sin_Ejemplares;
/

-- DISP-15: Impide eliminar una Compra si no está en estado PENDIENTE
-- La restricción correcta es: solo se puede eliminar una compra en estado PENDIENTE.
CREATE OR REPLACE TRIGGER TRG_Compra_Baja_Sin_Ejemplares
BEFORE DELETE ON Compra
FOR EACH ROW
BEGIN
    IF :OLD.estado != 'PENDIENTE' THEN
        RAISE_APPLICATION_ERROR(
            -20061,
            'No se puede eliminar la compra "' || :OLD.id ||
            '" porque su estado actual es "' || :OLD.estado || '" (solo se permite en PENDIENTE).'
        );
    END IF;
END TRG_Compra_Baja_Sin_Ejemplares;
/

-- DISP-16: Generar id de Proveedor → PRV + 3 dígitos
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

-- DISP-17: No eliminar Proveedor si tiene Compras
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

DROP TRIGGER TRG_Categoria_Generar_Id;
DROP TRIGGER TRG_Libro_Generar_Id;
DROP TRIGGER TRG_Libro_Titulo_Sin_Ediciones;
DROP TRIGGER TRG_Autor_Generar_Id;
DROP TRIGGER TRG_Edicion_Generar_Id;
DROP TRIGGER TRG_Edicion_Origen_Sin_Ejemplares;
DROP TRIGGER TRG_Edicion_Baja_Sin_Ejemplares;
DROP TRIGGER TRG_Editorial_Generar_Id;
DROP TRIGGER TRG_Editorial_Baja_Sin_Ediciones;
DROP TRIGGER TRG_Ejemplar_Generar_Id;
DROP TRIGGER TRG_Ejemplar_Disponible;
DROP TRIGGER TRG_Compra_Generar_Id;
DROP TRIGGER TRG_Compra_Estado_Inicial;
DROP TRIGGER TRG_Compra_Modificacion_Sin_Ejemplares;
DROP TRIGGER TRG_Compra_Baja_Sin_Ejemplares;
DROP TRIGGER TRG_Proveedor_Generar_Id;
DROP TRIGGER TRG_Proveedor_Baja_Sin_Compras;