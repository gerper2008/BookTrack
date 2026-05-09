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
