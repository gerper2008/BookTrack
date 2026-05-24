-- ============================================================
-- CRUDOK - DATOS CORRECTOS (IDEMPOTENTE / RE-EJECUTABLE)
-- ============================================================
-- Objetivo:
-- - Ejecutar sin romper por duplicados en corridas repetidas.
-- - Evitar variables de sustitución (&...) en SQL Developer.
-- - Mantener pruebas válidas de inserción usando paquetes CRUD.
--
-- Recomendación de orden previo:
-- 1) CRUD_Ciclo2/01_CRUDE_Especificacion_C2.sql
-- 2) CRUD_Ciclo2/02_CRUDI_Implementacion_C2.sql
--
-- Prerequisito de datos:
-- - Ejecutar previamente CRUDOK del Ciclo 1 para tener
--   Usuarios (USR), Ejemplares (EJM) y Clientes disponibles.
-- ============================================================

-- ============================================================
-- 1) PRESTAMOS
-- ============================================================
BEGIN
    PC_PRESTAMO.AD_PRESTAMO('USR001', 'EJM001', TO_DATE('2025-01-10', 'YYYY-MM-DD'));
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20201 THEN RAISE; END IF;
END;
/
BEGIN
    PC_PRESTAMO.AD_PRESTAMO('USR002', 'EJM002', TO_DATE('2025-02-14', 'YYYY-MM-DD'));
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20201 THEN RAISE; END IF;
END;
/
BEGIN
    PC_PRESTAMO.AD_PRESTAMO('USR003', 'EJM003', TO_DATE('2025-03-05', 'YYYY-MM-DD'));
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20201 THEN RAISE; END IF;
END;
/

-- ============================================================
-- 2) DEVOLUCIONES
-- ============================================================
BEGIN
    PC_DEVOLUCION.AD_DEVOLUCION('PR001', TRUE, 'Libro en buen estado');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20211 THEN RAISE; END IF;
END;
/
BEGIN
    PC_DEVOLUCION.AD_DEVOLUCION('PR002', FALSE, 'Portada con rayones');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20211 THEN RAISE; END IF;
END;
/
BEGIN
    PC_DEVOLUCION.AD_DEVOLUCION('PR003', FALSE, 'Paginas humedas');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20211 THEN RAISE; END IF;
END;
/

-- ============================================================
-- 3) MULTAS
-- ============================================================
BEGIN
    PC_MULTA.AD_MULTA('DV002', 'Daño', 45000);
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20221 THEN RAISE; END IF;
END;
/
BEGIN
    PC_MULTA.AD_MULTA('DV003', 'Retraso', 9000);
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20221 THEN RAISE; END IF;
END;
/
BEGIN
    PC_MULTA.AD_MULTA('DV002', 'Otro', 15000);
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20221 THEN RAISE; END IF;
END;
/

-- ============================================================
-- 4) PAGOS
-- ============================================================
BEGIN
    PC_PAGO.AD_PAGO('MT001', 45000, 'Efectivo');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20231 THEN RAISE; END IF;
END;
/
BEGIN
    PC_PAGO.AD_PAGO('MT002', 9000, 'Tarjeta');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20231 THEN RAISE; END IF;
END;
/
BEGIN
    PC_PAGO.AD_PAGO('MT003', 15000, 'Transferencia');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -20231 THEN RAISE; END IF;
END;
/
