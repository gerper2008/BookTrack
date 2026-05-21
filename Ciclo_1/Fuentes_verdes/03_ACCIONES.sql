---------------------------------------------------------------------------------------------
--- ACCIONES: Definición de acciones de referencia
---------------------------------------------------------------------------------------------

-- Libro.idCategoria → Categoria(id) - ON DELETE SET NULL
-- Si se elimina la categoría, el idCategoria del libro queda nulo
ALTER TABLE Libro ADD CONSTRAINT FK_Libro_Categoria
    FOREIGN KEY (idCategoria) REFERENCES Categoria(id) ON DELETE SET NULL;

-- Edicion.idLibro → Libro(id) - ON DELETE CASCADE
-- Si se elimina el libro, todas sus ediciones asociadas se eliminan en cascada
ALTER TABLE Edicion ADD CONSTRAINT FK_Edicion_Libro
    FOREIGN KEY (idLibro) REFERENCES Libro(id) ON DELETE CASCADE;

-- Edicion.idEditorial → Editorial(id) - ON DELETE SET NULL
-- Si se elimina la editorial, el idEditorial de la edición queda nulo
ALTER TABLE Edicion ADD CONSTRAINT FK_Edicion_Editorial
    FOREIGN KEY (idEditorial) REFERENCES Editorial(id) ON DELETE SET NULL;

-- Ejemplar.idEdicion → Edicion(id) - ON DELETE CASCADE
-- Si se elimina la edición, todos sus ejemplares asociados se eliminan en cascada
ALTER TABLE Ejemplar ADD CONSTRAINT FK_Ejemplar_Edicion
    FOREIGN KEY (idEdicion) REFERENCES Edicion(id) ON DELETE CASCADE;
    
-- Libro_Autor.idAutor → Autor(id) - ON DELETE CASCADE
-- SET NULL en columnas PK. Se usa CASCADE: si se elimina un autor, sus
-- registros en Libro_Autor se eliminan en cascada.
ALTER TABLE Libro_Autor ADD CONSTRAINT FK_LibroAutor_Autor
    FOREIGN KEY (idAutor) REFERENCES Autor(id) ON DELETE CASCADE;

-- Libro_Autor.idLibro → Libro(id) - ON DELETE CASCADE
-- Si se elimina un libro, sus asociaciones con autores se eliminan en cascada.
ALTER TABLE Libro_Autor ADD CONSTRAINT FK_LibroAutor_Libro
    FOREIGN KEY (idLibro) REFERENCES Libro(id) ON DELETE CASCADE;

-- Compra.idProveedor → Proveedor(id) - ON DELETE SET NULL
-- Si se elimina el proveedor, el idProveedor de la compra queda nulo
ALTER TABLE Compra ADD CONSTRAINT FK_Compra_Proveedor
    FOREIGN KEY (idProveedor) REFERENCES Proveedor(id) ON DELETE SET NULL;

-- Producto_Compra.idCompra → Compra(id) - ON DELETE CASCADE
-- Si se elimina la compra, todos sus productos asociados se eliminan en cascada
ALTER TABLE Producto_Compra ADD CONSTRAINT FK_ProductoCompra_Compra
    FOREIGN KEY (idCompra) REFERENCES Compra(id) ON DELETE CASCADE;

-- Producto_Compra.idLibro → Libro(id) - ON DELETE SET NULL
-- Si se elimina el libro, el idLibro del producto de compra queda nulo
ALTER TABLE Producto_Compra ADD CONSTRAINT FK_ProductoCompra_Libro
    FOREIGN KEY (idLibro) REFERENCES Libro(id) ON DELETE SET NULL;

-- Administrador.idUsuario → Usuario(id) - ON DELETE CASCADE
-- Si se elimina el usuario, su registro de administrador se elimina en cascada
ALTER TABLE Administrador ADD CONSTRAINT FK_Administrador_Usuario
    FOREIGN KEY (idUsuario) REFERENCES Usuario(id) ON DELETE CASCADE;
    
---------------------------------------------------------------------------------------------
--- Elminar Acciones
---------------------------------------------------------------------------------------------
ALTER TABLE Libro DROP CONSTRAINT FK_Libro_Categoria;
ALTER TABLE Edicion DROP CONSTRAINT FK_Edicion_Libro;
ALTER TABLE Edicion DROP CONSTRAINT FK_Edicion_Editorial;
ALTER TABLE Ejemplar DROP CONSTRAINT FK_Ejemplar_Edicion;
ALTER TABLE Libro_Autor DROP CONSTRAINT FK_LibroAutor_Autor;
ALTER TABLE Libro_Autor DROP CONSTRAINT FK_LibroAutor_Libro;
ALTER TABLE Compra DROP CONSTRAINT FK_Compra_Proveedor;
ALTER TABLE Producto_Compra DROP CONSTRAINT FK_ProductoCompra_Compra;
ALTER TABLE Producto_Compra DROP CONSTRAINT FK_ProductoCompra_Libro;
ALTER TABLE Administrador DROP CONSTRAINT FK_Administrador_Usuario;