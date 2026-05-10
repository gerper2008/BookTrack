---------------------------------------------------------------------------------------------
--- ELIMINAR TODO: Bloque dinámico para limpiar todo el esquema
---------------------------------------------------------------------------------------------
BEGIN
    FOR cur_rec IN (SELECT object_name, object_type
        FROM   all_objects
        WHERE  object_type IN ('TABLE', 'VIEW', 'PACKAGE', 'PROCEDURE', 'FUNCTION', 'SEQUENCE')
        AND    owner = '<schema_name>')
    LOOP
        BEGIN
            IF cur_rec.object_type = 'TABLE' THEN
                EXECUTE IMMEDIATE 'DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '" CASCADE CONSTRAINTS';
            ELSE
                EXECUTE IMMEDIATE 'DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '"';
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.put_line('FAILED: DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '"');
        END;
    END LOOP;
END;
/

---------------------------------------------------------------------------------------------
--- PERSISTENCIA: XTABLAS -> Eliminación de tablas (con CASCADE)
---------------------------------------------------------------------------------------------
DROP TABLE Libro_Autor CASCADE CONSTRAINTS;
DROP TABLE Producto_Compra CASCADE CONSTRAINTS;
DROP TABLE Compra CASCADE CONSTRAINTS;
DROP TABLE Ejemplar CASCADE CONSTRAINTS;
DROP TABLE Edicion CASCADE CONSTRAINTS;
DROP TABLE Administrador CASCADE CONSTRAINTS;
DROP TABLE Libro CASCADE CONSTRAINTS;
DROP TABLE Autor CASCADE CONSTRAINTS;
DROP TABLE Categoria CASCADE CONSTRAINTS;
DROP TABLE Editorial CASCADE CONSTRAINTS;
DROP TABLE Proveedor CASCADE CONSTRAINTS;
DROP TABLE Usuario CASCADE CONSTRAINTS;

-- ============================================================
-- RESET TOTAL - BOOKTRACK CICLO 1
-- ============================================================

-- 1. Eliminar todos los datos (orden por FK)
DELETE FROM Libro_Autor;
DELETE FROM Producto_Compra;
DELETE FROM Ejemplar;
DELETE FROM Edicion;
DELETE FROM Compra;
DELETE FROM Libro;
DELETE FROM Administrador;
DELETE FROM Categoria;
DELETE FROM Autor;
DELETE FROM Editorial;
DELETE FROM Proveedor;
DELETE FROM Usuario;
COMMIT;

-- 2. Resetear secuencias
DROP SEQUENCE SQ_CATEGORIA;
DROP SEQUENCE SQ_AUTOR;
DROP SEQUENCE SQ_EDITORIAL;
DROP SEQUENCE SQ_LIBRO;
DROP SEQUENCE SQ_EDICION;
DROP SEQUENCE SQ_EJEMPLAR;
DROP SEQUENCE SQ_PROVEEDOR;
DROP SEQUENCE SQ_COMPRA;
DROP SEQUENCE SQ_PROD_COMP;
DROP SEQUENCE SQ_USUARIO;

CREATE SEQUENCE SQ_CATEGORIA  START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE SQ_AUTOR      START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE SQ_EDITORIAL  START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE SQ_LIBRO      START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE SQ_EDICION    START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE SQ_EJEMPLAR   START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE SQ_PROVEEDOR  START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE SQ_COMPRA     START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE SQ_PROD_COMP  START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE SQ_USUARIO    START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
