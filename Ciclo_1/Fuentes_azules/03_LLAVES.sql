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

---------------------------------------------------------------------------------------------
--- PERSISTENCIA: FORANEAS -> Definición de claves foraneas
---------------------------------------------------------------------------------------------
ALTER TABLE Administrador ADD FOREIGN KEY(idUsuario) REFERENCES Usuario(id);
ALTER TABLE Libro ADD FOREIGN KEY(idCategoria) REFERENCES Categoria(id);
ALTER TABLE Edicion ADD FOREIGN KEY(idLibro) REFERENCES Libro(id);
ALTER TABLE Edicion ADD FOREIGN KEY(idEditorial) REFERENCES Editorial(id);
ALTER TABLE Ejemplar ADD FOREIGN KEY(idEdicion) REFERENCES Edicion(id);
ALTER TABLE Compra ADD FOREIGN KEY(idProveedor) REFERENCES Proveedor(id);
ALTER TABLE Producto_Compra ADD FOREIGN KEY(idCompra) REFERENCES Compra(id);
ALTER TABLE Producto_Compra ADD FOREIGN KEY(idLibro) REFERENCES Libro(id);
ALTER TABLE Libro_Autor ADD FOREIGN KEY (idLibro) REFERENCES Libro(id);
ALTER TABLE Libro_Autor ADD FOREIGN KEY (idAutor) REFERENCES Autor(id);