-- ============================================================
-- CASO DE PRUEBA 2: Laura registra productos a una compra existente
--
-- Historia:
-- Laura necesita reponer el inventario de dos títulos muy
-- solicitados. Contacta a Beatriz Muñoz (PRV038), proveedora
-- ya registrada, que tiene una orden abierta COM038 en estado
-- PENDIENTE. Laura le agrega 4 ejemplares de "Redondillas"
-- (LIB047) y 3 de "El Sonido y la Furia" (LIB049), revisa
-- el detalle y cuando llega la mercancía marca la compra
-- como COMPLETADO.
-- ============================================================


-- Laura agrega los productos a la orden COM038 que ya existe
-- 4 ejemplares de "Redondillas" de Sor Juana a $95.000 c/u
BEGIN PC_COMPRA.AD_PRODUCTO_COMPRA('COM038', 'LIB047', 4, 95000.00); END;
/

-- 3 ejemplares de "El Sonido y la Furia" a $130.000 c/u
BEGIN PC_COMPRA.AD_PRODUCTO_COMPRA('COM038', 'LIB049', 3, 130000.00); END;
/

-- Laura revisa el detalle de la orden antes de confirmarla
DECLARE cur SYS_REFCURSOR;
BEGIN
    cur := PC_COMPRA.CO_PRODUCTOS_COMPRA('COM038');
    DBMS_SQL.RETURN_RESULT(cur);
END;
/

-- Los libros llegan en perfectas condiciones
-- Laura actualiza la fecha y marca la compra como COMPLETADO
BEGIN PC_COMPRA.MOD_COMPRA('COM038', TO_DATE('30/05/2025', 'DD/MM/YYYY'), 770000.00, 'COMPLETADO'); END;
/

-- Confirma el estado final de la compra
DECLARE cur SYS_REFCURSOR;
BEGIN
    cur := PC_COMPRA.CO_COMPRA;
    DBMS_SQL.RETURN_RESULT(cur);
END;
/