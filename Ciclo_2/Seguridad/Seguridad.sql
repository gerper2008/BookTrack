--------------------------------------------------------------------------------
-- SEGURIDAD: ROLES Y PERMISOS
-- Roles de base de datos alineados con la arquitectura de paquetes:
--   Capa de negocio : PC_PRESTAMO, PC_DEVOLUCION, PC_MULTA, PC_PAGO
--   Capa de actores : pkg_Bibliotecario, pkg_Cliente
--------------------------------------------------------------------------------

-- -------------------------------------------------------
-- 1. CREACION DE ROLES
--    Se usa bloque PL/SQL para tolerar re-ejecuciones:
--    si el rol ya existe (ORA-01921) se continúa sin error.
-- -------------------------------------------------------
BEGIN
    EXECUTE IMMEDIATE 'CREATE ROLE rol_Bibliotecario';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1921 THEN NULL; ELSE RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE ROLE rol_Cliente';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1921 THEN NULL; ELSE RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE ROLE rol_Administrador';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1921 THEN NULL; ELSE RAISE; END IF;
END;
/

-- -------------------------------------------------------
-- 2. PERMISOS SOBRE PAQUETES DE NEGOCIO (capa CRUDI)
--    Solo rol_Administrador ejecuta directamente los PC_*
--    para tareas de mantenimiento y soporte.
-- -------------------------------------------------------
GRANT EXECUTE ON PC_PRESTAMO   TO rol_Administrador;
GRANT EXECUTE ON PC_DEVOLUCION TO rol_Administrador;
GRANT EXECUTE ON PC_MULTA      TO rol_Administrador;
GRANT EXECUTE ON PC_PAGO       TO rol_Administrador;

-- -------------------------------------------------------
-- 3. PERMISOS SOBRE PAQUETES DE ACTORES (capa de seguridad)
--    Bibliotecario: acceso completo a pkg_Bibliotecario
--      (préstamos, devoluciones, multas, pagos y vistas)
--    Cliente: acceso de solo lectura mediante pkg_Cliente
--      (consultas y verificaciones propias)
-- -------------------------------------------------------
GRANT EXECUTE ON pkg_Bibliotecario TO rol_Bibliotecario;
GRANT EXECUTE ON pkg_Cliente       TO rol_Cliente;

-- El bibliotecario también puede usar las consultas del cliente
-- para verificar estado y saldo antes de registrar operaciones.
GRANT EXECUTE ON pkg_Cliente TO rol_Bibliotecario;

-- -------------------------------------------------------
-- 4. ASIGNACION DE ROLES A USUARIOS DE BASE DE DATOS
--    NOTA: reemplazar los nombres de usuario según los
--    usuarios reales creados en la instancia Oracle.
--    Ejecutar por el DBA una vez creados los usuarios.
-- -------------------------------------------------------
-- GRANT rol_Bibliotecario TO <usuario_bibliotecario>;
-- GRANT rol_Cliente        TO <usuario_cliente>;
-- GRANT rol_Administrador  TO <usuario_administrador>;
