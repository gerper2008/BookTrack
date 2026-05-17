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
    
-- Libro_Autor.idAutor → Autor(id) - ON DELETE SET NULL
-- Si se elimina un autor, sus asociaciones con libros se conservan,
-- pero la referencia al autor queda en NULL.
ALTER TABLE Libro_Autor ADD CONSTRAINT FK_LibroAutor_Autor
    FOREIGN KEY (idAutor) REFERENCES Autor(id) ON DELETE SET NULL;

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