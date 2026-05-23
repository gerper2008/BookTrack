---------------------------------------------------------------------------------------------
--- CONSULTAS: Consulta SQL con identificador
---------------------------------------------------------------------------------------------

-- [C01] Listar todos los préstamos activos con nombre del cliente y ejemplar
SELECT
    p.id            AS ID_Prestamo,
    u.nombre        AS Nombre_Cliente,
    u.apellidos     AS Apellidos_Cliente,
    e.id            AS ID_Ejemplar,
    p.fechaPrestamo AS Fecha_Prestamo,
    p.diasRetraso   AS Dias_Retraso
FROM Prestamo p
JOIN Cliente    c ON c.idUsuario = p.idCliente
JOIN Usuario    u ON u.id        = c.idUsuario
JOIN Ejemplar   e ON e.id        = p.idEjemplar;

-- [C02] Listar devoluciones con estado de entrega y préstamo relacionado
SELECT
    d.id              AS ID_Devolucion,
    d.idPrestamo      AS ID_Prestamo,
    d.fechaEstimada   AS Fecha_Estimada,
    d.estadoEntrega   AS Entregado,
    d.observaciones   AS Observaciones
FROM Devolucion d;

-- [C03] Multas pendientes por cliente
SELECT
    u.nombre        AS Nombre_Cliente,
    u.apellidos     AS Apellidos_Cliente,
    m.id            AS ID_Multa,
    m.motivo        AS Motivo,
    m.montoAcumulado AS Monto,
    m.estado        AS Estado_Multa
FROM Multa  m
JOIN Cliente  c ON c.idUsuario = m.idCliente
JOIN Usuario  u ON u.id        = c.idUsuario
WHERE m.estado = 'Pendiente';

-- [C04] Pagos realizados con método y fecha
SELECT
    p.id           AS ID_Pago,
    u.nombre       AS Cliente,
    m.id           AS ID_Multa,
    p.metodoPago   AS Metodo,
    p.estado       AS Estado_Pago,
    p.fechaPago    AS Fecha_Pago
FROM Pago     p
JOIN Multa    m ON m.id        = p.idMulta
JOIN Cliente  c ON c.idUsuario = p.idCliente
JOIN Usuario  u ON u.id        = c.idUsuario;

-- [C05] Bibliotecarios disponibles en turno de mañana
SELECT
    u.nombre        AS Nombre,
    u.apellidos     AS Apellidos,
    b.jornada       AS Jornada,
    b.permisos      AS Permisos
FROM Bibliotecario b
JOIN Usuario u ON u.id = b.idUsuario
WHERE b.jornada = 'Mañana'
  AND b.disponibilidad = 1;
