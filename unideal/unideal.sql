-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-09-2025 a las 09:50:41
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `unideal`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areas`
--

CREATE TABLE `areas` (
  `ID_Area` int(11) NOT NULL,
  `Nombre_Area` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `areas`
--

INSERT INTO `areas` (`ID_Area`, `Nombre_Area`) VALUES
(1, 'Ingeniería y Tecnología'),
(2, 'Ciencias Exactas y Naturales'),
(3, 'Ciencias Sociales y Humanidades'),
(4, 'Ciencias de la Salud'),
(5, 'Ciencias Económicas y Administrativas'),
(6, 'Ciencias Jurídicas'),
(7, 'Educación'),
(8, 'Arte y Diseño'),
(9, 'Ciencias Agrarias y Veterinarias'),
(10, 'Informática y Computación');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carreras`
--

CREATE TABLE `carreras` (
  `ID_Carrera` int(11) NOT NULL,
  `ID_Universidad` int(11) NOT NULL,
  `ID_Area` int(11) NOT NULL,
  `Nombre_Carrera` varchar(150) NOT NULL,
  `Duracion` varchar(50) DEFAULT NULL,
  `Requisitos` varchar(255) DEFAULT NULL,
  `URL_Carrera` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrera_modalidad`
--

CREATE TABLE `carrera_modalidad` (
  `ID_Carrera` int(11) NOT NULL,
  `ID_Modalidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consultas`
--

CREATE TABLE `consultas` (
  `ID_Consulta` int(11) NOT NULL,
  `ID_Usuario` int(11) NOT NULL,
  `Asunto` varchar(255) NOT NULL,
  `Contenido` text NOT NULL,
  `Fecha_Envio` datetime DEFAULT current_timestamp(),
  `Fecha_Modificacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ID_Estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos_ext`
--

CREATE TABLE `cursos_ext` (
  `ID_Curso` int(11) NOT NULL,
  `ID_Universidad` int(11) NOT NULL,
  `ID_Area` int(11) NOT NULL,
  `Nombre_Curso` varchar(150) NOT NULL,
  `Duracion` varchar(50) DEFAULT NULL,
  `Requisitos` varchar(255) DEFAULT NULL,
  `URL_Curso` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso_modalidad`
--

CREATE TABLE `curso_modalidad` (
  `ID_Curso` int(11) NOT NULL,
  `ID_Modalidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados`
--

CREATE TABLE `estados` (
  `ID_Estado` int(11) NOT NULL,
  `Nombre_Estado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estados`
--

INSERT INTO `estados` (`ID_Estado`, `Nombre_Estado`) VALUES
(1, 'Pendiente'),
(2, 'Respondida'),
(3, 'Archivada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `foro`
--

CREATE TABLE `foro` (
  `ID_Forum` int(11) NOT NULL,
  `ID_Usuario` int(11) DEFAULT NULL,
  `Titulo` varchar(255) DEFAULT NULL,
  `Contenido` text DEFAULT NULL,
  `Fecha_Publicacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `localidades`
--

CREATE TABLE `localidades` (
  `ID_Localidad` int(11) NOT NULL,
  `ID_Provincia` int(11) NOT NULL,
  `Nombre_Localidad` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `localidades`
--

INSERT INTO `localidades` (`ID_Localidad`, `ID_Provincia`, `Nombre_Localidad`) VALUES
(1, 1, 'San Justo'),
(2, 1, 'Haedo'),
(3, 1, 'Hurlingham'),
(4, 1, 'Merlo'),
(5, 1, 'Tres de Febrero'),
(6, 1, 'Moreno'),
(7, 1, 'Moron'),
(8, 1, 'González Catán');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materias`
--

CREATE TABLE `materias` (
  `ID_Materia` int(11) NOT NULL,
  `ID_Carrera` int(11) DEFAULT NULL,
  `ID_Pregrado` int(11) DEFAULT NULL,
  `ID_Posgrado` int(11) DEFAULT NULL,
  `Nombre_Materia` varchar(150) NOT NULL,
  `Año` int(11) DEFAULT NULL,
  `Obligatorio` tinyint(1) DEFAULT 1,
  `URL_Materia` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modalidades_cursada`
--

CREATE TABLE `modalidades_cursada` (
  `ID_Modalidad` int(11) NOT NULL,
  `Nombre_Modalidad` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `modalidades_cursada`
--

INSERT INTO `modalidades_cursada` (`ID_Modalidad`, `Nombre_Modalidad`) VALUES
(1, 'Presencial'),
(2, 'Virtual'),
(3, 'Híbrida');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posgrados`
--

CREATE TABLE `posgrados` (
  `ID_Posgrado` int(11) NOT NULL,
  `ID_Universidad` int(11) NOT NULL,
  `ID_Area` int(11) NOT NULL,
  `Nombre_Posgrado` varchar(150) NOT NULL,
  `Tipo` varchar(50) DEFAULT NULL,
  `Requisitos` varchar(255) DEFAULT NULL,
  `URL_Posgrado` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posgrado_modalidad`
--

CREATE TABLE `posgrado_modalidad` (
  `ID_Posgrado` int(11) NOT NULL,
  `ID_Modalidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pregrados`
--

CREATE TABLE `pregrados` (
  `ID_Pregrado` int(11) NOT NULL,
  `ID_Universidad` int(11) NOT NULL,
  `ID_Area` int(11) NOT NULL,
  `Nombre_Pregrado` varchar(150) NOT NULL,
  `Duracion` varchar(50) DEFAULT NULL,
  `Requisitos` varchar(255) DEFAULT NULL,
  `URL_Pregrado` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pregrado_modalidad`
--

CREATE TABLE `pregrado_modalidad` (
  `ID_Pregrado` int(11) NOT NULL,
  `ID_Modalidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provincias`
--

CREATE TABLE `provincias` (
  `ID_Provincia` int(11) NOT NULL,
  `Nombre_Provincia` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `provincias`
--

INSERT INTO `provincias` (`ID_Provincia`, `Nombre_Provincia`) VALUES
(1, 'Buenos Aires');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestas`
--

CREATE TABLE `respuestas` (
  `ID_Respuesta` int(11) NOT NULL,
  `ID_Forum` int(11) DEFAULT NULL,
  `ID_Usuario` int(11) DEFAULT NULL,
  `Contenido` text DEFAULT NULL,
  `Fecha_Publicacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `ID_Rol` int(11) NOT NULL,
  `Nombre_Rol` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`ID_Rol`, `Nombre_Rol`) VALUES
(1, 'Estudiante'),
(2, 'Moderador'),
(3, 'Admin');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `universidades`
--

CREATE TABLE `universidades` (
  `ID_Universidad` int(11) NOT NULL,
  `ID_Localidad` int(11) NOT NULL,
  `Nombre_Universidad` varchar(150) NOT NULL,
  `Acronimo` varchar(20) DEFAULT NULL,
  `Tipo` varchar(40) DEFAULT NULL,
  `URL_Web` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `universidades`
--

INSERT INTO `universidades` (`ID_Universidad`, `ID_Localidad`, `Nombre_Universidad`, `Acronimo`, `Tipo`, `URL_Web`) VALUES
(1, 1, 'Universidad Nacional de La Matanza', 'UNLAM', 'Pública', 'https://www.unlam.edu.ar/'),
(2, 2, 'Universidad Tecnológica Nacional', 'UTN', 'Pública', 'https://www.utn.edu.ar/es/'),
(3, 3, 'Universidad Nacional de Hurlingham', 'UNAHUR', 'Pública', 'https://unahur.edu.ar/'),
(4, 4, 'Universidad Nacional del Oeste', 'UNO', 'Pública', 'https://uno.edu.ar/'),
(5, 5, 'Universidad Nacional de Tres de Febrero', 'UNTREF', 'Pública', 'https://untref.edu.ar/'),
(6, 6, 'Universidad Nacional de Moreno', 'UNM', 'Pública', 'https://www.unm.edu.ar/'),
(7, 7, 'Universidad Nacional de Moron', 'UM', 'Pública', 'https://unimoron.edu.ar/'),
(8, 8, 'Centro universitario de La Matanza', 'CUDI', 'Pública', 'https://www.cudi.ar/');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `ID_Usuario` int(11) NOT NULL,
  `Nombre_Usuario` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Contraseña` varchar(255) NOT NULL,
  `ID_Rol` int(11) NOT NULL DEFAULT 1,
  `Fecha_Creacion` datetime DEFAULT current_timestamp(),
  `Fecha_Modificacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`ID_Area`);

--
-- Indices de la tabla `carreras`
--
ALTER TABLE `carreras`
  ADD PRIMARY KEY (`ID_Carrera`),
  ADD KEY `ID_Universidad` (`ID_Universidad`),
  ADD KEY `ID_Area` (`ID_Area`);

--
-- Indices de la tabla `carrera_modalidad`
--
ALTER TABLE `carrera_modalidad`
  ADD PRIMARY KEY (`ID_Carrera`,`ID_Modalidad`),
  ADD KEY `ID_Modalidad` (`ID_Modalidad`);

--
-- Indices de la tabla `consultas`
--
ALTER TABLE `consultas`
  ADD PRIMARY KEY (`ID_Consulta`),
  ADD KEY `ID_Usuario` (`ID_Usuario`),
  ADD KEY `ID_Estado` (`ID_Estado`);

--
-- Indices de la tabla `cursos_ext`
--
ALTER TABLE `cursos_ext`
  ADD PRIMARY KEY (`ID_Curso`),
  ADD KEY `ID_Universidad` (`ID_Universidad`),
  ADD KEY `ID_Area` (`ID_Area`);

--
-- Indices de la tabla `curso_modalidad`
--
ALTER TABLE `curso_modalidad`
  ADD PRIMARY KEY (`ID_Curso`,`ID_Modalidad`),
  ADD KEY `ID_Modalidad` (`ID_Modalidad`);

--
-- Indices de la tabla `estados`
--
ALTER TABLE `estados`
  ADD PRIMARY KEY (`ID_Estado`);

--
-- Indices de la tabla `foro`
--
ALTER TABLE `foro`
  ADD PRIMARY KEY (`ID_Forum`),
  ADD KEY `ID_Usuario` (`ID_Usuario`);

--
-- Indices de la tabla `localidades`
--
ALTER TABLE `localidades`
  ADD PRIMARY KEY (`ID_Localidad`),
  ADD KEY `ID_Provincia` (`ID_Provincia`);

--
-- Indices de la tabla `materias`
--
ALTER TABLE `materias`
  ADD PRIMARY KEY (`ID_Materia`),
  ADD KEY `ID_Carrera` (`ID_Carrera`),
  ADD KEY `ID_Pregrado` (`ID_Pregrado`),
  ADD KEY `ID_Posgrado` (`ID_Posgrado`);

--
-- Indices de la tabla `modalidades_cursada`
--
ALTER TABLE `modalidades_cursada`
  ADD PRIMARY KEY (`ID_Modalidad`);

--
-- Indices de la tabla `posgrados`
--
ALTER TABLE `posgrados`
  ADD PRIMARY KEY (`ID_Posgrado`),
  ADD KEY `ID_Universidad` (`ID_Universidad`),
  ADD KEY `ID_Area` (`ID_Area`);

--
-- Indices de la tabla `posgrado_modalidad`
--
ALTER TABLE `posgrado_modalidad`
  ADD PRIMARY KEY (`ID_Posgrado`,`ID_Modalidad`),
  ADD KEY `ID_Modalidad` (`ID_Modalidad`);

--
-- Indices de la tabla `pregrados`
--
ALTER TABLE `pregrados`
  ADD PRIMARY KEY (`ID_Pregrado`),
  ADD KEY `ID_Universidad` (`ID_Universidad`),
  ADD KEY `ID_Area` (`ID_Area`);

--
-- Indices de la tabla `pregrado_modalidad`
--
ALTER TABLE `pregrado_modalidad`
  ADD PRIMARY KEY (`ID_Pregrado`,`ID_Modalidad`),
  ADD KEY `ID_Modalidad` (`ID_Modalidad`);

--
-- Indices de la tabla `provincias`
--
ALTER TABLE `provincias`
  ADD PRIMARY KEY (`ID_Provincia`);

--
-- Indices de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD PRIMARY KEY (`ID_Respuesta`),
  ADD KEY `ID_Forum` (`ID_Forum`),
  ADD KEY `ID_Usuario` (`ID_Usuario`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`ID_Rol`);

--
-- Indices de la tabla `universidades`
--
ALTER TABLE `universidades`
  ADD PRIMARY KEY (`ID_Universidad`),
  ADD KEY `ID_Localidad` (`ID_Localidad`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`ID_Usuario`),
  ADD UNIQUE KEY `Nombre_Usuario` (`Nombre_Usuario`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD KEY `ID_Rol` (`ID_Rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `areas`
--
ALTER TABLE `areas`
  MODIFY `ID_Area` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `carreras`
--
ALTER TABLE `carreras`
  MODIFY `ID_Carrera` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `consultas`
--
ALTER TABLE `consultas`
  MODIFY `ID_Consulta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cursos_ext`
--
ALTER TABLE `cursos_ext`
  MODIFY `ID_Curso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estados`
--
ALTER TABLE `estados`
  MODIFY `ID_Estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `foro`
--
ALTER TABLE `foro`
  MODIFY `ID_Forum` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `localidades`
--
ALTER TABLE `localidades`
  MODIFY `ID_Localidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `materias`
--
ALTER TABLE `materias`
  MODIFY `ID_Materia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `modalidades_cursada`
--
ALTER TABLE `modalidades_cursada`
  MODIFY `ID_Modalidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `posgrados`
--
ALTER TABLE `posgrados`
  MODIFY `ID_Posgrado` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pregrados`
--
ALTER TABLE `pregrados`
  MODIFY `ID_Pregrado` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `provincias`
--
ALTER TABLE `provincias`
  MODIFY `ID_Provincia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `ID_Respuesta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `ID_Rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `universidades`
--
ALTER TABLE `universidades`
  MODIFY `ID_Universidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `ID_Usuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carreras`
--
ALTER TABLE `carreras`
  ADD CONSTRAINT `carreras_ibfk_1` FOREIGN KEY (`ID_Universidad`) REFERENCES `universidades` (`ID_Universidad`) ON DELETE CASCADE,
  ADD CONSTRAINT `carreras_ibfk_2` FOREIGN KEY (`ID_Area`) REFERENCES `areas` (`ID_Area`) ON DELETE CASCADE;

--
-- Filtros para la tabla `carrera_modalidad`
--
ALTER TABLE `carrera_modalidad`
  ADD CONSTRAINT `carrera_modalidad_ibfk_1` FOREIGN KEY (`ID_Carrera`) REFERENCES `carreras` (`ID_Carrera`) ON DELETE CASCADE,
  ADD CONSTRAINT `carrera_modalidad_ibfk_2` FOREIGN KEY (`ID_Modalidad`) REFERENCES `modalidades_cursada` (`ID_Modalidad`) ON DELETE CASCADE;

--
-- Filtros para la tabla `consultas`
--
ALTER TABLE `consultas`
  ADD CONSTRAINT `consultas_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuarios` (`ID_Usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `consultas_ibfk_2` FOREIGN KEY (`ID_Estado`) REFERENCES `estados` (`ID_Estado`);

--
-- Filtros para la tabla `cursos_ext`
--
ALTER TABLE `cursos_ext`
  ADD CONSTRAINT `cursos_ext_ibfk_1` FOREIGN KEY (`ID_Universidad`) REFERENCES `universidades` (`ID_Universidad`) ON DELETE CASCADE,
  ADD CONSTRAINT `cursos_ext_ibfk_2` FOREIGN KEY (`ID_Area`) REFERENCES `areas` (`ID_Area`) ON DELETE CASCADE;

--
-- Filtros para la tabla `curso_modalidad`
--
ALTER TABLE `curso_modalidad`
  ADD CONSTRAINT `curso_modalidad_ibfk_1` FOREIGN KEY (`ID_Curso`) REFERENCES `cursos_ext` (`ID_Curso`) ON DELETE CASCADE,
  ADD CONSTRAINT `curso_modalidad_ibfk_2` FOREIGN KEY (`ID_Modalidad`) REFERENCES `modalidades_cursada` (`ID_Modalidad`) ON DELETE CASCADE;

--
-- Filtros para la tabla `foro`
--
ALTER TABLE `foro`
  ADD CONSTRAINT `foro_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuarios` (`ID_Usuario`) ON DELETE SET NULL;

--
-- Filtros para la tabla `localidades`
--
ALTER TABLE `localidades`
  ADD CONSTRAINT `localidades_ibfk_1` FOREIGN KEY (`ID_Provincia`) REFERENCES `provincias` (`ID_Provincia`) ON DELETE CASCADE;

--
-- Filtros para la tabla `materias`
--
ALTER TABLE `materias`
  ADD CONSTRAINT `materias_ibfk_1` FOREIGN KEY (`ID_Carrera`) REFERENCES `carreras` (`ID_Carrera`) ON DELETE CASCADE,
  ADD CONSTRAINT `materias_ibfk_2` FOREIGN KEY (`ID_Pregrado`) REFERENCES `pregrados` (`ID_Pregrado`) ON DELETE CASCADE,
  ADD CONSTRAINT `materias_ibfk_3` FOREIGN KEY (`ID_Posgrado`) REFERENCES `posgrados` (`ID_Posgrado`) ON DELETE CASCADE;

--
-- Filtros para la tabla `posgrados`
--
ALTER TABLE `posgrados`
  ADD CONSTRAINT `posgrados_ibfk_1` FOREIGN KEY (`ID_Universidad`) REFERENCES `universidades` (`ID_Universidad`) ON DELETE CASCADE,
  ADD CONSTRAINT `posgrados_ibfk_2` FOREIGN KEY (`ID_Area`) REFERENCES `areas` (`ID_Area`) ON DELETE CASCADE;

--
-- Filtros para la tabla `posgrado_modalidad`
--
ALTER TABLE `posgrado_modalidad`
  ADD CONSTRAINT `posgrado_modalidad_ibfk_1` FOREIGN KEY (`ID_Posgrado`) REFERENCES `posgrados` (`ID_Posgrado`) ON DELETE CASCADE,
  ADD CONSTRAINT `posgrado_modalidad_ibfk_2` FOREIGN KEY (`ID_Modalidad`) REFERENCES `modalidades_cursada` (`ID_Modalidad`) ON DELETE CASCADE;

--
-- Filtros para la tabla `pregrados`
--
ALTER TABLE `pregrados`
  ADD CONSTRAINT `pregrados_ibfk_1` FOREIGN KEY (`ID_Universidad`) REFERENCES `universidades` (`ID_Universidad`) ON DELETE CASCADE,
  ADD CONSTRAINT `pregrados_ibfk_2` FOREIGN KEY (`ID_Area`) REFERENCES `areas` (`ID_Area`) ON DELETE CASCADE;

--
-- Filtros para la tabla `pregrado_modalidad`
--
ALTER TABLE `pregrado_modalidad`
  ADD CONSTRAINT `pregrado_modalidad_ibfk_1` FOREIGN KEY (`ID_Pregrado`) REFERENCES `pregrados` (`ID_Pregrado`) ON DELETE CASCADE,
  ADD CONSTRAINT `pregrado_modalidad_ibfk_2` FOREIGN KEY (`ID_Modalidad`) REFERENCES `modalidades_cursada` (`ID_Modalidad`) ON DELETE CASCADE;

--
-- Filtros para la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD CONSTRAINT `respuestas_ibfk_1` FOREIGN KEY (`ID_Forum`) REFERENCES `foro` (`ID_Forum`) ON DELETE CASCADE,
  ADD CONSTRAINT `respuestas_ibfk_2` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuarios` (`ID_Usuario`) ON DELETE SET NULL;

--
-- Filtros para la tabla `universidades`
--
ALTER TABLE `universidades`
  ADD CONSTRAINT `universidades_ibfk_1` FOREIGN KEY (`ID_Localidad`) REFERENCES `localidades` (`ID_Localidad`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`ID_Rol`) REFERENCES `roles` (`ID_Rol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
