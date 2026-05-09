---------------------------------------------------------------------------------------------
--- TUPLAS: Restricciones que involucran más de un atributo
---------------------------------------------------------------------------------------------

-- TUP1: En Compra, si estado='COMPLETADO' el total debe ser > 0
ALTER TABLE Compra ADD CONSTRAINT CH_Compra_estado_total
    CHECK (
        (estado = 'COMPLETADO' AND total > 0)
        OR (estado IN ('PENDIENTE', 'RECHAZADO') AND total >= 0)
    );

-- TUP2: En Producto_Compra, cantidad y precio_unidad juntos deben generar un importe válido
ALTER TABLE Producto_Compra ADD CONSTRAINT CH_ProductoCompra_importe
    CHECK (cantidad > 0 AND precio_unidad > 0);

-- TUP3: En Ejemplar, si disponibilidad = FALSE, el estado_fisico NO puede ser 'Nuevo'
ALTER TABLE Ejemplar
ADD CONSTRAINT CH_Ejemplar_nuevo_disponible
CHECK (
    NOT (disponibilidad = 'FALSE' AND estado_fisico = 'Nuevo')
);

-- TUP4: El año de la Edicion no puede ser anterior a la fecha_publicacion del Libro.
--       Se implementa como disparador TRG_Edicion_Validar_Anio (ver sección Disparadores).

-- TUP5: En Autor, nombre, apellidos y nacionalidad deben existir juntos
ALTER TABLE Autor ADD CONSTRAINT CH_Autor_identidad
    CHECK (
        nombre IS NOT NULL AND apellidos IS NOT NULL AND nacionalidad IS NOT NULL
    );

-- TUP6: En Libro, titulo e idioma deben existir juntos
ALTER TABLE Libro ADD CONSTRAINT CH_Libro_titulo_idioma
    CHECK (titulo IS NOT NULL AND idioma IS NOT NULL);
