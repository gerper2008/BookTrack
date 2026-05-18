---------------------------------------------------------------------------------------------
--- SEGURIDAD: Definición de roles y permisos
---------------------------------------------------------------------------------------------

-- ============================================================
-- 1. CREACIÓN DE ROLES
-- ============================================================
CREATE ROLE ROL_ADMINISTRADOR;
CREATE ROLE ROL_BIBLIOTECARIO;
CREATE ROLE ROL_CLIENTE;

-- ============================================================
-- 2. PERMISOS SOBRE TABLAS
-- ============================================================

-- ROL_ADMINISTRADOR: control total sobre todas las tablas del ciclo 1
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

-- ROL_BIBLIOTECARIO: solo lectura sobre catálogo y ejemplares en ciclo 1
GRANT SELECT ON Categoria        TO ROL_BIBLIOTECARIO;
GRANT SELECT ON Libro            TO ROL_BIBLIOTECARIO;
GRANT SELECT ON Libro_Autor      TO ROL_BIBLIOTECARIO;
GRANT SELECT ON Autor            TO ROL_BIBLIOTECARIO;
GRANT SELECT ON Editorial        TO ROL_BIBLIOTECARIO;
GRANT SELECT ON Edicion          TO ROL_BIBLIOTECARIO;
GRANT SELECT ON Ejemplar         TO ROL_BIBLIOTECARIO;

-- ROL_CLIENTE: solo lectura sobre catálogo en ciclo 1
GRANT SELECT ON Categoria        TO ROL_CLIENTE;
GRANT SELECT ON Libro            TO ROL_CLIENTE;
GRANT SELECT ON Autor            TO ROL_CLIENTE;
GRANT SELECT ON Editorial        TO ROL_CLIENTE;
GRANT SELECT ON Edicion          TO ROL_CLIENTE;
GRANT SELECT ON Ejemplar         TO ROL_CLIENTE;

-- ============================================================
-- 3. PERMISOS SOBRE EL PAQUETE DE ACTORES
-- ============================================================
GRANT EXECUTE ON PK_ADMINISTRADOR TO ROL_ADMINISTRADOR;

-- ============================================================
-- 4. PERMISOS SOBRE PC_SEGURIDAD
-- ============================================================
GRANT EXECUTE ON PC_SEGURIDAD TO ROL_ADMINISTRADOR;
GRANT EXECUTE ON PC_SEGURIDAD TO ROL_BIBLIOTECARIO;
GRANT EXECUTE ON PC_SEGURIDAD TO ROL_CLIENTE;
