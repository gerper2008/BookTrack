<div align="center">
  <img src="https://github.com/gerper2008/BookTrack/blob/main/Formulaci%C3%B3n%20Proyecto/Logo.png" alt="Logo" width=200 />
  <br />
  <br />
  <p> Sistema de información centralizado para el control de inventario, préstamos y devoluciones de recursos bibliográficos (físicos y digitales)[cite: 6, 16, 19]. </p>
</div>

---

## 🎓 Contexto Académico
Este es un proyecto académico desarrollado para la materia de **Modelos y Servicios de Datos**, correspondiente del periodo **2026-01**.

## 👥 Responsables del Proyecto
* **Elián Eduardo Ibarra Contreras**
* **Gerónimo Peralta Acuña**

---

## 📝 Descripción del Proyecto
**BookTrack** nace de la necesidad de sustituir los procesos manuales tradicionales en la gestión de bibliotecas y librerías, los cuales suelen provocar pérdidas de libros, errores administrativos y una falta de seguimiento real sobre los recursos. 
Este sistema automatiza y centraliza la información, facilitando tanto la administración interna como el acceso rápido de los usuarios a los catálogos físicos y digitales.

### 🎯 Objetivos
* **Gestión integral:** Registrar, visualizar, editar y eliminar préstamos y devoluciones.
* **Control de usuarios:** Administrar perfiles de bibliotecarios y lectores/clientes.
* **Sanciones automáticas:** Generar multas y facturas por la entrega tardía de recursos.
* **Consulta ágil:** Permitir la verificación inmediata de la disponibilidad y el formato (físico o digital) de los libros.

### 🚫 Alcance
* **Incluye:** Libros, usuarios, préstamos y multas.
* **No Incluye:** Procesos de compra directa de libros por parte de los lectores de cara al público (el módulo de compras del modelo lógico está restringido al reabastecimiento interno por parte del administrador).

---

## 🗺️ Hitos y Entregables del Proyecto
| Hito / Entregable | Fecha Meta |
| :--- | :--- |
| Modelo conceptual general | Semana 07 (S07)  |
| **Ciclo 1 de desarrollo:** Gestión de libros y usuarios | Semana 13 (S13)  |
| **Ciclo 2 de desarrollo:** Gestión de préstamos y devoluciones | Semana 17 (S17)  |

---

## 🗄️ Modelo Lógico de la Base de Datos (Mini)
La arquitectura de datos relacional del sistema está planificada para evolucionar en dos fases de desarrollo incrementales:

### 🔹 Ciclo 1: Gestión de Libros y Usuarios (10 Conceptos)
En esta primera etapa se establecen los cimientos del catálogo, el control de existencias y la administración básica de usuarios y proveedores:
* **Estructura de Usuarios:** Basada en la entidad base `Usuario` y la extensión especializada `Administrador` (con atributos como `permisos` y `sede`).
* **Catálogo de Libros y Autores:** Organizado mediante las entidades `Libro`, `Autor`, `Autor_Libro`, `Categoria` e `Editorial`.
* **Control de Existencias:** Gestión física y de stock a través de `Edicion` y `Ejemplar` (que controla campos críticos como `estadoFisico`, `disponibilidad` y `localizacion`).
* **Módulo de Adquisiciones Internas:** Soporte para el reabastecimiento de recursos mediante `Proveedor` y `Compra`.

### 🔸 Ciclo 2: Gestión de Préstamos y Devoluciones (6 Conceptos adicionales)
En la segunda fase se incorporará la lógica transaccional del sistema para el flujo de recursos y penalizaciones, añadiendo los conceptos de:
* **Flujo de Recursos:** `Préstamo` y `Devolución` para el rastreo de los ejemplares.
* **Módulo de Sanciones:** `Multa` y `Pago` para la gestión de penalizaciones financieras por entregas tardías.
* **Roles Especializados:** Extensiones o especificaciones para `Bibliotecario` y `Cliente`.

---
