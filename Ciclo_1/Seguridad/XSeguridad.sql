---------------------------------------------------------------------------------------------
--- X SEGURIDAD: Eliminación de paquetes de actores, roles y permisos
---------------------------------------------------------------------------------------------

-- ============================================================
-- 1. REVOCAR PERMISOS SOBRE PAQUETES
-- ============================================================
REVOKE EXECUTE ON PK_ADMINISTRADOR FROM ROL_ADMINISTRADOR;

REVOKE EXECUTE ON PC_SEGURIDAD FROM ROL_ADMINISTRADOR;
REVOKE EXECUTE ON PC_SEGURIDAD FROM ROL_BIBLIOTECARIO;
REVOKE EXECUTE ON PC_SEGURIDAD FROM ROL_CLIENTE;

-- ============================================================
-- 2. REVOCAR PERMISOS SOBRE TABLAS — ROL_ADMINISTRADOR
-- ============================================================
REVOKE SELECT, INSERT, UPDATE, DELETE ON Usuario         FROM ROL_ADMINISTRADOR;
REVOKE SELECT, INSERT, UPDATE, DELETE ON Administrador   FROM ROL_ADMINISTRADOR;
REVOKE SELECT, INSERT, UPDATE, DELETE ON Categoria       FROM ROL_ADMINISTRADOR;
REVOKE SELECT, INSERT, UPDATE, DELETE ON Libro           FROM ROL_ADMINISTRADOR;
REVOKE SELECT, INSERT, UPDATE, DELETE ON Libro_Autor     FROM ROL_ADMINISTRADOR;
REVOKE SELECT, INSERT, UPDATE, DELETE ON Autor           FROM ROL_ADMINISTRADOR;
REVOKE SELECT, INSERT, UPDATE, DELETE ON Editorial       FROM ROL_ADMINISTRADOR;
REVOKE SELECT, INSERT, UPDATE, DELETE ON Edicion         FROM ROL_ADMINISTRADOR;
REVOKE SELECT, INSERT, UPDATE, DELETE ON Ejemplar        FROM ROL_ADMINISTRADOR;
REVOKE SELECT, INSERT, UPDATE, DELETE ON Proveedor       FROM ROL_ADMINISTRADOR;
REVOKE SELECT, INSERT, UPDATE, DELETE ON Compra          FROM ROL_ADMINISTRADOR;
REVOKE SELECT, INSERT, UPDATE, DELETE ON Producto_Compra FROM ROL_ADMINISTRADOR;

-- ============================================================
-- 3. REVOCAR PERMISOS SOBRE TABLAS — ROL_BIBLIOTECARIO
-- ============================================================
REVOKE SELECT ON Categoria   FROM ROL_BIBLIOTECARIO;
REVOKE SELECT ON Libro       FROM ROL_BIBLIOTECARIO;
REVOKE SELECT ON Libro_Autor FROM ROL_BIBLIOTECARIO;
REVOKE SELECT ON Autor       FROM ROL_BIBLIOTECARIO;
REVOKE SELECT ON Editorial   FROM ROL_BIBLIOTECARIO;
REVOKE SELECT ON Edicion     FROM ROL_BIBLIOTECARIO;
REVOKE SELECT ON Ejemplar    FROM ROL_BIBLIOTECARIO;

-- ============================================================
-- 4. REVOCAR PERMISOS SOBRE TABLAS — ROL_CLIENTE
-- ============================================================
REVOKE SELECT ON Categoria FROM ROL_CLIENTE;
REVOKE SELECT ON Libro     FROM ROL_CLIENTE;
REVOKE SELECT ON Autor     FROM ROL_CLIENTE;
REVOKE SELECT ON Editorial FROM ROL_CLIENTE;
REVOKE SELECT ON Edicion   FROM ROL_CLIENTE;
REVOKE SELECT ON Ejemplar  FROM ROL_CLIENTE;

-- ============================================================
-- 5. ELIMINAR PAQUETES
-- ============================================================
DROP PACKAGE PK_ADMINISTRADOR;
DROP PACKAGE PC_SEGURIDAD;

-- ============================================================
-- 6. ELIMINAR ROLES
-- ============================================================
DROP ROLE ROL_ADMINISTRADOR;
DROP ROLE ROL_BIBLIOTECARIO;
DROP ROLE ROL_CLIENTE;
