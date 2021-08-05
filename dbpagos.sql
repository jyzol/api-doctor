-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-08-2021 a las 22:38:08
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbpagos`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ingresarusuarios` ()  BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE usuario VARCHAR(100);
	DECLARE v_id_doctor INT;
	DECLARE v_nombres VARCHAR(200);
	DECLARE v_ap_pat VARCHAR(200);
	DECLARE v_ap_mat VARCHAR(200);
	DECLARE v_dni VARCHAR(8);

	DECLARE recorre CURSOR FOR
		SELECT id_doctor,nombres,ap_pat,ap_mat,dni FROM doctores;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	OPEN recorre;
	loop_recorre: LOOP
		FETCH recorre INTO v_id_doctor,v_nombres,v_ap_pat,v_ap_mat,v_dni;

		IF done THEN
			LEAVE loop_recorre;
		END IF;
	SET usuario = LOWER(CONCAT(LEFT(v_nombres,1),v_ap_pat,LEFT(v_ap_mat,1)));
	INSERT INTO usuarios VALUES (v_id_doctor,'personal',usuario,v_dni);

	END LOOP;
	CLOSE recorre;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bonos`
--

CREATE TABLE `bonos` (
  `id_doctor` int(10) NOT NULL,
  `paciente` varchar(200) NOT NULL,
  `fecha_atencion` date NOT NULL,
  `tipo_paciente` varchar(50) NOT NULL,
  `tipo_atencion` varchar(50) NOT NULL,
  `monto` float(10,2) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `fecha_pago` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `bonos`
--

INSERT INTO `bonos` (`id_doctor`, `paciente`, `fecha_atencion`, `tipo_paciente`, `tipo_atencion`, `monto`, `estado`, `fecha_pago`) VALUES
(19, 'Mollie Stokes', '2021-07-25', 'particular', 'bono', 123.00, 'pagado', '2021-07-31'),
(9, 'Damian Greene', '2021-07-24', 'seguro', 'bono', 104.00, 'pagado', '2021-07-31'),
(12, 'Iliana Chan', '2021-07-28', 'particular', 'bono', 51.00, 'pagado', '2021-07-31'),
(9, 'Jonah Hayes', '2021-07-30', 'particular', 'bono', 133.00, 'pagado', '2021-07-31'),
(9, 'Felicia White', '2021-07-07', 'particular', 'bono', 100.00, 'pagado', '2021-07-31'),
(3, 'Brent Harris', '2021-07-13', 'particular', 'bono', 60.00, 'pagado', '2021-07-31'),
(9, 'Hilary Doyle', '2021-07-22', 'seguro', 'bono', 97.00, 'pagado', '2021-07-31'),
(3, 'Isabella Chase', '2021-07-25', 'seguro', 'bono', 71.00, 'pagado', '2021-07-31'),
(8, 'Norman Avila', '2021-07-22', 'particular', 'bono', 87.00, 'pagado', '2021-07-31'),
(5, 'Keaton Mcconnell', '2021-07-15', 'particular', 'bono', 63.00, 'pagado', '2021-07-31'),
(5, 'Sharon Rowland', '2021-07-23', 'particular', 'bono', 131.00, 'pagado', '2021-07-31'),
(13, 'Alden Knapp', '2021-07-30', 'seguro', 'bono', 120.00, 'pagado', '2021-07-31'),
(7, 'Ebony Maynard', '2021-07-30', 'seguro', 'bono', 86.00, 'pagado', '2021-07-31'),
(15, 'Emmanuel Abbott', '2021-07-10', 'particular', 'bono', 81.00, 'pagado', '2021-07-31'),
(1, 'Gray Mcmahon', '2021-07-04', 'seguro', 'bono', 85.00, 'pagado', '2021-07-31'),
(17, 'Yolanda Tanner', '2021-07-19', 'particular', 'bono', 79.00, 'pagado', '2021-07-31'),
(14, 'Eric Barr', '2021-07-07', 'particular', 'bono', 116.00, 'pagado', '2021-07-31'),
(8, 'Uta Mosley', '2021-07-19', 'seguro', 'bono', 62.00, 'pagado', '2021-07-31'),
(20, 'Adrian Dalton', '2021-07-22', 'seguro', 'bono', 117.00, 'pagado', '2021-07-31'),
(10, 'Zephania Wright', '2021-07-04', 'seguro', 'bono', 149.00, 'pagado', '2021-07-31'),
(12, 'Rashad Valentine', '2021-07-30', 'seguro', 'bono', 64.00, 'pagado', '2021-07-31'),
(8, 'Hannah Woodward', '2021-07-20', 'particular', 'bono', 127.00, 'pagado', '2021-07-31'),
(7, 'Sara Hardy', '2021-07-09', 'particular', 'bono', 86.00, 'pagado', '2021-07-31'),
(11, 'Ainsley Boyd', '2021-07-23', 'particular', 'bono', 88.00, 'pagado', '2021-07-31'),
(11, 'Gareth Price', '2021-07-24', 'seguro', 'bono', 95.00, 'pagado', '2021-07-31'),
(7, 'Keefe Bates', '2021-07-28', 'particular', 'bono', 129.00, 'pagado', '2021-07-31'),
(12, 'Kirsten Knight', '2021-07-14', 'particular', 'bono', 55.00, 'pagado', '2021-07-31'),
(18, 'Summer Diaz', '2021-07-19', 'seguro', 'bono', 97.00, 'pagado', '2021-07-31'),
(15, 'Callum Bowen', '2021-07-25', 'seguro', 'bono', 125.00, 'pagado', '2021-07-31'),
(7, 'Patience Hopper', '2021-07-18', 'seguro', 'bono', 90.00, 'pagado', '2021-07-31'),
(7, 'Brenna Carpenter', '2021-07-10', 'particular', 'bono', 137.00, 'pagado', '2021-07-31'),
(14, 'Alma Nielsen', '2021-07-08', 'seguro', 'bono', 100.00, 'pagado', '2021-07-31'),
(4, 'Nelle Chavez', '2021-07-18', 'seguro', 'bono', 63.00, 'pagado', '2021-07-31'),
(3, 'Idona Carey', '2021-07-05', 'particular', 'bono', 60.00, 'pagado', '2021-07-31'),
(20, 'Amir Moreno', '2021-07-05', 'seguro', 'bono', 120.00, 'pagado', '2021-07-31'),
(11, 'Hadassah Mercer', '2021-07-08', 'seguro', 'bono', 146.00, 'pagado', '2021-07-31'),
(6, 'Hu Cruz', '2021-07-13', 'particular', 'bono', 146.00, 'pagado', '2021-07-31'),
(13, 'Dexter Frederick', '2021-07-30', 'seguro', 'bono', 131.00, 'pagado', '2021-07-31'),
(7, 'Dieter Chase', '2021-07-29', 'particular', 'bono', 148.00, 'pagado', '2021-07-31'),
(18, 'Pamela Duran', '2021-07-29', 'particular', 'bono', 88.00, 'pagado', '2021-07-31'),
(20, 'Mari Benton', '2021-07-18', 'seguro', 'bono', 102.00, 'pagado', '2021-07-31'),
(8, 'Perry Brewer', '2021-07-25', 'seguro', 'bono', 67.00, 'pagado', '2021-07-31'),
(6, 'Arsenio Berry', '2021-07-21', 'seguro', 'bono', 133.00, 'pagado', '2021-07-31'),
(15, 'Candice Ryan', '2021-07-03', 'particular', 'bono', 61.00, 'pagado', '2021-07-31'),
(18, 'Kasimir Wood', '2021-07-30', 'seguro', 'bono', 55.00, 'pagado', '2021-07-31'),
(20, 'Nicole Maddox', '2021-07-15', 'seguro', 'bono', 112.00, 'pagado', '2021-07-31'),
(2, 'Cara Velasquez', '2021-07-28', 'particular', 'bono', 116.00, 'pagado', '2021-07-31'),
(20, 'Kameko Moses', '2021-07-11', 'seguro', 'bono', 81.00, 'pagado', '2021-07-31'),
(18, 'Kato Barrett', '2021-07-14', 'seguro', 'bono', 73.00, 'pagado', '2021-07-31'),
(14, 'Hedley Lindsey', '2021-07-28', 'particular', 'bono', 101.00, 'pagado', '2021-07-31'),
(4, 'Wylie Oliver', '2021-08-01', 'seguro', 'bono', 148.00, 'pendiente', NULL),
(20, 'Shafira Sanders', '2021-08-02', 'seguro', 'bono', 83.00, 'pendiente', NULL),
(17, 'Wynter Jefferson', '2021-08-01', 'particular', 'bono', 144.00, 'pendiente', NULL),
(16, 'Maxwell Bender', '2021-08-03', 'particular', 'bono', 65.00, 'pendiente', NULL),
(4, 'Valentine Cooley', '2021-08-01', 'particular', 'bono', 65.00, 'pendiente', NULL),
(11, 'Kenyon Wilkerson', '2021-08-05', 'particular', 'bono', 89.00, 'pendiente', NULL),
(3, 'Vaughan Bray', '2021-08-04', 'seguro', 'bono', 136.00, 'pendiente', NULL),
(8, 'Rafael Christian', '2021-08-03', 'particular', 'bono', 141.00, 'pendiente', NULL),
(3, 'Keelie Ford', '2021-08-04', 'particular', 'bono', 129.00, 'pendiente', NULL),
(4, 'Rowan Howard', '2021-08-03', 'seguro', 'bono', 135.00, 'pendiente', NULL),
(11, 'Giselle Adams', '2021-08-03', 'particular', 'bono', 58.00, 'pendiente', NULL),
(9, 'Alvin Cummings', '2021-08-02', 'particular', 'bono', 115.00, 'pendiente', NULL),
(20, 'Jasper David', '2021-08-05', 'particular', 'bono', 135.00, 'pendiente', NULL),
(7, 'Colette Berry', '2021-08-01', 'particular', 'bono', 123.00, 'pendiente', NULL),
(20, 'Illana Stevens', '2021-08-05', 'particular', 'bono', 96.00, 'pendiente', NULL),
(5, 'Sara Lucas', '2021-08-05', 'seguro', 'bono', 126.00, 'pendiente', NULL),
(8, 'Boris Guerrero', '2021-08-02', 'seguro', 'bono', 77.00, 'pendiente', NULL),
(13, 'Sydnee Hoffman', '2021-08-02', 'particular', 'bono', 83.00, 'pendiente', NULL),
(11, 'Keiko Cervantes', '2021-08-02', 'particular', 'bono', 114.00, 'pendiente', NULL),
(20, 'Nichole Griffin', '2021-08-04', 'particular', 'bono', 79.00, 'pendiente', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consultas`
--

CREATE TABLE `consultas` (
  `id_doctor` int(10) NOT NULL,
  `especialidad` varchar(200) NOT NULL,
  `paciente` varchar(200) NOT NULL,
  `fecha_atencion` date NOT NULL,
  `tipo_atencion` varchar(50) NOT NULL,
  `tipo_cirugia` varchar(100) DEFAULT NULL,
  `tipo_paciente` varchar(50) NOT NULL,
  `monto` float(10,2) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `fecha_pago` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `consultas`
--

INSERT INTO `consultas` (`id_doctor`, `especialidad`, `paciente`, `fecha_atencion`, `tipo_atencion`, `tipo_cirugia`, `tipo_paciente`, `monto`, `estado`, `fecha_pago`) VALUES
(4, 'Gastroenterologia', 'Hillary Buchanan', '2021-07-27', 'cita', '', 'particular', 29.00, 'pagado', '2021-07-31'),
(6, 'Gastroenterologia', 'Steven Wong', '2021-07-13', 'cita', '', 'seguro', 143.00, 'pagado', '2021-07-31'),
(5, 'Medicina Interna', 'Carissa Little', '2021-07-30', 'cita', '', 'seguro', 83.00, 'pagado', '2021-07-31'),
(8, 'Medicina Interna', 'Clare Morales', '2021-07-04', 'procedimiento', '', 'seguro', 138.00, 'pagado', '2021-07-31'),
(16, 'Alergologia', 'Michelle Collier', '2021-07-14', 'procedimiento', '', 'seguro', 131.00, 'pagado', '2021-07-31'),
(10, 'Medicina General', 'Raja Sparks', '2021-07-09', 'cita', '', 'particular', 50.00, 'pagado', '2021-07-31'),
(9, 'Endocrinologia', 'Gillian Barnes', '2021-07-18', 'procedimiento', '', 'seguro', 36.00, 'pagado', '2021-07-31'),
(6, 'Gastroenterologia', 'Hayley Waller', '2021-07-29', 'cita', '', 'particular', 137.00, 'pagado', '2021-07-31'),
(1, 'Cardiologia', 'Frances Holder', '2021-07-24', 'procedimiento', '', 'particular', 125.00, 'pagado', '2021-07-31'),
(7, 'Dermatologia', 'Melvin Church', '2021-07-18', 'procedimiento', '', 'particular', 76.00, 'pagado', '2021-07-31'),
(14, 'Medicina Interna', 'Jameson Christian', '2021-08-02', 'procedimiento', '', 'seguro', 121.00, 'pendiente', NULL),
(3, 'Gastroenterologia', 'Luke Gomez', '2021-08-02', 'procedimiento', '', 'particular', 87.00, 'pendiente', NULL),
(19, 'Hematologia', 'Octavius Hurley', '2021-08-03', 'cita', '', 'seguro', 98.00, 'pendiente', NULL),
(4, 'Gastroenterologia', 'Hillary Buchanan', '2021-07-27', 'cita', '', 'particular', 29.00, 'pagado', '2021-07-31'),
(6, 'Gastroenterologia', 'Steven Wong', '2021-07-13', 'cita', '', 'seguro', 143.00, 'pagado', '2021-07-31'),
(5, 'Medicina Interna', 'Carissa Little', '2021-07-30', 'cita', '', 'seguro', 83.00, 'pagado', '2021-07-31'),
(8, 'Medicina Interna', 'Clare Morales', '2021-07-04', 'procedimiento', '', 'seguro', 138.00, 'pagado', '2021-07-31'),
(16, 'Alergologia', 'Michelle Collier', '2021-07-14', 'procedimiento', '', 'seguro', 131.00, 'pagado', '2021-07-31'),
(10, 'Medicina General', 'Raja Sparks', '2021-07-09', 'cita', '', 'particular', 50.00, 'pagado', '2021-07-31'),
(9, 'Endocrinologia', 'Gillian Barnes', '2021-07-18', 'procedimiento', '', 'seguro', 36.00, 'pagado', '2021-07-31'),
(6, 'Gastroenterologia', 'Hayley Waller', '2021-07-29', 'cita', '', 'particular', 137.00, 'pagado', '2021-07-31'),
(1, 'Cardiologia', 'Frances Holder', '2021-07-24', 'procedimiento', '', 'particular', 125.00, 'pagado', '2021-07-31'),
(7, 'Dermatologia', 'Melvin Church', '2021-07-18', 'procedimiento', '', 'particular', 76.00, 'pagado', '2021-07-31'),
(4, 'Gastroenterologia', 'Hillary Buchanan', '2021-07-27', 'cita', '', 'seguro', 29.00, 'pagado', '2021-07-31'),
(6, 'Gastroenterologia', 'Steven Wong', '2021-07-13', 'cita', '', 'particular', 143.00, 'pagado', '2021-07-31'),
(5, 'Medicina Interna', 'Carissa Little', '2021-07-30', 'cita', '', 'particular', 83.00, 'pagado', '2021-07-31'),
(8, 'Medicina Interna', 'Clare Morales', '2021-07-04', 'procedimiento', '', 'particular', 138.00, 'pagado', '2021-07-31'),
(16, 'Alergologia', 'Michelle Collier', '2021-07-14', 'procedimiento', '', 'particular', 131.00, 'pagado', '2021-07-31'),
(10, 'Medicina General', 'Raja Sparks', '2021-07-09', 'cita', '', 'seguro', 50.00, 'pagado', '2021-07-31'),
(9, 'Endocrinologia', 'Gillian Barnes', '2021-07-18', 'procedimiento', '', 'particular', 36.00, 'pagado', '2021-07-31'),
(6, 'Gastroenterologia', 'Hayley Waller', '2021-07-29', 'cita', '', 'seguro', 137.00, 'pagado', '2021-07-31'),
(1, 'Cardiologia', 'Frances Holder', '2021-07-24', 'procedimiento', '', 'seguro', 125.00, 'pagado', '2021-07-31'),
(7, 'Dermatologia', 'Melvin Church', '2021-07-18', 'procedimiento', '', 'seguro', 76.00, 'pagado', '2021-07-31'),
(4, 'Gastroenterologia', 'Hillary Buchanan', '2021-07-27', 'cita', '', 'particular', 29.00, 'pagado', '2021-07-31'),
(6, 'Gastroenterologia', 'Steven Wong', '2021-07-13', 'cita', '', 'particular', 143.00, 'pagado', '2021-07-31'),
(5, 'Medicina Interna', 'Carissa Little', '2021-07-30', 'cita', '', 'particular', 83.00, 'pagado', '2021-07-31'),
(8, 'Medicina Interna', 'Clare Morales', '2021-07-04', 'procedimiento', '', 'particular', 138.00, 'pagado', '2021-07-31'),
(16, 'Alergologia', 'Michelle Collier', '2021-07-14', 'procedimiento', '', 'particular', 131.00, 'pagado', '2021-07-31'),
(10, 'Medicina General', 'Raja Sparks', '2021-07-09', 'cita', '', 'particular', 50.00, 'pagado', '2021-07-31'),
(9, 'Endocrinologia', 'Gillian Barnes', '2021-07-18', 'procedimiento', '', 'particular', 36.00, 'pagado', '2021-07-31'),
(6, 'Gastroenterologia', 'Hayley Waller', '2021-07-29', 'cita', '', 'particular', 137.00, 'pagado', '2021-07-31'),
(1, 'Cardiologia', 'Frances Holder', '2021-07-24', 'procedimiento', '', 'particular', 125.00, 'pagado', '2021-07-31'),
(7, 'Dermatologia', 'Melvin Church', '2021-07-18', 'procedimiento', '', 'particular', 76.00, 'pagado', '2021-07-31'),
(4, 'Gastroenterologia', 'Hillary Buchanan', '2021-07-27', 'cita', '', 'seguro', 29.00, 'pagado', '2021-07-31'),
(6, 'Gastroenterologia', 'Steven Wong', '2021-07-13', 'cita', '', 'particular', 143.00, 'pagado', '2021-07-31'),
(5, 'Medicina Interna', 'Carissa Little', '2021-07-30', 'cita', '', 'particular', 83.00, 'pagado', '2021-07-31'),
(8, 'Medicina Interna', 'Clare Morales', '2021-07-04', 'procedimiento', '', 'particular', 138.00, 'pagado', '2021-07-31'),
(16, 'Alergologia', 'Michelle Collier', '2021-07-14', 'procedimiento', '', 'particular', 131.00, 'pagado', '2021-07-31'),
(10, 'Medicina General', 'Raja Sparks', '2021-07-09', 'cita', '', 'seguro', 50.00, 'pagado', '2021-07-31'),
(9, 'Endocrinologia', 'Gillian Barnes', '2021-07-18', 'procedimiento', '', 'particular', 36.00, 'pagado', '2021-07-31'),
(6, 'Gastroenterologia', 'Hayley Waller', '2021-07-29', 'cita', '', 'seguro', 137.00, 'pagado', '2021-07-31'),
(1, 'Cardiologia', 'Frances Holder', '2021-07-24', 'procedimiento', '', 'seguro', 125.00, 'pagado', '2021-07-31'),
(7, 'Dermatologia', 'Melvin Church', '2021-07-18', 'procedimiento', '', 'seguro', 76.00, 'pagado', '2021-07-31'),
(14, 'Medicina Interna', 'Jameson Christian', '2021-08-02', 'procedimiento', '', 'seguro', 121.00, 'pendiente', NULL),
(3, 'Gastroenterologia', 'Luke Gomez', '2021-08-02', 'procedimiento', '', 'particular', 87.00, 'pendiente', NULL),
(19, 'Hematologia', 'Octavius Hurley', '2021-08-03', 'cita', '', 'seguro', 98.00, 'pendiente', NULL),
(6, 'Medicina Interna', 'Jameson Christian', '2021-08-02', 'procedimiento', '', 'particular', 121.00, 'pendiente', NULL),
(7, 'Gastroenterologia', 'Luke Gomez', '2021-08-02', 'procedimiento', '', 'seguro', 87.00, 'pendiente', NULL),
(9, 'Hematologia', 'Octavius Hurley', '2021-08-03', 'cita', '', 'particular', 98.00, 'pendiente', NULL),
(15, 'Medicina Interna', 'Jameson Christian', '2021-08-02', 'procedimiento', '', 'seguro', 121.00, 'pendiente', NULL),
(2, 'Gastroenterologia', 'Luke Gomez', '2021-08-02', 'procedimiento', '', 'particular', 87.00, 'pendiente', NULL),
(5, 'Hematologia', 'Octavius Hurley', '2021-08-03', 'cita', '', 'seguro', 98.00, 'pendiente', NULL),
(10, 'Medicina Interna', 'Jameson Christian', '2021-08-02', 'procedimiento', '', 'particular', 121.00, 'pendiente', NULL),
(11, 'Gastroenterologia', 'Luke Gomez', '2021-08-02', 'procedimiento', '', 'seguro', 87.00, 'pendiente', NULL),
(19, 'Hematologia', 'Octavius Hurley', '2021-08-03', 'cita', '', 'particular', 98.00, 'pendiente', NULL),
(6, 'Gastroenterologia', 'Steven Wong', '2021-07-13', 'procedimiento', '', 'seguro', 143.00, 'pagado', '2021-07-31'),
(19, 'Gastroenterologia', 'Hillary Buchanan', '2021-07-27', 'cita', '', 'particular', 29.00, 'pagado', '2021-07-31'),
(19, 'Gastroenterologia', 'Steven Wong', '2021-07-13', 'cita', '', 'seguro', 143.00, 'pagado', '2021-07-31'),
(19, 'Medicina Interna', 'Carissa Little', '2021-07-30', 'cita', '', 'seguro', 83.00, 'pagado', '2021-07-31'),
(4, 'Gastroenterologia', 'Hillary Buchanan', '2021-07-27', 'procedimiento', '', 'particular', 29.00, 'pagado', '2021-07-31'),
(6, 'Gastroenterologia', 'Steven Wong', '2021-08-03', 'procedimiento', '', 'seguro', 143.00, 'pendiente', NULL),
(5, 'Medicina Interna', 'Carissa Little', '2021-08-03', 'procedimiento', '', 'particular', 83.00, 'pendiente', NULL),
(19, 'Gastroenterologia', 'Hillary Buchanan', '2021-07-27', 'procedimiento', '', 'particular', 29.00, 'pagado', '2021-07-31'),
(19, 'Gastroenterologia', 'Steven Wong', '2021-08-03', 'procedimiento', '', 'seguro', 143.00, 'pendiente', NULL),
(19, 'Medicina Interna', 'Carissa Little', '2021-08-04', 'procedimiento', '', 'particular', 83.00, 'pendiente', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctores`
--

CREATE TABLE `doctores` (
  `id_doctor` int(10) UNSIGNED NOT NULL,
  `nombres` varchar(200) NOT NULL,
  `ap_pat` varchar(200) NOT NULL,
  `ap_mat` varchar(200) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `especialidad` varchar(200) NOT NULL,
  `dni` char(8) NOT NULL,
  `ruc` char(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `doctores`
--

INSERT INTO `doctores` (`id_doctor`, `nombres`, `ap_pat`, `ap_mat`, `correo`, `direccion`, `especialidad`, `dni`, `ruc`) VALUES
(1, 'Christopher', 'Velasquez', 'Mathews', 'Cras@Aeneaneget.com', '674-7493 Tellus. Avda.', 'Gastroenterologia', '44539350', '44539350'),
(2, 'Yvette', 'Collins', 'Bruce', 'nibh.Aliquam.ornare@felis.co.uk', '9303 Nullam Carretera', 'Dermatologia', '29753472', '29753472'),
(3, 'Jackson', 'Leach', 'Oneal', 'elit.Nulla@pharetra.net', 'Apdo.:246-2806 Nulla Avenida', 'Mastologia', '10270880', '10270880'),
(4, 'Clementine', 'Montoya', 'Daniels', 'venenatis.vel.faucibus@vitaesodalesnisi.edu', '6019 Ante ', 'Medicina General', '44929350', '44929350'),
(5, 'Ulric', 'Dickson', 'Riddle', 'tellus.justo@risus.edu', '607-1716 Et Avenida', 'Cardiologia', '32751430', '32751430'),
(6, 'Savannah', 'Torres', 'Wood', 'est.vitae.sodales@tinciduntneque.com', '6538 Metus. ', 'Medicina General', '23994321', '23994321'),
(7, 'Blake', 'Aguilar', 'Hamilton', 'ornare@vitaeposuereat.org', 'Apdo.:200-5203 Nunc Calle', 'Medicina General', '13185937', '13185937'),
(8, 'Hiram', 'Robinson', 'Fuentes', 'sit.amet@laciniaatiaculis.co.uk', '7694 Pulvinar C.', 'Dermatologia', '14932787', '14932787'),
(9, 'Rama', 'Shannon', 'Knox', 'nec@convallisconvallisdolor.org', 'Apdo.:615-982 Fringilla. Carretera', 'Gastroenterologia', '25240768', '25240768'),
(10, 'Yoshio', 'Castaneda', 'Booth', 'mi.eleifend@mieleifendegestas.edu', 'Apdo.:200-4660 Ac Av.', 'Gastroenterologia', '43963239', '43963239'),
(11, 'Tanisha', 'Bradshaw', 'Mcdonald', 'urna.Vivamus.molestie@eratvitaerisus.co.uk', '7785 Amet, Carretera', 'Medicina General', '45311720', '45311720'),
(12, 'Galvin', 'Hickman', 'Conley', 'Mauris.nulla@ullamcorperviverra.edu', '443-4068 Senectus Ctra.', 'Hematologia', '45762351', '45762351'),
(13, 'Suki', 'Larson', 'Kim', 'sit@vehiculaet.net', 'Apartado núm.: 586, 7447 Eu Av.', 'Ecografia', '45649645', '45649645'),
(14, 'Ruby', 'Reynolds', 'Ellis', 'Quisque.purus@dolorFuscefeugiat.co.uk', '3894 Urna Avenida', 'Ecografia', '45681533', '45681533'),
(15, 'Ulysses', 'Acosta', 'Curtis', 'euismod.in@maurisipsumporta.com', 'Apartado núm.: 456, 9984 Ut, C/', 'Endocrinologia', '31913731', '31913731'),
(16, 'Byron', 'Torres', 'Keller', 'In.lorem@neque.co.uk', '3182 Ullamcorper, Calle', 'Cardiologia', '36390440', '36390440'),
(17, 'Rosalyn', 'Melendez', 'Parks', 'sem.molestie.sodales@velpedeblandit.ca', 'Apdo.:559-1813 Tristique C.', 'Mastologia', '7168991', '7168991'),
(18, 'Jana', 'Brooks', 'Todd', 'ipsum.primis@nectempus.org', 'Apdo.:119-5603 Ante Avda.', 'Medicina Interna', '14201984', '14201984'),
(19, 'Hayes', 'Weaver', 'Hawkins', 'mauris.Morbi.non@aliquetvel.net', 'Apartado núm.: 407, 1208 Placerat Avenida', 'Gastroenterologia', '23619153', '23619153'),
(20, 'Desirae', 'Alexander', 'Odom', 'in.magna.Phasellus@elementumlorem.co.uk', '841-9579 Mauris ', 'Ecografia', '33748287', '33748287');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--

CREATE TABLE `facturas` (
  `id` int(11) NOT NULL,
  `ruc` char(11) NOT NULL,
  `concepto` varchar(200) NOT NULL,
  `fec_emision` date NOT NULL,
  `monto` float(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `facturas`
--

INSERT INTO `facturas` (`id`, `ruc`, `concepto`, `fec_emision`, `monto`) VALUES
(1, '10123456780', 'Prueba factura', '2021-08-05', 105.00),
(2, '10884455660', 'Prueba factura 2', '2021-08-05', 54.00),
(3, '10884447860', 'Prueba factura 3', '2021-08-04', 211.00),
(4, '10454578780', 'Prueba front 1', '2021-08-04', 500.00),
(5, '12145456', 'Prueba monto', '2021-08-05', 123.00),
(6, '12145456', 'Prueba monto', '2021-08-05', 457.00),
(7, '12145456', 'Prueba monto', '2021-08-05', 457.00),
(8, '12145456', 'Prueba monto', '2021-08-05', 457.00),
(9, '10884447860', 'Prueba factura 3', '2021-08-05', 211.00),
(10, '12145456', 'Prueba monto', '2021-08-05', 457.00),
(11, '10884447860', 'Prueba factura 3', '2021-08-05', 211.00),
(12, '10884447860', 'Prueba factura 3', '2021-08-05', 211.00),
(13, '12145456', 'Prueba monto', '2021-08-05', 457.00),
(14, '12145456', 'Prueba monto', '2021-08-05', 457.00),
(15, '23619153', 'asdad', '2021-08-05', 458.00),
(16, '23619153', 'qwerty', '2021-08-05', 789.00),
(17, '23619153', 'asdfg', '2021-08-05', 175.00),
(18, '23619153', 'jkl', '2021-08-05', 451.00),
(19, '23619153', 'Conceptos', '2021-08-05', 785.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_doctor` int(10) NOT NULL,
  `tipo_usuario` varchar(10) NOT NULL,
  `nom_usuario` varchar(100) NOT NULL,
  `clave` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_doctor`, `tipo_usuario`, `nom_usuario`, `clave`) VALUES
(1, 'personal', 'cvelasquezm', '44539350'),
(2, 'personal', 'ycollinsb', '29753472'),
(3, 'personal', 'jleacho', '10270880'),
(4, 'personal', 'cmontoyad', '44929350'),
(5, 'personal', 'udicksonr', '32751430'),
(6, 'personal', 'storresw', '23994321'),
(7, 'personal', 'baguilarh', '13185937'),
(8, 'personal', 'hrobinsonf', '14932787'),
(9, 'personal', 'rshannonk', '25240768'),
(10, 'personal', 'ycastanedab', '43963239'),
(11, 'personal', 'tbradshawm', '45311720'),
(12, 'personal', 'ghickmanc', '45762351'),
(13, 'personal', 'slarsonk', '45649645'),
(14, 'personal', 'rreynoldse', '45681533'),
(15, 'personal', 'uacostac', '31913731'),
(16, 'personal', 'btorresk', '36390440'),
(17, 'personal', 'rmelendezp', '7168991'),
(18, 'personal', 'jbrookst', '14201984'),
(19, 'personal', 'hweaverh', '23619153'),
(20, 'personal', 'dalexandero', '33748287');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `doctores`
--
ALTER TABLE `doctores`
  ADD PRIMARY KEY (`id_doctor`);

--
-- Indices de la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD UNIQUE KEY `id_doctor` (`id_doctor`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `doctores`
--
ALTER TABLE `doctores`
  MODIFY `id_doctor` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `facturas`
--
ALTER TABLE `facturas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
