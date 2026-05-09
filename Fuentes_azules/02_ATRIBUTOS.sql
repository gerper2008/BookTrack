---------------------------------------------------------------------------------------------
--- PERSISTENCIA: ATRIBUTOS -> Definición de restricciones para un único atributo
---------------------------------------------------------------------------------------------

-- Usuario
ALTER TABLE Usuario ADD CONSTRAINT CHECK_Usuario_nombre CHECK (REGEXP_LIKE(nombre, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Usuario ADD CONSTRAINT CHECK_Usuario_apellidos CHECK (REGEXP_LIKE(apellidos, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Usuario ADD CONSTRAINT CHECK_Usuario_correo CHECK (REGEXP_LIKE(correo, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'));
ALTER TABLE Usuario ADD CONSTRAINT CHECK_Usuario_telefono CHECK (REGEXP_LIKE(telefono, '^[0-9]{10}$'));
ALTER TABLE Usuario ADD CONSTRAINT CHECK_Usuario_rol CHECK (rol IN ('Administrador', 'Lector', 'Bibliotecario'));

-- Administrador
ALTER TABLE Administrador ADD CONSTRAINT CHECK_Administrador_permisos CHECK (permisos IN ('Solo Lectura', 'Operativo', 'Total'));
ALTER TABLE Administrador ADD CONSTRAINT CHECK_Administrador_sede CHECK (REGEXP_LIKE(sede, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));

-- Categoria
ALTER TABLE Categoria ADD CONSTRAINT CHECK_Categoria_nombre CHECK (REGEXP_LIKE(nombre, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Categoria ADD CONSTRAINT CHECK_Categoria_descripcion CHECK (REGEXP_LIKE(descripcion, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));

-- Autor
ALTER TABLE Autor ADD CONSTRAINT CHECK_Autor_nombre CHECK (REGEXP_LIKE(nombre, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Autor ADD CONSTRAINT CHECK_Autor_apellidos CHECK (REGEXP_LIKE(apellidos, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Autor ADD CONSTRAINT CHECK_Autor_genero CHECK (genero IN ('Masculino', 'Femenino', 'Otro'));
ALTER TABLE Autor ADD CONSTRAINT CHECK_Autor_nacionalidad CHECK (REGEXP_LIKE(nacionalidad, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));

-- Libro
ALTER TABLE Libro ADD CONSTRAINT CHECK_Libro_titulo CHECK (REGEXP_LIKE(titulo, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Libro ADD CONSTRAINT CHECK_Libro_idioma CHECK (REGEXP_LIKE(idioma, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Libro ADD CONSTRAINT CHECK_Libro_descripcion CHECK (REGEXP_LIKE(descripcion, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Libro ADD CONSTRAINT CHECK_Libro_fecha_publicacion CHECK (fecha_publicacion <= TO_DATE('31/12/2025', 'DD/MM/YYYY'));

-- Ejemplar
ALTER TABLE Ejemplar ADD CONSTRAINT CHECK_Ejemplar_localizacion CHECK (REGEXP_LIKE(localizacion, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Ejemplar ADD CONSTRAINT CHECK_Ejemplar_fecha_adquisicion CHECK (fecha_adquisicion <= TO_DATE('31/12/2025', 'DD/MM/YYYY'));
ALTER TABLE Ejemplar ADD CONSTRAINT CHECK_Ejemplar_estado_fisico CHECK (estado_fisico IN ('Desgastado', 'Bueno', 'Dañado', 'Restaurado', 'Perdido', 'Nuevo'));

-- Edicion
ALTER TABLE Edicion ADD CONSTRAINT CHECK_Edicion_año CHECK (año <= TO_DATE('31/12/2025', 'DD/MM/YYYY'));
ALTER TABLE Edicion ADD CONSTRAINT CHECK_Edicion_paginas CHECK (paginas > 0);

-- Editorial
ALTER TABLE Editorial ADD CONSTRAINT CHECK_Editorial_correo CHECK (REGEXP_LIKE(correo, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'));
ALTER TABLE Editorial ADD CONSTRAINT CHECK_Editorial_telefono CHECK (REGEXP_LIKE(telefono, '^[0-9]{10}$'));
ALTER TABLE Editorial ADD CONSTRAINT CHECK_Editorial_nombre CHECK (REGEXP_LIKE(nombre, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Editorial ADD CONSTRAINT CHECK_Editorial_pais CHECK (REGEXP_LIKE(pais, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));

-- Producto_Compra
ALTER TABLE Producto_Compra ADD CONSTRAINT CHECK_Producto_Compra_cantidad CHECK (cantidad > 0);
ALTER TABLE Producto_Compra ADD CONSTRAINT CHECK_Producto_Compra_precio_unidad CHECK (precio_unidad > 0.0);

-- Compra
ALTER TABLE Compra ADD CONSTRAINT CHECK_Compra_fecha CHECK (fecha <= TO_DATE('31/12/2025', 'DD/MM/YYYY'));
ALTER TABLE Compra ADD CONSTRAINT CHECK_Compra_total CHECK (total > 0.0);
ALTER TABLE Compra ADD CONSTRAINT CHECK_Compra_estado CHECK (estado IN ('PENDIENTE', 'COMPLETADO', 'RECHAZADO'));

-- Proveedor
ALTER TABLE Proveedor ADD CONSTRAINT CHECK_Proveedor_correo CHECK (REGEXP_LIKE(correo, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'));
ALTER TABLE Proveedor ADD CONSTRAINT CHECK_Proveedor_nombre CHECK (REGEXP_LIKE(nombre, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Proveedor ADD CONSTRAINT CHECK_Proveedor_apellidos CHECK (REGEXP_LIKE(apellidos, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Proveedor ADD CONSTRAINT CHECK_Proveedor_empresa CHECK (REGEXP_LIKE(empresa, '^[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+$'));
ALTER TABLE Proveedor ADD CONSTRAINT CHECK_Proveedor_telefono CHECK (REGEXP_LIKE(telefono, '^[0-9]{10}$'));
