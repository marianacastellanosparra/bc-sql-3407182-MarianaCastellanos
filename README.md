# 🩸 Banco de Sangre - Base de Datos

> **Proyecto Semana 03** | DML: Manipulación de Datos

## 👋 Bienvenido

Este proyecto implementa operaciones de **Manipulación de Datos (DML)** para gestionar un banco de sangre, administrando la relación entre donantes, centros de recolección y donaciones. Incluye inserción masiva de datos, actualizaciones con justificaciones de negocio y eliminaciones seguras.

| Entidad | Descripción | Registros Iniciales |
|---------|-------------|---------------------|
| 🩸 **Donors (donantes)** | Personas que donan sangre | 15 |
| 🏥 **Collection Centers (centros)** | Centros de recolección | 5 |
| 🩸 **Donations (donaciones)** | Bolsas de sangre recolectadas | 15 |

Incluye operaciones DML con justificaciones de negocio y consultas de verificación.

---

## 🧱 Estructura de la Base de Datos

### 🏥 Tabla: Collection Centers (Centros de Recolección)

Registra los centros donde se realizan las donaciones de sangre.

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| `id` | INTEGER | PRIMARY KEY AUTOINCREMENT | Identificador único |
| `name` | TEXT | NOT NULL, UNIQUE | Nombre del centro |
| `location` | TEXT | NOT NULL | Ubicación/dirección |
| `is_active` | INTEGER | NOT NULL, DEFAULT 1 | Estado (1: activo, 0: inactivo) |

### 🩸 Tabla: Donors (Donantes)

Almacena la información de los donantes de sangre.

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| `id` | INTEGER | PRIMARY KEY AUTOINCREMENT | Identificador único |
| `full_name` | TEXT | NOT NULL | Nombre completo |
| `email` | TEXT | UNIQUE | Correo electrónico |
| `blood_type` | TEXT | NOT NULL, CHECK | Tipo de sangre (A+, A-, B+, B-, AB+, AB-, O+, O-) |
| `last_donation_date` | DATE | - | Fecha de última donación |

### 🩸 Tabla: Donations (Donaciones)

Registra las bolsas de sangre recolectadas.

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| `id` | INTEGER | PRIMARY KEY AUTOINCREMENT | Identificador único |
| `donor_id` | INTEGER | NOT NULL, FOREIGN KEY | Referencia al donante |
| `center_id` | INTEGER | NOT NULL, FOREIGN KEY | Referencia al centro |
| `volume_ml` | INTEGER | NOT NULL, DEFAULT 450, CHECK(volume_ml > 0) | Volumen en ml |
| `donation_date` | DATETIME | DEFAULT CURRENT_TIMESTAMP | Fecha de donación |
| `status` | TEXT | DEFAULT 'available', CHECK | Estado (available, used, expired) |

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
│             │       │ volume_ml   │       │ last_       │
│             │       │ donation_   │       │ donation_   │
│             │       │ date        │       │ date        │
│             │       │ status      │       │             │
└─────────────┘       └─────────────┘       └─────────────┘
```

> ✅ Relación uno a muchos: Un donante puede realizar múltiples donaciones.

---

## 📊 Operaciones DML del Proyecto

### ➕ Parte 1: INSERT INTO (Inserción Masiva)

- **15 donantes** insertados con datos variados.
- **5 centros de recolección** con ubicaciones distintas.
- **15 donaciones** respetando claves foráneas, con volúmenes y estados variados.

### 🔄 Parte 2: UPDATE (Actualizaciones con Justificación)

- Actualización de nombre de donante (cambio legal).
- Cambio de ubicación y desactivación de centro (traslado temporal).
- Marcado de donaciones como 'expired' (fallas en refrigeración).

### 🗑️ Parte 3: DELETE SEGURO (Eliminación Segura)

- Verificación previa de filas a eliminar (donaciones 'used').
- Eliminación de registros utilizados para depurar inventario.

---

## 📊 Datos del Proyecto

### 🏥 Centros de Recolección (5)

| ID | Nombre | Ubicación |
|----|--------|-----------|
| 1 | Estación Central | Centro Ciudad 123 |
| 2 | Hospital del Norte | Avenida Verde 45 |
| 3 | Unidad Móvil A | Plaza Mayor |
| 4 | Clínica del Sur | Calle Roja 789 |
| 5 | Punto Oriente | Zona Industrial |

### 🩸 Donantes (15 - Muestra)

| ID | Nombre | Email | Tipo de Sangre |
|----|--------|-------|----------------|
| 1 | Maria Garcia Hernandez | maria@mail.com | O+ |
| 2 | Juan Perez | juan@mail.com | A- |
| ... | ... | ... | ... |
| 15 | Bruce Wayne | bwayne@email.com | AB- |

### 🩸 Donaciones (Estado Final: ~10 tras operaciones)

- Volumen estándar: 450 ml (con variaciones)
- Estados: available, used, expired

---

## ⚙️ ¿Cómo usar este script?

### 1️⃣ Ejecutar el archivo SQL

```bash
sqlite3 mi_dominio.db < starter/proyecto.sql
```

### 2️⃣ Herramientas recomendadas

- **SQLite** (línea de comandos)
- **DB Browser for SQLite**
- **Visual Studio Code** (extensión SQLite)

### 3️⃣ El script se ejecuta en orden

1. Limpia tablas existentes (idempotente)
2. Crea las tablas
3. Inserta los datos (INSERT)
4. Actualiza registros (UPDATE)
5. Elimina registros seguros (DELETE)
6. Ejecuta consultas de verificación

---

## 🔍 Consultas de Verificación

### 📌 Ver tablas creadas

```sql
.tables
```

### 📌 Contar donaciones finales

```sql
SELECT 'Donaciones restantes:' as mensaje, count(*) from donations;
```

### 📌 Ver donaciones por estado

```sql
SELECT status, count(*) as cantidad FROM donations GROUP BY status;
```

---

## 🛡️ Restricciones Implementadas

| Restricción | Tabla | Descripción |
|-------------|-------|-------------|
| `PRIMARY KEY AUTOINCREMENT` | Todas | Identificador único |
| `NOT NULL` | Varios campos | Campo obligatorio |
| `UNIQUE` | collection_centers.name, donors.email | Sin duplicados |
| `CHECK(blood_type IN (...))` | donors.blood_type | Tipos válidos |
| `CHECK(status IN (...))` | donations.status | Estados válidos |
| `CHECK(volume_ml > 0)` | donations.volume_ml | Volumen positivo |
| `DEFAULT 450` | donations.volume_ml | Volumen por defecto |
| `DEFAULT 'available'` | donations.status | Estado por defecto |
| `DEFAULT CURRENT_TIMESTAMP` | donations.donation_date | Fecha automática |
| `FOREIGN KEY` | donations | Integridad referencial |

---

## 🧠 Lo que se aprende con este proyecto

- ✔️ Inserción masiva con **INSERT INTO**
- ✔️ Actualizaciones selectivas con **UPDATE** y WHERE
- ✔️ Eliminaciones seguras con **DELETE** y verificación previa
- ✔️ Justificaciones de negocio para operaciones DML
- ✔️ Consultas de verificación sin usar `*`
- ✔️ Integridad referencial con claves foráneas
- ✔️ Restricciones CHECK en tipos de sangre y estados
- ✔️ Valores por defecto y timestamps automáticos
- ✔️ Operaciones idempotentes (DROP IF EXISTS)

---

## ⚠️ Notas importantes

- Este es un proyecto de **DML** (Data Manipulation Language)
- Las operaciones incluyen **justificaciones de negocio**
- Se verifica antes de eliminar para evitar pérdidas accidentales
- El script es **idempotente**: puede ejecutarse múltiples veces
- Los estados de donaciones afectan el inventario disponible

---


## 👩‍💻 Autor

**Mariana Castellanos Parra**

📚 Estudiante en formación – Desarrollo de Software

🚀 SENA - Formación en Desarrollo de Software