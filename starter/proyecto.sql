DROP TABLE IF EXISTS donations;
DROP TABLE IF EXISTS donors;

-- ============================================
-- PASO 1: Crear la entidad principal (Donantes)
-- ============================================
CREATE TABLE donors (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name   TEXT    NOT NULL,
    blood_type  TEXT    NOT NULL,
    email       TEXT    UNIQUE,
    phone       TEXT,
    is_eligible INTEGER DEFAULT 1
);

-- ============================================
-- PASO 2: Crear la segunda entidad (Donaciones)
-- ============================================
CREATE TABLE donations (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    donor_id        INTEGER NOT NULL,
    donation_date   TEXT    NOT NULL,
    volume_ml       INTEGER NOT NULL,
    hospital_unit   TEXT    NOT NULL,
    FOREIGN KEY (donor_id) REFERENCES donors(id)
);

-- ============================================
-- PASO 3: Insertar datos de prueba
-- ============================================

-- 15 Donantes
INSERT INTO donors (full_name, blood_type, email, phone) VALUES
    ('Carlos Ruiz', 'O+', 'carlos.ruiz@email.com', '555-0101'),
    ('Ana Smith', 'A-', 'ana.smith@email.com', '555-0102'),
    ('Mariana Castellanos', 'AB+', 'm.castellanos@email.com', '555-0103'),
    ('Roberto Gómez', 'O-', 'roberto.g@email.com', '555-0104'),
    ('Lucía Méndez', 'B+', 'lucia.m@email.com', '555-0105'),
    ('Ricardo Tapia', 'O+', 'rtapia@email.com', '555-0106'),
    ('Elena Nito', 'A+', 'elena.nito@email.com', '555-0107'),
    ('Pablo Marmol', 'B-', 'pablo.m@email.com', '555-0108'),
    ('Diana Prince', 'O+', 'diana.p@email.com', '555-0109'),
    ('Bruce Wayne', 'AB-', 'bwayne@email.com', '555-0110'),
    ('Clark Kent', 'O+', 'ckent@email.com', '555-0111'),
    ('Peter Parker', 'B+', 'pparker@email.com', '555-0112'),
    ('Wanda Maximoff', 'A-', 'wanda.m@email.com', '555-0113'),
    ('Tony Stark', 'A+', 'tstark@email.com', '555-0114'),
    ('Steve Rogers', 'O-', 'cap@email.com', '555-0115');

-- 5 Donaciones (Ahora el nombre coincide con la tabla de arriba)
INSERT INTO donations (donor_id, donation_date, volume_ml, hospital_unit) VALUES
    (1, '2024-01-10', 450, 'Hospital Central'),
    (2, '2023-11-05', 450, 'Clínica Santa María'),
    (4, '2024-02-20', 500, 'Hospital del Sur'),
    (15, '2024-04-10', 450, 'Hospital Militar'),
    (7, '2024-03-15', 480, 'Centro Médico Norte');

-- ============================================
-- PASO 4: Consultas (No olvides agregarlas para tu tarea)
-- ============================================
SELECT id, full_name, blood_type FROM donors;
SELECT id, donor_id, donation_date, volume_ml FROM donations;


-- ============================================
-- PASO 4: Consultas SELECT básicas
-- ============================================

-- TODO: Mostrar todos los donantes con todas sus columnas (sin usar *)
SELECT id, full_name, blood_type, email, phone, is_eligible
FROM   donors;

-- TODO: Mostrar solo el nombre de los donantes ordenados alfabéticamente
SELECT full_name
FROM   donors
ORDER BY full_name ASC;

-- TODO: Contar cuántos donantes tienes en total
SELECT COUNT(id) AS total_donantes
FROM   donors;