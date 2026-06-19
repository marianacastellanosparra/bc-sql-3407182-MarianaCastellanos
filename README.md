# 🩸 Banco de Sangre - Base de Datos

> **Proyecto Semana 09** | INNER JOIN y LEFT JOIN

## 👋 Bienvenido

Este proyecto implementa consultas avanzadas utilizando `INNER JOIN` y `LEFT JOIN` para conectar múltiples tablas en un banco de sangre. Incluye reportes que relacionan donantes, tipos de sangre y donaciones, detectando patrones de actividad y registros sin actividad.

| Entidad | Descripción | Registros |
|---------|-------------|-----------|
| 🩸 **Blood Types (tipos de sangre)** | Clasificaciones y subtipos | 20 |
| 🩸 **Donors (donantes)** | Personas registradas | 80 |
| 🩸 **Donations (donaciones)** | Historial de extracciones | 84 |

Incluye JOINs de múltiples tablas, detección de huérfanos y reportes agregados.

---

## 🧱 Estructura de la Base de Datos

### 🩸 Tabla: Blood Types (Tipos de Sangre)

Referencia de clasificaciones y subtipos de sangre con niveles de cuidado.

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| `id` | INTEGER | PRIMARY KEY AUTOINCREMENT | Identificador único |
| `group_name` | TEXT | NOT NULL, UNIQUE | Tipo de sangre (ej: 'O+', 'AB-') |
| `rh_factor` | TEXT | NOT NULL, CHECK | Factor Rh (+ o -) |
| `care_level` | TEXT | NOT NULL, DEFAULT 'Normal' | Nivel de cuidado (Normal, Alto, Crítico) |

### 🩸 Tabla: Donors (Donantes)

Información de donantes registrados en el sistema.

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| `id` | INTEGER | PRIMARY KEY AUTOINCREMENT | Identificador único |
| `full_name` | TEXT | NOT NULL | Nombre completo |
| `national_id` | TEXT | NOT NULL, UNIQUE | Cédula/ID Nacional |
| `age` | INTEGER | NOT NULL, CHECK(age >= 18) | Edad mínima 18 años |
| `blood_type_id` | INTEGER | REFERENCES blood_types(id) | Referencia al tipo de sangre |

### 🩸 Tabla: Donations (Donaciones)

Historial de extracciones de sangre realizadas.

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| `id` | INTEGER | PRIMARY KEY AUTOINCREMENT | Identificador único |
| `recorded_at` | TEXT | NOT NULL, DEFAULT DATE('now') | Fecha de extracción |
| `volume_ml` | INTEGER | NOT NULL, CHECK(volume_ml >= 200) | Volumen mínimo 200 ml |
| `status` | TEXT | NOT NULL, DEFAULT 'available' | Estado de la bolsa |
| `donor_id` | INTEGER | REFERENCES donors(id) | Referencia al donante |

---

## 🔗 Diagrama de Relaciones

```
┌─────────────────┐       ┌──────────────┐       ┌──────────────┐
│   blood_types   │       │   donors     │       │  donations   │
├─────────────────┤       ├──────────────┤       ├──────────────┤
│ id (PK)         │       │ id (PK)      │       │ id (PK)      │
│ group_name      │       │ full_name    │       │ recorded_at  │
│ rh_factor       │   ◄───│ national_id  │   ◄───│ volume_ml    │
│ care_level      │       │ age          │       │ status       │
│                 │       │ blood_type   │       │ donor_id (FK)│
│                 │       │ id (FK)      │       │              │
└─────────────────┘       └──────────────┘       └──────────────┘
```

> ✅ Relaciones: Blood Types ← Donors ← Donations (uno a muchos)

---

## 📊 Consultas JOIN del Proyecto

### 🔗 Consulta 1: INNER JOIN Principal
- Une Donantes con Donaciones
- Muestra solo donantes con actividad registrada
- Columnas: nombre, fecha, volumen

### 🔗 Consulta 2: JOIN con 3 Tablas
- Conecta Donantes → Tipos de Sangre → Donaciones
- Información completa de cada extracción
- Columnas: nombre, tipo sangre, fecha, estado

### 🔗 Consulta 3: LEFT JOIN
- Lista todos los donantes sin importar actividad
- Muestra NULL si no tienen donaciones
- Detecta toda la población de donantes

### 🔗 Consulta 4: Huérfanos (LEFT JOIN + IS NULL)
- Filtra donantes sin actividad
- Identifica registros no aprovechados
- Oportunidad de contacto/campañas

### 🔗 Consulta 5: Reporte Agregado
- Conteo de donaciones por donante
- Incluye donantes inactivos (COUNT = 0)
- Ordenado por actividad descendente

---

## 📊 Datos del Proyecto

### 🩸 Tipos de Sangre (20)

| ID | Grupo | Factor Rh | Nivel Cuidado |
|----|-------|-----------|---------------|
| 1 | O+ General | + | Normal |
| 2 | O- Universal | - | Crítico |
| 3 | A+ Subtipo1 | + | Normal |
| ... | ... | ... | ... |
| 20 | O- Pediátrico | - | Crítico |

### 🩸 Donantes (80)

| ID | Nombre | Cédula | Edad | Tipo Sangre |
|----|--------|--------|------|-------------|
| 1 | Carlos Mendoza | 1012345001 | 25 | O+ General |
| 2 | Ana Silva | 1012345002 | 34 | O- Universal |
| ... | ... | ... | ... | ... |
| 80 | Gabriela Mistral | 1012345080 | 26 | ID 12 |

### 🩸 Donaciones (84)

- Volúmenes: 200-520 ml
- Estados: available, used, expired
- Incluye donantes con múltiples donaciones

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

1. Activa claves foráneas (PRAGMA foreign_keys)
2. Limpia tablas existentes
3. Crea las 3 tablas con relaciones
4. Inserta 20 tipos de sangre
5. Inserta 80 donantes
6. Inserta 84 donaciones
7. Ejecuta 5 consultas con JOINs

---

## 🔍 Consultas JOIN

### 🔗 Consulta 1: INNER JOIN Principal

```sql
SELECT
    dor.full_name   AS donante,
    don.recorded_at AS fecha_donacion,
    don.volume_ml   AS mililitros
FROM donors dor
INNER JOIN donations don ON don.donor_id = dor.id;
```

### 🔗 Consulta 2: JOIN con 3 Tablas

```sql
SELECT
    dor.full_name    AS donante,
    bt.group_name    AS tipo_sangre_subtipo,
    don.recorded_at  AS fecha_donacion,
    don.status       AS estado_bolsa
FROM donors dor
INNER JOIN blood_types bt ON dor.blood_type_id = bt.id
INNER JOIN donations   don ON don.donor_id     = dor.id;
```

### 🔗 Consulta 3: LEFT JOIN

```sql
SELECT
    dor.full_name   AS donante,
    don.recorded_at AS fecha_actividad
FROM donors dor
LEFT JOIN donations don ON don.donor_id = dor.id;
```

### 🔗 Consulta 4: Detectar Huérfanos

```sql
SELECT
    dor.full_name AS donante_sin_actividad,
    dor.national_id AS documento_identidad
FROM donors dor
LEFT JOIN donations don ON don.donor_id = dor.id
WHERE don.id IS NULL;
```

### 🔗 Consulta 5: Reporte Agregado

```sql
SELECT
    dor.full_name AS donante,
    COUNT(don.id) AS total_donaciones_realizadas
FROM donors dor
LEFT JOIN donations don ON don.donor_id = dor.id
GROUP BY dor.id, dor.full_name
ORDER BY total_donaciones_realizadas DESC, dor.full_name ASC;
```

---

## 🛡️ Restricciones Implementadas

| Restricción | Tabla | Descripción |
|-------------|-------|-------------|
| `PRIMARY KEY AUTOINCREMENT` | Todas | Identificador único |
| `NOT NULL` | Varios campos | Campo obligatorio |
| `UNIQUE` | blood_types.group_name, donors.national_id | Sin duplicados |
| `CHECK(rh_factor IN ('+', '-'))` | blood_types | Factor Rh válido |
| `CHECK(age >= 18)` | donors | Edad mínima legal |
| `CHECK(volume_ml >= 200)` | donations | Volumen mínimo médico |
| `FOREIGN KEY` | donors, donations | Integridad referencial |

---

## 🧠 Lo que se aprende con este proyecto

- ✔️ Sintaxis de `INNER JOIN` con dos tablas
- ✔️ Encadenamiento de múltiples `INNER JOIN`
- ✔️ Uso de `LEFT JOIN` para incluir registros sin coincidencia
- ✔️ Detección de registros huérfanos con `IS NULL`
- ✔️ Alias de tablas para simplificar consultas
- ✔️ Combinación de JOINs con `GROUP BY` y `COUNT`
- ✔️ Diseño de esquemas con claves foráneas
- ✔️ Integridad referencial con PRAGMA foreign_keys

---

## ⚠️ Notas importantes

- Este es un proyecto de **consultas JOIN**
- Enfatiza `INNER JOIN` vs `LEFT JOIN`
- 80 donantes pero solo 75-84 donaciones (identifica huérfanos)
- Las claves foráneas están activadas (`PRAGMA foreign_keys = ON`)
- El script es idempotente con `DROP TABLE IF EXISTS`
- Algunos donantes tienen múltiples donaciones

---

## 👩‍💻 Autor

**Mariana Castellanos Parra**

📚 Estudiante en formación – Desarrollo de Software

🚀 SENA - Formación en Desarrollo de Software