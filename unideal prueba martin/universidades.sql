-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-06-2025 a las 06:55:14
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
-- Estructura de tabla para la tabla `universidades`
--

CREATE TABLE `universidades` (
  `ID_Universidad` int(11) NOT NULL,
  `Nombre_Universidad` varchar(150) NOT NULL,
  `Tipo` enum('Pública','Privada') NOT NULL,
  `ID_Provincia` int(11) NOT NULL,
  `ID_Localidad` int(11) NOT NULL,
  `Acronimo` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `universidades`
--

INSERT INTO `universidades` (`ID_Universidad`, `Nombre_Universidad`, `Tipo`, `ID_Provincia`, `ID_Localidad`, `Acronimo`) VALUES
(1, 'Universidad de La Matanza', 'Pública', 1, 1, 'UnLaM'),
(2, 'Universidad Tecnológica Nacional', 'Pública', 1, 9, 'UTN'),
(3, 'Universidad Nacional de Hurlingham', 'Pública', 1, 3, 'UNAHUR'),
(4, 'Universidad Nacional del Oeste', 'Pública', 1, 5, 'UNO'),
(5, 'Universidad Nacional de Tres de Febrero', 'Pública', 1, 2, 'UNTREF'),
(6, 'Universidad Nacional de Moreno', 'Pública', 1, 6, 'UNM');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `universidades`
--
ALTER TABLE `universidades`
  ADD PRIMARY KEY (`ID_Universidad`),
  ADD KEY `ID_Provincia` (`ID_Provincia`),
  ADD KEY `ID_Localidad` (`ID_Localidad`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `universidades`
--
ALTER TABLE `universidades`
  MODIFY `ID_Universidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `universidades`
--
ALTER TABLE `universidades`
  ADD CONSTRAINT `universidades_ibfk_1` FOREIGN KEY (`ID_Provincia`) REFERENCES `provincias` (`ID_Provincia`),
  ADD CONSTRAINT `universidades_ibfk_2` FOREIGN KEY (`ID_Localidad`) REFERENCES `localidades` (`ID_Localidad`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
