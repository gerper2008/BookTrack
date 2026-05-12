---------------------------------------------------------------------------------------------
--- TUPLAS: Restricciones que involucran más de un atributo
---------------------------------------------------------------------------------------------
-- TUP1: Compra completada debe tener total > 0
ALTER TABLE Compra ADD CONSTRAINT CH_Compra_estado_total
    CHECK (
        (estado = 'COMPLETADO' AND total > 0)
        OR (estado IN ('PENDIENTE', 'RECHAZADO') AND total >= 0)
    );

-- TUP2: Producto_Compra: cantidad y precioUnidad positivos en conjunto
ALTER TABLE Producto_Compra ADD CONSTRAINT CH_ProductoCompra_importe
    CHECK (cantidad > 0 AND precioUnidad > 0);

-- TUP3: Ejemplar no disponible ('N') no puede ser 'Nuevo'
ALTER TABLE Ejemplar ADD CONSTRAINT CH_Ejemplar_nuevo_disponible
    CHECK (NOT (disponibilidad = '0' AND estadoFisico = 'Nuevo'));

-- TUP4: Edicion.anio >= fecha_publicacion del Libro → implementado como trigger

-- TUP5: Libro: titulo e idioma obligatorios juntos
ALTER TABLE Libro ADD CONSTRAINT CH_Libro_titulo_idioma
    CHECK (titulo IS NOT NULL AND idioma IS NOT NULL);

-- TUP6: Autor: nombre, apellidos y nacionalidad obligatorios
ALTER TABLE Autor ADD CONSTRAINT CH_Autor_identidad
    CHECK (nombre IS NOT NULL AND apellidos IS NOT NULL AND nacionalidad IS NOT NULL);

