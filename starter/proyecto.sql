-- ============================================
-- PROYECTO SEMANAL: DML — Manipulación de Datos
-- Semana 03 — INSERT INTO, UPDATE, DELETE
-- Dominio: Banco de Sangre
-- ============================================

-- RECREACIÓN DEL ESQUEMA (Idempotencia)
DROP TABLE IF EXISTS donations;
DROP TABLE IF EXISTS donors;
DROP TABLE IF EXISTS collection_centers;

-- TABLA 1: Centros de Recolección (Tabla Secundaria)
CREATE TABLE collection_centers (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT NOT NULL UNIQUE,
    location    TEXT NOT NULL,
    is_active   INTEGER NOT NULL DEFAULT 1 
);

-- TABLA 2: Donantes (Tabla Secundaria)
CREATE TABLE donors (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name   TEXT NOT NULL,
    email       TEXT UNIQUE,
    blood_type  TEXT NOT NULL CHECK (blood_type IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-')),
    last_donation_date DATE
);

-- TABLA 3: Donaciones (Tabla Principal - Requisito 15 filas)
CREATE TABLE donations (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    donor_id        INTEGER NOT NULL,
    center_id       INTEGER NOT NULL,
    volume_ml       INTEGER NOT NULL DEFAULT 450 CHECK (volume_ml > 0),
    donation_date   DATETIME DEFAULT CURRENT_TIMESTAMP,
    status          TEXT DEFAULT 'available' CHECK (status IN ('available', 'used', 'expired')),
    FOREIGN KEY (donor_id) REFERENCES donors(id),
    FOREIGN KEY (center_id) REFERENCES collection_centers(id)
);

-- ============================================
-- PARTE 1: INSERT INTO (Mínimo 15 filas por tabla principal/padre)
-- ============================================

-- Insertar 15 Donantes (Tabla Padre/Secundaria)
INSERT INTO donors (full_name, email, blood_type, last_donation_date) VALUES 
('Maria Garcia', 'maria@mail.com', 'O+', '2024-01-10'),
('Juan Perez', 'juan@mail.com', 'A-', '2024-02-15'),
('Ana Lopez', 'ana@mail.com', 'B+', '2024-03-01'),
('Luis Rodriguez', 'luis@mail.com', 'AB+', '2023-12-20'),
('Carla Mendez', 'carla@mail.com', 'O-', '2024-01-25'),
('Carlos Ruiz', 'carlos.ruiz@email.com', 'O+', '2024-01-10'),
('Ana Smith', 'ana.smith@email.com', 'A-', '2023-11-05'),
('Mariana Castellanos', 'm.castellanos@email.com', 'AB+', '2024-01-15'),
('Roberto Gomez', 'roberto.g@email.com', 'O-', '2024-02-20'),
('Lucia Mendez', 'lucia.m@email.com', 'B+', '2024-03-01'),
('Ricardo Tapia', 'rtapia@email.com', 'O+', '2024-03-10'),
('Elena Nito', 'elena.nito@email.com', 'A+', '2024-03-15'),
('Pablo Marmol', 'pablo.m@email.com', 'B-', '2024-03-20'),
('Diana Prince', 'diana.p@email.com', 'O+', '2024-03-25'),
('Bruce Wayne', 'bwayne@email.com', 'AB-', '2024-04-01');

-- Insertar 5 Centros de Recolección (Tabla Secundaria)
INSERT INTO collection_centers (name, location) VALUES 
('Estación Central', 'Centro Ciudad 123'),
('Hospital del Norte', 'Avenida Verde 45'),
('Unidad Móvil A', 'Plaza Mayor'),
('Clínica del Sur', 'Calle Roja 789'),
('Punto Oriente', 'Zona Industrial');

-- Insertar 15 Donaciones (Tabla Principal - Respetando FKs)
INSERT INTO donations (donor_id, center_id, volume_ml, status) VALUES 
(1, 1, 450, 'available'), (2, 1, 450, 'available'), (3, 2, 500, 'used'),
(4, 2, 450, 'available'), (5, 3, 450, 'expired'), (6, 3, 450, 'available'),
(7, 4, 480, 'used'), (8, 4, 450, 'available'), (9, 5, 450, 'available'),
(10, 5, 450, 'available'), (11, 2, 450, 'available'), (12, 3, 500, 'available'),
(13, 1, 450, 'used'), (14, 4, 450, 'available'), (15, 1, 450, 'available');

-- ============================================
-- PARTE 2: UPDATE (Con justificación de negocio)
-- ============================================

-- Justificación: Actualización por cambio de nombre legal del donante
UPDATE donors 
SET full_name = 'Maria Garcia Hernandez' 
WHERE id = 1;

-- Justificación: El centro de recolección se traslada a una nueva dirección y queda inactivo temporalmente
UPDATE collection_centers 
SET location = 'Calle Nueva 456', is_active = 0 
WHERE id = 5;

-- Justificación: El centro ID 5 ha reportado fallas en refrigeración; todas sus bolsas pasan a estado expirado por seguridad
UPDATE donations 
SET status = 'expired' 
WHERE center_id = 5;

-- ============================================
-- PARTE 3: DELETE SEGURO
-- ============================================

-- Paso previo obligatorio: Verificar filas a eliminar (Donaciones con estado 'used')
SELECT id, donor_id, status FROM donations WHERE status = 'used';

-- Justificación: Eliminación de registros de bolsas de sangre ya utilizadas para depurar el inventario actual
DELETE FROM donations 
WHERE status = 'used';

-- ============================================
-- VERIFICACIÓN FINAL (Sin usar *)
-- ============================================

-- Verificación de Donantes
SELECT id, full_name, email, blood_type, last_donation_date 
FROM donors 
ORDER BY id;

-- Verificación de Centros de Recolección
SELECT id, name, location, is_active 
FROM collection_centers 
ORDER BY id;

-- Verificación de Donaciones (Estado actual del inventario)
SELECT id, donor_id, center_id, volume_ml, donation_date, status 
FROM donations 
ORDER BY id;