---------------------------------------------------------------------------------------------
--- ACCIONES: Definición de acciones de referencia
---------------------------------------------------------------------------------------------

-- Libro.id_categoria → Categoria(id)  |  ON DELETE SET NULL
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
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id) ON DELETE SET NULL;

-- Edicion.id_libro → Libro(id)  |  ON DELETE CASCADE
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
    FOREIGN KEY (id_libro) REFERENCES Libro(id) ON DELETE CASCADE;

-- Edicion.id_editorial → Editorial(id)  |  ON DELETE SET NULL
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
    FOREIGN KEY (id_editorial) REFERENCES Editorial(id) ON DELETE SET NULL;

-- Ejemplar.id_edicion → Edicion(id)  |  ON DELETE CASCADE
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
    FOREIGN KEY (id_edicion) REFERENCES Edicion(id) ON DELETE CASCADE;

-- Compra.id_proveedor → Proveedor(id)  |  ON DELETE SET NULL
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
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id) ON DELETE SET NULL;

-- Producto_Compra.id_compra → Compra(id)  |  ON DELETE CASCADE
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
    FOREIGN KEY (id_compra) REFERENCES Compra(id) ON DELETE CASCADE;

-- Producto_Compra.id_libro → Libro(id)  |  ON DELETE SET NULL
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
    FOREIGN KEY (id_libro) REFERENCES Libro(id) ON DELETE SET NULL;

-- Administrador.id_usuario → Usuario(id)  |  ON DELETE CASCADE
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
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id) ON DELETE CASCADE;

-- Libro_Autor: tabla nueva con sus FKs CASCADE
CREATE TABLE Libro_Autor (
    id_libro VARCHAR2(10),
    id_autor VARCHAR2(10)
);
ALTER TABLE Libro_Autor ADD PRIMARY KEY (id_libro, id_autor);
ALTER TABLE Libro_Autor ADD CONSTRAINT FK_LibroAutor_Libro
    FOREIGN KEY (id_libro) REFERENCES Libro(id) ON DELETE CASCADE;
ALTER TABLE Libro_Autor ADD CONSTRAINT FK_LibroAutor_Autor
    FOREIGN KEY (id_autor) REFERENCES Autor(id) ON DELETE CASCADE;
