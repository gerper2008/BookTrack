

-- ============================================================
-- CRUDOK - INGRESO DE DATOS CORRECTOS
-- ============================================================

-- OK-01: Insertar usuario administrador
BEGIN PC_USUARIO.AD_USUARIO('admin@booktrack.com', 'Administrador', 'Laura', 'Mendez', '3156789012'); END;
/
-- OK-02: Registrar administrador (permisos segun CHECK: 'Solo Lectura', 'Operativo', 'Total')
BEGIN PC_USUARIO.AD_ADMINISTRADOR('USR001', 'Total', 'Sede Central'); END;
/
-- OK-03: Modificar administrador cambiando permisos
BEGIN PC_USUARIO.MOD_ADMINISTRADOR('USR001', 'Operativo', 'Sede Norte'); END;
/
-- OK-04: Consultar usuarios por rol
DECLARE cur SYS_REFCURSOR; BEGIN cur := PC_USUARIO.CO_USUARIO_ROL('Administrador'); END;
/
-- OK-05: Consultar todos los administradores
DECLARE cur SYS_REFCURSOR; BEGIN cur := PC_USUARIO.CO_ADMINISTRADORES(); END;
/
 
-- A partir de aqui los TRG_SOLO_ADMIN_* dejan pasar porque USR001 esta en Administrador
 
-- OK-06: Insertar categoria valida
BEGIN PC_CATEGORIA.AD_CATEGORIA('Ficcion', 'Libros de genero ficcion literaria'); END;
/
-- OK-07: Insertar categoria sin descripcion (campo opcional)
BEGIN PC_CATEGORIA.AD_CATEGORIA('Ciencia', NULL); END;
/
-- OK-08: Consultar todas las categorias
DECLARE cur SYS_REFCURSOR; BEGIN cur := PC_CATEGORIA.CO_CATEGORIA(); END;
/
 
-- OK-09: Insertar autor valido completo
BEGIN PC_AUTOR.AD_AUTOR('Gabriel', 'Garcia Marquez', 'M', 'Colombiana'); END;
/
-- OK-10: Insertar autor sin genero (campo opcional)
BEGIN PC_AUTOR.AD_AUTOR('J.K.', 'Rowling', NULL, 'Britanica'); END;
/
-- OK-11: Consultar todos los autores
DECLARE cur SYS_REFCURSOR; BEGIN cur := PC_AUTOR.CO_AUTOR(); END;
/
 
-- OK-12: Insertar editorial valida
BEGIN PC_EDITORIAL.AD_EDITORIAL('Planeta', 'contacto@planeta.com', '3001234567', 'Colombia'); END;
/
-- OK-13: Insertar segunda editorial
BEGIN PC_EDITORIAL.AD_EDITORIAL('Alfaguara', 'info@alfaguara.com', '3009876543', 'Espana'); END;
/
-- OK-14: Modificar editorial existente (correo diferente para no violar UNIQUE)
BEGIN PC_EDITORIAL.MOD_EDITORIAL('EDT001', 'Planeta', 'planeta_nuevo@planeta.com', '3001234567', 'Colombia'); END;
/
-- OK-15: Consultar todas las editoriales
DECLARE cur SYS_REFCURSOR; BEGIN cur := PC_EDITORIAL.CO_EDITORIAL(); END;
/
 
-- OK-16: Insertar libro valido
BEGIN PC_LIBRO.AD_LIBRO('CAT001', 'Cien Anos de Soledad', 'Novela del realismo magico', TO_DATE('1967-05-30','YYYY-MM-DD'), 'Espanol'); END;
/
-- OK-17: Insertar libro sin descripcion (campo opcional)
BEGIN PC_LIBRO.AD_LIBRO('CAT001', 'El Amor en los Tiempos del Colera', NULL, TO_DATE('1985-01-01','YYYY-MM-DD'), 'Espanol'); END;
/
-- OK-18: Asociar libro con autor
BEGIN PC_LIBRO.AD_LIBRO_AUTOR('LIB001', 'AUT001'); END;
/
-- OK-19: Consultar libros por categoria
DECLARE cur SYS_REFCURSOR; BEGIN cur := PC_LIBRO.CO_LIBRO_CAT('CAT001'); END;
/
 
-- OK-20: Insertar edicion de libro
BEGIN PC_EDICION.AD_EDICION('LIB001', 'EDC001', TO_DATE('2000-01-01','YYYY-MM-DD'), 471); END;
/
-- OK-21: Modificar edicion existente
BEGIN PC_EDICION.MOD_EDICION('EDI001', 'LIB001', 'EDC001', TO_DATE('2005-01-01','YYYY-MM-DD'), 500); END;
/
-- OK-23: Insertar ejemplar de edicion
BEGIN PC_EJEMPLAR.AD_EJEMPLAR('EDI001', 'Bueno', 'S', 'Estante Principal', TO_DATE('2023-01-15','YYYY-MM-DD')); END;
/
-- OK-24: Insertar segundo ejemplar
BEGIN PC_EJEMPLAR.AD_EJEMPLAR('EDI001', 'Nuevo', 'S', 'Estante Secundario', TO_DATE('2024-06-01','YYYY-MM-DD')); END;
/
-- OK-25: Modificar estado fisico de ejemplar
BEGIN PC_EJEMPLAR.MOD_EJEMPLAR('EJE001', 'Desgastado', 'S', 'Estante Principal'); END;
/
-- OK-26: Insertar proveedor valido
BEGIN PC_PROVEEDOR.AD_PROVEEDOR('Carlos', 'Lopez', 'carlos@distrilibros.com', 'Distrilibros SAS', '3101234567'); END;
/
-- OK-26b: Insertar compra valida (necesaria para OK-28 y OK-29)
BEGIN PC_COMPRA.AD_COMPRA('PRV001', TO_DATE('2024-03-01','YYYY-MM-DD'), 850000, 'Pendiente'); END;
/
-- OK-27: Modificar proveedor existente
BEGIN PC_PROVEEDOR.MOD_PROVEEDOR('PRV001', 'Carlos', 'Lopez Ruiz', 'carlosnuevo@distrilibros.com', 'Distrilibros SAS', '3109876543'); END;
/
-- OK-28: Agregar producto a compra
BEGIN PC_COMPRA.AD_PRODUCTO_COMPRA('COM001', 'LIB001', 5, 170000); END;
/
-- OK-29: Modificar estado de compra
BEGIN PC_COMPRA.MOD_COMPRA('COM001', TO_DATE('2024-03-01','YYYY-MM-DD'), 850000, 'Completada'); END;
/
-- OK-30: Consultar productos de una compra
DECLARE cur SYS_REFCURSOR; BEGIN cur := PC_COMPRA.CO_PRODUCTOS_COMPRA('COM001'); END;
/

