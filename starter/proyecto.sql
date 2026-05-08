-- ============================================
-- PROYECTO SEMANAL: Consultas SELECT
-- Semana 04 — SELECT, WHERE, ORDER BY, LIMIT/OFFSET
-- Dominio: Banco de Sangre
-- ============================================

-- ============================================
-- PREPARACIÓN: DDL Y DATOS (Requisito Semana 04)
-- ============================================
DROP TABLE IF EXISTS donations;
DROP TABLE IF EXISTS donors;
DROP TABLE IF EXISTS collection_centers;

CREATE TABLE collection_centers (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT NOT NULL UNIQUE,
    location    TEXT NOT NULL,
    is_active   INTEGER NOT NULL DEFAULT 1 
);

CREATE TABLE donors (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name   TEXT NOT NULL,
    email       TEXT UNIQUE,
    blood_type  TEXT NOT NULL,
    last_donation_date DATE
);

CREATE TABLE donations (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    donor_id        INTEGER NOT NULL,
    center_id       INTEGER NOT NULL,
    volume_ml       INTEGER NOT NULL DEFAULT 450,
    donation_date   DATETIME DEFAULT CURRENT_TIMESTAMP,
    status          TEXT DEFAULT 'available',
    FOREIGN KEY (donor_id) REFERENCES donors(id),
    FOREIGN KEY (center_id) REFERENCES collection_centers(id)
);

-- Inserción de 10 Centros y 30 Donantes para cumplir la rúbrica
INSERT INTO collection_centers (name, location) VALUES 
('Estación Central', 'Calle 1'), ('Hospital Norte', 'Calle 2'), ('Unidad Móvil A', 'Plaza 1'), 
('Clínica Sur', 'Calle 3'), ('Punto Oriente', 'Calle 4'), ('Centro Medico', 'Calle 5'), 
('Puesto Oeste', 'Calle 6'), ('Unidad Móvil B', 'Plaza 2'), ('Clínica Esperanza', 'Calle 7'), ('Laboratorio', 'Calle 8');

INSERT INTO donors (full_name, email, blood_type, last_donation_date) VALUES 
('Maria Garcia', 'm@mail.com', 'O+', '2024-01-01'), ('Juan Perez', 'j@mail.com', 'A-', '2024-01-02'),
('Ana Lopez', 'a@mail.com', 'B+', '2024-01-03'), ('Luis Rodriguez', 'l@mail.com', 'AB+', '2024-01-04'),
('Carla Mendez', 'c@mail.com', 'O-', '2024-01-05'), ('Carlos Ruiz', 'cr@mail.com', 'O+', '2024-01-06'),
('Ana Smith', 'as@mail.com', 'A-', '2024-01-07'), ('Mariana C', 'mc@mail.com', 'AB+', '2024-01-08'),
('Roberto G', 'rg@mail.com', 'O-', '2024-01-09'), ('Lucia M', 'lm@mail.com', 'B+', '2024-01-10'),
('Ricardo T', 'rt@mail.com', 'O+', '2024-01-11'), ('Elena N', 'en@mail.com', 'A+', '2024-01-12'),
('Pablo M', 'pm@mail.com', 'B-', '2024-01-13'), ('Diana P', 'dp@mail.com', 'O+', '2024-01-14'),
('Bruce W', 'bw@mail.com', 'AB-', '2024-01-15'), ('Laura C', 'lc@mail.com', 'A+', '2024-01-16'),
('Pedro I', 'pi@mail.com', 'O-', '2024-01-17'), ('Marta S', 'ms@mail.com', 'B+', '2024-01-18'),
('Julio V', 'jv@mail.com', 'AB-', '2024-01-19'), ('Sara C', 'sc@mail.com', 'O+', '2024-01-20'),
('Clark K', 'ck@mail.com', 'O+', '2024-01-21'), ('Tony S', 'ts@mail.com', 'A+', '2024-01-22'),
('Steve R', 'sr@mail.com', 'O-', '1945-01-01'), ('Natasha R', 'nr@mail.com', 'AB+', '2024-01-23'),
('Wanda M', 'wm@mail.com', 'B-', '2024-01-24'), ('Bruce B', 'bb@mail.com', 'A-', '2024-01-25'),
('Peter P', 'pp@mail.com', 'O+', '2024-01-26'), ('Logan H', 'lh@mail.com', 'AB+', '2024-01-27'),
('Jean G', 'jg@mail.com', 'O-', '2024-01-28'), ('Barry A', 'ba@mail.com', 'B+', '2024-01-29');

-- Inserción de 30 donaciones para que las consultas den resultados
INSERT INTO donations (donor_id, center_id, volume_ml, status) VALUES 
(1,1,450,'available'), (2,2,500,'available'), (3,3,450,'used'), (4,4,480,'available'), (5,5,450,'available'),
(6,6,500,'available'), (7,7,450,'available'), (8,8,450,'used'), (9,9,480,'available'), (10,10,450,'available'),
(11,1,450,'available'), (12,2,500,'available'), (13,3,450,'available'), (14,4,450,'available'), (15,5,450,'available'),
(16,6,450,'available'), (17,7,500,'available'), (18,8,450,'available'), (19,9,450,'available'), (20,10,480,'available'),
(21,1,450,'available'), (22,2,450,'available'), (23,3,450,'available'), (24,4,500,'available'), (25,5,450,'available'),
(26,6,450,'available'), (27,7,450,'available'), (28,8,450,'available'), (29,9,450,'available'), (30,10,450,'available');


-- ============================================
-- CONSULTA 1: Listado general con columnas explícitas
-- ============================================
-- TODO: Lista al menos 4 columnas de tu entidad principal
--       usando alias en español para cada columna
SELECT 
    id AS Folio_Donante,
    full_name AS Nombre_Completo,
    email AS Correo_Electronico,
    blood_type AS Tipo_Sangre
FROM donors;


-- ============================================
-- CONSULTA 2: Filtro por condición simple
-- ============================================
-- TODO: Filtra filas usando una condición de igualdad o comparación
SELECT id, full_name, blood_type
FROM donors
WHERE blood_type = 'O-';


-- ============================================
-- CONSULTA 3: Filtro combinado (AND u OR)
-- ============================================
-- TODO: Combina al menos dos condiciones con AND u OR
SELECT full_name, blood_type, last_donation_date
FROM donors
WHERE blood_type = 'A+'
  AND last_donation_date > '2024-01-01';


-- ============================================
-- CONSULTA 4: Top-N con ORDER BY + LIMIT
-- ============================================
-- TODO: Recupera los 5 primeros registros según un criterio de negocio
-- Criterio: Los 5 donantes registrados más recientemente (ID más alto)
-- CONSULTA 4: Top-N con ORDER BY + LIMIT
SELECT 
    id AS ID_Prioritario, 
    full_name AS Nombre_Donante, 
    email AS Contacto
FROM donors
ORDER BY id DESC
LIMIT 5;


-- ============================================
-- CONSULTA 5: Paginación (página 1 y página 2)
-- ============================================
-- TODO: Implementa 2 páginas de 3 registros cada una
--       ordenados por un criterio relevante para tu dominio

-- Página 1:
SELECT id, full_name, blood_type
FROM donors
ORDER BY full_name ASC
LIMIT 3 OFFSET 0;

-- Página 2:
SELECT id, full_name, blood_type
FROM donors
ORDER BY full_name ASC
LIMIT 3 OFFSET 3;