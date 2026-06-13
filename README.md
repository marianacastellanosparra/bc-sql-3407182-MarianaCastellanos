# 🩸 Banco de Sangre - Base de Datos

> **Proyecto Semana 07** | NULL y Constraints

## 👋 Bienvenido

Este proyecto implementa restricciones de integridad y manejo de `NULL` en un banco de sangre. El script usa `NOT NULL`, `UNIQUE`, `CHECK`, `FOREIGN KEY`, `PRAGMA foreign_keys`, `COALESCE` y `IS NULL` para mantener la calidad de los datos.

EntidadDescripciónRegistros
🩸 **Donors (donantes)**Personas que donan sangre30
🏥 **Collection Centers (centros)**Centros de recolección3
🩸 **Donations (donaciones)**Bolsas de sangre recolectadas0* 

*La tabla `donations` está definida para el modelo relacional, pero el script actual no inserta filas de donación de ejemplo.

---

## 🧱 Estructura de la Base de Datos

### 🏥 Tabla: Collection Centers (Centros de Recolección)
Registra los centros donde se realizan las donaciones de sangre.

CampoTipoRestriccionesDescripción
`id`INTEGERPRIMARY KEY AUTOINCREMENTIdentificador único
`name`TEXTNOT NULL, UNIQUENombre del centro
`location`TEXTNOT NULLUbicación/dirección
`is_active`INTEGERNOT NULL, DEFAULT 1Estado (1: activo, 0: inactivo)

### 🩸 Tabla: Donors (Donantes)
Almacena la información de los donantes de sangre.

CampoTipoRestriccionesDescripción
`id`INTEGERPRIMARY KEY AUTOINCREMENTIdentificador único
`full_name`TEXTNOT NULLNombre completo
`email`TEXTUNIQUECorreo electrónico
`blood_type`TEXTNOT NULLTipo de sangre
`national_id`TEXTNOT NULL, UNIQUEDocumento único
`age`INTEGERNOT NULL, CHECK(age >= 18 AND age <= 65)Edad válida para donar

### 🩸 Tabla: Donations (Donaciones)
Registra las bolsas de sangre recolectadas.

CampoTipoRestriccionesDescripción
`id`INTEGERPRIMARY KEY AUTOINCREMENTIdentificador único
`donor_id`INTEGERNOT NULL, FOREIGN KEYReferencia al donante
`center_id`INTEGERNOT NULL, FOREIGN KEYReferencia al centro
`volume_ml`INTEGERNOT NULL, CHECK(volume_ml >= 200 AND volume_ml <= 600)Volumen en ml
`donation_date`DATETIMEDEFAULT CURRENT_TIMESTAMPFecha de donación
`status`TEXTNOT NULL DEFAULT 'available', CHECK(status IN ('available', 'used', 'expired'))Estado

---

## 🔗 Diagrama de Relaciones

```
┌─────────────┐       ┌─────────────┐       ┌─────────────┐
│ collection_ │       │  donations  │       │   donors    │
│   centers   │       │             │       │             │
├─────────────┤       ├─────────────┤       ├─────────────┤
│ id (PK)     │◄──────│ center_id   │       │ id (PK)     │
│ name        │       │ (FK)        │       │ full_name   │
│ location    │       │ donor_id    │───────│ (FK)        │
│ is_active   │       │ (FK)        │       │ email       │
│             │       │ id (PK)     │       │ blood_type  │
│             │       │ volume_ml   │       │ national_id │
│             │       │ donation_   │       │ age         │
│             │       │ date        │       │             │
│             │       │ status      │       │             │
└─────────────┘       └─────────────┘       └─────────────┘
```

> ✅ Relación uno a muchos: Un donante puede realizar múltiples donaciones.

---

## 📊 Reportes del Proyecto

Este script incluye consultas de verificación basadas en `NULL` y la calidad de los datos.

### 📊 Reporte 1: Donantes sin correo registrado

- Busca donantes que no han completado su correo electrónico.

```sql
SELECT 
    id AS codigo_donante,
    full_name AS nombre_completo,
    national_id AS documento
FROM donors
WHERE email IS NULL;
```

### 📊 Reporte 2: Donantes con `COALESCE`

- Reemplaza valores `NULL` en el correo con un texto descriptivo.

```sql
SELECT
    national_id AS documento,
    full_name AS nombre_completo,
    COALESCE(email, 'No Registra Correo') AS contacto_email,
    blood_type AS tipo_sangre
FROM donors
ORDER BY full_name ASC;
```

---

## 📊 Datos del Proyecto

### 🏥 Centros de Recolección (3)
IDNombreUbicación
1Sede Central HospitalariaAvenida Caracas #26-10
2Unidad Móvil de Rescate APlaza de Bolívar Comercial
3Clínica del Sur ExtensiónCarrera 10 #45-20 Sur

### 🩸 Donantes (30)
El script inserta 30 donantes, incluyendo múltiples casos con `email = NULL` para validar el manejo de datos incompletos.

### 🩸 Donaciones (0)
La tabla `donations` está creada con sus constraints, pero el script no añade filas de donación de ejemplo.

---

## ⚙️ ¿Cómo usar este script?

### 1️⃣ Ejecutar el archivo SQL

```
sqlite3 starter/banco_sangre.db < starter/proyecto.sql
```

### 2️⃣ Herramientas recomendadas

- **SQLite** (línea de comandos)
- **DB Browser for SQLite**
- **Visual Studio Code** (extensión SQLite)

### 3️⃣ El script se ejecuta en orden

1. Limpia tablas existentes
2. Crea las tablas
3. Inserta los datos de prueba
4. Ejecuta las consultas de verificación

---

## 🔍 Reportes de Verificación

### 📊 Reporte 1: Donantes sin correo

```sql
SELECT 
    id AS codigo_donante,
    full_name AS nombre_completo,
    national_id AS documento
FROM donors
WHERE email IS NULL;
```

### 📊 Reporte 2: Donantes con contacto alternativo

```sql
SELECT
    national_id AS documento,
    full_name AS nombre_completo,
    COALESCE(email, 'No Registra Correo') AS contacto_email,
    blood_type AS tipo_sangre
FROM donors
ORDER BY full_name ASC;
```

---

## 🛡️ Restricciones Implementadas

RestricciónTablaDescripción
`PRIMARY KEY AUTOINCREMENT`TodasIdentificador único
`NOT NULL`Varios camposCampos obligatorios
`UNIQUE`collection_centers.name, donors.email, donors.national_idSin duplicados
`CHECK`donors.age, donations.volume_ml, donations.statusValidación de rango/valor
`DEFAULT`collection_centers.is_active=1, donations.donation_date, donations.statusValores por defecto
`FOREIGN KEY`donationsIntegridad referencial

---

## 🧠 Lo que se aprende con este proyecto

- ✔️ Uso de `NOT NULL` para campos obligatorios
- ✔️ Uso de `UNIQUE` para evitar duplicados
- ✔️ Uso de `CHECK` para validar rangos y valores permitidos
- ✔️ Uso de `FOREIGN KEY` para relaciones referenciales
- ✔️ Manejo de `NULL` con `IS NULL` y `COALESCE`
- ✔️ Creación de un script idempotente con `DROP TABLE IF EXISTS`

---

## ⚠️ Notas importantes

- Este proyecto se enfoca en `NULL` y `constraints`, no en agregaciones.
- SQLite requiere `PRAGMA foreign_keys = ON;` para validar las claves foráneas.
- El script es reutilizable y puede ejecutarse varias veces gracias a `DROP TABLE IF EXISTS`.

---

## 👩‍💻 Autor
**Mariana Castellanos Parra**

📚 Estudiante en formación – Desarrollo de Software

🚀 SENA - Formación en Desarrollo de Software
