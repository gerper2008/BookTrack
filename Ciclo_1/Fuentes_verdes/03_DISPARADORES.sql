---------------------------------------------------------------------------------------------
--- DISPARADORES: Automatización y restricciones procedimentales
---------------------------------------------------------------------------------------------

-- ==========================================================================================
-- CU-1 (Mantener Categoría): COMO Administrador, QUIERO gestionar los géneros y
-- clasificaciones, PARA PODER organizar el catálogo por áreas temáticas.
-- ==========================================================================================

-- DISP-01: Generar automáticamente el id de Categoria con formato CAT + secuencial de 3 dígitos
-- CU-1 > A: "El id se genera automáticamente con el formato CAT + secuencial de
--   3 dígitos (CAT001, CAT002, ...)"
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

-- DISP-02: Solo un Administrador puede registrar Categorias
-- CU-1 > A: "Solo un Administrador puede registrar categorías"
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Categoria
BEFORE INSERT ON Categoria
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Administrador A
    JOIN Usuario U ON U.id = A.idUsuario
    WHERE U.rol = 'Administrador';

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Categorias.');
    END IF;
END TRG_Solo_Admin_Categoria;
/

-- DISP-03: Al eliminar Categoria, verificar que no tenga libros vinculados
-- CU-1 > E: "Se requiere que la categoría no tenga libros (0..*) vinculados
--   para mantener la integridad."
CREATE OR REPLACE TRIGGER TRG_Categoria_Baja_Sin_Libros
BEFORE DELETE ON Categoria
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Libro
    WHERE idCategoria = :OLD.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20040,
            'No se puede eliminar la categoría "' || :OLD.nombre ||
            '" porque tiene ' || count || ' libro(s) asociado(s).');
    END IF;
END TRG_Categoria_Baja_Sin_Libros;
/

-- DISP-04: Verificar que el nombre de la Categoria no esté duplicado
-- CU-1 > A: "Se requiere que el nombre no esté duplicado en el sistema."
CREATE OR REPLACE TRIGGER TRG_Categoria_Nombre_Unico
BEFORE INSERT OR UPDATE OF nombre ON Categoria
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Categoria
    WHERE UPPER(nombre) = UPPER(:NEW.nombre)
    AND   id != :NEW.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20042,
            'Ya existe una categoría con el nombre "' || :NEW.nombre || '" en el sistema.');
    END IF;
END TRG_Categoria_Nombre_Unico;
/

-- ==========================================================================================
-- CU-2 (Mantener Libro): COMO Administrador, QUIERO gestionar la información de los libros,
-- PARA PODER mantener el catálogo actualizado.
-- ==========================================================================================

-- DISP-05: Generar automáticamente el id de Libro con formato LIB + secuencial de 3 dígitos
-- CU-2 > A: "El id se genera automáticamente con el formato LIB + secuencial de
--   3 dígitos (LIB001, LIB002, ...)"
-- Corrección: SUBSTR arranca en posición 4 (longitud de prefijo 'LIB' = 3 chars).
--   La versión anterior usaba posición 6 y generaba 'LIB-001' con guion,
--   inconsistente con el formato definido en el caso de uso.
CREATE OR REPLACE TRIGGER TRG_Libro_Generar_Id
BEFORE INSERT ON Libro
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID
    FROM Libro;

    :NEW.id := 'LIB' || LPAD(lastID + 1, 3, '0');
END TRG_Libro_Generar_Id;
/

-- DISP-06: Verificar que el idCategoria del Libro exista en Categoria
-- CU-2 > A: "El idCategoria suministrado debe corresponder a una categoría
--   registrada en el sistema."
CREATE OR REPLACE TRIGGER TRG_Libro_Categoria_Existe
BEFORE INSERT OR UPDATE OF idCategoria ON Libro
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Categoria
    WHERE id = :NEW.idCategoria;

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20041,
            'La categoría "' || :NEW.idCategoria ||
            '" no existe en el catálogo.');
    END IF;
END TRG_Libro_Categoria_Existe;
/

-- DISP-07: Solo un Administrador puede registrar Libros
-- CU-2 > A: "Solo un Administrador puede registrar libros"
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Libro
BEFORE INSERT ON Libro
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Administrador A
    JOIN Usuario U ON U.id = A.idUsuario
    WHERE U.rol = 'Administrador';

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Libros.');
    END IF;
END TRG_Solo_Admin_Libro;
/

-- DISP-08: Al modificar el título del Libro, verificar que no tenga ediciones activas
-- CU-2 > M: "Se requiere que el libro no tenga ediciones activas si se intenta
--   cambiar el título."
CREATE OR REPLACE TRIGGER TRG_Libro_Titulo_Sin_Ediciones
BEFORE UPDATE OF titulo ON Libro
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Edicion
    WHERE idLibro = :OLD.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20020,
            'No se puede modificar el título del libro "' || :OLD.titulo ||
            '" porque tiene ' || count || ' edición(es) activa(s) registrada(s).');
    END IF;
END TRG_Libro_Titulo_Sin_Ediciones;
/

-- DISP-09: Al eliminar Libro, verificar que no tenga ediciones vinculadas
-- CU-2 > E: "Se requiere que el libro no posea ediciones vinculadas en el sistema."
CREATE OR REPLACE TRIGGER TRG_Libro_Baja_Sin_Ediciones
BEFORE DELETE ON Libro
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Edicion
    WHERE idLibro = :OLD.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20021,
            'No se puede eliminar el libro "' || :OLD.titulo ||
            '" porque posee ' || count || ' edición(es) registrada(s).');
    END IF;
END TRG_Libro_Baja_Sin_Ediciones;
/

-- ==========================================================================================
-- CU-3 (Mantener Autor): COMO Administrador, QUIERO gestionar la información de los
-- escritores, PARA PODER clasificar los libros según su autoría.
-- ==========================================================================================

-- DISP-10: Generar automáticamente el id de Autor con formato AUT + secuencial de 3 dígitos
-- CU-3 > A: "El id se genera automáticamente con el formato AUT + secuencial de
--   3 dígitos (AUT001, AUT002, ...)"
CREATE OR REPLACE TRIGGER TRG_Autor_Generar_Id
BEFORE INSERT ON Autor
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID
    FROM Autor;

    :NEW.id := 'AUT' || LPAD(lastID + 1, 3, '0');
END TRG_Autor_Generar_Id;
/

-- DISP-11: Solo un Administrador puede registrar Autores
-- CU-3 > A: "Solo un Administrador puede registrar autores"
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Autor
BEFORE INSERT ON Autor
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Administrador A
    JOIN Usuario U ON U.id = A.idUsuario
    WHERE U.rol = 'Administrador';

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Autores.');
    END IF;
END TRG_Solo_Admin_Autor;
/

-- DISP-12: Verificar que la combinación nombre + apellidos del Autor no esté duplicada
-- CU-3 > A/M: "Se requiere que la combinación nombre + apellidos no esté duplicada
--   en el sistema."
CREATE OR REPLACE TRIGGER TRG_Autor_Nombre_Unico
BEFORE INSERT OR UPDATE OF nombre, apellidos ON Autor
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Autor
    WHERE UPPER(nombre) = UPPER(:NEW.nombre)
    AND UPPER(apellidos) = UPPER(:NEW.apellidos)
    AND id != :NEW.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20050,
            'Ya existe un autor con el nombre "' || :NEW.nombre ||
            ' ' || :NEW.apellidos || '" en el sistema.');
    END IF;
END TRG_Autor_Nombre_Unico;
/

-- DISP-13: Verificar que el Autor exista antes de modificar
-- CU-3 > M: "Se requiere que el autor exista previamente en el sistema."
CREATE OR REPLACE TRIGGER TRG_Autor_Existe_Para_Modificar
BEFORE UPDATE ON Autor
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Autor
    WHERE id = :OLD.id;

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20051,
            'El autor con id "' || :OLD.id || '" no existe en el sistema.');
    END IF;
END TRG_Autor_Existe_Para_Modificar;
/

-- DISP-14: Al eliminar Autor, verificar que no tenga libros vinculados
-- CU-3 > E: "Se requiere que el autor no tenga libros (0..*) asociados para proceder."
-- Nota: se asume tabla intermedia Libro_Autor (idLibro, idAutor) por relación M:N
CREATE OR REPLACE TRIGGER TRG_Autor_Baja_Sin_Libros
BEFORE DELETE ON Autor
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Libro_Autor
    WHERE idAutor = :OLD.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20052,
            'No se puede eliminar el autor "' || :OLD.nombre || ' ' || :OLD.apellidos ||
            '" porque tiene ' || count || ' libro(s) asociado(s).');
    END IF;
END TRG_Autor_Baja_Sin_Libros;
/

-- ==========================================================================================
-- CU-4 (Mantener Edición): COMO Administrador, QUIERO gestionar las versiones específicas
-- de los títulos, PARA PODER controlar el año y la extensión de cada obra.
-- ==========================================================================================

-- DISP-15: Generar automáticamente el id de Edicion con formato EDI + secuencial de 3 dígitos
-- CU-4 > A: "El id se genera automáticamente con el formato EDI + secuencial de
--   3 dígitos (EDI001, EDI002, ...)"
CREATE OR REPLACE TRIGGER TRG_Edicion_Generar_Id
BEFORE INSERT ON Edicion
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID
    FROM Edicion;

    :NEW.id := 'EDI' || LPAD(lastID + 1, 3, '0');
END TRG_Edicion_Generar_Id;
/

-- DISP-16: Solo un Administrador puede registrar Ediciones
-- CU-4 > A: "Solo un Administrador puede registrar ediciones"
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Edicion
BEFORE INSERT ON Edicion
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Administrador A
    JOIN Usuario U ON U.id = A.idUsuario
    WHERE U.rol = 'Administrador';

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Ediciones.');
    END IF;
END TRG_Solo_Admin_Edicion;
/

-- DISP-17: Verificar que el idLibro de la Edicion exista en Libro
-- CU-4 > A/M: "El idLibro suministrado debe corresponder a un libro registrado
--   en el sistema."
CREATE OR REPLACE TRIGGER TRG_Edicion_Libro_Existe
BEFORE INSERT OR UPDATE OF idLibro ON Edicion
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Libro
    WHERE id = :NEW.idLibro;

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20060,
            'El libro con id "' || :NEW.idLibro || '" no existe en el catálogo.');
    END IF;
END TRG_Edicion_Libro_Existe;
/

-- DISP-18: Verificar que el idEditorial de la Edicion exista en Editorial
-- CU-4 > A/M: "El idEditorial suministrado debe corresponder a una editorial
--   registrada en el sistema."
CREATE OR REPLACE TRIGGER TRG_Edicion_Editorial_Existe
BEFORE INSERT OR UPDATE OF idEditorial ON Edicion
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Editorial
    WHERE id = :NEW.idEditorial;

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20061,
            'La editorial con id "' || :NEW.idEditorial || '" no existe en el sistema.');
    END IF;
END TRG_Edicion_Editorial_Existe;
/

-- DISP-19: Al modificar el origen (idLibro o idEditorial), verificar ausencia de Ejemplares
-- CU-4 > M: "Se requiere que la edición no tenga Ejemplares asociados si se desea
--   cambiar el origen (idLibro o idEditorial)."
CREATE OR REPLACE TRIGGER TRG_Edicion_Origen_Sin_Ejemplares
BEFORE UPDATE OF idLibro, idEditorial ON Edicion
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    IF (:NEW.idLibro     != :OLD.idLibro OR
        :NEW.idEditorial != :OLD.idEditorial) THEN

        SELECT COUNT(*)
        INTO count
        FROM Ejemplar
        WHERE idEdicion = :OLD.id;

        IF count > 0 THEN
            RAISE_APPLICATION_ERROR(-20062,
                'No se puede cambiar el origen de la edición "' || :OLD.id ||
                '" porque posee ' || count || ' ejemplar(es) registrado(s).');
        END IF;
    END IF;
END TRG_Edicion_Origen_Sin_Ejemplares;
/

-- DISP-20: Al eliminar Edicion, verificar que no tenga Ejemplares vinculados
-- CU-4 > E: "Se requiere que la edición no posea ejemplares (0..*) registrados."
CREATE OR REPLACE TRIGGER TRG_Edicion_Baja_Sin_Ejemplares
BEFORE DELETE ON Edicion
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Ejemplar
    WHERE idEdicion = :OLD.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20063,
            'No se puede eliminar la edición "' || :OLD.id ||
            '" porque posee ' || count || ' ejemplar(es) registrado(s).');
    END IF;
END TRG_Edicion_Baja_Sin_Ejemplares;
/

-- ==========================================================================================
-- CU-5 (Mantener Editorial): COMO Administrador, QUIERO gestionar las casas editoriales,
-- PARA PODER vincular las ediciones con sus respectivos orígenes.
-- ==========================================================================================

-- DISP-21: Generar automáticamente el id de Editorial con formato EDT + secuencial de 3 dígitos
-- CU-5 > A: "El id se genera automáticamente con el formato EDT + secuencial de
--   3 dígitos (EDT001, EDT002, ...)"
CREATE OR REPLACE TRIGGER TRG_Editorial_Generar_Id
BEFORE INSERT ON Editorial
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID
    FROM Editorial;

    :NEW.id := 'EDT' || LPAD(lastID + 1, 3, '0');
END TRG_Editorial_Generar_Id;
/

-- DISP-22: Solo un Administrador puede registrar Editoriales
-- CU-5 > A: "Solo un Administrador puede registrar editoriales"
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Editorial
BEFORE INSERT ON Editorial
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Administrador A
    JOIN Usuario U ON U.id = A.idUsuario
    WHERE U.rol = 'Administrador';

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Editoriales.');
    END IF;
END TRG_Solo_Admin_Editorial;
/

-- DISP-23: Verificar que el correo de la Editorial no esté duplicado
-- CU-5 > A/M: "Se requiere que el correo no esté duplicado en el sistema."
-- Nota: la constraint UNIQUE ya garantiza integridad; este trigger provee mensaje en español.
CREATE OR REPLACE TRIGGER TRG_Editorial_Correo_Unico
BEFORE INSERT OR UPDATE OF correo ON Editorial
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Editorial
    WHERE UPPER(correo) = UPPER(:NEW.correo)
    AND id != :NEW.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20070,
            'Ya existe una editorial con el correo "' || :NEW.correo || '" en el sistema.');
    END IF;
END TRG_Editorial_Correo_Unico;
/

-- DISP-24: Verificar que el teléfono de la Editorial no esté duplicado
-- CU-5 > A/M: "Se requiere que el teléfono no esté duplicado en el sistema."
-- Nota: la constraint UNIQUE ya garantiza integridad; este trigger provee mensaje en español.
CREATE OR REPLACE TRIGGER TRG_Editorial_Telefono_Unico
BEFORE INSERT OR UPDATE OF telefono ON Editorial
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Editorial
    WHERE telefono = :NEW.telefono
    AND id != :NEW.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20071,
            'Ya existe una editorial con el teléfono "' || :NEW.telefono || '" en el sistema.');
    END IF;
END TRG_Editorial_Telefono_Unico;
/

-- DISP-25: Al eliminar Editorial, verificar que no tenga ediciones vinculadas
-- CU-5 > E: "Se requiere que la editorial no tenga ediciones (0..*) vinculadas."
-- Nota: la FK Edicion.idEditorial → Editorial(id) ya bloquea el DELETE con ORA-02292;
--   este trigger provee mensaje descriptivo en español.
CREATE OR REPLACE TRIGGER TRG_Editorial_Baja_Sin_Ediciones
BEFORE DELETE ON Editorial
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Edicion
    WHERE idEditorial = :OLD.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20072,
            'No se puede eliminar la editorial "' || :OLD.nombre ||
            '" porque tiene ' || count || ' edición(es) registrada(s).');
    END IF;
END TRG_Editorial_Baja_Sin_Ediciones;
/

-- ==========================================================================================
-- CU-6 (Mantener Ejemplar): COMO Administrador, QUIERO gestionar las unidades físicas,
-- PARA PODER controlar el stock y su ubicación.
-- ==========================================================================================

-- DISP-26: Generar automáticamente el id de Ejemplar con formato EJM + secuencial de 3 dígitos
-- CU-6 > A: "El id se genera automáticamente con el formato EJM + secuencial de
--   3 dígitos (EJM001, EJM002, ...)"
CREATE OR REPLACE TRIGGER TRG_Ejemplar_Generar_Id
BEFORE INSERT ON Ejemplar
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID
    FROM Ejemplar;

    :NEW.id := 'EJM' || LPAD(lastID + 1, 3, '0');
END TRG_Ejemplar_Generar_Id;
/

-- DISP-27: Solo un Administrador puede registrar Ejemplares
-- CU-6 > A: "Solo un Administrador puede registrar ejemplares"
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Ejemplar
BEFORE INSERT ON Ejemplar
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Administrador A
    JOIN Usuario U ON U.id = A.idUsuario
    WHERE U.rol = 'Administrador';

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Ejemplares.');
    END IF;
END TRG_Solo_Admin_Ejemplar;
/

-- ==========================================================================================
-- CU-7 (Registrar Compra): COMO Administrador, QUIERO registrar adquisiciones de stock,
-- PARA PODER aumentar el conjunto bibliográfico.
-- ==========================================================================================

-- DISP-28: Generar automáticamente el id de Compra con formato COM + secuencial de 3 dígitos
-- CU-7 > A: "El id se genera automáticamente con el formato COM + secuencial de
--   3 dígitos (COM001, COM002, ...)"
CREATE OR REPLACE TRIGGER TRG_Compra_Generar_Id
BEFORE INSERT ON Compra
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID
    FROM Compra;

    :NEW.id := 'COM' || LPAD(lastID + 1, 3, '0');
END TRG_Compra_Generar_Id;
/

-- DISP-29: Solo un Administrador puede registrar Compras
-- CU-7 > A: "Solo un Administrador puede registrar compras"
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Compra
BEFORE INSERT ON Compra
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Administrador A
    JOIN Usuario U ON U.id = A.idUsuario
    WHERE U.rol = 'Administrador';

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Compras.');
    END IF;
END TRG_Solo_Admin_Compra;
/

-- DISP-30: Verificar que el idProveedor de la Compra exista en Proveedor
-- CU-7 > A: "El idProveedor suministrado debe corresponder a un proveedor registrado."
-- Nota: la FK Compra.idProveedor → Proveedor(id) ya garantiza integridad referencial;
--   este trigger provee mensaje descriptivo en español.
CREATE OR REPLACE TRIGGER TRG_Compra_Proveedor_Existe
BEFORE INSERT OR UPDATE OF idProveedor ON Compra
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Proveedor
    WHERE id = :NEW.idProveedor;

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20090,
            'El proveedor con id "' || :NEW.idProveedor || '" no existe en el sistema.');
    END IF;
END TRG_Compra_Proveedor_Existe;
/

-- DISP-31: Establecer el estado de la Compra en 'PENDIENTE' al registrar
-- CU-7 > A: "El estado se establece automáticamente en 'PENDIENTE' al momento del registro."
CREATE OR REPLACE TRIGGER TRG_Compra_Estado_Inicial
BEFORE INSERT ON Compra
FOR EACH ROW
BEGIN
    :NEW.estado := 'PENDIENTE';
END TRG_Compra_Estado_Inicial;
/

-- DISP-32: Solo se puede modificar una Compra si su estado es 'PENDIENTE'
-- CU-7 > M: "Se requiere que la compra esté en estado 'PENDIENTE' para poder modificarse."
CREATE OR REPLACE TRIGGER TRG_Compra_Modificar_Pendiente
BEFORE UPDATE OF total, idProveedor ON Compra
FOR EACH ROW
BEGIN
    IF :OLD.estado != 'PENDIENTE' THEN
        RAISE_APPLICATION_ERROR(-20091,
            'No se puede modificar la compra "' || :OLD.id ||
            '" porque su estado es "' || :OLD.estado || '" (solo se permiten modificaciones en estado Pendiente).');
    END IF;
END TRG_Compra_Modificar_Pendiente;
/

-- DISP-33: Al eliminar Compra, verificar que no se hayan generado Ejemplares a partir de ella
-- CU-7 > E: "Se requiere que no se hayan generado Ejemplares físicos a partir de esta compra."
-- Lógica: se verifica que ningún Libro referenciado en Producto_Compra de esta compra
--   tenga Ediciones con Ejemplares registrados, como trazabilidad indirecta de stock generado.
CREATE OR REPLACE TRIGGER TRG_Compra_Baja_Sin_Ejemplares
BEFORE DELETE ON Compra
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Ejemplar EJ
    JOIN Edicion  ED ON ED.id      = EJ.idEdicion
    JOIN Producto_Compra PC ON PC.idLibro = ED.idLibro
    WHERE PC.idCompra = :OLD.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20092,
            'No se puede eliminar la compra "' || :OLD.id ||
            '" porque se han generado ' || count || ' ejemplar(es) físico(s) a partir de sus productos.');
    END IF;
END TRG_Compra_Baja_Sin_Ejemplares;
/

-- ==========================================================================================
-- CU-8 (Mantener Proveedor): COMO Administrador, QUIERO gestionar la base de datos de
-- proveedores, PARA PODER formalizar los procesos de adquisición y compra.
-- ==========================================================================================

-- DISP-34: Generar automáticamente el id de Proveedor con formato PRV + secuencial de 3 dígitos
-- CU-8 > A: "El id se genera automáticamente con el formato PRV + secuencial de
--   3 dígitos (PRV001, PRV002, ...)"
CREATE OR REPLACE TRIGGER TRG_Proveedor_Generar_Id
BEFORE INSERT ON Proveedor
FOR EACH ROW
DECLARE
    lastID NUMBER;
BEGIN
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 4))), 0)
    INTO lastID
    FROM Proveedor;

    :NEW.id := 'PRV' || LPAD(lastID + 1, 3, '0');
END TRG_Proveedor_Generar_Id;
/

-- DISP-35: Solo un Administrador puede registrar Proveedores
-- CU-8 > A: "Solo un Administrador puede registrar proveedores"
CREATE OR REPLACE TRIGGER TRG_Solo_Admin_Proveedor
BEFORE INSERT ON Proveedor
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Administrador A
    JOIN Usuario U ON U.id = A.idUsuario
    WHERE U.rol = 'Administrador';

    IF count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Acceso denegado: solo un Administrador puede registrar Proveedores.');
    END IF;
END TRG_Solo_Admin_Proveedor;
/

-- DISP-36: Verificar que el correo del Proveedor no esté duplicado
-- CU-8 > A/M: "Se requiere que el correo no esté duplicado en el sistema."
-- Nota: la constraint UNIQUE sobre Proveedor.correo ya garantiza integridad;
--   este trigger provee mensaje descriptivo en español.
CREATE OR REPLACE TRIGGER TRG_Proveedor_Correo_Unico
BEFORE INSERT OR UPDATE OF correo ON Proveedor
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Proveedor
    WHERE UPPER(correo) = UPPER(:NEW.correo)
    AND   id           != :NEW.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20100,
            'Ya existe un proveedor con el correo "' || :NEW.correo || '" en el sistema.');
    END IF;
END TRG_Proveedor_Correo_Unico;
/

-- DISP-37: Al eliminar Proveedor, verificar que no tenga Compras asociadas
-- CU-8 > E: "Se requiere que el proveedor no tenga registros de Compra (0..*) asociados."
-- Nota: la FK Compra.idProveedor → Proveedor(id) ya bloquea el DELETE con ORA-02292;
--   este trigger provee mensaje descriptivo en español.
CREATE OR REPLACE TRIGGER TRG_Proveedor_Baja_Sin_Compras
BEFORE DELETE ON Proveedor
FOR EACH ROW
DECLARE
    count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count
    FROM Compra
    WHERE idProveedor = :OLD.id;

    IF count > 0 THEN
        RAISE_APPLICATION_ERROR(-20101,
            'No se puede eliminar el proveedor "' || :OLD.nombre || ' ' || :OLD.apellidos ||
            '" (' || :OLD.empresa || ') porque tiene ' || count || ' compra(s) registrada(s).');
    END IF;
END TRG_Proveedor_Baja_Sin_Compras;
/