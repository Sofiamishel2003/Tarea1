--Creación de tablas
CREATE TABLE Piezas (
    codigo VARCHAR(10) PRIMARY KEY,
    peso INT,
    descripcion TEXT
);

CREATE TABLE Operaciones (
    codigo VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(255)
);

CREATE TABLE Equipos (
    nombre VARCHAR(255),
    modelo VARCHAR(50),
    pais_origen VARCHAR(50),
    PRIMARY KEY (nombre, modelo)
);

CREATE TABLE Normas (
    codigo VARCHAR(10) PRIMARY KEY,
    descripcion TEXT,
    tiempo_ejecucion INT,
    pieza_codigo VARCHAR(10) REFERENCES Piezas(codigo),
    operacion_codigo VARCHAR(10) REFERENCES Operaciones(codigo),
    equipo_nombre VARCHAR(255),
    equipo_modelo VARCHAR(50),
    FOREIGN KEY (equipo_nombre, equipo_modelo) REFERENCES Equipos(nombre, modelo)
);

CREATE TABLE Obreros (
    codigo VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(255),
    fecha_inicio DATE
);

CREATE TABLE ObreroNorma (
    obrero_codigo VARCHAR(10) REFERENCES Obreros(codigo),
    norma_codigo VARCHAR(10) REFERENCES Normas(codigo),
    porcentaje_involucramiento INT,
    PRIMARY KEY (obrero_codigo, norma_codigo)
);
--Consultas----------------
--1
SELECT AVG(n.tiempo_ejecucion) AS promedio_tiempo
FROM Normas n
JOIN Piezas p ON n.pieza_codigo = p.codigo
WHERE p.descripcion LIKE '%Tornillos redondos%' AND p.peso = 10;
--2
SELECT o.codigo, o.nombre, COUNT(onm.norma_codigo) AS cantidad_normas
FROM Obreros o
LEFT JOIN ObreroNorma onm ON o.codigo = onm.obrero_codigo
GROUP BY o.codigo, o.nombre;
--3
SELECT p.codigo, p.descripcion, COUNT(DISTINCT n.equipo_nombre, n.equipo_modelo) AS cantidad_equipos
FROM Piezas p
JOIN Normas n ON p.codigo = n.pieza_codigo
GROUP BY p.codigo, p.descripcion
ORDER BY cantidad_equipos DESC
LIMIT 1;
-- INSERCIÓN DE DATOS-------------------------
-- Insertar datos de prueba en la tabla `Piezas`
INSERT INTO Piezas (codigo, peso, descripcion) VALUES
('TR11', 10, 'tornillos redondos de 10 gramos'),
('TC10', 10, 'tornillos cuadrados de 10 gramos'),
('CL8', 8, 'clavos largos de 8 gramos'),
('TR01', 5, 'Tornillos redondos de 5 gramos'),
('TR02', 10, 'Tornillos redondos de 10 gramos'),
('TR03', 15, 'Tornillos redondos de 15 gramos'),
('TR04', 20, 'Tornillos redondos de 20 gramos'),
('TR05', 25, 'Tornillos redondos de 25 gramos'),
('TR06', 30, 'Tornillos redondos de 30 gramos'),
('TR07', 35, 'Tornillos redondos de 35 gramos'),
('TR08', 40, 'Tornillos redondos de 40 gramos'),
('TR09', 45, 'Tornillos redondos de 45 gramos'),
('CL9', 8, 'clavos largos de 8 gramos'),
('TR10', 50, 'Tornillos redondos de 50 gramos');
-- Insertar datos de prueba en la tabla `Operaciones`
INSERT INTO Operaciones (codigo, nombre) VALUES
('COR', 'corte'),
('FRE', 'fresado'),
('ESM', 'esmalte');

-- Insertar datos de prueba en la tabla `Equipos`
INSERT INTO Equipos (nombre, modelo, pais_origen) VALUES
('fresadora', 'FRE-200', 'Alemania'),
('máquina de troquelado', 'TRO-100', 'Italia'),
('máquina de esmalte', 'ESM-300', 'China');

-- Insertar datos de prueba en la tabla `Normas`
INSERT INTO Normas (codigo, descripcion, tiempo_ejecucion, pieza_codigo, operacion_codigo, equipo_nombre, equipo_modelo) VALUES
('NORM1', 'fresado de roscas en tornillos redondos', 8, 'TR10', 'FRE', 'fresadora', 'FRE-200'),
('NORM2', 'troquelado de tornillos', 10, 'TC10', 'COR', 'máquina de troquelado', 'TRO-100'),
('NORM3', 'esmalte de clavos largos', 15, 'CL8', 'ESM', 'máquina de esmalte', 'ESM-300'),
('NORM5', 'esmalte de clavos largos', 20, 'TR11', 'ESM', 'máquina de esmalte', 'ESM-300'),
('NORM4', 'troquelado de tornillos', 9, 'TR02', 'COR', 'máquina de troquelado', 'TRO-100'),
('NORM6', 'esmalte de clavos largos', 15, 'CL8', 'ESM', 'máquina de esmalte', 'TRO-100');

-- Insertar datos de prueba en la tabla `Obreros`
INSERT INTO Obreros (codigo, nombre, fecha_inicio) VALUES
('OBR1', 'Juan Pérez', '2020-01-10'),
('OBR2', 'Ana Gómez', '2021-05-20'),
('OBR3', 'Luis Martínez', '2019-11-01');

-- Insertar datos de prueba en la tabla `ObreroNorma`
INSERT INTO ObreroNorma (obrero_codigo, norma_codigo, porcentaje_involucramiento) VALUES
('OBR1', 'NORM1', 100),
('OBR1', 'NORM2', 50),
('OBR2', 'NORM2', 50),
('OBR3', 'NORM3', 100);
