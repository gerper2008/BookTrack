---------------------------------------------------------------------------------------------
--- ACTORES I: Implementación de los paquetes de actores
---------------------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY PK_ADMINISTRADOR AS

    ------------------------------------------------------------
    -- CATEGORIA
    ------------------------------------------------------------
    PROCEDURE AD_CATEGORIA (xNOMBRE IN VARCHAR2, xDESCRIPCION IN VARCHAR2) IS
    BEGIN
        INSERT INTO Categoria (id, nombre, descripcion)
        VALUES (NULL, xNOMBRE, xDESCRIPCION);
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20001, 'Ya existe una categoría con ese nombre.');
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END AD_CATEGORIA;

    PROCEDURE MOD_CATEGORIA (xID IN VARCHAR2, xNOMBRE IN VARCHAR2, xDESCRIPCION IN VARCHAR2) IS
    BEGIN
        UPDATE Categoria
        SET nombre = xNOMBRE, descripcion = xDESCRIPCION
        WHERE id = xID;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Categoría no encontrada: ' || xID);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END MOD_CATEGORIA;

    PROCEDURE EL_CATEGORIA (xID IN VARCHAR2) IS
    BEGIN
        DELETE FROM Categoria WHERE id = xID;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'Categoría no encontrada: ' || xID);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END EL_CATEGORIA;

    FUNCTION CO_CATEGORIA RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR SELECT * FROM Categoria ORDER BY nombre;
        RETURN cur;
    END CO_CATEGORIA;

    ------------------------------------------------------------
    -- LIBRO
    ------------------------------------------------------------
    PROCEDURE AD_LIBRO (xTITULO IN VARCHAR2, xFECHA_PUBLICACION IN DATE, xIDIOMA IN VARCHAR2, xDESCRIPCION IN VARCHAR2, xID_CATEGORIA IN VARCHAR2) IS
    BEGIN
        INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria)
        VALUES (NULL, xTITULO, xFECHA_PUBLICACION, xIDIOMA, xDESCRIPCION, xID_CATEGORIA);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END AD_LIBRO;

    PROCEDURE MOD_LIBRO (xID IN VARCHAR2, xTITULO IN VARCHAR2, xFECHA_PUBLICACION IN DATE, xIDIOMA IN VARCHAR2, xDESCRIPCION IN VARCHAR2, xID_CATEGORIA IN VARCHAR2) IS
    BEGIN
        -- TRG_Libro_Titulo_Sin_Ediciones controla que no se cambie titulo si tiene ediciones
        UPDATE Libro
        SET titulo = xTITULO, fecha_publicacion = xFECHA_PUBLICACION,
            idioma = xIDIOMA, descripcion = xDESCRIPCION, idCategoria = xID_CATEGORIA
        WHERE id = xID;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Libro no encontrado: ' || xID);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END MOD_LIBRO;

    PROCEDURE EL_LIBRO (xID IN VARCHAR2) IS
    BEGIN
        DELETE FROM Libro WHERE id = xID;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20005, 'Libro no encontrado: ' || xID);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END EL_LIBRO;

    FUNCTION CO_CATALOGO_LIBROS (xID_CATEGORIA IN VARCHAR2, xIDIOMA IN VARCHAR2) RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
            SELECT l.id, l.titulo, l.fecha_publicacion, l.idioma, l.descripcion,
                   c.nombre AS categoria
            FROM Libro l
            LEFT JOIN Categoria c ON l.idCategoria = c.id
            WHERE (xID_CATEGORIA IS NULL OR l.idCategoria = xID_CATEGORIA)
              AND (xIDIOMA IS NULL OR l.idioma = xIDIOMA)
            ORDER BY l.titulo;
        RETURN cur;
    END CO_CATALOGO_LIBROS;

    ------------------------------------------------------------
    -- AUTOR
    ------------------------------------------------------------
    PROCEDURE AD_AUTOR (xNOMBRE IN VARCHAR2, xAPELLIDOS IN VARCHAR2, xGENERO IN VARCHAR2, xNACIONALIDAD IN VARCHAR2) IS
    BEGIN
        INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad)
        VALUES (NULL, xNOMBRE, xAPELLIDOS, xGENERO, xNACIONALIDAD);
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20006, 'Ya existe un autor con ese nombre y apellidos.');
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END AD_AUTOR;

    PROCEDURE MOD_AUTOR (xID IN VARCHAR2, xNOMBRE IN VARCHAR2, xAPELLIDOS IN VARCHAR2, xGENERO IN VARCHAR2, xNACIONALIDAD IN VARCHAR2) IS
    BEGIN
        UPDATE Autor
        SET nombre = xNOMBRE, apellidos = xAPELLIDOS,
            genero = xGENERO, nacionalidad = xNACIONALIDAD
        WHERE id = xID;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20007, 'Autor no encontrado: ' || xID);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END MOD_AUTOR;

    PROCEDURE EL_AUTOR (xID IN VARCHAR2) IS
    BEGIN
        DELETE FROM Autor WHERE id = xID;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20008, 'Autor no encontrado: ' || xID);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END EL_AUTOR;

    FUNCTION CO_AUTOR (xNOMBRE IN VARCHAR2, xNACIONALIDAD IN VARCHAR2) RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
            SELECT * FROM Autor
            WHERE (xNOMBRE IS NULL OR UPPER(nombre) LIKE UPPER('%' || xNOMBRE || '%'))
              AND (xNACIONALIDAD IS NULL OR nacionalidad = xNACIONALIDAD)
            ORDER BY apellidos, nombre;
        RETURN cur;
    END CO_AUTOR;

    ------------------------------------------------------------
    -- LIBRO_AUTOR
    ------------------------------------------------------------
    PROCEDURE AD_AUTOR_LIBRO (xID_AUTOR IN VARCHAR2, xID_LIBRO IN VARCHAR2) IS
    BEGIN
        INSERT INTO Libro_Autor (idLibro, idAutor) VALUES (xID_LIBRO, xID_AUTOR);
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20009, 'Esa relación autor-libro ya existe.');
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END AD_AUTOR_LIBRO;

    PROCEDURE EL_AUTOR_LIBRO (xID_AUTOR IN VARCHAR2, xID_LIBRO IN VARCHAR2) IS
    BEGIN
        DELETE FROM Libro_Autor WHERE idAutor = xID_AUTOR AND idLibro = xID_LIBRO;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20010, 'Relación autor-libro no encontrada.');
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END EL_AUTOR_LIBRO;

    ------------------------------------------------------------
    -- EDITORIAL
    ------------------------------------------------------------
    PROCEDURE AD_EDITORIAL (xNOMBRE IN VARCHAR2, xCORREO IN VARCHAR2, xTELEFONO IN VARCHAR2, xPAIS IN VARCHAR2) IS
    BEGIN
        INSERT INTO Editorial (id, nombre, correo, telefono, pais)
        VALUES (NULL, xNOMBRE, xCORREO, xTELEFONO, xPAIS);
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20011, 'Ya existe una editorial con ese correo o teléfono.');
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END AD_EDITORIAL;

    PROCEDURE MOD_EDITORIAL (xID IN VARCHAR2, xNOMBRE IN VARCHAR2, xCORREO IN VARCHAR2, xTELEFONO IN VARCHAR2, xPAIS IN VARCHAR2) IS
    BEGIN
        UPDATE Editorial
        SET nombre = xNOMBRE, correo = xCORREO, telefono = xTELEFONO, pais = xPAIS
        WHERE id = xID;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20012, 'Editorial no encontrada: ' || xID);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END MOD_EDITORIAL;

    PROCEDURE EL_EDITORIAL (xID IN VARCHAR2) IS
    BEGIN
        -- TRG_Editorial_Baja_Sin_Ediciones controla que no tenga ediciones
        DELETE FROM Editorial WHERE id = xID;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20013, 'Editorial no encontrada: ' || xID);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END EL_EDITORIAL;

    FUNCTION CO_EDITORIAL (xPAIS IN VARCHAR2) RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
            SELECT * FROM Editorial
            WHERE (xPAIS IS NULL OR pais = xPAIS)
            ORDER BY nombre;
        RETURN cur;
    END CO_EDITORIAL;

    ------------------------------------------------------------
    -- EDICION
    ------------------------------------------------------------
    PROCEDURE AD_EDICION (xID_LIBRO IN VARCHAR2, xID_EDITORIAL IN VARCHAR2, xANIO IN DATE, xPAGINAS IN NUMBER) IS
    BEGIN
        INSERT INTO Edicion (id, idLibro, idEditorial, anio, paginas)
        VALUES (NULL, xID_LIBRO, xID_EDITORIAL, xANIO, xPAGINAS);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END AD_EDICION;

    PROCEDURE MOD_EDICION (xID IN VARCHAR2, xID_LIBRO IN VARCHAR2, xID_EDITORIAL IN VARCHAR2, xANIO IN DATE, xPAGINAS IN NUMBER) IS
    BEGIN
        -- TRG_Edicion_Origen_Sin_Ejemplares controla cambios de libro/editorial
        UPDATE Edicion
        SET idLibro = xID_LIBRO, idEditorial = xID_EDITORIAL,
            anio = xANIO, paginas = xPAGINAS
        WHERE id = xID;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20014, 'Edición no encontrada: ' || xID);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END MOD_EDICION;

    PROCEDURE EL_EDICION (xID IN VARCHAR2) IS
    BEGIN
        -- TRG_Edicion_Baja_Sin_Ejemplares controla que no tenga ejemplares
        DELETE FROM Edicion WHERE id = xID;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20015, 'Edición no encontrada: ' || xID);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END EL_EDICION;

    FUNCTION CO_EDICION RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
            SELECT e.id, e.anio, e.paginas,
                   l.titulo AS libro, ed.nombre AS editorial
            FROM Edicion e
            JOIN Libro l ON e.idLibro = l.id
            LEFT JOIN Editorial ed ON e.idEditorial = ed.id
            ORDER BY l.titulo, e.anio;
        RETURN cur;
    END CO_EDICION;

    FUNCTION CO_EDICION_LIBRO (xID_LIBRO IN VARCHAR2) RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
            SELECT e.id, e.anio, e.paginas, ed.nombre AS editorial
            FROM Edicion e
            LEFT JOIN Editorial ed ON e.idEditorial = ed.id
            WHERE e.idLibro = xID_LIBRO
            ORDER BY e.anio;
        RETURN cur;
    END CO_EDICION_LIBRO;

    ------------------------------------------------------------
    -- EJEMPLAR
    ------------------------------------------------------------
    PROCEDURE AD_EJEMPLAR (xID_EDICION IN VARCHAR2, xESTADO_FISICO IN VARCHAR2, xDISPONIBILIDAD IN NUMBER, xLOCALIZACION IN VARCHAR2, xFECHA_ADQ IN DATE) IS
    BEGIN
        -- TUP3: no puede ser disponibilidad=0 y estadoFisico='Nuevo'
        IF xDISPONIBILIDAD = 0 AND xESTADO_FISICO = 'Nuevo' THEN
            RAISE_APPLICATION_ERROR(-20016, 'Un ejemplar no disponible no puede tener estado Nuevo.');
        END IF;
        INSERT INTO Ejemplar (id, idEdicion, estadoFisico, disponibilidad, localizacion, fechaAdquisicion)
        VALUES (NULL, xID_EDICION, xESTADO_FISICO, xDISPONIBILIDAD, xLOCALIZACION, xFECHA_ADQ);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END AD_EJEMPLAR;

    PROCEDURE MOD_EJEMPLAR (xID IN VARCHAR2, xESTADO_FISICO IN VARCHAR2, xDISPONIBILIDAD IN NUMBER, xLOCALIZACION IN VARCHAR2) IS
    BEGIN
        IF xDISPONIBILIDAD = 0 AND xESTADO_FISICO = 'Nuevo' THEN
            RAISE_APPLICATION_ERROR(-20016, 'Un ejemplar no disponible no puede tener estado Nuevo.');
        END IF;
        UPDATE Ejemplar
        SET estadoFisico = xESTADO_FISICO,
            disponibilidad = xDISPONIBILIDAD,
            localizacion = xLOCALIZACION
        WHERE id = xID;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20017, 'Ejemplar no encontrado: ' || xID);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END MOD_EJEMPLAR;

    PROCEDURE EL_EJEMPLAR (xID IN VARCHAR2) IS
    BEGIN
        -- TRG_Ejemplar_Disponible controla que no esté disponible
        DELETE FROM Ejemplar WHERE id = xID;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20018, 'Ejemplar no encontrado: ' || xID);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END EL_EJEMPLAR;

    FUNCTION CO_EJEMPLAR RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
            SELECT ej.id, ej.estadoFisico, ej.disponibilidad,
                   ej.localizacion, ej.fechaAdquisicion,
                   ed.id AS idEdicion, l.titulo AS libro
            FROM Ejemplar ej
            JOIN Edicion ed ON ej.idEdicion = ed.id
            JOIN Libro l ON ed.idLibro = l.id
            ORDER BY l.titulo;
        RETURN cur;
    END CO_EJEMPLAR;

    FUNCTION CO_EJEMPLAR_EDICION (xID_EDICION IN VARCHAR2) RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
            SELECT * FROM Ejemplar
            WHERE idEdicion = xID_EDICION
            ORDER BY estadoFisico;
        RETURN cur;
    END CO_EJEMPLAR_EDICION;

    ------------------------------------------------------------
    -- PROVEEDOR
    ------------------------------------------------------------
    PROCEDURE AD_PROVEEDOR (xNOMBRE IN VARCHAR2, xAPELLIDOS IN VARCHAR2, xCORREO IN VARCHAR2, xEMPRESA IN VARCHAR2, xTELEFONO IN VARCHAR2) IS
    BEGIN
        INSERT INTO Proveedor (id, nombre, apellidos, correo, empresa, telefono)
        VALUES (NULL, xNOMBRE, xAPELLIDOS, xCORREO, xEMPRESA, xTELEFONO);
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20019, 'Ya existe un proveedor con ese correo.');
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END AD_PROVEEDOR;

    PROCEDURE MOD_PROVEEDOR (xID IN VARCHAR2, xNOMBRE IN VARCHAR2, xAPELLIDOS IN VARCHAR2, xCORREO IN VARCHAR2, xEMPRESA IN VARCHAR2, xTELEFONO IN VARCHAR2) IS
    BEGIN
        UPDATE Proveedor
        SET nombre = xNOMBRE, apellidos = xAPELLIDOS,
            correo = xCORREO, empresa = xEMPRESA, telefono = xTELEFONO
        WHERE id = xID;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20020, 'Proveedor no encontrado: ' || xID);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END MOD_PROVEEDOR;

    PROCEDURE EL_PROVEEDOR (xID IN VARCHAR2) IS
    BEGIN
        -- TRG_Proveedor_Baja_Sin_Compras controla que no tenga compras
        DELETE FROM Proveedor WHERE id = xID;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20021, 'Proveedor no encontrado: ' || xID);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END EL_PROVEEDOR;

    FUNCTION CO_PROVEEDOR RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
            SELECT * FROM Proveedor ORDER BY empresa, apellidos;
        RETURN cur;
    END CO_PROVEEDOR;

    ------------------------------------------------------------
    -- COMPRA
    ------------------------------------------------------------
    PROCEDURE AD_COMPRA (xFECHA IN DATE, xTOTAL IN NUMBER, xESTADO IN VARCHAR2, xID_PROVEEDOR IN VARCHAR2) IS
    BEGIN
        -- TUP1: si COMPLETADO, total debe ser > 0
        IF xESTADO = 'COMPLETADO' AND xTOTAL <= 0 THEN
            RAISE_APPLICATION_ERROR(-20022, 'Una compra COMPLETADA debe tener total mayor a cero.');
        END IF;
        INSERT INTO Compra (id, fecha, total, estado, idProveedor)
        VALUES (NULL, xFECHA, xTOTAL, xESTADO, xID_PROVEEDOR);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END AD_COMPRA;

    PROCEDURE MOD_COMPRA (xID IN VARCHAR2, xFECHA IN DATE, xTOTAL IN NUMBER, xESTADO IN VARCHAR2, xID_PROVEEDOR IN VARCHAR2) IS
    BEGIN
        -- TRG_Compra_Modificacion_Sin_Ejemplares controla que no tenga ejemplares
        IF xESTADO = 'COMPLETADO' AND xTOTAL <= 0 THEN
            RAISE_APPLICATION_ERROR(-20022, 'Una compra COMPLETADA debe tener total mayor a cero.');
        END IF;
        UPDATE Compra
        SET fecha = xFECHA, total = xTOTAL, estado = xESTADO, idProveedor = xID_PROVEEDOR
        WHERE id = xID;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20023, 'Compra no encontrada: ' || xID);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END MOD_COMPRA;

    PROCEDURE EL_COMPRA (xID IN VARCHAR2) IS
    BEGIN
        -- TRG_Compra_Baja_Sin_Ejemplares controla que no tenga ejemplares
        DELETE FROM Compra WHERE id = xID;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20024, 'Compra no encontrada: ' || xID);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END EL_COMPRA;

    FUNCTION CO_COMPRA RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
            SELECT c.id, c.fecha, c.total, c.estado,
                   p.nombre || ' ' || p.apellidos AS proveedor, p.empresa
            FROM Compra c
            LEFT JOIN Proveedor p ON c.idProveedor = p.id
            ORDER BY c.fecha DESC;
        RETURN cur;
    END CO_COMPRA;

    FUNCTION CO_PRODUCTOS_COMPRA (xID_COMPRA IN VARCHAR2) RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
            SELECT pc.id, pc.cantidad, pc.precioUnidad,
                   pc.cantidad * pc.precioUnidad AS subtotal,
                   l.titulo AS libro
            FROM Producto_Compra pc
            LEFT JOIN Libro l ON pc.idLibro = l.id
            WHERE pc.idCompra = xID_COMPRA;
        RETURN cur;
    END CO_PRODUCTOS_COMPRA;

    ------------------------------------------------------------
    -- PRODUCTO_COMPRA
    ------------------------------------------------------------
    PROCEDURE AD_PRODUCTO_COMPRA (xID_COMPRA IN VARCHAR2, xID_LIBRO IN VARCHAR2, xCANTIDAD IN NUMBER, xPRECIO_UNIDAD IN NUMBER) IS
    BEGIN
        -- TUP2: cantidad y precioUnidad deben ser positivos
        IF xCANTIDAD <= 0 OR xPRECIO_UNIDAD <= 0 THEN
            RAISE_APPLICATION_ERROR(-20025, 'Cantidad y precio unitario deben ser mayores a cero.');
        END IF;
        INSERT INTO Producto_Compra (id, idCompra, idLibro, cantidad, precioUnidad)
        VALUES (SYS_GUID(), xID_COMPRA, xID_LIBRO, xCANTIDAD, xPRECIO_UNIDAD);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END AD_PRODUCTO_COMPRA;

    PROCEDURE EL_PRODUCTO_COMPRA (xID IN VARCHAR2) IS
    BEGIN
        DELETE FROM Producto_Compra WHERE id = xID;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20026, 'Producto de compra no encontrado: ' || xID);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END EL_PRODUCTO_COMPRA;

    ------------------------------------------------------------
    -- USUARIO / ADMINISTRADOR
    ------------------------------------------------------------
    PROCEDURE AD_USUARIO (xCORREO IN VARCHAR2, xROL IN VARCHAR2, xNOMBRE IN VARCHAR2, xAPELLIDOS IN VARCHAR2, xTELEFONO IN VARCHAR2) IS
    BEGIN
        INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono)
        VALUES (SYS_GUID(), xCORREO, xROL, xNOMBRE, xAPELLIDOS, xTELEFONO);
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20027, 'Ya existe un usuario con ese correo.');
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END AD_USUARIO;

    PROCEDURE MOD_USUARIO (xID IN VARCHAR2, xCORREO IN VARCHAR2, xNOMBRE IN VARCHAR2, xAPELLIDOS IN VARCHAR2, xTELEFONO IN VARCHAR2) IS
    BEGIN
        UPDATE Usuario
        SET correo = xCORREO, nombre = xNOMBRE,
            apellidos = xAPELLIDOS, telefono = xTELEFONO
        WHERE id = xID;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20028, 'Usuario no encontrado: ' || xID);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END MOD_USUARIO;

    PROCEDURE EL_USUARIO (xID IN VARCHAR2) IS
    BEGIN
        DELETE FROM Usuario WHERE id = xID;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20029, 'Usuario no encontrado: ' || xID);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END EL_USUARIO;

    PROCEDURE AD_ADMINISTRADOR (xID_USUARIO IN VARCHAR2, xPERMISOS IN VARCHAR2, xSEDE IN VARCHAR2) IS
    BEGIN
        INSERT INTO Administrador (idUsuario, permisos, sede)
        VALUES (xID_USUARIO, xPERMISOS, xSEDE);
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20030, 'Ya existe un administrador para ese usuario.');
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END AD_ADMINISTRADOR;

    PROCEDURE MOD_ADMINISTRADOR (xID_USUARIO IN VARCHAR2, xPERMISOS IN VARCHAR2, xSEDE IN VARCHAR2) IS
    BEGIN
        UPDATE Administrador
        SET permisos = xPERMISOS, sede = xSEDE
        WHERE idUsuario = xID_USUARIO;
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20031, 'Administrador no encontrado: ' || xID_USUARIO);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; RAISE;
    END MOD_ADMINISTRADOR;

    FUNCTION CO_USUARIOS RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
            SELECT * FROM Usuario ORDER BY apellidos, nombre;
        RETURN cur;
    END CO_USUARIOS;

    FUNCTION CO_ADMINISTRADORES RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
            SELECT u.id, u.nombre, u.apellidos, u.correo,
                   a.permisos, a.sede
            FROM Administrador a
            JOIN Usuario u ON a.idUsuario = u.id
            ORDER BY u.apellidos;
        RETURN cur;
    END CO_ADMINISTRADORES;

END PK_ADMINISTRADOR;
/
