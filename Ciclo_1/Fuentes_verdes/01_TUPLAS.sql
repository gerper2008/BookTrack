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

-- TUP3: Ejemplar no disponible no puede estar como Nuevo
ALTER TABLE Ejemplar ADD CONSTRAINT CH_Ejemplar_nuevo_disponible
    CHECK (NOT (disponibilidad = 0 AND estadoFisico = 'Nuevo'));

-- TUP4: Edicion.anio >= fecha_publicacion del Libro
-- Implementado mediante trigger