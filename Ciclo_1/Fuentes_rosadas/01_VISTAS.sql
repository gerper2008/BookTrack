---------------------------------------------------------------------------------------------
--- VISTAS: Consultas Operativas ------------------------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-- VW1: Consultar catálogo de libros
-- Detalle:
-- "COMO Administrador, Quiero consultar el catálogo de libros,
-- PARA poder supervisar el material disponible."
---------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW VW_Catalogo_Libros AS
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

-- Ejemplo de uso:
SELECT *
FROM VW_Catalogo_Libros
WHERE categoria = 'Ficción'
  AND autor = 'Gabriel García Márquez'
ORDER BY titulo, autor;

---------------------------------------------------------------------------------------------
-- VW2: Consultar proveedores
-- Detalle:
-- "COMO Administrador, Quiero consultar los proveedores,
-- PARA poder gestionar las fuentes de compra."
---------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW VW_Proveedores AS
SELECT
    nombre,
    telefono,
    correo,
    empresa
FROM Proveedor;

-- Ejemplo de uso:
SELECT *
FROM VW_Proveedores
WHERE empresa = 'Distribuidora XYZ'
ORDER BY nombre;

---------------------------------------------------------------------------------------------
-- VW3: Consultar compras realizadas
-- Detalle:
-- "COMO Administrador, Quiero consultar las compras realizadas,
-- PARA poder controlar las adquisiciones de la biblioteca."
---------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW VW_Compras AS
SELECT
    c.id AS id_compra,
    c.fecha,
    c.total,
    p.nombre || ' ' || p.apellidos AS proveedor
FROM Compra c
LEFT JOIN Proveedor p ON p.id = c.idProveedor;

-- Ejemplo de uso:
SELECT *
FROM VW_Compras
WHERE proveedor = 'Juan Pérez'
  AND fecha BETWEEN DATE '2025-01-01' AND DATE '2025-12-31'
ORDER BY fecha;

---------------------------------------------------------------------------------------------
-- VW4: Consultar productos de compra
-- Detalle:
-- "COMO Administrador, Quiero consultar los productos de compra,
-- PARA poder ver los libros adquiridos en cada compra."
---------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW VW_Productos_Compra AS
SELECT
    pc.idCompra,
    l.titulo AS producto,
    pc.cantidad,
    pc.precioUnidad,
    (pc.cantidad * pc.precioUnidad) AS subtotal
FROM Producto_Compra pc
LEFT JOIN Libro l ON l.id = pc.idLibro;

-- Ejemplo de uso:
SELECT *
FROM VW_Productos_Compra
WHERE idCompra = 'COM001'
ORDER BY producto;

---------------------------------------------------------------------------------------------
-- VW5: Consultar ejemplares disponibles
-- Detalle:
-- "COMO Bibliotecario, Quiero consultar los ejemplares disponibles,
-- PARA poder saber qué libros están disponibles para préstamo."
---------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW VW_Ejemplares_Disponibles AS
SELECT
    e.id AS codigoEjemplar,
    l.titulo AS titulo_libro,
    e.disponibilidad,
    e.localizacion
FROM Ejemplar e
LEFT JOIN Edicion ed ON ed.id = e.idEdicion
LEFT JOIN Libro l ON l.id = ed.idLibro;

-- Ejemplo de uso:
SELECT *
FROM VW_Ejemplares_Disponibles
WHERE disponibilidad = 1
AND localizacion = 'Sala A'
ORDER BY titulo_libro, codigoEjemplar;

---------------------------------------------------------------------------------------------
--- VISTAS: Consultas Modelo de Funciones ---------------------------------------------------
---------------------------------------------------------------------------------------------

-- Consultar categoria
CREATE OR REPLACE VIEW VW_Categoria_Consulta AS
SELECT 
    id,
    nombre,
    descripcion
FROM Categoria;

-- Consultar libro
CREATE OR REPLACE VIEW VW_Libro_Consulta AS
SELECT 
    l.id,
    l.titulo,
    l.idioma,
    c.nombre AS categoria
FROM Libro l
LEFT JOIN Categoria c ON c.id = l.idCategoria;

-- Consultar autor
CREATE OR REPLACE VIEW VW_Autor_Consulta AS
SELECT 
    nombre,
    apellidos,
    genero,
    nacionalidad
FROM Autor;

-- Consultar edición
CREATE OR REPLACE VIEW VW_Edicion_Consulta AS
SELECT 
    id,
    anio,
    paginas
FROM Edicion;

-- Consultar editorial
CREATE OR REPLACE VIEW VW_Editorial_Consulta AS
SELECT 
    id,
    nombre,
    correo,
    telefono,
    pais
FROM Editorial;

-- Consultar ejemplar
CREATE OR REPLACE VIEW VW_Ejemplar_Consulta AS
SELECT 
    id,
    estadoFisico,
    disponibilidad,
    fechaAdquisicion
FROM Ejemplar;