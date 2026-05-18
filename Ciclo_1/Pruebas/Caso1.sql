--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- PARTE IV: PRUEBA DE ACEPTACIÓN ----------------------------------------------
--------------------------------------------------------------------------------
--
-- Historia: "Laura organiza nuevos libros para la biblioteca"
--
--------------------------------------------------------------------------------

-- LIMPIEZA PREVIA
DELETE FROM Libro_Autor WHERE idLibro = 'LIB900';
DELETE FROM Ejemplar    WHERE idEdicion = 'EDI900';
DELETE FROM Edicion     WHERE id = 'EDI900';
DELETE FROM Libro       WHERE id = 'LIB900';
DELETE FROM Autor       WHERE id = 'AUT900';
DELETE FROM Categoria   WHERE id = 'CAT900';
COMMIT;

-- PASO 1 ----------------------------------------------------------------------
-- Laura registra una nueva categoría de libros.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 1: Registro categoria ===');

    INSERT INTO Categoria(id, nombre, descripcion)
    VALUES ('CAT900', 'Ciberseguridad', 'Libros de seguridad informatica');

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Categoria registrada');
END;
/

-- Verificación paso 1
SELECT *
FROM Categoria
WHERE id = 'CAT900';


-- PASO 2 ----------------------------------------------------------------------
-- Laura registra un nuevo autor.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 2: Registro autor ===');

    INSERT INTO Autor(id, nombre, apellidos, genero, nacionalidad)
    VALUES ('AUT900', 'Kevin', 'Mitnick', 'M', 'Estadounidense');

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Autor registrado');
END;
/

-- Verificación paso 2
SELECT *
FROM Autor
WHERE id = 'AUT900';


-- PASO 3 ----------------------------------------------------------------------
-- Laura registra un nuevo libro.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 3: Registro libro ===');

    INSERT INTO Libro(
        id,
        idCategoria,
        titulo,
        descripcion,
        fecha_publicacion,
        idioma
    )
    VALUES (
        'LIB900',
        'CAT900',
        'Hackeo Etico Moderno',
        'Tecnicas modernas de pentesting',
        DATE '2024-01-10',
        'Español'
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Libro registrado');
END;
/

-- Verificación paso 3
SELECT id, titulo, idCategoria
FROM Libro
WHERE id = 'LIB900';


-- PASO 4 ----------------------------------------------------------------------
-- Laura relaciona el autor con el libro.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 4: Asociacion libro-autor ===');

    INSERT INTO Libro_Autor(idLibro, idAutor)
    VALUES ('LIB900', 'AUT900');

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Relacion registrada');
END;
/

-- Verificación paso 4
SELECT *
FROM Libro_Autor
WHERE idLibro = 'LIB900';


-- PASO 5 ----------------------------------------------------------------------
-- Laura registra una edición del libro.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 5: Registro edicion ===');

    INSERT INTO Edicion(
        id,
        idLibro,
        idEditorial,
        anio,
        paginas
    )
    VALUES (
        'EDI900',
        'LIB900',
        NULL,
        DATE '2024-01-01',
        420
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Edicion registrada');
END;
/

-- Verificación paso 5
SELECT *
FROM Edicion
WHERE id = 'EDI900';


-- PASO 6 ----------------------------------------------------------------------
-- Laura registra un ejemplar físico del libro.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 6: Registro ejemplar ===');

    INSERT INTO Ejemplar(
        id,
        idEdicion,
        estadoFisico,
        disponibilidad,
        localizacion,
        fechaAdquisicion
    )
    VALUES (
        'EJM900',
        'EDI900',
        'Excelente',
        '1',
        'Estante A1',
        DATE '2025-01-15'
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Ejemplar registrado');
END;
/

-- Verificación paso 6
SELECT *
FROM Ejemplar
WHERE id = 'EJM900';


-- PASO 7 ----------------------------------------------------------------------
-- Laura consulta los ejemplares disponibles del libro.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 7: Consulta ejemplares ===');
END;
/

-- Verificación paso 7
SELECT
    L.titulo,
    E.id,
    E.estadoFisico,
    E.disponibilidad
FROM Libro L
JOIN Edicion ED ON ED.idLibro = L.id
JOIN Ejemplar E ON E.idEdicion = ED.id
WHERE L.id = 'LIB900';


-- PASO 8 ----------------------------------------------------------------------
-- Laura intenta eliminar la edición con ejemplares asociados.
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== PASO 8: Eliminacion protegida ===');

    DELETE FROM Edicion
    WHERE id = 'EDI900';

    COMMIT;
END;
/

-- → FALLA:
-- ORA-20063 No se puede eliminar la edición porque posee ejemplares registrados


-- Verificación paso 8
SELECT *
FROM Edicion
WHERE id = 'EDI900';