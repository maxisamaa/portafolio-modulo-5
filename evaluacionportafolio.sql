-- Crear la base de datos
CREATE DATABASE AgendaPersonal;
USE AgendaPersonal;

-- Tabla de categorías
CREATE TABLE Categoria(
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    titulo_categoria VARCHAR(50) NOT NULL
);

-- Tabla de personas involucradas
CREATE TABLE Personas_Involucradas(
    id_persona INT PRIMARY KEY AUTO_INCREMENT,
    nombre_persona VARCHAR(100) NOT NULL,
    rol VARCHAR(50) -- Ej: "Profesor", "Amigo", "Compañero"
);

-- Tabla principal de tareas
CREATE TABLE Tareas(
    id_tarea INT PRIMARY KEY AUTO_INCREMENT,
    id_categoria INT NOT NULL,
    id_persona INT,
    fecha_tarea DATE NOT NULL,
    titulo_tarea VARCHAR(100) NOT NULL,
    hora_inicio DATETIME NOT NULL,
    hora_fin DATETIME NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria) ON DELETE CASCADE,
    FOREIGN KEY (id_persona) REFERENCES Personas_Involucradas(id_persona) ON DELETE SET NULL
);

-- Detalles de cada tarea
CREATE TABLE Detalles_tareas(
    id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    id_tarea INT NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    duracion_tarea TIME,
    FOREIGN KEY (id_tarea) REFERENCES Tareas(id_tarea) ON DELETE CASCADE
);

CREATE TABLE Tareas_Personas(
    id_tarea INT NOT NULL,
    id_persona INT NOT NULL,
    PRIMARY KEY (id_tarea, id_persona),
    FOREIGN KEY (id_tarea) REFERENCES Tareas(id_tarea) ON DELETE CASCADE,
    FOREIGN KEY (id_persona) REFERENCES Personas_Involucradas(id_persona) ON DELETE CASCADE
);

-- Insertar categorías
INSERT INTO Categoria (titulo_categoria) VALUES
('Estudio'),
('Trabajo'),
('Ocio'),
('Salud');

-- Insertar personas involucradas
INSERT INTO Personas_Involucradas (nombre_persona, rol) VALUES
('Juan Pérez', 'Profesor'),
('María López', 'Amiga'),
('Carlos Torres', 'Compañero de trabajo'),
('Ana Martínez', 'Doctor');

-- Insertar tareas
INSERT INTO Tareas (id_categoria, id_persona, fecha_tarea, titulo_tarea, hora_inicio, hora_fin) VALUES
(1, 1, '2025-09-08', 'Repasar SQL', '2025-09-08 10:00:00', '2025-09-08 12:00:00'),
(2, 3, '2025-09-08', 'Reunión de proyecto', '2025-09-08 15:00:00', '2025-09-08 16:30:00'),
(3, 2, '2025-09-09', 'Salir al cine', '2025-09-09 20:00:00', '2025-09-09 23:00:00'),
(4, 4, '2025-09-10', 'Chequeo médico', '2025-09-10 09:00:00', '2025-09-10 09:30:00');

-- Insertar detalles de tareas
INSERT INTO Detalles_tareas (id_tarea, descripcion, duracion_tarea) VALUES
(1, 'Practicar ejercicios de consultas con JOIN y GROUP BY', '02:00:00'),
(2, 'Discutir avances del sistema y asignar tareas', '01:30:00'),
(3, 'Ver película de ciencia ficción', '03:00:00'),
(4, 'Control de presión arterial y exámenes rutinarios', '00:30:00');

-- Todas las tareas de la categoría "Estudio"
SELECT t.titulo_tarea, t.fecha_tarea, c.titulo_categoria
FROM Tareas t
JOIN Categoria c ON t.id_categoria = c.id_categoria
WHERE c.titulo_categoria = 'Estudio';

-- INSERT: agregar una nueva tarea
INSERT INTO Tareas (id_categoria, fecha_tarea, titulo_tarea, hora_inicio, hora_fin)
VALUES (1, '2025-09-15', 'Estudiar Normalización', '2025-09-15 18:00:00', '2025-09-15 20:00:00');

-- UPDATE: cambiar la hora de fin de una tarea
UPDATE Tareas
SET hora_fin = '2025-09-15 21:00:00'
WHERE id_tarea = 1;

-- DELETE: eliminar una tarea que fue cancelada
DELETE FROM Tareas
WHERE id_tarea = 3;

-- Agregar columna prioridad a las tareas
ALTER TABLE Tareas
ADD COLUMN prioridad VARCHAR(20);

-- Cambiar el nombre de la columna "rol" en Personas_Involucradas
ALTER TABLE Personas_Involucradas
CHANGE COLUMN rol tipo_participacion VARCHAR(50);

-- Aumentar el tamaño del campo descripción en Detalles_tareas
ALTER TABLE Detalles_tareas
MODIFY descripcion VARCHAR(500);

-- Eliminar tabla de detalles si decido guardarlos en otra parte
DROP TABLE Detalles_tareas;

-- Eliminar tabla de categorías (afectará en cascada a tareas)
DROP TABLE Categoria;
