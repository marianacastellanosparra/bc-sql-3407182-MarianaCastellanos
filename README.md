# 🩸 Banco de Sangre - Base de Datos

> **Proyecto Semana 06** | Funciones de Agregación

## 👋 Bienvenido

Este proyecto implementa funciones de agregación para analizar datos en un banco de sangre. Utiliza `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `GROUP BY` y `HAVING` para generar reportes estadísticos sobre donantes, centros y donaciones.

| Entidad | Descripción | Registros |
|---------|-------------|-----------|
| 🩸 **Donors (donantes)** | Personas que donan sangre | 30 |
| 🏥 **Collection Centers (centros)** | Centros de recolección | 10 |
| 🩸 **Donations (donaciones)** | Bolsas de sangre recolectadas | 30 |

Incluye reportes globales, extremos y agrupados con filtros avanzados.

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

## 📊 Reportes de Agregación del Proyecto

### 📊 Reporte 1: Totales Globales
- **COUNT(*)**: Total de donaciones
- **SUM(volume_ml)**: Total de ml recolectados
- **AVG(volume_ml)**: Promedio de volumen

### 📊 Reporte 2: Extremos
- **MIN(volume_ml)**: Donación mínima
- **MAX(volume_ml)**: Donación máxima

### 📊 Reporte 3: Subtotales por Categoría
- Agrupación por `status` con **GROUP BY**
- **COUNT(*)** y **AVG(volume_ml)** por grupo
- Ordenado por total descendente

### 📊 Reporte 4: Filtro de Grupos
- **HAVING COUNT(*) > 4**: Tipos de sangre con más de 4 donantes
- Agrupación por `blood_type`

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

### 🩸 Donantes (30)

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

- Volumen variado: 410-500 ml
- Estados: available, used

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
4. Ejecuta los reportes de agregación

---

## 🔍 Reportes de Verificación

### 📊 Reporte 1: Totales globales

```sql
SELECT
    COUNT(*) AS total_donaciones,
    SUM(volume_ml) AS total_ml_recolectados,
    AVG(volume_ml) AS promedio_volumen_ml
FROM donations;
```

### 📊 Reporte 2: Extremos

```sql
SELECT
    MIN(volume_ml) AS donacion_minima,
    MAX(volume_ml) AS donacion_maxima
FROM donations;
```

### 📊 Reporte 3: Subtotales por categoría

```sql
SELECT
    status AS estado_donacion,
    COUNT(*) AS total_donaciones,
    ROUND(AVG(volume_ml), 2) AS promedio_volumen_ml
FROM donations
GROUP BY status
ORDER BY total_donaciones DESC;
```

### 📊 Reporte 4: Filtro de grupos

```sql
SELECT
    blood_type AS tipo_sangre,
    COUNT(*) AS total
FROM donors
GROUP BY blood_type
HAVING COUNT(*) > 4;
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

- ✔️ Funciones de agregación: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- ✔️ Agrupación con `GROUP BY`
- ✔️ Filtrado de grupos con `HAVING`
- ✔️ Redondeo con `ROUND`
- ✔️ Ordenamiento con `ORDER BY`
- ✔️ Alias descriptivos en consultas
- ✔️ Creación de reportes estadísticos
- ✔️ Análisis de datos agrupados

---

## ⚠️ Notas importantes

- Este es un proyecto de **funciones de agregación**
- Se enfoca en `COUNT`, `SUM`, `AVG`, `GROUP BY`, `HAVING`
- Los datos incluyen volúmenes variados para análisis
- El script es idempotente gracias a `DROP TABLE IF EXISTS`
- Los reportes generan estadísticas útiles para el negocio

---

## 👩‍💻 Autor

**Mariana Castellanos Parra**

📚 Estudiante en formación – Desarrollo de Software

🚀 SENA - Formación en Desarrollo de Software