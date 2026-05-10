---------------------------------------------------------------------------------------------
--- PERSISTENCIA: TABLAS -> Creación de tablas
---------------------------------------------------------------------------------------------
CREATE TABLE Usuario (
    id VARCHAR2(10),
    correo VARCHAR2(50),
    rol VARCHAR2(30),
    nombre VARCHAR2(60),
    apellidos VARCHAR2(60),
    telefono VARCHAR2(10)
);

CREATE TABLE Administrador (
    idUsuario VARCHAR2(10),
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
    nombre VARCHAR2(60),
    apellidos VARCHAR2(60),
    genero VARCHAR2(30),
    nacionalidad VARCHAR2(50)
);

CREATE TABLE Libro (
    id VARCHAR2(10),
    titulo VARCHAR2(60),
    fecha_publicacion DATE,
    idioma VARCHAR2(30),
    descripcion VARCHAR2(200),
    idCategoria VARCHAR2(10)
);

CREATE TABLE Libro_Autor (
    idLibro VARCHAR2(10),
    idAutor VARCHAR2(10)
);

CREATE TABLE Ejemplar (
    id VARCHAR2(10),
    estadoFisico VARCHAR2(30),
    disponibilidad BOOLEAN,
    localizacion VARCHAR2(40),
    fechaAdquisicion DATE,
    idEdicion VARCHAR2(10)
);

CREATE TABLE Edicion (
    id VARCHAR2(10),
    año DATE,
    paginas INT(3),
    idLibro VARCHAR2(10),
    idEditorial VARCHAR2(10)
);

CREATE TABLE Editorial (
    id VARCHAR2(10),
    correo VARCHAR2(100),
    telefono VARCHAR2(10),
    nombre VARCHAR2(50),
    pais VARCHAR2(60)
);

CREATE TABLE Producto_Compra (
    id VARCHAR2(10),
    cantidad INT,
    precioUnidad DECIMAL(10, 2),
    idCompra VARCHAR2(10),
    idLibro VARCHAR2(10)
);

CREATE TABLE Compra (
    id VARCHAR2(10),
    fecha DATE,
    total DECIMAL(10, 2),
    estado VARCHAR2(20),
    idProveedor VARCHAR2(10)
);

CREATE TABLE Proveedor (
    id VARCHAR2(10),
    correo VARCHAR2(100),
    nombre VARCHAR2(60),
    apellidos VARCHAR2(60),
    empresa VARCHAR2(50),
    telefono VARCHAR2(10)
);
