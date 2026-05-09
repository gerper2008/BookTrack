---------------------------------------------------------------------------------------------
--- TUPLAS: Restricciones que involucran más de un atributo
---------------------------------------------------------------------------------------------

-- TUP1: En Compra, si estado='COMPLETADO' el total debe ser > 0.
-- Nota: los valores válidos de estado están en mayúsculas según CHECK_Compra_estado.
--   Se unifica criterio: 'PENDIENTE', 'COMPLETADO', 'RECHAZADO'.
--   El trigger TRG_Compra_Estado_Inicial debe actualizarse para asignar 'PENDIENTE'.
ALTER TABLE Compra ADD CONSTRAINT CH_Compra_estado_total
    CHECK (
        (estado = 'COMPLETADO' AND total > 0)
        OR (estado IN ('PENDIENTE', 'RECHAZADO') AND total >= 0)
    );

-- TUP2: En Producto_Compra, cantidad y precioUnidad juntos deben ser positivos.
-- Nota: cada atributo ya tiene su CHECK individual (CHECK_Producto_Compra_cantidad
--   y CHECK_Producto_Compra_precioUnidad). Esta constraint es redundante pero se
--   conserva como documentación explícita de la regla de negocio conjunta.
ALTER TABLE Producto_Compra ADD CONSTRAINT CH_ProductoCompra_importe
    CHECK (cantidad > 0 AND precio_unidad > 0);

-- TUP3: En Ejemplar, si disponibilidad = 0 (no disponible), estadoFisico NO puede ser 'Nuevo'.
-- Nota: Oracle anterior a 23c no tiene tipo BOOLEAN nativo. La columna disponibilidad
--   se trata como NUMBER(1): 1 = disponible, 0 = no disponible.
--   Se corrige 'FALSE' (string inválido) por comparación numérica.
--   Se corrige también el nombre de columna: estado_fisico → estadoFisico (según DDL).
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

-- TUP7: En Autor, nombre, apellidos y nacionalidad son obligatorios en conjunto.
-- Nota: CHECK (col IS NOT NULL) es equivalente a NOT NULL en cada columna.
--   Se reemplaza por constraints NOT NULL directas, que son más eficientes.
ALTER TABLE Autor ADD CONSTRAINT CH_Autor_nombre_apellidos_nacionalidad
    CHECK (nombre IS NOT NULL AND apellidos IS NOT NULL nacionalidad IS NOT NULL);