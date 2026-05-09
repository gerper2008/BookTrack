---------------------------------------------------------------------------------------------
--- PERSISTENCIA: TABLAS -> Creación de tablas
---------------------------------------------------------------------------------------------
CREATE TABLE Usuario (
    id VARCHAR2(10),
    correo VARCHAR2(50),
    rol VARCHAR2(30),
    nombre VARCHAR2(50),
    apellidos VARCHAR2(50),
    telefono VARCHAR2(10)
);

CREATE TABLE Administrador (
    id_usuario VARCHAR2(10),
    permisos VARCHAR2(30),
    sede VARCHAR2(60)
);

CREATE TABLE Categoria (
    id VARCHAR2(10),
    nombre VARCHAR(50),
    descripcion VARCHAR2(100)
);

CREATE TABLE Autor (
    id VARCHAR2(10),
    nombre VARCHAR2(50),
    apellidos VARCHAR2(50),
    genero VARCHAR2(30),
    nacionalidad VARCHAR2(30)
);

CREATE TABLE Libro (
    id VARCHAR2(10),
    titulo VARCHAR2(40),
    fecha_publicacion DATE,
    idioma VARCHAR2(30),
    descripcion VARCHAR2(100),
    id_categoria VARCHAR2(10)
);

CREATE TABLE Ejemplar (
    id VARCHAR2(10),
    estado_fisico VARCHAR2(30),
    disponibilidad CHAR(1),
    localizacion VARCHAR2(40),
    fecha_adquisicion DATE,
    id_edicion VARCHAR2(10)
);

CREATE TABLE Edicion (
    id VARCHAR2(10),
    año DATE,
    paginas INT,
    id_libro VARCHAR2(10),
    id_editorial VARCHAR2(10)
);

CREATE TABLE Editorial (
    id VARCHAR2(10),
    correo VARCHAR2(50),
    telefono VARCHAR2(10),
    nombre VARCHAR2(30),
    pais VARCHAR2(60)
);

CREATE TABLE Producto_Compra (
    id VARCHAR2(10),
    cantidad INT,
    precio_unidad DECIMAL(10, 2),
    id_compra VARCHAR2(10),
    id_libro VARCHAR2(10)
);

CREATE TABLE Compra (
    id VARCHAR2(10),
    fecha DATE,
    total DECIMAL(10, 2),
    estado VARCHAR2(10),
    id_proveedor VARCHAR2(10)
);

CREATE TABLE Proveedor (
    id VARCHAR2(10),
    correo VARCHAR2(50),
    nombre VARCHAR2(30),
    apellidos VARCHAR2(50),
    empresa VARCHAR2(50),
    telefono VARCHAR2(10)
);
