---------------------------------------------------------------------------------------------
--- PERSISTENCIA: PRIMARIAS -> Definición de claves primarias
---------------------------------------------------------------------------------------------
ALTER TABLE Usuario ADD PRIMARY KEY(id);
ALTER TABLE Compra ADD PRIMARY KEY(id);
ALTER TABLE Producto_Compra ADD PRIMARY KEY(id);
ALTER TABLE Proveedor ADD PRIMARY KEY(id);
ALTER TABLE Autor ADD PRIMARY KEY(id);
ALTER TABLE Libro ADD PRIMARY KEY(id);
ALTER TABLE Ejemplar ADD PRIMARY KEY(id);
ALTER TABLE Categoria ADD PRIMARY KEY(id);
ALTER TABLE Edicion ADD PRIMARY KEY(id);
ALTER TABLE Editorial ADD PRIMARY KEY(id);
ALTER TABLE Libro_Autor ADD PRIMARY KEY (idLibro, idAutor);
ALTER TABLE Administrador ADD PRIMARY KEY(idUsuario);

---------------------------------------------------------------------------------------------
--- PERSISTENCIA: UNICAS -> Definición de claves únicas
---------------------------------------------------------------------------------------------
ALTER TABLE Usuario ADD UNIQUE(correo);
ALTER TABLE Proveedor ADD UNIQUE(correo);
ALTER TABLE Editorial ADD UNIQUE(correo);
ALTER TABLE Editorial ADD UNIQUE(telefono);
ALTER TABLE Categoria ADD UNIQUE(nombre);
ALTER TABLE Autor ADD CONSTRAINT UQ_Autor_Nombre_Apellidos UNIQUE (nombre, apellidos);

---------------------------------------------------------------------------------------------
--- PERSISTENCIA: FORANEAS -> Definición lógica de relaciones
--- (Documentación, no ejecutar. Las relaciones reales están en ACCIONES)
---------------------------------------------------------------------------------------------
-- Administrador.idUsuario → Usuario(id)
-- Libro.idCategoria → Categoria(id)
-- Edicion.idLibro → Libro(id)
-- Edicion.idEditorial → Editorial(id)
-- Ejemplar.idEdicion → Edicion(id)
-- Compra.idProveedor → Proveedor(id)
-- Producto_Compra.idCompra → Compra(id)
-- Producto_Compra.idLibro → Libro(id)
-- Libro_Autor.idLibro → Libro(id)
-- Libro_Autor.idAutor → Autor(id)