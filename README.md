# 🩸 Banco de Sangre - Base de Datos

> **Proyecto Semana 02** | DDL: Diseño de Esquemas

## 👋 Bienvenido

Este proyecto implementa una base de datos para gestionar un banco de sangre, administrando la relación entre donantes, centros de recolección y donaciones.

| Entidad | Descripción | Registros |
|---------|-------------|-----------|
| 🩸 **Donors (donantes)** | Personas que donan sangre | 5 |
| 🏥 **Collection Centers (centros)** | Centros de recolección | 5 |
| 🩸 **Donations (donaciones)** | Bolsas de sangre recolectadas | 15 |

Incluye creación de tablas con claves foráneas, restricciones CHECK y consultas básicas.

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

## 📊 Datos del Proyecto

### 🏥 Centros de Recolección (5)

| ID | Nombre | Ubicación |
|----|--------|-----------|
| 1 | Estación Central | Centro Ciudad 123 |
| 2 | Hospital del Norte | Avenida Verde 45 |
| 3 | Unidad Móvil A | Plaza Mayor |
| 4 | Clínica del Sur | Calle Roja 789 |
| 5 | Punto Oriente | Zona Industrial |

### 🩸 Donantes (5)

| ID | Nombre | Email | Tipo de Sangre |
|----|--------|-------|----------------|
| 1 | Maria Garcia | maria@mail.com | O+ |
| 2 | Juan Perez | juan@mail.com | A- |
| 3 | Ana Lopez | ana@mail.com | B+ |
| 4 | Luis Rodriguez | luis@mail.com | AB+ |
| 5 | Carla Mendez | carla@mail.com | O- |

### 🩸 Donaciones (15)

- Volumen estándar: 450 ml
- Estados: available, used, expired

---

## ⚙️ ¿Cómo usar este script?

### 1️⃣ Ejecutar el archivo SQL

```bash
sqlite3 banco_sangre.db < proyecto.sql
```

### 2️⃣ Herramientas recomendadas

- **SQLite** (línea de comandos)
- **DB Browser for SQLite**
- **Visual Studio Code** (extensión SQLite)

### 3️⃣ El script se ejecuta en orden

1. Limpia tablas existentes
2. Crea las tablas
3. Inserta los datos
4. Ejecuta consultas de verificación

---

## 🔍 Consultas de Verificación

### 📌 Ver tablas creadas

```sql
.tables
```

### 📌 Contar donaciones

```sql
SELECT 'Conteo de donaciones:' as mensaje, count(*) from donations;
```

### 📌 Ver estructura de la tabla donations

```sql
PRAGMA table_info(donations);
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

- ✔️ Creación de tablas con DDL
- ✔️ Definición de claves primarias AUTOINCREMENT
- ✔️ Definición de claves foráneas
- ✔️ Restricciones CHECK
- ✔️ Restricciones UNIQUE
- ✔️ Valores por defecto (DEFAULT)
- ✔️ Tipos de datos DATE y DATETIME
- ✔️ Inserción de datos (DML)
- ✔️ Consultas básicas con SELECT
- ✔️ Uso de PRAGMA para metadatos

---

## ⚠️ Notas importantes

- Este es un proyecto de **DDL** (Data Definition Language)
- Se implementan **claves foráneas** para integridad referencial
- Los tipos de sangre se validan con **CHECK**
- El estado de las donaciones puede ser: available, used, expired
- El volumen por defecto es **450 ml** (estándar médico)

---

## 🔥 Próximos pasos

- 🔹 Agregar tabla de **pacientes** que reciben sangre
- 🔹 Crear tabla de **hospitales**
- 🔹 Implementar consultas con **JOIN**
- 🔹 Agregar **historial médico** de donantes
- 🔹 Crear vista de **inventario disponible**
- 🔹 Integrar con API (FastAPI)

---

## 👩‍💻 Autor

**Mariana Castellanos Parra**

📚 Estudiante en formación – Desarrollo de Software

🚀 SENA - Formación en Desarrollo de Software