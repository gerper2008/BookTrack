---------------------------------------------------------------------------------------------
--- ACCIONES: Definición de acciones de referencia
---------------------------------------------------------------------------------------------

-- Libro.idCategoria → Categoria(id)  |  ON DELETE SET NULL
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'LIBRO'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'CATEGORIA' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Libro DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Libro ADD CONSTRAINT FK_Libro_Categoria
    FOREIGN KEY (idCategoria) REFERENCES Categoria(id) ON DELETE SET NULL;

-- Edicion.idLibro → Libro(id)  |  ON DELETE CASCADE
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'EDICION'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'LIBRO' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Edicion DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Edicion ADD CONSTRAINT FK_Edicion_Libro
    FOREIGN KEY (idLibro) REFERENCES Libro(id) ON DELETE CASCADE;

-- Edicion.idEditorial → Editorial(id)  |  ON DELETE SET NULL
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'EDICION'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'EDITORIAL' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Edicion DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Edicion ADD CONSTRAINT FK_Edicion_Editorial
    FOREIGN KEY (idEditorial) REFERENCES Editorial(id) ON DELETE SET NULL;

-- Ejemplar.idEdicion → Edicion(id)  |  ON DELETE CASCADE
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'EJEMPLAR'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'EDICION' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Ejemplar DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Ejemplar ADD CONSTRAINT FK_Ejemplar_Edicion
    FOREIGN KEY (idEdicion) REFERENCES Edicion(id) ON DELETE CASCADE;

-- Compra.idProveedor → Proveedor(id)  |  ON DELETE SET NULL
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'COMPRA'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'PROVEEDOR' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Compra DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Compra ADD CONSTRAINT FK_Compra_Proveedor
    FOREIGN KEY (idProveedor) REFERENCES Proveedor(id) ON DELETE SET NULL;

-- Producto_Compra.idCompra → Compra(id)  |  ON DELETE CASCADE
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'PRODUCTO_COMPRA'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'COMPRA' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Producto_Compra DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Producto_Compra ADD CONSTRAINT FK_ProductoCompra_Compra
    FOREIGN KEY (idCompra) REFERENCES Compra(id) ON DELETE CASCADE;

-- Producto_Compra.idLibro → Libro(id)  |  ON DELETE SET NULL
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'PRODUCTO_COMPRA'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'LIBRO' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Producto_Compra DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Producto_Compra ADD CONSTRAINT FK_ProductoCompra_Libro
    FOREIGN KEY (idLibro) REFERENCES Libro(id) ON DELETE SET NULL;

-- Administrador.idUsuario → Usuario(id)  |  ON DELETE CASCADE
BEGIN
    FOR r IN (SELECT constraint_name FROM user_constraints
        WHERE table_name = 'ADMINISTRADOR'
            AND constraint_type = 'R'
            AND r_constraint_name IN (
                SELECT constraint_name FROM user_constraints
                WHERE table_name = 'USUARIO' AND constraint_type = 'P'))
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE Administrador DROP CONSTRAINT ' || r.constraint_name;
    END LOOP;
END;
/
ALTER TABLE Administrador ADD CONSTRAINT FK_Administrador_Usuario
    FOREIGN KEY (idUsuario) REFERENCES Usuario(id) ON DELETE CASCADE;

