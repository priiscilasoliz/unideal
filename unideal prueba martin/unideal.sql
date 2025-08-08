-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-08-2025 a las 01:32:21
-- Versión del servidor: 10.4.21-MariaDB
-- Versión de PHP: 8.0.11

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
-- Estructura de tabla para la tabla `localidades`
--

CREATE TABLE `localidades` (
  `ID_Localidad` int(11) NOT NULL,
  `Nombre_Localidad` varchar(100) NOT NULL,
  `ID_Provincia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `localidades`
--

INSERT INTO `localidades` (`ID_Localidad`, `Nombre_Localidad`, `ID_Provincia`) VALUES
(1, 'La Matanza', 1),
(2, 'Tres de Febrero', 1),
(3, 'Hurlingham', 1),
(4, 'Ituzaingó', 1),
(5, 'Merlo', 1),
(6, 'Moreno', 1),
(7, 'General Rodríguez', 1),
(8, 'Marcos Paz', 1),
(9, 'Haedo', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provincias`
--

CREATE TABLE `provincias` (
  `ID_Provincia` int(11) NOT NULL,
  `Nombre_Provincia` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `provincias`
--

INSERT INTO `provincias` (`ID_Provincia`, `Nombre_Provincia`) VALUES
(1, 'Buenos Aires');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `universidades`
--

CREATE TABLE `universidades` (
  `ID_Universidad` int(11) NOT NULL,
  `Nombre_Universidad` varchar(150) NOT NULL,
  `Tipo` enum('Pública','Privada') NOT NULL,
  `ID_Localidad` int(11) NOT NULL,
  `Acronimo` varchar(20) DEFAULT NULL,
  `Enlace_Web` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `universidades`
--

INSERT INTO `universidades` (`ID_Universidad`, `Nombre_Universidad`, `Tipo`, `ID_Localidad`, `Acronimo`, `Enlace_Web`) VALUES
(1, 'Universidad de La Matanza', 'Pública', 1, 'UnLaM', '../HTML/unlam.html'),
(2, 'Universidad Tecnológica Nacional', 'Pública', 9, 'UTN', '../HTML/utn.html'),
(3, 'Universidad Nacional de Hurlingham', 'Pública', 3, 'UNAHUR', '../HTML/unahur.html'),
(4, 'Universidad Nacional del Oeste', 'Pública', 5, 'UNO', '../HTML/uno.html'),
(5, 'Universidad Nacional de Tres de Febrero', 'Pública', 2, 'UNTREF', '../HTML/untref.html'),
(6, 'Universidad Nacional de Moreno', 'Pública', 6, 'UNM', '../HTML/unm.html');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `ID_Usuario` int(11) NOT NULL,
  `Nombre_Usuario` varchar(100) NOT NULL,
  `Gmail` varchar(100) NOT NULL,
  `Contraseña` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `localidades`
--
ALTER TABLE `localidades`
  ADD PRIMARY KEY (`ID_Localidad`),
  ADD KEY `ID_Provincia` (`ID_Provincia`);

--
-- Indices de la tabla `provincias`
--
ALTER TABLE `provincias`
  ADD PRIMARY KEY (`ID_Provincia`);

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
  ADD UNIQUE KEY `Gmail` (`Gmail`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `localidades`
--
ALTER TABLE `localidades`
  MODIFY `ID_Localidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `provincias`
--
ALTER TABLE `provincias`
  MODIFY `ID_Provincia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `universidades`
--
ALTER TABLE `universidades`
  MODIFY `ID_Universidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `ID_Usuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `localidades`
--
ALTER TABLE `localidades`
  ADD CONSTRAINT `localidades_ibfk_1` FOREIGN KEY (`ID_Provincia`) REFERENCES `provincias` (`ID_Provincia`);

--
-- Filtros para la tabla `universidades`
--
ALTER TABLE `universidades`
  ADD CONSTRAINT `universidades_ibfk_2` FOREIGN KEY (`ID_Localidad`) REFERENCES `localidades` (`ID_Localidad`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
