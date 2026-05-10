-- ============================================================
-- CRUDI - IMPLEMENTACION DE LOS PAQUETES
-- ============================================================

-- -----------------------------------------------
-- CRUDI: PC_CATEGORIA
-- -----------------------------------------------
CREATE OR REPLACE PACKAGE BODY PC_CATEGORIA IS

    PROCEDURE AD_CATEGORIA(xNOMBRE IN VARCHAR2, xDESCRIPCION IN VARCHAR2) IS
    BEGIN
        INSERT INTO Categoria(id, nombre, descripcion)
        VALUES ('CAT' || LPAD(SQ_CATEGORIA.NEXTVAL, 3, '0'), xNOMBRE, xDESCRIPCION);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20101, 'Error al insertar Categoria: ' || SQLERRM);
    END AD_CATEGORIA;

    PROCEDURE MOD_CATEGORIA(xID IN VARCHAR2, xNOMBRE IN VARCHAR2, xDESCRIPCION IN VARCHAR2) IS
    BEGIN
        UPDATE Categoria
        SET nombre = xNOMBRE, descripcion = xDESCRIPCION
        WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20102, 'Error al modificar Categoria: ' || SQLERRM);
    END MOD_CATEGORIA;

    PROCEDURE ELI_CATEGORIA(xID IN VARCHAR2) IS
    BEGIN
        DELETE FROM Categoria WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20103, 'Error al eliminar Categoria: ' || SQLERRM);
    END ELI_CATEGORIA;

    FUNCTION CO_CATEGORIA RETURN SYS_REFCURSOR IS
        cursor_cat SYS_REFCURSOR;
    BEGIN
        OPEN cursor_cat FOR SELECT * FROM Categoria;
        RETURN cursor_cat;
    END CO_CATEGORIA;

END PC_CATEGORIA;
/

-- -----------------------------------------------
-- CRUDI: PC_AUTOR
-- -----------------------------------------------
CREATE OR REPLACE PACKAGE BODY PC_AUTOR IS

    PROCEDURE AD_AUTOR(xNOMBRE IN VARCHAR2, xAPELLIDOS IN VARCHAR2, xGENERO IN VARCHAR2, xNACIONALIDAD IN VARCHAR2) IS
    BEGIN
        INSERT INTO Autor(id, nombre, apellidos, genero, nacionalidad)
        VALUES ('AUT' || LPAD(SQ_AUTOR.NEXTVAL, 3, '0'), xNOMBRE, xAPELLIDOS, xGENERO, xNACIONALIDAD);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20111, 'Error al insertar Autor: ' || SQLERRM);
    END AD_AUTOR;

    PROCEDURE MOD_AUTOR(xID IN VARCHAR2, xNOMBRE IN VARCHAR2, xAPELLIDOS IN VARCHAR2, xGENERO IN VARCHAR2, xNACIONALIDAD IN VARCHAR2) IS
    BEGIN
        UPDATE Autor
        SET nombre = xNOMBRE, apellidos = xAPELLIDOS, genero = xGENERO, nacionalidad = xNACIONALIDAD
        WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20112, 'Error al modificar Autor: ' || SQLERRM);
    END MOD_AUTOR;

    PROCEDURE ELI_AUTOR(xID IN VARCHAR2) IS
    BEGIN
        DELETE FROM Autor WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20113, 'Error al eliminar Autor: ' || SQLERRM);
    END ELI_AUTOR;

    FUNCTION CO_AUTOR RETURN SYS_REFCURSOR IS
        cursor_autor SYS_REFCURSOR;
    BEGIN
        OPEN cursor_autor FOR SELECT * FROM Autor;
        RETURN cursor_autor;
    END CO_AUTOR;

END PC_AUTOR;
/

-- -----------------------------------------------
-- CRUDI: PC_EDITORIAL
-- -----------------------------------------------
CREATE OR REPLACE PACKAGE BODY PC_EDITORIAL IS

    PROCEDURE AD_EDITORIAL(xNOMBRE IN VARCHAR2, xCORREO IN VARCHAR2, xTELEFONO IN VARCHAR2, xPAIS IN VARCHAR2) IS
    BEGIN
        INSERT INTO Editorial(id, nombre, correo, telefono, pais)
        VALUES ('EDI' || LPAD(SQ_EDITORIAL.NEXTVAL, 3, '0'), xNOMBRE, xCORREO, xTELEFONO, xPAIS);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20121, 'Error al insertar Editorial: ' || SQLERRM);
    END AD_EDITORIAL;

    PROCEDURE MOD_EDITORIAL(xID IN VARCHAR2, xNOMBRE IN VARCHAR2, xCORREO IN VARCHAR2, xTELEFONO IN VARCHAR2, xPAIS IN VARCHAR2) IS
    BEGIN
        UPDATE Editorial
        SET nombre = xNOMBRE, correo = xCORREO, telefono = xTELEFONO, pais = xPAIS
        WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20122, 'Error al modificar Editorial: ' || SQLERRM);
    END MOD_EDITORIAL;

    PROCEDURE ELI_EDITORIAL(xID IN VARCHAR2) IS
    BEGIN
        DELETE FROM Editorial WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20123, 'Error al eliminar Editorial: ' || SQLERRM);
    END ELI_EDITORIAL;

    FUNCTION CO_EDITORIAL RETURN SYS_REFCURSOR IS
        cursor_ed SYS_REFCURSOR;
    BEGIN
        OPEN cursor_ed FOR SELECT * FROM Editorial;
        RETURN cursor_ed;
    END CO_EDITORIAL;

END PC_EDITORIAL;
/

-- -----------------------------------------------
-- CRUDI: PC_LIBRO
-- -----------------------------------------------
CREATE OR REPLACE PACKAGE BODY PC_LIBRO IS

    PROCEDURE AD_LIBRO(xIDCATEGORIA IN VARCHAR2, xTITULO IN VARCHAR2, xDESCRIPCION IN VARCHAR2, xFECHA_PUBLICACION IN DATE, xIDIOMA IN VARCHAR2) IS
    BEGIN
        INSERT INTO Libro(id, idCategoria, titulo, descripcion, fecha_publicacion, idioma)
        VALUES ('LIB' || LPAD(SQ_LIBRO.NEXTVAL, 3, '0'), xIDCATEGORIA, xTITULO, xDESCRIPCION, xFECHA_PUBLICACION, xIDIOMA);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20131, 'Error al insertar Libro: ' || SQLERRM);
    END AD_LIBRO;

    PROCEDURE MOD_LIBRO(xID IN VARCHAR2, xIDCATEGORIA IN VARCHAR2, xTITULO IN VARCHAR2, xDESCRIPCION IN VARCHAR2, xIDIOMA IN VARCHAR2) IS
    BEGIN
        UPDATE Libro
        SET idCategoria = xIDCATEGORIA, titulo = xTITULO, descripcion = xDESCRIPCION, idioma = xIDIOMA
        WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20132, 'Error al modificar Libro: ' || SQLERRM);
    END MOD_LIBRO;

    PROCEDURE ELI_LIBRO(xID IN VARCHAR2) IS
    BEGIN
        DELETE FROM Libro WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20133, 'Error al eliminar Libro: ' || SQLERRM);
    END ELI_LIBRO;

    PROCEDURE AD_LIBRO_AUTOR(xIDLIBRO IN VARCHAR2, xIDAUTOR IN VARCHAR2) IS
    BEGIN
        INSERT INTO Libro_Autor(idLibro, idAutor)
        VALUES (xIDLIBRO, xIDAUTOR);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20134, 'Error al insertar Libro_Autor: ' || SQLERRM);
    END AD_LIBRO_AUTOR;

    PROCEDURE ELI_LIBRO_AUTOR(xIDLIBRO IN VARCHAR2, xIDAUTOR IN VARCHAR2) IS
    BEGIN
        DELETE FROM Libro_Autor WHERE idLibro = xIDLIBRO AND idAutor = xIDAUTOR;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20135, 'Error al eliminar Libro_Autor: ' || SQLERRM);
    END ELI_LIBRO_AUTOR;

    FUNCTION CO_LIBRO RETURN SYS_REFCURSOR IS
        cursor_lib SYS_REFCURSOR;
    BEGIN
        OPEN cursor_lib FOR SELECT * FROM Libro;
        RETURN cursor_lib;
    END CO_LIBRO;

    FUNCTION CO_LIBRO_CAT(xIDCATEGORIA IN VARCHAR2) RETURN SYS_REFCURSOR IS
        cursor_lib SYS_REFCURSOR;
    BEGIN
        OPEN cursor_lib FOR SELECT * FROM Libro WHERE idCategoria = xIDCATEGORIA;
        RETURN cursor_lib;
    END CO_LIBRO_CAT;

END PC_LIBRO;
/

-- -----------------------------------------------
-- CRUDI: PC_EDICION
-- -----------------------------------------------
CREATE OR REPLACE PACKAGE BODY PC_EDICION IS

    PROCEDURE AD_EDICION(xIDLIBRO IN VARCHAR2, xIDEDITORIAL IN VARCHAR2, xANIO IN DATE, xPAGINAS IN NUMBER) IS
    BEGIN
        INSERT INTO Edicion(id, idLibro, idEditorial, anio, paginas)
        VALUES ('EDC' || LPAD(SQ_EDICION.NEXTVAL, 3, '0'), xIDLIBRO, xIDEDITORIAL, xANIO, xPAGINAS);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20141, 'Error al insertar Edicion: ' || SQLERRM);
    END AD_EDICION;

    PROCEDURE MOD_EDICION(xID IN VARCHAR2, xIDLIBRO IN VARCHAR2, xIDEDITORIAL IN VARCHAR2, xANIO IN DATE, xPAGINAS IN NUMBER) IS
    BEGIN
        UPDATE Edicion
        SET idLibro = xIDLIBRO, idEditorial = xIDEDITORIAL, anio = xANIO, paginas = xPAGINAS
        WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20142, 'Error al modificar Edicion: ' || SQLERRM);
    END MOD_EDICION;

    PROCEDURE ELI_EDICION(xID IN VARCHAR2) IS
    BEGIN
        DELETE FROM Edicion WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20143, 'Error al eliminar Edicion: ' || SQLERRM);
    END ELI_EDICION;

    FUNCTION CO_EDICION RETURN SYS_REFCURSOR IS
        cursor_edc SYS_REFCURSOR;
    BEGIN
        OPEN cursor_edc FOR SELECT * FROM Edicion;
        RETURN cursor_edc;
    END CO_EDICION;

    FUNCTION CO_EDICION_LIBRO(xIDLIBRO IN VARCHAR2) RETURN SYS_REFCURSOR IS
        cursor_edc SYS_REFCURSOR;
    BEGIN
        OPEN cursor_edc FOR SELECT * FROM Edicion WHERE idLibro = xIDLIBRO;
        RETURN cursor_edc;
    END CO_EDICION_LIBRO;

END PC_EDICION;
/

-- -----------------------------------------------
-- CRUDI: PC_EJEMPLAR
-- -----------------------------------------------
CREATE OR REPLACE PACKAGE BODY PC_EJEMPLAR IS

    PROCEDURE AD_EJEMPLAR(xIDEDICION IN VARCHAR2, xESTADOFISICO IN VARCHAR2, xDISPONIBILIDAD IN CHAR, xLOCALIZACION IN VARCHAR2, xFECHAADQUISICION IN DATE) IS
    BEGIN
        INSERT INTO Ejemplar(id, idEdicion, estadoFisico, disponibilidad, localizacion, fechaAdquisicion)
        VALUES ('EJE' || LPAD(SQ_EJEMPLAR.NEXTVAL, 3, '0'), xIDEDICION, xESTADOFISICO, xDISPONIBILIDAD, xLOCALIZACION, xFECHAADQUISICION);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20151, 'Error al insertar Ejemplar: ' || SQLERRM);
    END AD_EJEMPLAR;

    PROCEDURE MOD_EJEMPLAR(xID IN VARCHAR2, xESTADOFISICO IN VARCHAR2, xDISPONIBILIDAD IN CHAR, xLOCALIZACION IN VARCHAR2) IS
    BEGIN
        UPDATE Ejemplar
        SET estadoFisico = xESTADOFISICO, disponibilidad = xDISPONIBILIDAD, localizacion = xLOCALIZACION
        WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20152, 'Error al modificar Ejemplar: ' || SQLERRM);
    END MOD_EJEMPLAR;

    PROCEDURE ELI_EJEMPLAR(xID IN VARCHAR2) IS
    BEGIN
        DELETE FROM Ejemplar WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20153, 'Error al eliminar Ejemplar: ' || SQLERRM);
    END ELI_EJEMPLAR;

    FUNCTION CO_EJEMPLAR RETURN SYS_REFCURSOR IS
        cursor_eje SYS_REFCURSOR;
    BEGIN
        OPEN cursor_eje FOR SELECT * FROM Ejemplar;
        RETURN cursor_eje;
    END CO_EJEMPLAR;

    FUNCTION CO_EJEMPLAR_EDICION(xIDEDICION IN VARCHAR2) RETURN SYS_REFCURSOR IS
        cursor_eje SYS_REFCURSOR;
    BEGIN
        OPEN cursor_eje FOR SELECT * FROM Ejemplar WHERE idEdicion = xIDEDICION;
        RETURN cursor_eje;
    END CO_EJEMPLAR_EDICION;

END PC_EJEMPLAR;
/

-- -----------------------------------------------
-- CRUDI: PC_PROVEEDOR
-- -----------------------------------------------
CREATE OR REPLACE PACKAGE BODY PC_PROVEEDOR IS

    PROCEDURE AD_PROVEEDOR(xNOMBRE IN VARCHAR2, xAPELLIDOS IN VARCHAR2, xCORREO IN VARCHAR2, xEMPRESA IN VARCHAR2, xTELEFONO IN VARCHAR2) IS
    BEGIN
        INSERT INTO Proveedor(id, nombre, apellidos, correo, empresa, telefono)
        VALUES ('PRO' || LPAD(SQ_PROVEEDOR.NEXTVAL, 3, '0'), xNOMBRE, xAPELLIDOS, xCORREO, xEMPRESA, xTELEFONO);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20161, 'Error al insertar Proveedor: ' || SQLERRM);
    END AD_PROVEEDOR;

    PROCEDURE MOD_PROVEEDOR(xID IN VARCHAR2, xNOMBRE IN VARCHAR2, xAPELLIDOS IN VARCHAR2, xCORREO IN VARCHAR2, xEMPRESA IN VARCHAR2, xTELEFONO IN VARCHAR2) IS
    BEGIN
        UPDATE Proveedor
        SET nombre = xNOMBRE, apellidos = xAPELLIDOS, correo = xCORREO, empresa = xEMPRESA, telefono = xTELEFONO
        WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20162, 'Error al modificar Proveedor: ' || SQLERRM);
    END MOD_PROVEEDOR;

    PROCEDURE ELI_PROVEEDOR(xID IN VARCHAR2) IS
    BEGIN
        DELETE FROM Proveedor WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20163, 'Error al eliminar Proveedor: ' || SQLERRM);
    END ELI_PROVEEDOR;

    FUNCTION CO_PROVEEDOR RETURN SYS_REFCURSOR IS
        cursor_prov SYS_REFCURSOR;
    BEGIN
        OPEN cursor_prov FOR SELECT * FROM Proveedor;
        RETURN cursor_prov;
    END CO_PROVEEDOR;

END PC_PROVEEDOR;
/

-- -----------------------------------------------
-- CRUDI: PC_COMPRA
-- -----------------------------------------------
CREATE OR REPLACE PACKAGE BODY PC_COMPRA IS

    PROCEDURE AD_COMPRA(xIDPROVEEDOR IN VARCHAR2, xFECHA IN DATE, xTOTAL IN NUMBER, xESTADO IN VARCHAR2) IS
    BEGIN
        INSERT INTO Compra(id, idProveedor, fecha, total, estado)
        VALUES ('COM' || LPAD(SQ_COMPRA.NEXTVAL, 3, '0'), xIDPROVEEDOR, xFECHA, xTOTAL, xESTADO);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20171, 'Error al insertar Compra: ' || SQLERRM);
    END AD_COMPRA;

    PROCEDURE MOD_COMPRA(xID IN VARCHAR2, xFECHA IN DATE, xTOTAL IN NUMBER, xESTADO IN VARCHAR2) IS
    BEGIN
        UPDATE Compra
        SET fecha = xFECHA, total = xTOTAL, estado = xESTADO
        WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20172, 'Error al modificar Compra: ' || SQLERRM);
    END MOD_COMPRA;

    PROCEDURE ELI_COMPRA(xID IN VARCHAR2) IS
    BEGIN
        DELETE FROM Compra WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20173, 'Error al eliminar Compra: ' || SQLERRM);
    END ELI_COMPRA;

    PROCEDURE AD_PRODUCTO_COMPRA(xIDCOMPRA IN VARCHAR2, xIDLIBRO IN VARCHAR2, xCANTIDAD IN NUMBER, xPRECIOUNIDAD IN NUMBER) IS
    BEGIN
        INSERT INTO Producto_Compra(id, idCompra, idLibro, cantidad, precioUnidad)
        VALUES ('PC' || LPAD(SQ_PROD_COMP.NEXTVAL, 4, '0'), xIDCOMPRA, xIDLIBRO, xCANTIDAD, xPRECIOUNIDAD);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20174, 'Error al insertar Producto_Compra: ' || SQLERRM);
    END AD_PRODUCTO_COMPRA;

    PROCEDURE ELI_PRODUCTO_COMPRA(xID IN VARCHAR2) IS
    BEGIN
        DELETE FROM Producto_Compra WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20175, 'Error al eliminar Producto_Compra: ' || SQLERRM);
    END ELI_PRODUCTO_COMPRA;

    FUNCTION CO_COMPRA RETURN SYS_REFCURSOR IS
        cursor_com SYS_REFCURSOR;
    BEGIN
        OPEN cursor_com FOR SELECT * FROM Compra;
        RETURN cursor_com;
    END CO_COMPRA;

    FUNCTION CO_PRODUCTOS_COMPRA(xIDCOMPRA IN VARCHAR2) RETURN SYS_REFCURSOR IS
        cursor_pc SYS_REFCURSOR;
    BEGIN
        OPEN cursor_pc FOR SELECT * FROM Producto_Compra WHERE idCompra = xIDCOMPRA;
        RETURN cursor_pc;
    END CO_PRODUCTOS_COMPRA;

END PC_COMPRA;
/

-- -----------------------------------------------
-- CRUDI: PC_USUARIO
-- -----------------------------------------------
CREATE OR REPLACE PACKAGE BODY PC_USUARIO IS

    PROCEDURE AD_USUARIO(xCORREO IN VARCHAR2, xROL IN VARCHAR2, xNOMBRE IN VARCHAR2, xAPELLIDOS IN VARCHAR2, xTELEFONO IN VARCHAR2) IS
    BEGIN
        INSERT INTO Usuario(id, correo, rol, nombre, apellidos, telefono)
        VALUES ('USR' || LPAD(SQ_USUARIO.NEXTVAL, 3, '0'), xCORREO, xROL, xNOMBRE, xAPELLIDOS, xTELEFONO);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20181, 'Error al insertar Usuario: ' || SQLERRM);
    END AD_USUARIO;

    PROCEDURE MOD_USUARIO(xID IN VARCHAR2, xCORREO IN VARCHAR2, xNOMBRE IN VARCHAR2, xAPELLIDOS IN VARCHAR2, xTELEFONO IN VARCHAR2) IS
    BEGIN
        UPDATE Usuario
        SET correo = xCORREO, nombre = xNOMBRE, apellidos = xAPELLIDOS, telefono = xTELEFONO
        WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20182, 'Error al modificar Usuario: ' || SQLERRM);
    END MOD_USUARIO;

    PROCEDURE ELI_USUARIO(xID IN VARCHAR2) IS
    BEGIN
        DELETE FROM Usuario WHERE id = xID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20183, 'Error al eliminar Usuario: ' || SQLERRM);
    END ELI_USUARIO;

    PROCEDURE AD_ADMINISTRADOR(xIDUSUARIO IN VARCHAR2, xPERMISOS IN VARCHAR2, xSEDE IN VARCHAR2) IS
    BEGIN
        INSERT INTO Administrador(idUsuario, permisos, sede)
        VALUES (xIDUSUARIO, xPERMISOS, xSEDE);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20184, 'Error al insertar Administrador: ' || SQLERRM);
    END AD_ADMINISTRADOR;

    PROCEDURE MOD_ADMINISTRADOR(xIDUSUARIO IN VARCHAR2, xPERMISOS IN VARCHAR2, xSEDE IN VARCHAR2) IS
    BEGIN
        UPDATE Administrador
        SET permisos = xPERMISOS, sede = xSEDE
        WHERE idUsuario = xIDUSUARIO;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20185, 'Error al modificar Administrador: ' || SQLERRM);
    END MOD_ADMINISTRADOR;

    PROCEDURE ELI_ADMINISTRADOR(xIDUSUARIO IN VARCHAR2) IS
    BEGIN
        DELETE FROM Administrador WHERE idUsuario = xIDUSUARIO;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20186, 'Error al eliminar Administrador: ' || SQLERRM);
    END ELI_ADMINISTRADOR;

    FUNCTION CO_USUARIOS RETURN SYS_REFCURSOR IS
        cursor_usr SYS_REFCURSOR;
    BEGIN
        OPEN cursor_usr FOR SELECT * FROM Usuario;
        RETURN cursor_usr;
    END CO_USUARIOS;

    FUNCTION CO_USUARIO_ROL(xROL IN VARCHAR2) RETURN SYS_REFCURSOR IS
        cursor_usr SYS_REFCURSOR;
    BEGIN
        OPEN cursor_usr FOR SELECT * FROM Usuario WHERE rol = xROL;
        RETURN cursor_usr;
    END CO_USUARIO_ROL;

    FUNCTION CO_ADMINISTRADORES RETURN SYS_REFCURSOR IS
        cursor_adm SYS_REFCURSOR;
    BEGIN
        OPEN cursor_adm FOR
            SELECT u.id, u.nombre, u.apellidos, u.correo, a.permisos, a.sede
            FROM Usuario u
            JOIN Administrador a ON u.id = a.idUsuario;
        RETURN cursor_adm;
    END CO_ADMINISTRADORES;

END PC_USUARIO;
/

