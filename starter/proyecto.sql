-- ============================================
-- PROYECTO SEMANAL: NULL y Constraints
-- Semana 07 — NOT NULL, UNIQUE, CHECK, FK
-- Dominio: Banco de Sangre (CORREGIDO)
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

-- TABLA SECUNDARIA: Donantes 
CREATE TABLE donors (
    id                  INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name           TEXT NOT NULL,                             -- NOT NULL: Nombre obligatorio
    email               TEXT UNIQUE,                               -- Columna opcional (admite NULL)
    blood_type          TEXT NOT NULL,                             -- NOT NULL: Tipo de sangre obligatorio
    national_id         TEXT NOT NULL UNIQUE,                      -- UNIQUE: Cédula única
    age                 INTEGER NOT NULL CHECK(age >= 18 AND age <= 65) -- CHECK: Edad legal
);

-- TABLA PRINCIPAL: Historial de Donaciones con Constraints Avanzados
CREATE TABLE donations (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    donor_id        INTEGER NOT NULL,
    center_id       INTEGER NOT NULL,
    volume_ml       INTEGER NOT NULL CHECK(volume_ml >= 200 AND volume_ml <= 600), -- CHECK: Volumen médico seguro
    donation_date   DATETIME,                                                      -- Columna opcional (admite NULL para simular contingencias)
    status          TEXT CHECK(status IN ('available', 'used', 'expired')),        -- Columna opcional (admite NULL para análisis de laboratorio pendientes)
    FOREIGN KEY (donor_id) REFERENCES donors(id) ON DELETE RESTRICT,
    FOREIGN KEY (center_id) REFERENCES collection_centers(id) ON DELETE RESTRICT
);


-- ============================================
-- PARTE 2: DATOS DE PRUEBA
-- ============================================

-- Inserción de 3 Centros de Recolección (Categorías base)
INSERT INTO collection_centers (id, name, location) VALUES
(1, 'Sede Central Hospitalaria', 'Avenida Caracas #26-10'),
(2, 'Unidad Móvil de Rescate A', 'Plaza de Bolívar Comercial'),
(3, 'Clínica del Sur Extensión', 'Carrera 10 #45-20 Sur');

-- Inserción de 30 Donantes 
INSERT INTO donors (id, full_name, email, blood_type, national_id, age) VALUES
(1, 'Carlos Mendoza', 'carlos.m@mail.com', 'O+', '1012345678', 25),
(2, 'Ana Silva', NULL, 'A-', '1023456789', 34),
(3, 'Luis Andrés Gómez', 'luis.gomez@outlook.com', 'O-', '1034567890', 19),
(4, 'Martha Liliana Paez', NULL, 'B+', '1045678901', 45),
(5, 'Jorge Eliecer Cortés', 'jorge.c@gmail.com', 'AB+', '1056789012', 60),
(6, 'Diana Carolina Reyes', 'diana.reyes@mail.com', 'O+', '1067890123', 28),
(7, 'Pedro Pablo Infante', NULL, 'A+', '1078901234', 52),
(8, 'Sandra Milena Ortiz', 'sandra.o@gmail.com', 'O-', '1089012345', 31),
(9, 'Gustavo Adolfo Petro', 'gustavo.p@mail.com', 'B-', '1090123456', 22),
(10, 'Lucía Fernanda Meza', NULL, 'AB-', '1101234567', 41),
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

-- Inserción Obligatoria de 30 filas en la Tabla Principal (Donations)
-- Incluye 4 registros con status = NULL (Simula pruebas de laboratorio pendientes)
INSERT INTO donations (donor_id, center_id, volume_ml, donation_date, status) VALUES
(1, 1, 450, '2026-06-01 08:30:00', 'available'),
(2, 1, 500, '2026-06-01 09:15:00', 'used'),
(3, 2, 450, '2026-06-02 10:00:00', 'available'),
(4, 3, 480, '2026-06-02 14:20:00', NULL),        -- NULL 1: Estado pendiente
(5, 1, 520, '2026-06-03 11:05:00', 'available'),
(6, 2, 450, '2026-06-04 07:45:00', 'used'),
(7, 2, 450, '2026-06-05 08:00:00', 'expired'),
(8, 3, 490, '2026-06-05 16:30:00', 'available'),
(9, 1, 450, '2026-06-06 09:00:00', NULL),        -- NULL 2: Estado pendiente
(10, 2, 550, '2026-06-07 13:10:00', 'used'),
(11, 1, 450, '2026-06-08 10:25:00', 'available'),
(12, 3, 460, '2026-06-08 15:40:00', 'available'),
(13, 2, 450, '2026-06-09 08:50:00', 'used'),
(14, 1, 500, '2026-06-10 11:15:00', 'expired'),
(15, 3, 450, '2026-06-11 14:00:00', NULL),        -- NULL 3: Estado pendiente
(16, 2, 470, '2026-06-12 09:10:00', 'available'),
(17, 1, 450, '2026-06-12 10:30:00', 'used'),
(18, 3, 510, '2026-06-13 16:00:00', 'available'),
(19, 2, 450, '2026-06-14 07:55:00', 'available'),
(20, 1, 480, '2026-06-15 12:20:00', 'used'),
(21, 3, 450, '2026-06-16 13:45:00', 'expired'),
(22, 2, 530, '2026-06-17 08:15:00', 'available'),
(23, 1, 450, '2026-06-18 10:00:00', NULL),        -- NULL 4: Estado pendiente
(24, 3, 460, '2026-06-19 15:10:00', 'used'),
(25, 2, 450, '2026-06-20 09:30:00', 'available'),
(26, 1, 490, '2026-06-21 11:00:00', 'available'),
(27, 3, 450, '2026-06-22 14:25:00', 'used'),
(28, 2, 500, '2026-06-23 08:40:00', 'expired'),
(29, 1, 450, '2026-06-24 10:50:00', 'available'),
(30, 3, 470, '2026-06-25 16:15:00', 'available');


-- ============================================
-- PARTE 3: CONSULTAS CON NULL
-- ============================================

-- TODO: Mostrar items donde columna_opcional IS NULL
-- Alertas de Laboratorio: Donaciones cuyo estado de disponibilidad está pendiente de analizar
SELECT 
    id AS codigo_donacion, 
    donor_id AS codigo_donante,
    volume_ml AS volumen_extraido,
    donation_date AS fecha_registro
FROM donations
WHERE status IS NULL;


-- TODO: Mostrar todos los items usando COALESCE para reemplazar NULL
-- Reporte integral de inventario de bolsas reemplazando estados vacíos por una etiqueta de control
SELECT
    id AS codigo_donacion,
    volume_ml AS volumen_ml,
    donation_date AS fecha_donacion,
    COALESCE(status, 'En Análisis de Laboratorio') AS estado_unidades
FROM donations
ORDER BY id ASC;