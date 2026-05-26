-- ============================================================
-- CASO DE PRUEBA 1: Laura registra nuevos ejemplares en el catálogo
--
-- Historia:
-- Laura es administradora de la biblioteca. Acaba de recibir
-- una donación de tres ejemplares de "El Arte de la Guerra".
-- El libro, su edición (EDI051) y el autor ya fueron
-- registrados previamente en el sistema. Laura solo necesita
-- ingresar los tres ejemplares físicos que llegaron, verificar
-- que quedaron bien ubicados, y corregir uno que quedó mal.
-- ============================================================


-- Los tres ejemplares físicos llegan a la biblioteca
-- Dos en buen estado para el Estante F-01 y uno en Estante F-02
BEGIN PC_EJEMPLAR.AD_EJEMPLAR('EDI051', 'Nuevo', '1', 'Estante F-01', TO_DATE('20/05/2025', 'DD/MM/YYYY')); END;
/
BEGIN PC_EJEMPLAR.AD_EJEMPLAR('EDI051', 'Nuevo', '1', 'Estante F-01', TO_DATE('20/05/2025', 'DD/MM/YYYY')); END;
/
BEGIN PC_EJEMPLAR.AD_EJEMPLAR('EDI051', 'Bueno', '1', 'Estante F-02', TO_DATE('20/05/2025', 'DD/MM/YYYY')); END;
/

-- Laura consulta los ejemplares de esa edición para confirmar
DECLARE cur SYS_REFCURSOR;
BEGIN
    cur := PC_EJEMPLAR.CO_EJEMPLAR_EDICION('EDI051');
    DBMS_SQL.RETURN_RESULT(cur);
END;
/

-- Días después Laura nota que el tercer ejemplar quedó mal ubicado
-- Debía ir en Estante F-01 junto a los otros dos, lo corrige
-- Nota: reemplazar EJE003 por el ID real que generó el sistema
BEGIN PC_EJEMPLAR.MOD_EJEMPLAR('EJE003', 'Bueno', '1', 'Estante F-01'); END;
/

-- Confirma que la corrección quedó aplicada
DECLARE cur SYS_REFCURSOR;
BEGIN
    cur := PC_EJEMPLAR.CO_EJEMPLAR_EDICION('EDI051');
    DBMS_SQL.RETURN_RESULT(cur);
END;
/