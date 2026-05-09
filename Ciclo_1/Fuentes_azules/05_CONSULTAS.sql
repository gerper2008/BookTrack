---------------------------------------------------------------------------------------------
--- PERSISTENCIA: CONSULTAS
---------------------------------------------------------------------------------------------

-- Q1: Lista simple de todos los libros
SELECT id, titulo, idioma, fecha_publicacion FROM Libro;

-- Q2: Lista de autores registrados
SELECT id, nombre, apellidos, nacionalidad FROM Autor;

-- Q3: Ejemplares disponibles para prestar
SELECT id, estado_fisico, localizacion FROM Ejemplar WHERE disponibilidad = 1;

-- Q4: Libro con su categoria
SELECT L.titulo, C.nombre AS categoria
FROM Libro L
JOIN Categoria C ON L.id_categoria = C.id;

-- Q5: Ediciones con su editorial
SELECT E.id, E.paginas, ED.nombre AS editorial
FROM Edicion E
JOIN Editorial ED ON E.id_editorial = ED.id;

-- Q6: Compras con su proveedor
SELECT C.id, C.fecha, C.total, P.nombre AS proveedor
FROM Compra C
JOIN Proveedor P ON C.id_proveedor = P.id;

-- Q7: Cantidad de libros por categoria
SELECT C.nombre AS categoria, COUNT(L.id) AS total_libros
FROM Categoria C
JOIN Libro L ON L.id_categoria = C.id
GROUP BY C.nombre;

-- Consulta de restricciones foraneas
SELECT constraint_name, table_name, r_constraint_name
FROM user_constraints
WHERE constraint_type = 'R'
ORDER BY table_name;
