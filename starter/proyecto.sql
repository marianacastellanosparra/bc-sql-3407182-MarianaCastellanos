-- ============================================
-- PROYECTO SEMANAL: DDL de tu Dominio
-- Semana 02 — DDL: Diseño de Esquemas
-- Dominio: Banco de Sangre (Blood Bank)
-- ============================================

-- ============================================
-- LIMPIEZA: Eliminar tablas si existen (Idempotencia)
-- ============================================
DROP TABLE IF EXISTS donations;
DROP TABLE IF EXISTS donors;
DROP TABLE IF EXISTS collection_centers;

-- ============================================
-- TABLA 1: Centros de Recolección (Entidad Secundaria 1)
-- ============================================
CREATE TABLE IF NOT EXISTS collection_centers (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT NOT NULL UNIQUE, -- El nombre debe ser único
    location    TEXT NOT NULL,
    is_active   INTEGER NOT NULL DEFAULT 1 -- 1 para activo, 0 para inactivo
);

-- ============================================
-- TABLA 2: Donantes (Entidad Secundaria 2)
-- ============================================
CREATE TABLE IF NOT EXISTS donors (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name   TEXT NOT NULL,
    email       TEXT UNIQUE, -- El correo electrónico no puede repetirse
    blood_type  TEXT NOT NULL CHECK (blood_type IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-')), -- Validación de tipos
    last_donation_date DATE
);

-- ============================================
-- TABLA 3: Donaciones / Bolsas (Entidad Principal)
-- ============================================
CREATE TABLE IF NOT EXISTS donations (
    id                  INTEGER PRIMARY KEY AUTOINCREMENT,
    donor_id            INTEGER NOT NULL,
    center_id           INTEGER NOT NULL,
    volume_ml           INTEGER NOT NULL DEFAULT 450 CHECK (volume_ml > 0), -- El volumen debe ser positivo
    donation_date       DATETIME DEFAULT CURRENT_TIMESTAMP,
    status              TEXT DEFAULT 'available' CHECK (status IN ('available', 'used', 'expired')),
    FOREIGN KEY (donor_id) REFERENCES donors(id),
    FOREIGN KEY (center_id) REFERENCES collection_centers(id)
);

-- ============================================
-- DATOS DE PRUEBA (Requerido para la Semana 02)
-- ============================================

-- 5 Registros: Centros de Recolección
INSERT INTO collection_centers (name, location) VALUES 
('Estación Central', 'Centro Ciudad 123'),
('Hospital del Norte', 'Avenida Verde 45'),
('Unidad Móvil A', 'Plaza Mayor'),
('Clínica del Sur', 'Calle Roja 789'),
('Punto Oriente', 'Zona Industrial');

-- 5 Registros: Donantes
INSERT INTO donors (full_name, email, blood_type, last_donation_date) VALUES 
('Maria Garcia', 'maria@mail.com', 'O+', '2024-01-10'),
('Juan Perez', 'juan@mail.com', 'A-', '2024-02-15'),
('Ana Lopez', 'ana@mail.com', 'B+', '2024-03-01'),
('Luis Rodriguez', 'luis@mail.com', 'AB+', '2023-12-20'),
('Carla Mendez', 'carla@mail.com', 'O-', '2024-01-25');

-- 15 Registros: Donaciones (Tabla Principal)
INSERT INTO donations (donor_id, center_id, volume_ml, status) VALUES 
(1, 1, 450, 'available'), (2, 1, 450, 'available'), (3, 2, 500, 'used'),
(4, 2, 450, 'available'), (5, 3, 450, 'expired'), (1, 3, 450, 'available'),
(2, 4, 480, 'used'), (3, 4, 450, 'available'), (4, 5, 450, 'available'),
(5, 5, 450, 'available'), (1, 2, 450, 'available'), (2, 3, 500, 'available'),
(3, 1, 450, 'used'), (4, 4, 450, 'available'), (5, 1, 450, 'available');

-- ============================================
-- VERIFICACIÓN
-- ============================================
.tables
SELECT 'Conteo de donaciones:' as mensaje, count(*) from donations;
PRAGMA table_info(donations);