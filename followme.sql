-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 09, 2012 at 04:58 AM
-- Server version: 5.5.21
-- PHP Version: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `followme`
--

-- --------------------------------------------------------

--
-- Table structure for table `relationships`
--

CREATE TABLE IF NOT EXISTS `relationships` (
  `follower_id` int(11) NOT NULL,
  `followed_id` int(11) NOT NULL,
  UNIQUE KEY `duplicates` (`follower_id`,`followed_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `relationships`
--

INSERT INTO `relationships` (`follower_id`, `followed_id`) VALUES
(1396, 1397),
(1396, 1398),
(1396, 1413),
(1396, 1414),
(1396, 1415);

-- --------------------------------------------------------

--
-- Table structure for table `tweets`
--

CREATE TABLE IF NOT EXISTS `tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(140) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3551 ;

--
-- Dumping data for table `tweets`
--

INSERT INTO `tweets` (`id`, `content`, `user_id`, `created_at`) VALUES
(3499, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed', 1414, '2012-03-09 03:31:02'),
(3500, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor', 1416, '2012-03-09 03:31:02'),
(3501, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor', 1409, '2012-03-09 03:31:02'),
(3502, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt', 1416, '2012-03-09 03:31:02'),
(3503, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed', 1416, '2012-03-09 03:31:02'),
(3504, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna', 1418, '2012-03-09 03:31:02'),
(3505, 'Lorem ipsum dolor sit amet, consetetur', 1412, '2012-03-09 03:31:02'),
(3506, 'Lorem', 1400, '2012-03-09 03:31:02'),
(3507, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,', 1415, '2012-03-09 03:31:02'),
(3508, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam', 1397, '2012-03-09 03:31:02'),
(3509, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,', 1408, '2012-03-09 03:31:02'),
(3510, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt', 1397, '2012-03-09 03:31:03'),
(3511, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt', 1399, '2012-03-09 03:31:03'),
(3512, 'Lorem ipsum dolor sit amet, consetetur', 1417, '2012-03-09 03:31:03'),
(3513, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor', 1403, '2012-03-09 03:31:03'),
(3514, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam', 1401, '2012-03-09 03:31:03'),
(3515, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod', 1412, '2012-03-09 03:31:03'),
(3516, 'Lorem ipsum dolor', 1398, '2012-03-09 03:31:03'),
(3517, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed', 1401, '2012-03-09 03:31:03'),
(3518, 'Lorem ipsum', 1397, '2012-03-09 03:31:03'),
(3519, 'Lorem ipsum dolor sit amet,', 1403, '2012-03-09 03:31:03'),
(3520, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod', 1409, '2012-03-09 03:31:03'),
(3521, 'Lorem ipsum dolor', 1414, '2012-03-09 03:31:03'),
(3522, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna', 1410, '2012-03-09 03:31:03'),
(3523, 'Lorem', 1397, '2012-03-09 03:31:03'),
(3524, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam', 1414, '2012-03-09 03:31:03'),
(3525, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et', 1408, '2012-03-09 03:31:03'),
(3526, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt', 1408, '2012-03-09 03:31:03'),
(3527, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor', 1401, '2012-03-09 03:31:03'),
(3528, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed', 1409, '2012-03-09 03:31:03'),
(3529, 'Lorem ipsum dolor', 1400, '2012-03-09 03:31:03'),
(3530, 'Lorem ipsum dolor', 1398, '2012-03-09 03:31:04'),
(3531, 'Lorem ipsum dolor sit', 1413, '2012-03-09 03:31:04'),
(3532, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy', 1405, '2012-03-09 03:31:04'),
(3533, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut', 1412, '2012-03-09 03:31:04'),
(3534, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut', 1402, '2012-03-09 03:31:04'),
(3535, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et', 1408, '2012-03-09 03:31:04'),
(3536, 'Lorem ipsum dolor sit amet,', 1396, '2012-03-09 03:31:04'),
(3537, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed', 1401, '2012-03-09 03:31:04'),
(3538, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore', 1398, '2012-03-09 03:31:04'),
(3539, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod', 1416, '2012-03-09 03:31:04'),
(3540, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna', 1413, '2012-03-09 03:31:04'),
(3541, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut', 1416, '2012-03-09 03:31:04'),
(3542, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor', 1408, '2012-03-09 03:31:04'),
(3543, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod', 1403, '2012-03-09 03:31:04'),
(3544, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et', 1407, '2012-03-09 03:31:04'),
(3545, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam', 1396, '2012-03-09 03:31:04'),
(3546, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,', 1405, '2012-03-09 03:31:04'),
(3547, 'Lorem ipsum dolor sit amet, consetetur sadipscing', 1404, '2012-03-09 03:31:04'),
(3548, 'Lorem', 1406, '2012-03-09 03:31:04'),
(3549, 'sdfasdfa dfasd fasd fasd', 1396, '2012-03-09 04:02:11'),
(3550, 'Hello here', 1396, '2012-03-09 04:09:35');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1419 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `name`, `created_at`) VALUES
(1396, 'davidrobles', 'drobles@gmail.com', '3aa6246005451bf2fde085a8ff09ec7a', 'David Robles', '2012-03-09 03:31:00'),
(1397, 'nataliacaballero', 'nattycaballero@gmail.com', '18a46f54aa5d19410958a6d389517490', 'Natalia Caballero', '2012-03-09 03:31:00'),
(1398, 'ben.royall', 'ben.royall@gmail.com', '3b3dde8eeb063c8a029d88f3ddc604ec', 'Ben Royall', '2012-03-09 03:31:00'),
(1399, 'acarrillomodderman', 'acarrillomodderman@gmail.com', 'a60e08f1ebe7c66fafbb66ff908008d9', 'Alexandra Cm', '2012-03-09 03:31:00'),
(1400, 'StephenSONeil', 'christophe.mansfield@gmail.com', '6c3390e37b810910babb4ca61ffd9118', 'Steve Smith', '2012-03-09 03:31:00'),
(1401, 'mgraffg', 'mgraffg@gmail.com', '833ca9d8e775aeab4a983046a5661183', 'Mario Graff', '2012-03-09 03:31:00'),
(1402, 'nielsvanhoorn', 'nielsvanhoorn@gmail.com', '8397a28718557a6592aea4008275b502', 'Niels van Hoorn', '2012-03-09 03:31:00'),
(1403, 'Klovli', 'Klovli@gmail.com', '19b57ec8b0eee7cd0b7015062c6e90c7', 'Alex Holmes', '2012-03-09 03:31:00'),
(1404, 'alisonchiu', 'alisonchiu@gmail.com', '2c917ff5326db27f18ad5a7d7af8e48c', 'Alison Hsin-Yi', '2012-03-09 03:31:01'),
(1405, 'auasch', 'auasch@gmail.com', 'b37470caa638b9d17179fd377d0af654', 'Anna Schoiswohl', '2012-03-09 03:31:01'),
(1406, 'acoldenbjerg', 'acoldenbjerg@gmail.com', '65848b4dc557885b6a11bb36724a705d', 'Anne Cathrine', '2012-03-09 03:31:01'),
(1407, 'chrispaarup', 'chrispaarup@gmail.com', '744b1eda3c4c3fc979a0eb5fb31208e7', 'Chris Pickering', '2012-03-09 03:31:01'),
(1408, 'christianeskehansen', 'christianeskehansen@gmail.com', '6b494df0b176252edbf52bc3cc96d943', 'Christian Eske', '2012-03-09 03:31:01'),
(1409, 'amanfel', 'amanfel@gmail.com', '9a8b6d716bcbe52e6dc702260d6f0dc6', 'Amanda Feldman', '2012-03-09 03:31:01'),
(1410, 'davidgwebb', 'davidgwebb@gmail.com', '49a4fcb8d0088a595b8229840f781eac', 'David Webb', '2012-03-09 03:31:01'),
(1411, 'agbatiz', 'agbatiz@gmail.com', 'e5d1d125e9757c6fccc2fa6293aaccf9', 'Andie Garza', '2012-03-09 03:31:01'),
(1412, 'amneft', 'amneft@gmail.com', '97945192d3133c807e2a40a6789cb676', 'Adam Neft', '2012-03-09 03:31:02'),
(1413, 'SchlackDizzle', 'SchlackDizzle@gmail.com', '183b9241bf5df96784363467b4088369', 'Adam Schlackman', '2012-03-09 03:31:02'),
(1414, 'RachelPocahontas', 'RachelPocahontas@gmail.com', '1712fee1c22d8e109cac403134af2134', 'Rachel Barros', '2012-03-09 03:31:02'),
(1415, 'bronsonali', 'bronsonali@gmail.com', '3c7b993fcf0d3b14c31137473e367f62', 'Ali Bronson', '2012-03-09 03:31:02'),
(1416, 'acp21178', 'acp21178@gmail.com', '7012be86a13029c4d657fe6310726234', 'Andrew Pennacchio', '2012-03-09 03:31:02'),
(1417, 'andrewychoo', 'andrewychoo@gmail.com', 'fc74674b9215807aa81c9e5b3896bf16', 'Andy Choo', '2012-03-09 03:31:02'),
(1418, 'Thrillhelm', 'Thrillhelm@gmail.com', '0c99b87b7f373e402110ab4d47722f30', 'Andy Wilhelm', '2012-03-09 03:31:02');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
