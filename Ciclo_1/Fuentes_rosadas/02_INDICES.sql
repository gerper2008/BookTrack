---------------------------------------------------------------------------------------------
--- ÍNDICES ---------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

-- IDX01: Optimiza la consulta del catálogo de libros filtrando por categoría y ordenando por título
CREATE INDEX IDX_Libro_Categoria_Titulo
ON Libro(idCategoria, titulo);

-- IDX02: Optimiza la relación entre libros y autores para joins en el catálogo y consultas de autoría
CREATE INDEX IDX_LibroAutor_Libro_Autor
ON Libro_Autor(idLibro, idAutor);

-- IDX03: Optimiza búsquedas y ordenamiento de autores por apellido y nombre
CREATE INDEX IDX_Autor_Apellido_Nombre
ON Autor(apellidos, nombre);

-- IDX04: Optimiza la consulta de productos de compra filtrando por compra y libro
CREATE INDEX IDX_ProductoCompra_Compra_Libro
ON Producto_Compra(idCompra, idLibro);

-- IDX05: Optimiza consultas de compras por proveedor y rango de fecha
CREATE INDEX IDX_Compra_Proveedor_Fecha
ON Compra(idProveedor, fecha);

-- IDX06: Optimiza consultas de ejemplares por disponibilidad, ubicación y fecha de adquisición
CREATE INDEX IDX_Ejemplar_Disponibilidad_Loc_Fecha
ON Ejemplar(disponibilidad, localizacion, fechaAdquisicion);

-- IDX07: Optimiza el acceso a ediciones filtrando por libro, editorial y año
CREATE INDEX IDX_Edicion_Libro_Editorial_Anio
ON Edicion(idLibro, idEditorial, anio);

-- IDX08: Optimiza la búsqueda de proveedores por empresa y ordenamiento por nombre
CREATE INDEX IDX_Proveedor_Empresa_Nombre
ON Proveedor(empresa, nombre, apellidos);

-- IDX09: Optimiza búsquedas de libros por título y categoría
CREATE INDEX IDX_Libro_Titulo_Categoria
ON Libro(titulo, idCategoria);

-- IDX10: Optimiza filtros de autores por nacionalidad y género
CREATE INDEX IDX_Autor_Nacionalidad_Genero
ON Autor(nacionalidad, genero);