-- ============================================
-- PROYECTO SEMANAL: NULL y Constraints
-- Semana 07 — NOT NULL, UNIQUE, CHECK, FK
-- Dominio: Banco de Sangre
-- ============================================

-- Activar claves foráneas (obligatorio en SQLite)
PRAGMA foreign_keys = ON;

-- Limpieza de estructura previa para pruebas limpias
DROP TABLE IF EXISTS donations;
DROP TABLE IF EXISTS donors;
DROP TABLE IF EXISTS collection_centers;

-- ============================================
-- PARTE 1: ESQUEMA CON CONSTRAINTS
-- ============================================

-- TABLA PADRE: Centros de Recolección (Categorías/Grupos)
CREATE TABLE collection_centers (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT NOT NULL UNIQUE,          -- UNIQUE: No pueden haber dos sedes con el mismo nombre
    location    TEXT NOT NULL,                 -- NOT NULL: Ubicación obligatoria
    is_active   INTEGER NOT NULL DEFAULT 1     -- DEFAULT: Por defecto activo (1)
);

-- TABLA PRINCIPAL: Donantes e Historial de Donaciones con Constraints Avanzados
CREATE TABLE donors (
    id                  INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name           TEXT NOT NULL,                             -- NOT NULL: Nombre obligatorio
    email               TEXT UNIQUE,                               -- Columna opcional (admite NULL), pero si existe debe ser única
    blood_type          TEXT NOT NULL,                             -- NOT NULL: Tipo de sangre obligatorio
    national_id         TEXT NOT NULL UNIQUE,                      -- UNIQUE: Cédula/Documento de identidad único por donante
    age                 INTEGER NOT NULL CHECK(age >= 18 AND age <= 65) -- CHECK: Restricción de edad legal para donar en Colombia
);

CREATE TABLE donations (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    donor_id        INTEGER NOT NULL,
    center_id       INTEGER NOT NULL,
    volume_ml       INTEGER NOT NULL CHECK(volume_ml >= 200 AND volume_ml <= 600), -- CHECK: Validación de volumen médico seguro
    donation_date   DATETIME DEFAULT CURRENT_TIMESTAMP,
    status          TEXT NOT NULL DEFAULT 'available' CHECK(status IN ('available', 'used', 'expired')), -- CHECK y DEFAULT combinados
    FOREIGN KEY (donor_id) REFERENCES donors(id) ON DELETE RESTRICT,
    FOREIGN KEY (center_id) REFERENCES collection_centers(id) ON DELETE RESTRICT
);


-- ============================================
-- PARTE 2: DATOS DE PRUEBA (Mínimo 30 filas)
-- ============================================

-- Inserción de 3 Centros de Recolección (Categorías base)
INSERT INTO collection_centers (id, name, location) VALUES
(1, 'Sede Central Hospitalaria', 'Avenida Caracas #26-10'),
(2, 'Unidad Móvil de Rescate A', 'Plaza de Bolívar Comercial'),
(3, 'Clínica del Sur Extensión', 'Carrera 10 #45-20 Sur');

-- Inserción de 30 Donantes (Incluye 4 donantes SIN correo electrónico -> NULL realistas)
INSERT INTO donors (id, full_name, email, blood_type, national_id, age) VALUES
(1, 'Carlos Mendoza', 'carlos.m@mail.com', 'O+', '1012345678', 25),
(2, 'Ana Silva', NULL, 'A-', '1023456789', 34), -- NULL 1
(3, 'Luis Andrés Gómez', 'luis.gomez@outlook.com', 'O-', '1034567890', 19),
(4, 'Martha Liliana Paez', NULL, 'B+', '1045678901', 45), -- NULL 2
(5, 'Jorge Eliecer Cortés', 'jorge.c@gmail.com', 'AB+', '1056789012', 60),
(6, 'Diana Carolina Reyes', 'diana.reyes@mail.com', 'O+', '1067890123', 28),
(7, 'Pedro Pablo Infante', NULL, 'A+', '1078901234', 52), -- NULL 3
(8, 'Sandra Milena Ortiz', 'sandra.o@gmail.com', 'O-', '1089012345', 31),
(9, 'Gustavo Adolfo Petro', 'gustavo.p@mail.com', 'B-', '1090123456', 22),
(10, 'Lucía Fernanda Meza', NULL, 'AB-', '1101234567', 41), -- NULL 4
(11, 'Ricardo Antonio Toro', 'ricardo.t@outlook.com', 'O+', '1112345678', 26),
(12, 'Elena Sofía Niño', 'elena.n@gmail.com', 'A+', '1123456789', 38),
(13, 'Pablo Emilio Marín', 'pablo.m@mail.com', 'B+', '1134567890', 47),
(14, 'Claudia Patricia Arce', 'claudia.a@gmail.com', 'O+', '1145678901', 50),
(15, 'Fabio Nelson Beltrán', 'fabio.b@outlook.com', 'O-', '1156789012', 23),
(16, 'Gloria Stella Vargas', 'gloria.v@mail.com', 'A-', '1167890123', 58),
(17, 'Héctor Fabio Castro', 'hector.c@gmail.com', 'B-', '1178901234', 33),
(18, 'Inés María Zabala', 'ines.z@outlook.com', 'AB+', '1189012345', 29),
(19, 'Jaime Alberto Duqu', 'jaime.d@mail.com', 'O+', '1190123456', 44),
(20, 'Karen Julieth Moreno', 'karen.m@gmail.com', 'A+', '1201234567', 21),
(21, 'Leonardo Fabio Cruz', 'leonardo.c@outlook.com', 'O-', '1212345678', 36),
(22, 'Mauricio Andrés Tobón', 'mauricio.t@mail.com', 'B+', '1223456789', 55),
(23, 'Nancy Yaneth Pineda', 'nancy.p@gmail.com', 'AB-', '1234567890', 49),
(24, 'Óscar Iván Zuluaga', 'oscar.z@outlook.com', 'O+', '1245678901', 62),
(25, 'Patricia Elena Guerrero', 'patricia.g@mail.com', 'A-', '1256789012', 27),
(26, 'Ramiro Antonio Suarez', 'ramiro.s@gmail.com', 'O+', '1267890123', 40),
(27, 'Sonia Esperanza Ruiz', 'sonia.r@outlook.com', 'B-', '1278901234', 32),
(28, 'Tomás Alfonso Rojas', 'tomas.r@mail.com', 'O-', '1289012345', 18),
(29, 'Úrsula Valentina Restrepo', 'ursula.r@gmail.com', 'AB+', '1290123456', 43),
(30, 'Víctor Manuel Hugo', 'victor.h@outlook.com', 'A+', '1301234567', 51);


-- ============================================
-- PARTE 3: CONSULTAS CON NULL
-- ============================================

-- TODO: Mostrar items donde columna_opcional IS NULL
-- Reporte de Donantes que requieren actualización de datos de contacto (No tienen email registrado)
SELECT 
    id AS codigo_donante, 
    full_name AS nombre_completo,
    national_id AS documento
FROM donors
WHERE email IS NULL;


-- TODO: Mostrar todos los items usando COALESCE para reemplazar NULL
-- Reporte generalizado de donantes reemplazando vacíos por una etiqueta formal
SELECT
    national_id AS documento,
    full_name AS nombre_completo,
    COALESCE(email, 'No Registra Correo') AS contacto_email,
    blood_type AS tipo_sangre
FROM donors
ORDER BY full_name ASC;