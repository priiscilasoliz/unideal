-- Base de datos: unideal
-- Adaptada para PostgreSQL

BEGIN;

-- --------------------------------------------------------
-- Tablas maestras
-- --------------------------------------------------------

CREATE TABLE areas (
  ID_Area SERIAL PRIMARY KEY,
  Nombre_Area VARCHAR(100) NOT NULL
);

CREATE TABLE provincias (
  ID_Provincia SERIAL PRIMARY KEY,
  Nombre_Provincia VARCHAR(100) NOT NULL
);

CREATE TABLE localidades (
  ID_Localidad SERIAL PRIMARY KEY,
  ID_Provincia INT NOT NULL,
  Nombre_Localidad VARCHAR(100) NOT NULL,
  CONSTRAINT fk_localidades_provincias FOREIGN KEY (ID_Provincia) REFERENCES provincias(ID_Provincia) ON DELETE CASCADE
);

CREATE TABLE roles (
  ID_Rol SERIAL PRIMARY KEY,
  Nombre_Rol VARCHAR(50) NOT NULL
);

INSERT INTO roles (Nombre_Rol) VALUES
('Estudiante'),
('Moderador'),
('Admin');

CREATE TABLE modalidades_cursada (
  ID_Modalidad SERIAL PRIMARY KEY,
  Nombre_Modalidad VARCHAR(50) NOT NULL
);

INSERT INTO modalidades_cursada (Nombre_Modalidad) VALUES
('Presencial'),
('Virtual'),
('Híbrida');

CREATE TABLE estados (
  ID_Estado SERIAL PRIMARY KEY,
  Nombre_Estado VARCHAR(50) NOT NULL
);

INSERT INTO estados (Nombre_Estado) VALUES
('Pendiente'),
('Respondida'),
('Archivada');

-- --------------------------------------------------------
-- Tablas dependientes de localidades y areas
-- --------------------------------------------------------

CREATE TABLE universidades (
  ID_Universidad SERIAL PRIMARY KEY,
  ID_Localidad INT NOT NULL,
  Nombre_Universidad VARCHAR(150) NOT NULL,
  Acronimo VARCHAR(20),
  Tipo VARCHAR(40),
  URL_Web VARCHAR(255),
  CONSTRAINT fk_universidades_localidades FOREIGN KEY (ID_Localidad) REFERENCES localidades(ID_Localidad) ON DELETE CASCADE
);

CREATE TABLE pregrados (
  ID_Pregrado SERIAL PRIMARY KEY,
  ID_Universidad INT NOT NULL,
  ID_Area INT NOT NULL,
  Nombre_Pregrado VARCHAR(150) NOT NULL,
  Duracion VARCHAR(50),
  Requisitos VARCHAR(255),
  URL_Pregrado VARCHAR(255),
  CONSTRAINT fk_pregrados_universidades FOREIGN KEY (ID_Universidad) REFERENCES universidades(ID_Universidad) ON DELETE CASCADE,
  CONSTRAINT fk_pregrados_areas FOREIGN KEY (ID_Area) REFERENCES areas(ID_Area) ON DELETE CASCADE
);

CREATE TABLE posgrados (
  ID_Posgrado SERIAL PRIMARY KEY,
  ID_Universidad INT NOT NULL,
  ID_Area INT NOT NULL,
  Nombre_Posgrado VARCHAR(150) NOT NULL,
  Tipo VARCHAR(50),
  Requisitos VARCHAR(255),
  URL_Posgrado VARCHAR(255),
  CONSTRAINT fk_posgrados_universidades FOREIGN KEY (ID_Universidad) REFERENCES universidades(ID_Universidad) ON DELETE CASCADE,
  CONSTRAINT fk_posgrados_areas FOREIGN KEY (ID_Area) REFERENCES areas(ID_Area) ON DELETE CASCADE
);

CREATE TABLE carreras (
  ID_Carrera SERIAL PRIMARY KEY,
  ID_Universidad INT NOT NULL,
  ID_Area INT NOT NULL,
  Nombre_Carrera VARCHAR(150) NOT NULL,
  Duracion VARCHAR(50),
  Requisitos VARCHAR(255),
  URL_Carrera VARCHAR(255),
  CONSTRAINT fk_carreras_universidades FOREIGN KEY (ID_Universidad) REFERENCES universidades(ID_Universidad) ON DELETE CASCADE,
  CONSTRAINT fk_carreras_areas FOREIGN KEY (ID_Area) REFERENCES areas(ID_Area) ON DELETE CASCADE
);

CREATE TABLE cursos_ext (
  ID_Curso SERIAL PRIMARY KEY,
  ID_Universidad INT NOT NULL,
  ID_Area INT NOT NULL,
  Nombre_Curso VARCHAR(150) NOT NULL,
  Duracion VARCHAR(50),
  Requisitos VARCHAR(255),
  URL_Curso VARCHAR(255),
  CONSTRAINT fk_cursos_universidades FOREIGN KEY (ID_Universidad) REFERENCES universidades(ID_Universidad) ON DELETE CASCADE,
  CONSTRAINT fk_cursos_areas FOREIGN KEY (ID_Area) REFERENCES areas(ID_Area) ON DELETE CASCADE
);

-- --------------------------------------------------------
-- Tablas de relaciones N:M
-- --------------------------------------------------------

CREATE TABLE pregrado_modalidad (
  ID_Pregrado INT NOT NULL,
  ID_Modalidad INT NOT NULL,
  PRIMARY KEY (ID_Pregrado, ID_Modalidad),
  CONSTRAINT fk_pregrado_mod_pregrado FOREIGN KEY (ID_Pregrado) REFERENCES pregrados(ID_Pregrado) ON DELETE CASCADE,
  CONSTRAINT fk_pregrado_mod_modalidad FOREIGN KEY (ID_Modalidad) REFERENCES modalidades_cursada(ID_Modalidad) ON DELETE CASCADE
);

CREATE TABLE posgrado_modalidad (
  ID_Posgrado INT NOT NULL,
  ID_Modalidad INT NOT NULL,
  PRIMARY KEY (ID_Posgrado, ID_Modalidad),
  CONSTRAINT fk_posgrado_mod_posgrado FOREIGN KEY (ID_Posgrado) REFERENCES posgrados(ID_Posgrado) ON DELETE CASCADE,
  CONSTRAINT fk_posgrado_mod_modalidad FOREIGN KEY (ID_Modalidad) REFERENCES modalidades_cursada(ID_Modalidad) ON DELETE CASCADE
);

CREATE TABLE carrera_modalidad (
  ID_Carrera INT NOT NULL,
  ID_Modalidad INT NOT NULL,
  PRIMARY KEY (ID_Carrera, ID_Modalidad),
  CONSTRAINT fk_carrera_mod_carrera FOREIGN KEY (ID_Carrera) REFERENCES carreras(ID_Carrera) ON DELETE CASCADE,
  CONSTRAINT fk_carrera_mod_modalidad FOREIGN KEY (ID_Modalidad) REFERENCES modalidades_cursada(ID_Modalidad) ON DELETE CASCADE
);

CREATE TABLE curso_modalidad (
  ID_Curso INT NOT NULL,
  ID_Modalidad INT NOT NULL,
  PRIMARY KEY (ID_Curso, ID_Modalidad),
  CONSTRAINT fk_curso_mod_curso FOREIGN KEY (ID_Curso) REFERENCES cursos_ext(ID_Curso) ON DELETE CASCADE,
  CONSTRAINT fk_curso_mod_modalidad FOREIGN KEY (ID_Modalidad) REFERENCES modalidades_cursada(ID_Modalidad) ON DELETE CASCADE
);

-- --------------------------------------------------------
-- Tablas dependientes de usuarios
-- --------------------------------------------------------

CREATE TABLE usuarios (
  ID_Usuario SERIAL PRIMARY KEY,
  Nombre_Usuario VARCHAR(100) UNIQUE NOT NULL,
  Email VARCHAR(100) UNIQUE NOT NULL,
  Contraseña VARCHAR(255) NOT NULL,
  ID_Rol INT NOT NULL DEFAULT 1,
  Fecha_Creacion TIMESTAMP DEFAULT now(),
  Fecha_Modificacion TIMESTAMP DEFAULT now(),
  CONSTRAINT fk_usuarios_roles FOREIGN KEY (ID_Rol) REFERENCES roles(ID_Rol)
);

CREATE TABLE consultas (
  ID_Consulta SERIAL PRIMARY KEY,
  ID_Usuario INT NOT NULL,
  Asunto VARCHAR(255) NOT NULL,
  Contenido TEXT NOT NULL,
  Fecha_Envio TIMESTAMP DEFAULT now(),
  Fecha_Modificacion TIMESTAMP DEFAULT now(),
  ID_Estado INT NOT NULL DEFAULT 1,
  CONSTRAINT fk_consultas_usuarios FOREIGN KEY (ID_Usuario) REFERENCES usuarios(ID_Usuario) ON DELETE CASCADE,
  CONSTRAINT fk_consultas_estados FOREIGN KEY (ID_Estado) REFERENCES estados(ID_Estado)
);

CREATE TABLE foro (
  ID_Forum SERIAL PRIMARY KEY,
  ID_Usuario INT,
  Titulo VARCHAR(255),
  Contenido TEXT,
  Fecha_Publicacion TIMESTAMP DEFAULT now(),
  CONSTRAINT fk_foro_usuarios FOREIGN KEY (ID_Usuario) REFERENCES usuarios(ID_Usuario) ON DELETE SET NULL
);

CREATE TABLE respuestas (
  ID_Respuesta SERIAL PRIMARY KEY,
  ID_Forum INT,
  ID_Usuario INT,
  Contenido TEXT,
  Fecha_Publicacion TIMESTAMP DEFAULT now(),
  CONSTRAINT fk_respuestas_foro FOREIGN KEY (ID_Forum) REFERENCES foro(ID_Forum) ON DELETE CASCADE,
  CONSTRAINT fk_respuestas_usuarios FOREIGN KEY (ID_Usuario) REFERENCES usuarios(ID_Usuario) ON DELETE SET NULL
);

-- --------------------------------------------------------
-- Tabla materias
-- --------------------------------------------------------

CREATE TABLE materias (
  ID_Materia SERIAL PRIMARY KEY,
  ID_Carrera INT,
  ID_Pregrado INT,
  ID_Posgrado INT,
  Nombre_Materia VARCHAR(150) NOT NULL,
  Año INT,
  Obligatorio BOOLEAN DEFAULT TRUE,
  URL_Materia VARCHAR(255),
  CONSTRAINT fk_materias_carrera FOREIGN KEY (ID_Carrera) REFERENCES carreras(ID_Carrera) ON DELETE CASCADE,
  CONSTRAINT fk_materias_pregrado FOREIGN KEY (ID_Pregrado) REFERENCES pregrados(ID_Pregrado) ON DELETE CASCADE,
  CONSTRAINT fk_materias_posgrado FOREIGN KEY (ID_Posgrado) REFERENCES posgrados(ID_Posgrado) ON DELETE CASCADE
);

COMMIT;
