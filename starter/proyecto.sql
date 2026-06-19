-- ============================================
-- PROYECTO SEMANAL: JOINs aplicados a tu dominio
-- Semana 09 — INNER JOIN y LEFT JOIN
-- Dominio: Banco de Sangre
-- ============================================

PRAGMA foreign_keys = ON;

-- ============================================
-- LIMPIEZA Y CREACIÓN DE ESTRUCTURAS
-- ============================================

DROP TABLE IF EXISTS donations;
DROP TABLE IF EXISTS donors;
DROP TABLE IF EXISTS blood_types;

-- Tabla de referencia: Clasificaciones y subtipos de Sangre (Mínimo 20 registros de control)
CREATE TABLE blood_types (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    group_name  TEXT NOT NULL UNIQUE,          -- Ej: 'O+', 'O-', 'A+'
    rh_factor   TEXT NOT NULL CHECK(rh_factor IN ('+', '-')),
    care_level  TEXT NOT NULL DEFAULT 'Normal' -- Prioridad médica de almacenamiento
);

-- Tabla principal de tu dominio: Donantes registrados (Mínimo 80 registros)
CREATE TABLE donors (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name     TEXT NOT NULL,
    national_id   TEXT NOT NULL UNIQUE,
    age           INTEGER NOT NULL CHECK(age >= 18),
    blood_type_id INTEGER REFERENCES blood_types (id)
);

-- Tabla hija: Transacciones de Donaciones efectuadas
CREATE TABLE donations (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    recorded_at     TEXT NOT NULL DEFAULT (DATE('now')),
    volume_ml       INTEGER NOT NULL CHECK(volume_ml >= 200),
    status          TEXT NOT NULL DEFAULT 'available',
    donor_id        INTEGER REFERENCES donors (id)
);

-- ============================================
-- INSERCIÓN DE DATOS DE PRUEBA REALISTAS
-- ============================================

-- 1. Insertar 20 registros en la Tabla de Referencia (Variaciones de control de laboratorio)
INSERT INTO blood_types (id, group_name, rh_factor, care_level) VALUES
(1, 'O+ General', '+', 'Normal'), (2, 'O- Universal', '-', 'Crítico'),
(3, 'A+ Subtipo1', '+', 'Normal'), (4, 'A- Subtipo1', '-', 'Alto'),
(5, 'B+ Estándar', '+', 'Normal'), (6, 'B- Estándar', '-', 'Alto'),
(7, 'AB+ Receptor', '+', 'Bajo'),  (8, 'AB- Escaso', '-', 'Crítico'),
(9, 'O+ Emergencia', '+', 'Crítico'),(10, 'A+ Clínico', '+', 'Normal'),
(11, 'B+ Clínico', '+', 'Normal'), (12, 'O- Reserva', '-', 'Crítico'),
(13, 'A- Reserva', '-', 'Alto'),   (14, 'B- Reserva', '-', 'Alto'),
(15, 'AB+ Control', '+', 'Bajo'),  (16, 'AB- Control', '-', 'Crítico'),
(17, 'O+ Neonatal', '+', 'Crítico'),(18, 'A+ Neonatal', '+', 'Alto'),
(19, 'B+ Neonatal', '+', 'Alto'),   (20, 'O- Pediátrico', '-', 'Crítico');

-- 2. Insertar 80 registros en la Tabla Principal (Donadores)
INSERT INTO donors (id, full_name, national_id, age, blood_type_id) VALUES
(1, 'Carlos Mendoza', '1012345001', 25, 1), (2, 'Ana Silva', '1012345002', 34, 2),
(3, 'Luis Gómez', '1012345003', 19, 1),      (4, 'Martha Páez', '1012345004', 45, 3),
(5, 'Jorge Cortés', '1012345005', 60, 4),    (6, 'Diana Reyes', '1012345006', 28, 2),
(7, 'Pedro Infante', '1012345007', 52, 5),   (8, 'Sandra Ortiz', '1012345008', 31, 6),
(9, 'Gustavo Petro', '1012345009', 22, 1),   (10, 'Lucía Meza', '1012345010', 41, 7),
(11, 'Ricardo Toro', '1012345011', 26, 8),   (12, 'Elena Niño', '1012345012', 38, 1),
(13, 'Pablo Marín', '1012345013', 47, 2),    (14, 'Claudia Arce', '1012345014', 50, 3),
(15, 'Fabio Beltrán', '1012345015', 23, 5),  (16, 'Gloria Vargas', '1012345016', 58, 6),
(17, 'Héctor Castro', '1012345017', 33, 9),  (18, 'Inés Zabala', '1012345018', 29, 10),
(19, 'Jaime Duque', '1012345019', 44, 11),   (20, 'Karen Moreno', '1012345020', 21, 12),
(21, 'Leonardo Cruz', '1012345021', 36, 13), (22, 'Mauricio Tobón', '1012345022', 55, 14),
(23, 'Nancy Pineda', '1012345023', 49, 15),  (24, 'Óscar Zuluaga', '1012345024', 62, 16),
(25, 'Patricia Guerrero', '1012345025', 27, 17), (26, 'Ramiro Suarez', '1012345026', 40, 18),
(27, 'Sonia Ruiz', '1012345027', 32, 19),    (28, 'Tomás Rojas', '1012345028', 18, 20),
(29, 'Úrsula Restrepo', '1012345029', 43, 1), (30, 'Víctor Hugo', '1012345030', 51, 2),
(31, 'Andrés Cepeda', '1012345031', 30, 3),  (32, 'Belisario Betancur', '1012345032', 64, 4),
(33, 'Camilo Torres', '1012345033', 24, 5),  (34, 'Daniel Samper', '1012345034', 53, 6),
(35, 'Eduardo Santos', '1012345035', 41, 7), (36, 'Francisco Paula', '1012345036', 39, 8),
(37, 'Guillermo León', '1012345037', 48, 9), (38, 'Humberto De la Calle', '1012345038', 57, 10),
(39, 'Iván Duque', '1012345039', 46, 11),    (40, 'Juan Manuel Santos', '1012345040', 61, 12),
(41, 'Álvaro Uribe', '1012345041', 63, 13),  (42, 'Julio César Turbay', '1012345042', 59, 14),
(43, 'Misael Pastrana', '1012345043', 52, 15),(44, 'Mariano Ospina', '1012345044', 44, 16),
(45, 'Laureano Gómez', '1012345045', 37, 17), (46, 'Roberto Urdaneta', '1012345046', 31, 18),
(47, 'Gustavo Rojas Pinilla', '1012345047', 50, 19), (48, 'Alberto Lleras', '1012345048', 26, 20),
(49, 'Carlos Lleras', '1012345049', 29, 1),  (50, 'Alfonso López', '1012345050', 33, 2),
(51, 'Julio Garavito', '1012345051', 42, 3), (52, 'Jorge Isaacs', '1012345052', 28, 5),
(53, 'José Asunción Silva', '1012345053', 35, 6), (54, 'Gabriel García Márquez', '1012345054', 54, 2),
(55, 'Rafael Pombo', '1012345055', 20, 1),   (56, 'Antonio Nariño', '1012345056', 47, 4),
(57, 'Policarpa Salavarrieta', '1012345057', 22, 2), (58, 'Manuela Beltrán', '1012345058', 25, 8),
(59, 'Simón Bolívar', '1012345059', 46, 12), (60, 'Francisco Santander', '1012345060', 43, 9),
(61, 'Camilo Daza', '1012345061', 38, 1),    (62, 'José María Córdova', '1012345062', 27, 3),
(63, 'Atanasio Girardot', '1012345063', 21, 5),(64, 'Antonio Ricaurte', '1012345064', 24, 6),
(65, 'José Prudencio Padilla', '1012345065', 51, 14), (66, 'Hermógenes Maza', '1012345066', 33, 2),
(67, 'Liborio Mejía', '1012345067', 30, 4),  (68, 'Custodio García', '1012345068', 56, 12),
(69, 'Joaquín Camacho', '1012345069', 49, 1), (70, 'Jorge Tadeo Lozano', '1012345070', 60, 3),
(71, 'Louis Pasteur', '1012345071', 50, 1),  (72, 'Alexander Fleming', '1012345072', 45, 2),
(73, 'Robert Koch', '1012345073', 39, 3),     (74, 'Carlos Finlay', '1012345074', 55, 4),
(75, 'William Harvey', '1012345075', 61, 5),
(76, 'Mariana Castellanos', '1012345076', 21, 2),
(77, 'Juan Pablo Duarte', '1012345077', 28, 1),
(78, 'Frida Kahlo', '1012345078', 32, 6),
(79, 'Diego Rivera', '1012345079', 40, 8),
(80, 'Gabriela Mistral', '1012345080', 26, 12);

-- 3. Tabla Hija: Insertar historial de extracciones en donaciones (Cruzando únicamente con IDs del 1 al 75)
INSERT INTO donations (volume_ml, status, donor_id) VALUES
(450, 'available', 1), (500, 'used', 2),      (420, 'available', 3), (460, 'available', 4),
(480, 'expired', 5),   (450, 'available', 6), (520, 'used', 7),      (490, 'available', 8),
(450, 'available', 9), (470, 'available', 10),(430, 'used', 11),     (440, 'available', 12),
(510, 'available', 13),(450, 'available', 14),(460, 'expired', 15),  (480, 'available', 16),
(450, 'available', 17),(500, 'used', 18),      (420, 'available', 19), (460, 'available', 20),
(480, 'available', 21),(450, 'used', 22),      (520, 'available', 23), (490, 'available', 24),
(450, 'available', 25),(470, 'expired', 26),  (430, 'available', 27), (440, 'available', 28),
(510, 'used', 29),     (450, 'available', 30),(460, 'available', 31), (480, 'available', 32),
(450, 'available', 33),(500, 'used', 34),      (420, 'available', 35), (460, 'available', 36),
(480, 'expired', 37),  (450, 'available', 38),(520, 'used', 39),      (490, 'available', 40),
(450, 'available', 41),(470, 'available', 42),(430, 'used', 43),     (440, 'available', 44),
(510, 'available', 45),(450, 'available', 46),(460, 'expired', 47),  (480, 'available', 48),
(450, 'available', 49),(500, 'used', 50),      (420, 'available', 51), (460, 'available', 52),
(480, 'available', 53),(450, 'used', 54),      (520, 'available', 55), (490, 'available', 56),
(450, 'available', 57),(470, 'expired', 58),  (430, 'available', 59), (440, 'available', 60),
(510, 'used', 61),     (450, 'available', 62),(460, 'available', 63), (480, 'available', 64),
(450, 'available', 65),(500, 'used', 66),      (420, 'available', 67), (460, 'available', 68),
(480, 'expired', 69),  (450, 'available', 70),(520, 'used', 71),      (490, 'available', 72),
(450, 'available', 73),(470, 'available', 74),(430, 'used', 75),
-- Segundas donaciones de algunos pacientes para enriquecer el conteo posterior
(450, 'available', 1), (500, 'available', 2),  (420, 'used', 3),       (460, 'available', 15);


-- ============================================
-- CONSULTA 1: INNER JOIN principal
-- Explicación: Une Donantes con Donaciones. Muestra únicamente 
-- a las personas que efectivamente registran una extracción física.
-- ============================================
SELECT
    dor.full_name   AS donante,
    don.recorded_at AS fecha_donacion,
    don.volume_ml   AS mililitros
FROM donors dor
INNER JOIN donations don ON don.donor_id = dor.id;


-- ============================================
-- CONSULTA 2: JOIN con tres tablas
-- Explicación: Conecta las donaciones con su donante respectivo 
-- y cruza con la tabla de referencia para conocer el tipo de sangre de ese donante.
-- ============================================
SELECT
    dor.full_name    AS donante,
    bt.group_name    AS tipo_sangre_subtipo,
    don.recorded_at  AS fecha_donacion,
    don.status       AS estado_bolsa
FROM donors dor
INNER JOIN blood_types bt ON dor.blood_type_id = bt.id
INNER JOIN donations   don ON don.donor_id     = dor.id;


-- ============================================
-- CONSULTA 3: LEFT JOIN — todos los registros
-- Explicación: Lista absolutamente todos los donantes de la tabla padre,
-- reflejando la fecha si donaron, o saliendo en blanco (NULL) si no tienen actividad.
-- ============================================
SELECT
    dor.full_name   AS donante,
    don.recorded_at AS fecha_actividad
FROM donors dor
LEFT JOIN donations don ON don.donor_id = dor.id;


-- ============================================
-- CONSULTA 4: Detectar huérfanos (registros sin actividad)
-- Explicación: Filtra mediante 'IS NULL' para aislar y encontrar 
-- a los donantes inscritos en el sistema que jamás han realizado una donación.
-- ============================================
SELECT
    dor.full_name AS donante_sin_actividad,
    dor.national_id AS documento_identidad
FROM donors dor
LEFT JOIN donations don ON don.donor_id = dor.id
WHERE don.id IS NULL;


-- ============================================
-- CONSULTA 5: Reporte agregado con LEFT JOIN + COUNT
-- Explicación: Muestra el top de donantes calculando cuántas veces 
-- han aportado al banco de sangre, incluyendo en 0 a los que no tienen actividad.
-- ============================================
SELECT
    dor.full_name AS donante,
    COUNT(don.id) AS total_donaciones_realizadas
FROM donors dor
LEFT JOIN donations don ON don.donor_id = dor.id
GROUP BY dor.id, dor.full_name
ORDER BY total_donaciones_realizadas DESC, dor.full_name ASC;