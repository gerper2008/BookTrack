---------------------------------------------------------------------------------------------
--- TUPLAS: Restricciones que involucran más de un atributo ---------------------------------
---------------------------------------------------------------------------------------------
 
-- TUP1: En Compra, si estado='COMPLETADO' el total debe ser > 0
ALTER TABLE Compra ADD CONSTRAINT CH_Compra_estado_total
    CHECK (
        (estado = 'COMPLETADO' AND total > 0)
        OR (estado IN ('PENDIENTE', 'RECHAZADO') AND total >= 0)
    );
 
-- TUP2: En Producto_Compra, cantidad y precio_unidad juntos deben generar un importe válido
ALTER TABLE Producto_Compra ADD CONSTRAINT CH_ProductoCompra_importe
    CHECK (cantidad > 0 AND precio_unidad > 0);
 
-- TUP3: En Ejemplar, si disponibilidad = FALSE, el estado_fisico NO puede ser 'Nuevo'
ALTER TABLE Ejemplar ADD CONSTRAINT CH_Ejemplar_nuevo_disponible
    CHECK (
        NOT (disponibilidad = FALSE AND estado_fisico = 'Nuevo')
    );
 
-- TUP4: El año de la Edicion no puede ser anterior a la fecha_publicacion del Libro.
--       Se implementa como disparador TRG_Edicion_Validar_Anio (ver sección Disparadores).
 
-- TUP5: En Autor, nombre, apellidos y nacionalidad deben existir juntos
ALTER TABLE Autor ADD CONSTRAINT CH_Autor_identidad
    CHECK (
        nombre IS NOT NULL AND apellidos IS NOT NULL AND nacionalidad IS NOT NULL
    );
 
-- TUP6: En Libro, titulo e idioma deben existir juntos
ALTER TABLE Libro ADD CONSTRAINT CH_Libro_titulo_idioma
    CHECK (titulo IS NOT NULL AND idioma IS NOT NULL);
 
---------------------------------------------------------------------------------------------
--- ACCIONES: Definición de acciones de referencia -----------------------------------------
---------------------------------------------------------------------------------------------
 
-- Libro.id_categoria → Categoria(id)  |  ON DELETE SET NULL
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'LIBRO'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'CATEGORIA' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Libro DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Libro ADD CONSTRAINT FK_Libro_Categoria
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id) ON DELETE SET NULL;
 
-- Edicion.id_libro → Libro(id)  |  ON DELETE CASCADE
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'EDICION'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'LIBRO' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Edicion DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Edicion ADD CONSTRAINT FK_Edicion_Libro
    FOREIGN KEY (id_libro) REFERENCES Libro(id) ON DELETE CASCADE;
 
-- Edicion.id_editorial → Editorial(id)  |  ON DELETE SET NULL
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'EDICION'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'EDITORIAL' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Edicion DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Edicion ADD CONSTRAINT FK_Edicion_Editorial
    FOREIGN KEY (id_editorial) REFERENCES Editorial(id) ON DELETE SET NULL;
 
-- Ejemplar.id_edicion → Edicion(id)  |  ON DELETE CASCADE
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'EJEMPLAR'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'EDICION' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Ejemplar DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Ejemplar ADD CONSTRAINT FK_Ejemplar_Edicion
    FOREIGN KEY (id_edicion) REFERENCES Edicion(id) ON DELETE CASCADE;
 
-- Compra.id_proveedor → Proveedor(id)  |  ON DELETE SET NULL
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'COMPRA'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'PROVEEDOR' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Compra DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Compra ADD CONSTRAINT FK_Compra_Proveedor
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id) ON DELETE SET NULL;
 
-- Producto_Compra.id_compra → Compra(id)  |  ON DELETE CASCADE
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'PRODUCTO_COMPRA'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'COMPRA' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Producto_Compra DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Producto_Compra ADD CONSTRAINT FK_ProductoCompra_Compra
    FOREIGN KEY (id_compra) REFERENCES Compra(id) ON DELETE CASCADE;
 
-- Producto_Compra.id_libro → Libro(id)  |  ON DELETE SET NULL
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'PRODUCTO_COMPRA'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'LIBRO' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Producto_Compra DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Producto_Compra ADD CONSTRAINT FK_ProductoCompra_Libro
    FOREIGN KEY (id_libro) REFERENCES Libro(id) ON DELETE SET NULL;
 
-- Administrador.id_usuario → Usuario(id)  |  ON DELETE CASCADE
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'ADMINISTRADOR'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'USUARIO' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Administrador DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Administrador ADD CONSTRAINT FK_Administrador_Usuario
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id) ON DELETE CASCADE;
 
-- Libro_Autor: tabla nueva con sus FKs CASCADE
CREATE TABLE Libro_Autor (
    id_libro VARCHAR2(10),
    id_autor VARCHAR2(10)
);
ALTER TABLE Libro_Autor ADD PRIMARY KEY (id_libro, id_autor);
ALTER TABLE Libro_Autor ADD CONSTRAINT FK_LibroAutor_Libro
    FOREIGN KEY (id_libro) REFERENCES Libro(id) ON DELETE CASCADE;
ALTER TABLE Libro_Autor ADD CONSTRAINT FK_LibroAutor_Autor
    FOREIGN KEY (id_autor) REFERENCES Autor(id) ON DELETE CASCADE;
 
---------------------------------------------------------------------------------------------
--- DISPARADORES: Automatización y restricciones procedimentales ----------------------------
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
    IF :OLD.disponibilidad = TRUE THEN
        RAISE_APPLICATION_ERROR(-20002,
            'No se puede eliminar el ejemplar ' || :OLD.id ||
            ' porque está marcado como disponible (en circulacion activa).');
    END IF;
END TRG_Ejemplar_Proteger_Disponible;
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
    AND  U.rol = 'Administrador';
 
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
    AND  U.rol = 'Administrador';
 
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
    AND  U.rol = 'Administrador';
 
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
    AND  U.rol = 'Administrador';
 
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
    AND  U.rol = 'Administrador';
 
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
    AND  U.rol = 'Administrador';
 
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
    AND  U.rol = 'Administrador';
 
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
--- XDISPARADORES: Eliminación de disparadores ----------------------------------------------
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
 
---------------------------------------------------------------------------------------------
--- PRUEBAS: TuplasOK -> Ingreso correcto respecto a restricciones de tupla -----------------
---------------------------------------------------------------------------------------------
 
-- TUP1-OK: Compra completada con total > 0
INSERT INTO Compra VALUES ('CMP010', TO_DATE('2024-09-01','YYYY-MM-DD'), 200000.00, 'COMPLETADO', 'PRV001');
 
-- TUP1-OK: Compra pendiente con total = 0 (aún sin productos)
INSERT INTO Compra VALUES ('CMP011', TO_DATE('2024-09-05','YYYY-MM-DD'), 0.00, 'PENDIENTE',  'PRV002');
 
-- TUP1-OK: Compra rechazada con total = 0 (no se procesó)
INSERT INTO Compra VALUES ('CMP012', TO_DATE('2024-09-08','YYYY-MM-DD'), 0.00, 'RECHAZADO', 'PRV001');
 
-- TUP2-OK: Producto_Compra con cantidad y precio válidos
INSERT INTO Producto_Compra VALUES ('PC010', 3, 45000.00, 'CMP010', 'LIB001');
 
-- TUP3-OK: Ejemplar Nuevo con disponibilidad = TRUE (nuevo y disponible — correcto)
INSERT INTO Ejemplar VALUES ('EJE010', 'Nuevo',      1, 'Estante D cuatro', TO_DATE('2024-01-01','YYYY-MM-DD'), 'EDI001');
 
-- TUP3-OK: Ejemplar Desgastado con disponibilidad = FALSE (no disponible — correcto)
INSERT INTO Ejemplar VALUES ('EJE011', 'Desgastado', 0, 'Bodega sur',       TO_DATE('2022-03-10','YYYY-MM-DD'), 'EDI002');
 
-- TUP5-OK: Autor con nombre, apellidos y nacionalidad completos
INSERT INTO Autor VALUES ('AUT010', 'Juan', 'Rulfo Vizcaino', 'Masculino', 'Mexicana');
 
-- TUP6-OK: Libro con titulo e idioma presentes
INSERT INTO Libro VALUES ('LIB010', 'Pedro Paramo', TO_DATE('1955-03-19','YYYY-MM-DD'), 'Espanol', 'Novela del realismo magico mexicano', 'CAT001');
 
---------------------------------------------------------------------------------------------
--- PRUEBAS: TuplasNoOK -> Intentos incorrectos respecto a restricciones de tupla -----------
---------------------------------------------------------------------------------------------
 
-- TUP1-NOK: Compra completada con total negativo  ✗
INSERT INTO Compra VALUES ('CERR1', TO_DATE('2024-09-10','YYYY-MM-DD'), -500.00, 'COMPLETADO', 'PRV001');
 
-- TUP1-NOK: Compra pendiente con total negativo  ✗
INSERT INTO Compra VALUES ('CERR2', TO_DATE('2024-09-10','YYYY-MM-DD'), -1.00, 'PENDIENTE', 'PRV001');
 
-- TUP2-NOK: Producto_Compra con cantidad = 0  ✗
INSERT INTO Producto_Compra VALUES ('PCER1', 0, 30000.00, 'CMP001', 'LIB001');
 
-- TUP2-NOK: Producto_Compra con precio_unidad negativo  ✗
INSERT INTO Producto_Compra VALUES ('PCER2', 2, -1000.00, 'CMP001', 'LIB001');
 
-- TUP3-NOK: Ejemplar Nuevo con disponibilidad = FALSE  ✗
INSERT INTO Ejemplar VALUES ('EERR1', 'Nuevo', 0, 'Estante X', TO_DATE('2024-01-01','YYYY-MM-DD'), 'EDI001');
 
-- TUP5-NOK: Autor con nacionalidad NULL  ✗
INSERT INTO Autor VALUES ('AERR1', 'Sin', 'Pais', 'Masculino', NULL);
 
-- TUP6-NOK: Libro sin idioma  ✗
INSERT INTO Libro VALUES ('LERR1', 'Sin Idioma', TO_DATE('2020-01-01','YYYY-MM-DD'), NULL, 'Sin idioma registrado', 'CAT001');
 
---------------------------------------------------------------------------------------------
--- PRUEBAS: AccionesOK -> Verificación de las acciones de referencia -----------------------
---------------------------------------------------------------------------------------------
 
-- SET NULL: Al eliminar una Categoria, los Libros quedan con id_categoria = NULL
DELETE FROM Categoria WHERE id = 'CAT002';
-- Verificar: SELECT id, titulo, id_categoria FROM Libro WHERE id_categoria IS NULL;
 
-- CASCADE Edicion→Ejemplar: Al eliminar una Edicion, sus Ejemplares desaparecen
DELETE FROM Edicion WHERE id = 'EDI003';
-- Verificar: SELECT * FROM Ejemplar WHERE id_edicion = 'EDI003'; → Sin resultado
 
-- CASCADE Libro→Edicion: Al eliminar un Libro, sus Ediciones (y en cascada Ejemplares) desaparecen
DELETE FROM Libro WHERE id = 'LIB002';
-- Verificar: SELECT * FROM Edicion WHERE id_libro = 'LIB002';    → Sin resultado
-- Verificar: SELECT * FROM Ejemplar WHERE id_edicion = 'EDI002'; → Sin resultado
 
-- SET NULL: Al eliminar un Proveedor, las Compras quedan con id_proveedor = NULL
DELETE FROM Proveedor WHERE id = 'PRV003';
-- Verificar: SELECT id, id_proveedor FROM Compra WHERE id = 'CMP003'; → id_proveedor = NULL
 
-- CASCADE Compra→Producto_Compra: Al eliminar una Compra, sus productos desaparecen
DELETE FROM Compra WHERE id = 'CMP001';
-- Verificar: SELECT * FROM Producto_Compra WHERE id_compra = 'CMP001'; → Sin resultado
 
-- CASCADE Usuario→Administrador: Al eliminar el Usuario, se elimina el Administrador
DELETE FROM Usuario WHERE id = 'USR001';
-- Verificar: SELECT * FROM Administrador WHERE id_usuario = 'USR001'; → Sin resultado
 
---------------------------------------------------------------------------------------------
--- PRUEBAS: DisparadoresOK -> Datos ingresados usando la automatización de disparadores ----
---------------------------------------------------------------------------------------------
 
-- DISP-1-OK: Edicion con año POSTERIOR a la fecha de publicacion del libro  ✓
INSERT INTO Edicion VALUES ('EDI010', TO_DATE('2010-01-01','YYYY-MM-DD'), 300, 'LIB001', 'ED001');
-- LIB001 publicado en 1967, edicion 2010 → válido
 
-- DISP-1-OK: Edicion con año IGUAL al año de publicacion  ✓
INSERT INTO Edicion VALUES ('EDI011', TO_DATE('1967-06-05','YYYY-MM-DD'), 350, 'LIB001', 'ED002');
 
-- DISP-2-OK: Insertar Producto_Compra → el total de la Compra se recalcula automáticamente
SELECT total FROM Compra WHERE id = 'CMP002';  -- Total antes del nuevo producto
INSERT INTO Producto_Compra VALUES ('PC020', 2, 40000.00, 'CMP002', 'LIB002');
SELECT total FROM Compra WHERE id = 'CMP002';  -- Total después (debe haber aumentado en 80000)
 
-- DISP-2-OK: Eliminar un Producto_Compra → total se reduce automáticamente
DELETE FROM Producto_Compra WHERE id = 'PC020';
SELECT total FROM Compra WHERE id = 'CMP002';  -- Vuelve al valor original
 
-- DISP-3-OK: Eliminar un Ejemplar NO disponible no genera error  ✓
UPDATE Ejemplar SET disponibilidad = FALSE WHERE id = 'EJE003';
DELETE FROM Ejemplar WHERE id = 'EJE003';      -- disponibilidad=FALSE → permitido
 
-- DISP-4-OK: Insertar como sesión del Administrador registrado → permitido  ✓
-- (Sesión Oracle es 'admin@biblioteca.com', USR001 con rol 'Administrador')
-- CONNECT admin@biblioteca.com/...;
INSERT INTO Compra    VALUES ('CMP030', TO_DATE('2024-10-01','YYYY-MM-DD'), 120000.00, 'PENDIENTE',  'PRV001');
INSERT INTO Libro     VALUES ('LIB030', 'El Otono del Patriarca', TO_DATE('1975-01-01','YYYY-MM-DD'), 'Espanol', 'Novela de dictadura de Garcia Marquez', 'CAT001');
INSERT INTO Autor     VALUES ('AUT030', 'Ernesto', 'Sabato Rojas', 'Masculino', 'Argentina');
INSERT INTO Categoria VALUES ('CAT030', 'Ciencia Ficcion', 'Libros de ciencia ficcion contemporanea');
INSERT INTO Ejemplar  VALUES ('EJE030', 'Nuevo', 1, 'Estante F seis', TO_DATE('2024-01-01','YYYY-MM-DD'), 'EDI001');
INSERT INTO Proveedor VALUES ('PRV030', 'nuevo@proveedor.com', 'Jorge', 'Mendez Rios', 'Libros Colombia', '3159990011');
-- Todos deben insertarse sin error
 
-- DISP-5-OK: Actualizar correo de Proveedor a uno que NO existe en Editorial  ✓
UPDATE Proveedor SET correo = 'nuevo_proveedor@logistica.com' WHERE id = 'PRV001';
-- Ese correo no está en Editorial → permitido
 
---------------------------------------------------------------------------------------------
--- PRUEBAS: DisparadoresNoOK -> Intentos bloqueados por disparadores -----------------------
---------------------------------------------------------------------------------------------
 
-- DISP-1-NOK: Edicion con año ANTERIOR a la fecha de publicacion del libro  ✗
INSERT INTO Edicion VALUES ('EDI099', TO_DATE('1950-01-01','YYYY-MM-DD'), 200, 'LIB001', 'ED001');
-- LIB001 publicado en 1967, edicion en 1950 → ORA-20001
 
-- DISP-1-NOK: Edicion con año muy anterior  ✗
INSERT INTO Edicion VALUES ('EDI098', TO_DATE('1900-01-01','YYYY-MM-DD'), 150, 'LIB002', 'ED002');
-- LIB002 publicado en 1944, edicion en 1900 → ORA-20001
 
-- DISP-3-NOK: Intentar eliminar un Ejemplar disponible (disponibilidad = TRUE)  ✗
UPDATE Ejemplar SET disponibilidad = TRUE WHERE id = 'EJE001';
DELETE FROM Ejemplar WHERE id = 'EJE001';
-- → ORA-20002: No se puede eliminar el ejemplar EJE001 porque está en circulacion activa.
 
-- DISP-4-NOK: Insertar como sesión de un Bibliotecario → denegado  ✗
-- (Sesión Oracle es 'biblio@biblioteca.com', USR002 con rol 'Bibliotecario')
-- CONNECT biblio@biblioteca.com/...;
INSERT INTO Compra    VALUES ('CERR9', TO_DATE('2024-10-05','YYYY-MM-DD'), 50000.00, 'PENDIENTE', 'PRV001');
-- → ORA-20010: Acceso denegado: solo un Administrador puede registrar Compras.
 
INSERT INTO Libro     VALUES ('LERR9', 'Libro No Autorizado', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol', 'Sin permiso', 'CAT001');
-- → ORA-20010: Acceso denegado: solo un Administrador puede registrar Libros.
 
INSERT INTO Autor     VALUES ('AERR9', 'No', 'Autorizado', 'Masculino', 'Colombiana');
-- → ORA-20010: Acceso denegado: solo un Administrador puede registrar Autores.
 
INSERT INTO Proveedor VALUES ('PERR9', 'no@autorizado.com', 'Sin', 'Permiso Gil', 'Empresa X', '3000000099');
-- → ORA-20010: Acceso denegado: solo un Administrador puede registrar Proveedores.
 
-- DISP-4-NOK: Insertar como sesión de un Lector → denegado  ✗
-- CONNECT lector@gmail.com/...;
INSERT INTO Categoria VALUES ('KERR9', 'Sin Permiso', 'Categoria no autorizada');
-- → ORA-20010: Acceso denegado: solo un Administrador puede registrar Categorias.
 
-- DISP-5-NOK: Actualizar correo de Proveedor a uno que ya existe en Editorial  ✗
UPDATE Proveedor SET correo = 'contacto@planeta.com' WHERE id = 'PRV002';
-- 'contacto@planeta.com' ya es correo de ED001 → ORA-20003
 
---------------------------------------------------------------------------------------------
--- PRUEBAS: XPoblar -> Eliminación de datos ------------------------------------------------
---------------------------------------------------------------------------------------------
DELETE FROM Producto_Compra WHERE id IN ('PC001','PC002','PC003');
DELETE FROM Compra WHERE id IN ('CMP001','CMP002','CMP003');
DELETE FROM Ejemplar WHERE id IN ('EJE001','EJE002','EJE003');
DELETE FROM Edicion WHERE id IN ('EDI001','EDI002','EDI003');
DELETE FROM Libro_Autor WHERE id_libro IN ('LIB001','LIB002','LIB003');
DELETE FROM Administrador WHERE id_usuario = 'USR001';
DELETE FROM Libro WHERE id IN ('LIB001','LIB002','LIB003');
DELETE FROM Autor WHERE id IN ('AUT001','AUT002','AUT003');
DELETE FROM Categoria WHERE id IN ('CAT001','CAT002','CAT003');
DELETE FROM Editorial WHERE id IN ('ED001','ED002','ED003');
DELETE FROM Proveedor WHERE id IN ('PRV001','PRV002','PRV003');
DELETE FROM Usuario WHERE id IN ('USR001','USR002','USR003');
 
---------------------------------------------------------------------------------------------
--- ELIMINAR TODO ---------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
BEGIN
    FOR cur_rec IN (SELECT object_name, object_type
        FROM   all_objects
        WHERE  object_type IN ('TABLE', 'VIEW', 'PACKAGE', 'PROCEDURE', 'FUNCTION', 'SEQUENCE')
        AND  owner = '<schema_name>')
    LOOP
        BEGIN
        IF cur_rec.object_type = 'TABLE' THEN
            EXECUTE IMMEDIATE 'DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '" CASCADE CONSTRAINTS';
        ELSE
            EXECUTE IMMEDIATE 'DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '"';
        END IF;
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line('FAILED: DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '"');
        END;
    END LOOP;
END;
/
 
DROP TABLE Libro_Autor CASCADE CONSTRAINTS;
DROP TABLE Producto_Compra CASCADE CONSTRAINTS;
DROP TABLE Compra CASCADE CONSTRAINTS;
DROP TABLE Ejemplar CASCADE CONSTRAINTS;
DROP TABLE Edicion CASCADE CONSTRAINTS;
DROP TABLE Administrador CASCADE CONSTRAINTS;
DROP TABLE Libro CASCADE CONSTRAINTS;
DROP TABLE Autor CASCADE CONSTRAINTS;
DROP TABLE Categoria CASCADE CONSTRAINTS;
DROP TABLE Editorial CASCADE CONSTRAINTS;
DROP TABLE Proveedor CASCADE CONSTRAINTS;
DROP TABLE Usuario CASCADE CONSTRAINTS;