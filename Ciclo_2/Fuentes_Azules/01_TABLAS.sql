---------------------------------------------------------------------------------------------
--- PERSISTENCIA: TABLAS -> Creación de tablas
---------------------------------------------------------------------------------------------

-- [Ciclo 2 - Nuevas entidades: Bibliotecario, Cliente, Prestamo, Devolucion, Multa, Pago]

CREATE TABLE Bibliotecario (
    idUsuario   VARCHAR2(10),
    jornada     VARCHAR2(20),
    permisos    VARCHAR2(30),
    disponibilidad NUMBER(1)
);

CREATE TABLE Cliente (
    idUsuario        VARCHAR2(10),
    estado           VARCHAR2(20),
    fechaVencimiento DATE,
    saldo            NUMBER(10,2)
);

CREATE TABLE Prestamo (
    id              VARCHAR2(10),
    fechaPrestamo   DATE,
    diasRetraso     NUMBER(5,2),
    idBibliotecario VARCHAR2(10),
    idCliente       VARCHAR2(10),
    idEjemplar      VARCHAR2(10)
);

CREATE TABLE Devolucion (
    id             VARCHAR2(10),
    idPrestamo     VARCHAR2(10),
    fechaEstimada  DATE,
    observaciones  VARCHAR2(100),
    estadoEntrega  NUMBER(1)
);

CREATE TABLE Multa (
    id              VARCHAR2(10),
    idDevolucion    VARCHAR2(10),
    idCliente       VARCHAR2(10),
    montoAcumulado  NUMBER(10,2),
    motivo          VARCHAR2(30),
    estado          VARCHAR2(20)
);

CREATE TABLE Pago (
    id          VARCHAR2(10),
    idCliente   VARCHAR2(10),
    idMulta     VARCHAR2(10),
    estado      VARCHAR2(20),
    fechaPago   DATE,
    metodoPago  VARCHAR2(30)
);

---------------------------------------------------------------------------------------------
--- XTABLAS: Eliminación de tablas
---------------------------------------------------------------------------------------------
DROP TABLE Producto_Compra CASCADE CONSTRAINTS;
DROP TABLE Compra CASCADE CONSTRAINTS;
DROP TABLE Ejemplar CASCADE CONSTRAINTS;
DROP TABLE Edicion CASCADE CONSTRAINTS;
DROP TABLE Administrador CASCADE CONSTRAINTS;
DROP TABLE Libro CASCADE CONSTRAINTS;
DROP TABLE Libro_Autor CASCADE CONSTRAINTS;
DROP TABLE Autor CASCADE CONSTRAINTS;
DROP TABLE Categoria CASCADE CONSTRAINTS;
DROP TABLE Editorial CASCADE CONSTRAINTS;
DROP TABLE Proveedor CASCADE CONSTRAINTS;
DROP TABLE Usuario CASCADE CONSTRAINTS;
DROP TABLE Pago CASCADE CONSTRAINTS;
DROP TABLE Multa CASCADE CONSTRAINTS;
DROP TABLE Devolucion CASCADE CONSTRAINTS;
DROP TABLE Prestamo CASCADE CONSTRAINTS;
DROP TABLE Cliente CASCADE CONSTRAINTS;
DROP TABLE Bibliotecario CASCADE CONSTRAINTS;
