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
DROP TABLE PRODUCTO_COMPRA CASCADE CONSTRAINTS;
DROP TABLE COMU_EVIDENCIA CASCADE CONSTRAINTS;
DROP TABLE COMUNICACIONES CASCADE CONSTRAINTS;
DROP TABLE LIBRO_AUTOR CASCADE CONSTRAINTS;
DROP TABLE PRESTAMO CASCADE CONSTRAINTS;
DROP TABLE DEVOLUCION CASCADE CONSTRAINTS;
DROP TABLE MULTA CASCADE CONSTRAINTS;
DROP TABLE PAGO CASCADE CONSTRAINTS;
DROP TABLE COMPRA CASCADE CONSTRAINTS;
DROP TABLE EJEMPLAR CASCADE CONSTRAINTS;
DROP TABLE LIBRO CASCADE CONSTRAINTS;
DROP TABLE AUTOR CASCADE CONSTRAINTS;
DROP TABLE EDITORIAL CASCADE CONSTRAINTS;
DROP TABLE EDICION CASCADE CONSTRAINTS;
DROP TABLE CATEGORIA CASCADE CONSTRAINTS;
DROP TABLE PROVEEDOR CASCADE CONSTRAINTS;
DROP TABLE BIBLIOTECARIO CASCADE CONSTRAINTS;
DROP TABLE ADMINISTRADOR CASCADE CONSTRAINTS;
DROP TABLE CLIENTE CASCADE CONSTRAINTS;
DROP TABLE USUARIO CASCADE CONSTRAINTS;
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

-- Eliminar si ya existen (opcional, para evitar duplicados)
BEGIN
  FOR s IN (SELECT SEQUENCE_NAME FROM USER_SEQUENCES 
            WHERE SEQUENCE_NAME IN (
              'SEQ_CATEGORIA','SEQ_AUTOR','SEQ_EDITORIAL','SEQ_LIBRO',
              'SEQ_EDICION','SEQ_EJEMPLAR','SEQ_PROVEEDOR','SEQ_COMPRA',
              'SEQ_USUARIO'
            )) LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE ' || s.SEQUENCE_NAME;
  END LOOP;
END;
/
