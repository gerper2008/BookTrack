---------------------------------------------------------------------------------------------
--- PERSISTENCIA: CONSULTAS -----------------------------------------------------------------
---------------------------------------------------------------------------------------------

-- Q1: Consultar catálogo de libros
SELECT 
    l.titulo,
    a.nombre || ' ' || a.apellidos AS autor,
    c.nombre AS categoria,
    e.nombre AS editorial,
    ed.anio
FROM Libro l
LEFT JOIN Libro_Autor la ON la.idLibro = l.id
LEFT JOIN Autor a ON a.id = la.idAutor
LEFT JOIN Categoria c ON c.id = l.idCategoria
LEFT JOIN Edicion ed ON ed.idLibro = l.id
LEFT JOIN Editorial e ON e.id = ed.idEditorial;

-- Q2: Consultar proveedores
SELECT
    nombre,
    telefono,
    correo,
    empresa
FROM Proveedor;

-- Q3: Consultar compras realizadas
SELECT
    c.id AS id_compra,
    c.fecha,
    c.total,
    p.nombre || ' ' || p.apellidos AS proveedor
FROM Compra c
LEFT JOIN Proveedor p ON p.id = c.idProveedor;

-- Q4: Consultar productos de compra
SELECT
    pc.idCompra,
    l.titulo AS producto,
    pc.cantidad,
    pc.precioUnidad,
    (pc.cantidad * pc.precioUnidad) AS subtotal
FROM Producto_Compra pc
LEFT JOIN Libro l ON l.id = pc.idLibro;

-- Q5: Consultar ejemplares disponibles
SELECT
    e.id AS codigoEjemplar,
    l.titulo AS titulo_libro,
    e.disponibilidad,
    e.localizacion
FROM Ejemplar e
LEFT JOIN Edicion ed ON ed.id = e.idEdicion
LEFT JOIN Libro l ON l.id = ed.idLibro
WHERE e.disponibilidad = 'TRUE'
  AND e.localizacion = 'Sala A'
ORDER BY titulo_libro, codigoEjemplar;

---------------------------------------------------------------------------------------------
--- PERSISTENCIA: CONSULTAS MODELO DE FUNCIONES ---------------------------------------------
---------------------------------------------------------------------------------------------

-- Q6: Consultar categoría
SELECT 
    id,
    nombre,
    descripcion
FROM Categoria;

-- Q7: Consultar libro
SELECT 
    l.id,
    l.titulo,
    l.idioma,
    c.nombre AS categoria
FROM Libro l
LEFT JOIN Categoria c ON c.id = l.idCategoria;

-- Q8: Consultar autor
SELECT 
    nombre,
    apellidos,
    genero,
    nacionalidad
FROM Autor;

-- Q9: Consultar edición
SELECT 
    id,
    anio,
    paginas
FROM Edicion;

-- Q10: Consultar editorial
SELECT 
    id,
    nombre,
    correo,
    telefono,
    pais
FROM Editorial;

-- Q11: Consultar ejemplar
SELECT 
    id,
    estadoFisico,
    disponibilidad,
    fechaAdquisicion
FROM Ejemplar;