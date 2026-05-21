/*
==================================================================================================
DOCUMENTACIÓN COMPLETA DEL PROYECTO - BookTrack (Ciclo 1)
==================================================================================================

Sistema de Gestión de Biblioteca - Base de Datos Oracle
=========================================================================================================================

CONTENIDO DE LA DOCUMENTACIÓN:
------------------------------
1. Estructura General del Proyecto
2. Orden de Ejecución de Scripts
3. Descripción de Cada Archivo
4. Dependencias entre Objetos
5. Restricciones y Reglas de Negocio
6. Notas Técnicas Importantes

==================================================================================================
1. ESTRUCTURA GENERAL DEL PROYECTO
==================================================================================================

El proyecto se organiza en carpetas que representan las "fuentes" de diferentes colores:

CARPETAS:
--------
- Fuentes_azules/    : Definición estructural (TABLAS, ATRIBUTOS, LLAVES, POBLAR, CONSULTAS)
- Fuentes_verdes/    : Reglas de tuplas, acciones y disparadores (lógica de negocio)
- Fuentes_rosadas/   : Vistas e índices (optimización)
- CRUD_Ciclo1/       : Operaciones CRUD completas
- Seguridad/          : Control de acceso y auditoría
- Pruebas/            : Casos de prueba

==================================================================================================
2. ORDEN DE EJECUCIÓN DE SCRIPTS (IMPORTANTE)
==========================================================================================================

ORDEN OBLIGATORIO para crear la base de datos desde cero:

==== ETAPA 1: FUNDAMENTO (Azules) ====
1.1) Fuentes_azules/01_TABLAS.sql      <- CREA LAS TABLAS BASE
1.2) Fuentes_azules/02_ATRIBUTOS.sql  <- RESTRICCIONES DE ATRIBUTOS (CHECKS SIMPLES)
1.3) Fuentes_azules/03_LLAVES.sql     <- CLAVES PRIMARIAS Y ÚNICAS
1.4) Fuentes_azules/04_POBLAR.sql     <- DATOS INICIALES (DATOS DE PRUEBA)

==== ETAPA 2: LÓGICA DE NEGOCIO (Verdes) ====
2.1) Fuentes_verdes/01_TUPLAS.sql     <- RESTRICCIONES DE TUPLAS (MULTI-ATRIBUTO)
2.2) Fuentes_verdes/03_ACCIONES.sql   <- LLAVES FORÁNEAS (RELACIONES ENTRE TABLAS)
2.3) Fuentes_verdes/05_DISPARADORES.sql <- TRIGGERS (AUTOMATISMOS Y VALIDACIONES)

==== ETAPA 3: CONSULTA Y OPTIMIZACIÓN (Rosadas) ====
3.1) Fuentes_rosadas/01_VISTAS.sql    <- VISTAS MATERIALIZABLES
3.2) Fuentes_rosadas/02_INDICES.sql   <- ÍNDICES PARA MEJORAR RENDIMIENTO

==== ETAPA 4: OPERACIONES CRUD ====
4.1) CRUD_Ciclo1/01_CRUDE_Especificacion.sql  <- ESPECIFICACIÓN DE OPERACIONES
4.2) CRUD_Ciclo1/02_CRUDI_Implementacion.sql <- IMPLEMENTACIÓN DE INSERTS/UPDATES
4.3) CRUD_Ciclo1/03_XCRUD_Eliminacion.sql    <- ELIMINACIONES (DELETES)
4.4) CRUD_Ciclo1/04_CRUDOK_DatosCorrectos.sql   <- DATOS VÁLIDOS PARA PRUEBAS
4.5) CRUD_Ciclo1/05_CRUDNoOK_DatosErroneos.sql  <- DATOS INVÁLIDOS (RECHAZOS)

==== ETAPA 5: SEGURIDAD ====
5.1) Seguridad/Seguridad.sql          <- POLÍTICAS DE SEGURIDAD
5.2) Seguridad/SeguridadOK.sql      <- PRUEBAS DE SEGURIDAD

==== ETAPA 6: PRUEBAS FUNCIONALES ====
6.1) Pruebas/Caso1.sql               <- CASO DE PRUEBA 1
6.2) Pruebas/Caso2.sql               <- CASO DE PRUEBA 2

==== PRUEBAS DE VERDES (DESPUÉS DE TODO LO ANTERIOR) ====
V1) Fuentes_verdes/02_TUPLAS_OK_NOOK.sql       <- PRUEBAS DE RESTRICCIONES DE TUPLA
V2) Fuentes_verdes/04_ACCIONES_OK_NOOK.sql   <- PRUEBAS DE LLAVES FORÁNEAS
V3) Fuentes_verdes/06_DISPARADORES_OK_NOOK.sql <- PRUEBAS DE TRIGGERS

==================================================================================================
3. DESCRIPCIÓN DETALLADA DE CADA ARCHIVO
==================================================================================================

===== FUENTES AZULES (Estructura) =====

--- 01_TABLAS.sql ---
Propósito: Crear las 12 tablas base del sistema
Tablas Creadas:
- Usuario       : Usuarios del sistema (lectores, bibliotecarios, admins)
- Administrador: Perfiles de administración
- Categoria    : Categorías de libros
- Autor        : Autores de libros
- Libro        : Libros en el sistema
- Libro_Autor  : Relación muchos a muchos libro-autor
- Ejemplar     : Ejemplares físicos de libros
- Edicion      : Ediciones de libros
- Editorial   : Editoras
- Producto_Compra: Productos en una compra
- Compra       : Compras a proveedores
- Proveedor   : Proveedores de libros

--- 02_ATRIBUTOS.sql ---
Propósito: Definir restricciones a nivel de UN SOLO ATRIBUTO
Tipos de restricciones:
- CHECK con REGEXP (formatos de texto, teléfonos, emails)
- CHECK con listas (estado, género, rol, etc.)
- CHECK de fechas (no mayores a 31/12/2025)
- CHECK numéricos (positivos, > 0)

--- 03_LLAVES.sql ---
Propósito: Definir CLAVES PRIMARIAS (PRIMARY KEY) y ÚNICAS (UNIQUE)
Ejecutar DESPUÉS de 02_ATRIBUTOS.sql

--- 04_POBLAR.sql ---
Propósito: Insertar datos iniciales para pruebas
Ejecutar DESPUÉS de 03_LLAVES.sql

--- 05_CONSULTAS.sql ---
Propósito: Definir consultas de ejemplo/vistas base

--- 06_XTABLAS.sql ---
Propósito: Eliminar todas las tablas (LIMPIEZA)


===== FUENTES VERDES (Lógica de Negocio) =====

--- 01_TUPLAS.sql ---
Propósito: Restricciones que involucran MÁS DE UN ATRIBUTO (reglas de tupla)

Definiciones:
- TUP1: Compra completada debe tener total > 0
- TUP2: Producto_Compra: cantidad y precioUnidad > 0
- TUP3: Ejemplar no disponible no puede estar como Nuevo
- TUP4: Edicion.anio >= fecha_publicacion del Libro (vía trigger)

--- 02_TUPLAS_OK_NOOK.sql ---
Propósito: PRUEBAS de las restricciones de tupla
Contiene:
- Precondiciones (datos padre necesarios para pruebas)
- Casos OK (que deben pasar)
- Casos NO OK (que deben fallar con errores específicos)

--- 03_ACCIONES.sql ---
Propósito: Definir LLAVES FORÁNEAS (FOREIGN KEY) entre tablas

Relaciones definidas:
1) Libro.idCategoria → Categoria(id) ON DELETE SET NULL
2) Edicion.idLibro → Libro(id) ON DELETE CASCADE
3) Edicion.idEditorial → Editorial(id) ON DELETE SET NULL
4) Ejemplar.idEdicion → Edicion(id) ON DELETE CASCADE
5) Libro_Autor.idAutor → Autor(id) ON DELETE CASCADE
6) Libro_Autor.idLibro → Libro(id) ON DELETE CASCADE
7) Compra.idProveedor → Proveedor(id) ON DELETE SET NULL
8) Producto_Compra.idCompra → Compra(id) ON DELETE CASCADE
9) Producto_Compra.idLibro → Libro(id) ON DELETE SET NULL
10) Administrador.idUsuario → Usuario(id) ON DELETE CASCADE

--- 04_ACCIONES_OK_NOOK.sql ---
Propósito: PRUEBAS de las acciones referenciales
Contiene pruebas de:
- DELETE CASCADE (eliminación en cascada)
- DELETE SET NULL (poner en NULL)
- Errores por integridad referencial

--- 05_DISPARADORES.sql ---
Propósito: Definir TRIGGERS (disparadores) para automatizaciones

Triggers definidos:
- DISP-01: Generar id de Categoria (CAT001, CAT002...)
- DISP-02: Generar id de Libro (LIB001, LIB002...)
- DISP-03: No modificar título si tiene ediciones activas
- DISP-04: Generar id de Autor (AUT001, AUT002...)
- DISP-05: Generar id de Edicion (EDI001, EDI002...)
- DISP-06: Impide cambiar libro/editorial de edición con ejemplares
- DISP-07: No eliminar edición con ejemplares
- DISP-08: Generar id de Editorial (EDT001, EDT002...)
- DISP-09: No eliminar editorial con ediciones
- DISP-10: Generar id de Ejemplar (EJM001, EJM002...)
- DISP-11: No eliminar ejemplar disponible
- DISP-12: Generar id de Compra (COM001, COM002...)
- DISP-13: Estado inicial de compra PENDIENTE
- DISP-14: No modificar compra no pendiente
- DISP-15: No eliminar compra no pendiente
- DISP-16: Generar id de Proveedor (PRV001, PRV002...)
- DISP-17: No eliminar proveedor con compras

--- 06_DISPARADORES_OK_NOOK.sql ---
Propósito: PRUEBAS de los triggers
Contiene:
- Casos OK (autogeneración de IDs, modificaciones válidas)
- Casos NO OK (errores esperados por triggers de blockade)

--- 07_XTABLAS.sql ---
Propósito: Eliminar tablas y triggers (LIMPIEZA)


===== FUENTES ROSADAS (Optimización) =====

--- 01_VISTAS.sql ---
Propósito: Crear vistas para consultas frecuentes
Vistas:
- VW_Catalogo_Libros
- VW_Proveedores
- VW_Compras
- VW_Productos_Compra
- VW_Ejemplares_Disponibles

--- 02_INDICES.sql ---
Propósito: Crear índices para mejorar rendimiento


===== CRUD_Ciclo1 =====

--- 01_CRUDE_Especificacion.sql ---
Propósito: Especificar operaciones CRUD por tabla

--- 02_CRUDI_Implementacion.sql ---
Propósito: Implementar INSERT y UPDATE

--- 03_XCRUD_Eliminacion.sql ---
Propósito: Implementar DELETE

--- 04_CRUDOK_DatosCorrectos.sql ---
Propósito: Datos de prueba válidos

--- 05_CRUDNoOK_DatosErroneos.sql ---
Propósito: Datos de prueba inválidos


===== SEGURIDAD =====

--- Seguridad.sql ---
Propósito: Definir políticas de seguridad

--- SeguridadOK.sql ---
Propósito: Pruebas de seguridad

--- ActoresI.sql ---
Propósito: Actores internos

--- ActoresE.sql ---
Propósito: Actores externos

--- XSeguridad.sql ---
Propósito: Eliminar objetos de seguridad


===== PRUEBAS =====

--- Caso1.sql ---
Propósito: Caso de prueba 1 completo

--- Caso2.sql ---
Propósito: Caso de prueba 2 completo


==================================================================================================
4. DEPENDENCIAS ENTRE OBJETOS (IMPORTANTE)
==================================================================================================

ORDEN DE DEPENDENCIA (qué requiere qué):
---------------------------------
TABLAS (01) → ATRIBUTOS (02) → LLAVES (03) → POBLAR (04)
                                    ↓
                          TUPLAS (01) ← ATRIBUTOS y LLAVES
                                    ↓
                          ACCIONES (03) ← LLAVES Y TUPLAS
                                    ↓
                          DISPARADORES (05) ← TUPLAS, ACCIONES, TABLAS
                                    ↓
                          VISTAS/ÍNDICES ← TODAS LAS ANTERIORES
                                    ↓
                          CRUD ← VISTAS, TRIGGERS
                                    ↓
                          SEGURIDAD ← CRUD, TRIGGERS

==================================================================================================
5. REGLAS DE NEGOCIO IMPORTANTES
==================================================================================================

REGLAS DE TUPLA:
-------------
1. Una Compra en estado COMPLETADO debe tener total > 0
2. Producto_Compra debe tener cantidad > 0 Y precioUnidad > 0
3. Un Ejemplar con disponibilidad = 0 (no disponible) NO puede tener estadoFisico = 'Nuevo'
4. El año de una Edicion debe ser >= fecha_publicacion del Libro

REGLAS DE TRIGGER:
-----------------
1. No se puede modificar el título de un Libro que ya tiene ediciones
2. No se puede modificar una Edicion que ya tiene ejemplares
3. No se puede eliminar una Edicion que tiene ejemplares
4. No se puede eliminar una Editorial que tiene ediciones
5. No se puede eliminar un Ejemplar disponible (disponibilidad = 1)
6. No se puede modificar una Compra que no está en estado PENDIENTE
7. No se puede eliminar una Compra que no está en estado PENDIENTE
8. No se puede eliminar un Proveedor que tiene compras registradas

ESTADOS VÁLIDOS:
----------------
- Compra.estado: 'PENDIENTE', 'COMPLETADO', 'RECHAZADO'
- Ejemplar.estadoFisico: 'Desgastado', 'Bueno', 'Dañado', 'Restaurado', 'Perdido', 'Nuevo'
- Usuario.rol: 'Administrador', 'Lector', 'Bibliotecario'
- Administrador.permisos: 'Solo Lectura', 'Operativo', 'Total'
- Autor.genero: 'Masculino', 'Femenino', 'Otro'

==================================================================================================
6. NOTAS TÉCNICAS IMPORTANTES
==================================================================================================

A) EJECUCIÓN EN SQL*PLUS O SQL DEVELOPER:
---------------------------------
- Cada bloque PL/SQL termina con "/" para ejecutarse
- Los comentarios son "--" para una línea o "/* */" para bloque
-- Usar SET SERVEROUTPUT ON para ver mensajes DBMS_OUTPUT

B) MANEJO DE ERRORES:
-----------------
- DUP_VAL_ON_INDEX: Intento de insertar duplicado en PK o UK
- ORA-02290: Violación de CHECK
- ORA-02291: Violación de FK (clave foránea no encontrada)
- ORA-01400: Intento de insertar NULL en columna NOT NULL

C) RE-EJECUCIÓN DE SCRIPTS:
-------------------------
- Antes de re-ejecutar, ejecutar scripts de limpieza (X)
-Scripts con prefijos "ZV" son re-ejecutables (contienen excepciones para duplicados)

D) PROBLEMAS COMUNES Y SOLUCIONES:
-------------------------------
1) ORA-02291 al ejecutar acciones: Primero ejecutar 03_LLAVES.sql para tener PKs
2) ORA-02290 al ejecutar tuplas: Primero ejecutar 01_TUPLAS.sql antes de datos
3) Trigger no compila: Verificar que las tablas y constraints existan
4) FK no funciona: Verificar orden (ACCIONES debe ir después de LLAVES)

E) DATOS DE PRUEBA:
------------------
- Los scripts OK_NOOK usan prefijo "ZV" para evitar choques
- Siempre ejecutar limpieza antes de pruebas completas

==================================================================================================
7. GUÍA RÁPIDA DE EJECUCIÓN
==================================================================================================

PARA CREAR LA BASE DESDE CERO:
------------------------
1. Conectar como usuario propietario
2. Ejecutar en orden:
   @Fuentes_azules/01_TABLAS.sql
   @Fuentes_azules/02_ATRIBUTOS.sql
   @Fuentes_azules/03_LLAVES.sql
   @Fuentes_azules/04_POBLAR.sql
   @Fuentes_verdes/01_TUPLAS.sql
   @Fuentes_verdes/03_ACCIONES.sql
   @Fuentes_verdes/05_DISPARADORES.sql
   @Fuentes_rosadas/01_VISTAS.sql
   @Fuentes_rosadas/02_INDICES.sql

PARA VERIFICAR ERRORES:
-------------------
SELECT * FROM USER_ERRORS WHERE TYPE IN ('TRIGGER', 'PROCEDURE');
SELECT CONSTRAINT_NAME, TABLE_NAME FROM USER_CONSTRAINTS WHERE STATUS = 'ENABLED';

PARA LIMPIAR TODO:
-----------------
@Fuentes_azules/06_XTABLAS.sql
@Fuentes_verdes/07_XTABLAS.sql

==================================================================================================
FIN DE LA DOCUMENTACIÓN
==================================================================================================
*/
