# 🩸 Banco de Sangre - Base de Datos

> **Proyecto Semana 05** | BETWEEN, IN, LIKE

## 👋 Bienvenido

Este proyecto implementa consultas de filtrado avanzadas para gestionar un banco de sangre. Trabaja con operadores `BETWEEN`, `IN` y `LIKE` sobre datos de donantes, centros de recolección y donaciones.

| Entidad | Descripción | Registros |
|---------|-------------|-----------|
| 🩸 **Donors (donantes)** | Personas que donan sangre | 30 |
| 🏥 **Collection Centers (centros)** | Centros de recolección | 10 |
| 🩸 **Donations (donaciones)** | Bolsas de sangre recolectadas | 30 |

Incluye creación de tablas, inserción de datos y consultas con filtros avanzados.

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

- Volumen estándar: 450 ml (con variaciones)
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
4. Ejecuta las consultas de filtro

---

## 🔍 Consultas de Verificación

### 📌 Consulta 1: Filtro con BETWEEN
```sql
SELECT 
    id AS Folio_Donacion, 
    volume_ml AS Volumen, 
    status AS Estado 
FROM donations 
WHERE volume_ml BETWEEN 460 AND 500;
```

### 📌 Consulta 2: Filtro con IN
```sql
SELECT 
    full_name AS Donante, 
    blood_type AS Tipo 
FROM donors 
WHERE blood_type IN ('O+', 'O-', 'AB+');
```

### 📌 Consulta 3: Búsqueda con LIKE
```sql
SELECT 
    full_name AS Nombre, 
    email AS Correo 
FROM donors 
WHERE email LIKE '%.com%';
```

### 📌 Consulta 4: Filtro combinado
```sql
SELECT 
    id, 
    volume_ml, 
    status 
FROM donations 
WHERE volume_ml BETWEEN 400 AND 500 
  AND status IN ('available', 'reserved') 
  AND status LIKE 'avai%'
ORDER BY volume_ml DESC;
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

- ✔️ Uso de `BETWEEN` para rangos
- ✔️ Uso de `IN` para múltiples valores
- ✔️ Uso de `LIKE` para patrones
- ✔️ Consultas combinadas con varias condiciones
- ✔️ Ordenamiento con `ORDER BY`
- ✔️ Control de resultados con `LIMIT` y `OFFSET`
- ✔️ Creación de tablas con DDL
- ✔️ Inserción masiva de datos

---

## ⚠️ Notas importantes

- Este es un proyecto de **consultas y filtros**
- Se enfoca en operadores `BETWEEN`, `IN` y `LIKE`
- Los datos incluyen 10 centros, 30 donantes y 30 donaciones
- El script es idempotente gracias a `DROP TABLE IF EXISTS`
- El estado de las donaciones utiliza `available` y `used`

---

## 🔥 Próximos pasos

- 🔹 Agregar consultas con `JOIN`
- 🔹 Incluir `GROUP BY` y agregaciones
- 🔹 Añadir filtros por fecha con `BETWEEN`
- 🔹 Crear vistas para consultas frecuentes
- 🔹 Agregar más patrones `LIKE`
- 🔹 Implementar triggers para reglas de negocio

---

## 👩‍💻 Autor

**Mariana Castellanos Parra**

📚 Estudiante en formación – Desarrollo de Software

🚀 SENA - Formación en Desarrollo de Software