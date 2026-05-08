# 🩸 Banco de Sangre - Base de Datos

> **Proyecto Semana 04** | SELECT: Consultas y Filtros

## 👋 Bienvenido

Este proyecto implementa **consultas SELECT avanzadas** para gestionar un banco de sangre, utilizando cláusulas como WHERE, ORDER BY, LIMIT y OFFSET. Incluye preparación de datos con DDL e inserciones masivas, seguido de 5 consultas prácticas con criterios de negocio.

| Entidad | Descripción | Registros |
|---------|-------------|-----------|
| 🩸 **Donors (donantes)** | Personas que donan sangre | 30 |
| 🏥 **Collection Centers (centros)** | Centros de recolección | 10 |
| 🩸 **Donations (donaciones)** | Bolsas de sangre recolectadas | 30 |

Incluye consultas con alias, filtros simples/combinados, top-N y paginación.

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
| `blood_type` | TEXT | NOT NULL | Tipo de sangre |
| `last_donation_date` | DATE | - | Fecha de última donación |

### 🩸 Tabla: Donations (Donaciones)

Registra las bolsas de sangre recolectadas.

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| `id` | INTEGER | PRIMARY KEY AUTOINCREMENT | Identificador único |
| `donor_id` | INTEGER | NOT NULL, FOREIGN KEY | Referencia al donante |
| `center_id` | INTEGER | NOT NULL, FOREIGN KEY | Referencia al centro |
| `volume_ml` | INTEGER | NOT NULL, DEFAULT 450 | Volumen en ml |
| `donation_date` | DATETIME | DEFAULT CURRENT_TIMESTAMP | Fecha de donación |
| `status` | TEXT | DEFAULT 'available' | Estado |

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

## 📊 Consultas SELECT del Proyecto

### 🔍 Consulta 1: Listado General con Alias
- Lista 4 columnas de donantes con alias en español.
- Columnas: ID, nombre completo, email, tipo de sangre.

### 🔍 Consulta 2: Filtro Simple
- Filtra donantes por tipo de sangre 'O-'.
- Usa WHERE con condición de igualdad.

### 🔍 Consulta 3: Filtro Combinado (AND)
- Filtra donantes con tipo 'A+' y fecha posterior a '2024-01-01'.
- Combina condiciones con AND.

### 🔍 Consulta 4: Top-N con ORDER BY + LIMIT
- Recupera los 5 donantes más recientes (ID más alto).
- Ordena por ID DESC y limita a 5.

### 🔍 Consulta 5: Paginación con OFFSET
- Página 1: Primeros 3 donantes ordenados alfabéticamente.
- Página 2: Siguientes 3 donantes.

---

## 📊 Datos del Proyecto

### 🏥 Centros de Recolección (10)

| ID | Nombre | Ubicación |
|----|--------|-----------|
| 1 | Estación Central | Calle 1 |
| 2 | Hospital Norte | Calle 2 |
| 3 | Unidad Móvil A | Plaza 1 |
| 4 | Clínica Sur | Calle 3 |
| 5 | Punto Oriente | Calle 4 |
| 6 | Centro Medico | Calle 5 |
| 7 | Puesto Oeste | Calle 6 |
| 8 | Unidad Móvil B | Plaza 2 |
| 9 | Clínica Esperanza | Calle 7 |
| 10 | Laboratorio | Calle 8 |

### 🩸 Donantes (30 - Muestra)

| ID | Nombre | Email | Tipo de Sangre |
|----|--------|-------|----------------|
| 1 | Maria Garcia | m@mail.com | O+ |
| 2 | Juan Perez | j@mail.com | A- |
| 3 | Ana Lopez | a@mail.com | B+ |
| 4 | Luis Rodriguez | l@mail.com | AB+ |
| 5 | Carla Mendez | c@mail.com | O- |
| ... | ... | ... | ... |
| 30 | Barry A | ba@mail.com | B+ |

### 🩸 Donaciones (30)

- Volumen estándar: 450 ml (con variaciones)
- Estados: available, used

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
3. Inserta los datos
4. Ejecuta las 5 consultas SELECT

---

## 🔍 Ejemplos de Consultas

### 📌 Consulta 1: Listado con alias

```sql
SELECT 
    id AS Folio_Donante,
    full_name AS Nombre_Completo,
    email AS Correo_Electronico,
    blood_type AS Tipo_Sangre
FROM donors;
```

### 📌 Consulta 2: Filtro simple

```sql
SELECT id, full_name, blood_type
FROM donors
WHERE blood_type = 'O-';
```

### 📌 Consulta 3: Filtro combinado

```sql
SELECT full_name, blood_type, last_donation_date
FROM donors
WHERE blood_type = 'A+'
  AND last_donation_date > '2024-01-01';
```

### 📌 Consulta 4: Top-N

```sql
SELECT 
    id AS ID_Prioritario, 
    full_name AS Nombre_Donante, 
    email AS Contacto
FROM donors
ORDER BY id DESC
LIMIT 5;
```

### 📌 Consulta 5: Paginación

```sql
-- Página 1
SELECT id, full_name, blood_type
FROM donors
ORDER BY full_name ASC
LIMIT 3 OFFSET 0;

-- Página 2
SELECT id, full_name, blood_type
FROM donors
ORDER BY full_name ASC
LIMIT 3 OFFSET 3;
```

---

## 🛡️ Restricciones Implementadas

| Restricción | Tabla | Descripción |
|-------------|-------|-------------|
| `PRIMARY KEY AUTOINCREMENT` | Todas | Identificador único |
| `NOT NULL` | Varios campos | Campo obligatorio |
| `UNIQUE` | collection_centers.name, donors.email | Sin duplicados |
| `DEFAULT 450` | donations.volume_ml | Volumen por defecto |
| `DEFAULT 'available'` | donations.status | Estado por defecto |
| `DEFAULT CURRENT_TIMESTAMP` | donations.donation_date | Fecha automática |
| `FOREIGN KEY` | donations | Integridad referencial |

---

## 🧠 Lo que se aprende con este proyecto

- ✔️ Consultas SELECT con columnas explícitas
- ✔️ Uso de alias (AS) en español
- ✔️ Filtros con WHERE y condiciones simples
- ✔️ Filtros combinados con AND/OR
- ✔️ Ordenamiento con ORDER BY
- ✔️ Limitación de resultados con LIMIT
- ✔️ Paginación con OFFSET
- ✔️ Criterios de negocio en consultas
- ✔️ Preparación de datos con DDL e INSERT

---

## ⚠️ Notas importantes

- Este es un proyecto de **consultas SELECT**
- Se enfoca en cláusulas WHERE, ORDER BY, LIMIT/OFFSET
- Los datos incluyen 30 donantes y 30 donaciones para resultados variados
- Las consultas usan alias descriptivos
- El script es idempotente

---

## 👩‍💻 Autor

**Mariana Castellanos Parra**

📚 Estudiante en formación – Desarrollo de Software

🚀 SENA - Formación en Desarrollo de Software