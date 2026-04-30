# 🩸 Sistema de Gestión de Donantes de Sangre

> **Proyecto Semana 01** | Bases de Datos Relacionales

## 👋 Bienvenido

Este proyecto implementa una base de datos para gestionar un banco de sangre, administrando:

| Entidad | Descripción |
|---------|-------------|
| 🩸 **Donantes (donors)** | Personas que donan sangre |
| 📋 **Donaciones (donations)** | Registros de las donaciones realizadas |

Incluye creación de tablas con claves foráneas, inserción de datos y consultas básicas.

---

## 🧱 Estructura de la Base de Datos

### 🩸 Tabla: Donors (Donantes)

Almacena la información de los donantes de sangre.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `id` | INTEGER | Identificador único (autoincremental) |
| `full_name` | TEXT | Nombre completo del donante |
| `blood_type` | TEXT | Tipo de sangre (A+, A-, B+, B-, AB+, AB-, O+, O-) |
| `email` | TEXT | Correo electrónico (único) |
| `phone` | TEXT | Teléfono de contacto |
| `is_eligible` | INTEGER | Estado de elegibilidad (1: Apto, 0: En periodo de espera) |

### 📋 Tabla: Donations (Donaciones)

Registra las donaciones de sangre realizadas.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `id` | INTEGER | Identificador único (autoincremental) |
| `donor_id` | INTEGER | Referencia al donante (FOREIGN KEY) |
| `donation_date` | TEXT | Fecha de la donación |
| `volume_ml` | INTEGER | Volumen donado en mililitros |
| `hospital_unit` | TEXT | Unidad hospitalaria donde se realizó |

---

## 🔗 Relaciones

```
┌─────────────┐       ┌─────────────┐
│   donors    │       │  donations │
├─────────────┤       ├─────────────┤
│ id (PK)     │◄──────│ donor_id    │
│ full_name   │       │ (FK)        │
│ blood_type  │       │ id (PK)     │
│ email       │       │ donation_   │
│ phone       │       │ date        │
│ is_eligible │       │ volume_ml   │
└─────────────┘       │ hospital_   │
                      │ unit        │
                      └─────────────┘
```

> ✅ Relación uno a muchos: Un donante puede realizar múltiples donaciones.

---

## 📊 Datos del Proyecto

- 🩸 **15 donantes** (con tipos de sangre diversos)
- 📋 **5 donaciones** registradas

> ✅ Todos los datos fueron diseñados con valores realistas.

---

## ⚙️ ¿Cómo usar este script?

### 1️⃣ Ejecutar el archivo SQL

Puedes usar herramientas como:

- **SQLite** (línea de comandos)
- **DB Browser for SQLite**
- **Visual Studio Code** (extensión SQLite)

### 2️⃣ Ejemplo de ejecución

```bash
sqlite3 banco_sangre.db < proyecto.sql
```

### 3️⃣ Ejecutar en orden

El script ya está organizado:

1. Elimina tablas existentes
2. Crea las tablas
3. Inserta los datos
4. Ejecuta consultas

---

## 🔍 Consultas incluidas

### 📌 Listar todos los donantes

```sql
SELECT id, full_name, blood_type, email, phone, is_eligible
FROM   donors;
```

### 📌 Donantes ordenados alfabéticamente

```sql
SELECT full_name
FROM   donors
ORDER BY full_name ASC;
```

### 📌 Contar total de donantes

```sql
SELECT COUNT(id) AS total_donantes
FROM   donors;
```

### 📌 Listar donaciones con información del donante

```sql
SELECT id, donor_id, donation_date, volume_ml, hospital_unit
FROM   donations;
```

---

## 🧠 Lo que se aprende con este proyecto

- ✔️ Creación de tablas (DDL)
- ✔️ Definición de claves primarias (PRIMARY KEY)
- ✔️ Definición de claves foráneas (FOREIGN KEY)
- ✔️ Restricciones UNIQUE y DEFAULT
- ✔️ Inserción de datos (DML)
- ✔️ Consultas básicas con SELECT
- ✔️ Uso de ORDER BY
- ✔️ Uso de COUNT
- ✔️ Organización de scripts SQL

---

## ⚠️ Notas importantes

- Se implementan **claves foráneas** para mantener la integridad referencial
- Los emails de donantes son **únicos** (no se permiten duplicados)
- El campo `is_eligible` indica si el donante puede donate nuevamente

---

## 🔥 Próximos pasos

- 🔹 Agregar tabla de **ubicaciones** (cities)
- 🔹 Implementar consultas con **JOIN**
- 🔹 Agregar **historial médico** de donantes
- 🔹 Crear vista de **donantes activos**
- 🔹 Integrar con API (FastAPI)

---

## 👩‍💻 Autor

**Mariana Castellanos Parra**

📚 Estudiante en formación – Desarrollo de Software

🚀 SENA - Formación en Desarrollo de Software