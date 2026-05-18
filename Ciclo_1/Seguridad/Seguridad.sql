---------------------------------------------------------------------------------------------
--- SEGURIDAD: Definición de roles y permisos
---------------------------------------------------------------------------------------------

-- ============================================================
-- 1. CREACIÓN DE ROL (solo si no existe)
-- Usa EXCEPTION en lugar de dba_roles para evitar ORA-00942
-- en usuarios sin privilegios DBA.
-- ============================================================
BEGIN
    EXECUTE IMMEDIATE 'CREATE ROLE ROL_ADMINISTRADOR';
    DBMS_OUTPUT.PUT_LINE('Rol ROL_ADMINISTRADOR creado.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1921 THEN
            DBMS_OUTPUT.PUT_LINE('Rol ROL_ADMINISTRADOR ya existia, se omite creacion.');
        ELSE
            RAISE;
        END IF;
END;
/
 
-- ============================================================
-- 2. PERMISOS SOBRE TABLAS
-- ============================================================
GRANT SELECT, INSERT, UPDATE, DELETE ON Usuario          TO ROL_ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON Administrador    TO ROL_ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON Categoria        TO ROL_ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON Libro            TO ROL_ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON Libro_Autor      TO ROL_ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON Autor            TO ROL_ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON Editorial        TO ROL_ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON Edicion          TO ROL_ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON Ejemplar         TO ROL_ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON Proveedor        TO ROL_ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON Compra           TO ROL_ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON Producto_Compra  TO ROL_ADMINISTRADOR;
 
-- ============================================================
-- 3. PERMISO SOBRE PK_ADMINISTRADOR
-- ============================================================
BEGIN
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON PK_ADMINISTRADOR TO ROL_ADMINISTRADOR';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -4042 THEN
            NULL;
        ELSE
            RAISE;
        END IF;
END;
/
 
BEGIN
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON PC_SEGURIDAD TO ROL_ADMINISTRADOR';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -4042 THEN
            NULL;
        ELSE
            RAISE;
        END IF;
END;
/