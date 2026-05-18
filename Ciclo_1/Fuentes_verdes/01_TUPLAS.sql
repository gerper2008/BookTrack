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

-- TUP3: Ejemplar no disponible (FALSE) no puede ser 'Nuevo'
ALTER TABLE Ejemplar ADD CONSTRAINT CH_Ejemplar_nuevo_disponible
    CHECK (NOT (disponibilidad = 0 AND estadoFisico = 'Nuevo'));

-- TUP4: Edicion.anio >= fecha_publicacion del Libro → implementado como trigger

-- TUP5: Libro: titulo e idioma obligatorios juntos
ALTER TABLE Libro MODIFY titulo VARCHAR2(60) NOT NULL;
ALTER TABLE Libro MODIFY idioma VARCHAR2(30) NOT NULL;

-- TUP6: Autor: nombre, apellidos y nacionalidad obligatorios
-- NOTA: Misma razón que TUP5 — IS NOT NULL en CHECK no funciona en Oracle.
ALTER TABLE Autor MODIFY nombre VARCHAR2(60) NOT NULL;
ALTER TABLE Autor MODIFY apellidos VARCHAR2(60) NOT NULL;
ALTER TABLE Autor MODIFY nacionalidad VARCHAR2(50) NOT NULL;
