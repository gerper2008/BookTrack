---------------------------------------------------------------------------------------------
--- DISPARADORES: Automatización y restricciones procedimentales
---------------------------------------------------------------------------------------------

-- DISP-1: Validar que el año de la Edicion no sea anterior a fecha_publicacion del Libro
CREATE OR REPLACE TRIGGER TRG_Edicion_Validar_Anio
BEFORE INSERT OR UPDATE ON Edicion
FOR EACH ROW
DECLARE
    v_fecha_pub Libro.fecha_publicacion%TYPE;
BEGIN
    SELECT fecha_publicacion
    INTO   v_fecha_pub
    FROM   Libro
    WHERE  id = :NEW.id_libro;

    IF :NEW.año < v_fecha_pub THEN
        RAISE_APPLICATION_ERROR(-20001,
            'El año de la edicion (' || TO_CHAR(:NEW.año,'YYYY') ||
            ') no puede ser anterior a la fecha de publicacion del libro (' ||
            TO_CHAR(v_fecha_pub,'YYYY') || ').');
    END IF;
END TRG_Edicion_Validar_Anio;
/

-- DISP-2: Actualizar automáticamente el total de una Compra
--         al insertar, modificar o eliminar un Producto_Compra
CREATE OR REPLACE TRIGGER TRG_ProductoCompra_Actualizar_Total
AFTER INSERT OR UPDATE OR DELETE ON Producto_Compra
FOR EACH ROW
DECLARE
    v_id_compra VARCHAR2(10);
BEGIN
    IF DELETING THEN
        v_id_compra := :OLD.id_compra;
    ELSE
        v_id_compra := :NEW.id_compra;
    END IF;

    UPDATE Compra
    SET total = (
        SELECT NVL(SUM(cantidad * precio_unidad), 0)
        FROM   Producto_Compra
        WHERE  id_compra = v_id_compra
    )
    WHERE  id = v_id_compra;
END TRG_ProductoCompra_Actualizar_Total;
/

-- DISP-3: Impedir la eliminación de un Ejemplar disponible (disponibilidad = TRUE)
CREATE OR REPLACE TRIGGER TRG_Ejemplar_Proteger_Disponible
BEFORE DELETE ON Ejemplar
FOR EACH ROW
BEGIN
    IF :OLD.disponibilidad = 'TRUE' THEN
        RAISE_APPLICATION_ERROR(-20002,
            'No se puede eliminar el ejemplar ' || :OLD.id ||
            ' porque está marcado como disponible (en circulacion activa).');
    END IF;
END;
/

-- DISP-4: Solo un Administrador puede insertar en tablas de gestión.
--         El USER de sesión Oracle debe coincidir con el correo
--         de un Usuario con rol 'Administrador' registrado en Administrador.

CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Compra
BEFORE INSERT ON Compra
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Administrador A
    JOIN   Usuario U ON U.id = A.id_usuario
    WHERE  UPPER(U.correo) = UPPER(USER)
    AND    U.rol = 'Administrador';

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Compras.');
    END IF;
END TRG_Solo_Admin_Compra;
/

CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Libro
BEFORE INSERT ON Libro
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Administrador A
    JOIN   Usuario U ON U.id = A.id_usuario
    WHERE  UPPER(U.correo) = UPPER(USER)
    AND    U.rol = 'Administrador';

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Libros.');
    END IF;
END TRG_Solo_Admin_Libro;
/

CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Edicion
BEFORE INSERT ON Edicion
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Administrador A
    JOIN   Usuario U ON U.id = A.id_usuario
    WHERE  UPPER(U.correo) = UPPER(USER)
    AND    U.rol = 'Administrador';

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Ediciones.');
    END IF;
END TRG_Solo_Admin_Edicion;
/

CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Editorial
BEFORE INSERT ON Editorial
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Administrador A
    JOIN   Usuario U ON U.id = A.id_usuario
    WHERE  UPPER(U.correo) = UPPER(USER)
    AND    U.rol = 'Administrador';

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Editoriales.');
    END IF;
END TRG_Solo_Admin_Editorial;
/

CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Autor
BEFORE INSERT ON Autor
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Administrador A
    JOIN   Usuario U ON U.id = A.id_usuario
    WHERE  UPPER(U.correo) = UPPER(USER)
    AND    U.rol = 'Administrador';

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Autores.');
    END IF;
END TRG_Solo_Admin_Autor;
/

CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Categoria
BEFORE INSERT ON Categoria
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Administrador A
    JOIN   Usuario U ON U.id = A.id_usuario
    WHERE  UPPER(U.correo) = UPPER(USER)
    AND    U.rol = 'Administrador';

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Categorias.');
    END IF;
END TRG_Solo_Admin_Categoria;
/

CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Ejemplar
BEFORE INSERT ON Ejemplar
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Administrador A
    JOIN   Usuario U ON U.id = A.id_usuario
    WHERE  UPPER(U.correo) = UPPER(USER)
    AND    U.rol = 'Administrador';

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Ejemplares.');
    END IF;
END TRG_Solo_Admin_Ejemplar;
/

CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Proveedor
BEFORE INSERT ON Proveedor
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   Administrador A
    JOIN   Usuario U ON U.id = A.id_usuario
    WHERE  UPPER(U.correo) = UPPER(USER)
      AND  U.rol = 'Administrador';

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Proveedores.');
    END IF;
END TRG_Solo_Admin_Proveedor;
/

-- DISP-5: Al modificar el correo de un Proveedor, verificar que no exista en Editorial
CREATE OR REPLACE TRIGGER TRG_Proveedor_Correo_CrossCheck
BEFORE UPDATE OF correo ON Proveedor
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM   Editorial
    WHERE  correo = :NEW.correo;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20003,
            'El correo ' || :NEW.correo ||
            ' ya está registrado como correo de una Editorial.');
    END IF;
END TRG_Proveedor_Correo_CrossCheck;
/

---------------------------------------------------------------------------------------------
--- XDISPARADORES: Eliminación de disparadores
---------------------------------------------------------------------------------------------
DROP TRIGGER TRG_Edicion_Validar_Anio;
DROP TRIGGER TRG_ProductoCompra_Actualizar_Total;
DROP TRIGGER TRG_Ejemplar_Proteger_Disponible;
DROP TRIGGER TRG_Solo_Admin_Compra;
DROP TRIGGER TRG_Solo_Admin_Libro;
DROP TRIGGER TRG_Solo_Admin_Edicion;
DROP TRIGGER TRG_Solo_Admin_Editorial;
DROP TRIGGER TRG_Solo_Admin_Autor;
DROP TRIGGER TRG_Solo_Admin_Categoria;
DROP TRIGGER TRG_Solo_Admin_Ejemplar;
DROP TRIGGER TRG_Solo_Admin_Proveedor;
DROP TRIGGER TRG_Proveedor_Correo_CrossCheck;
