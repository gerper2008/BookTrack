---------------------------------------------------------------------------------------------
--- AUTOMATIZACIÓN: XDISPARADORES -> Eliminación de disparadores y secuencias
---------------------------------------------------------------------------------------------

-- [Disparadores de IDs]
DROP TRIGGER TRG_Prestamo_ID;
DROP TRIGGER TRG_Devolucion_ID;
DROP TRIGGER TRG_Multa_ID;
DROP TRIGGER TRG_Pago_ID;

-- [Disparadores de validación]
DROP TRIGGER TRG_Devolucion_Fecha;

-- [Disparadores de automatización]
DROP TRIGGER TRG_Multa_RetrasoAuto;
DROP TRIGGER TRG_Multa_PagadaEstado;
DROP TRIGGER TRG_Prestamo_EjemplarOcupar;
DROP TRIGGER TRG_Devolucion_EjemplarLiberar;
DROP TRIGGER TRG_Cliente_EstadoMoroso;

-- [Secuencias]
DROP SEQUENCE SEQ_Prestamo;
DROP SEQUENCE SEQ_Devolucion;
DROP SEQUENCE SEQ_Multa;
DROP SEQUENCE SEQ_Pago;
