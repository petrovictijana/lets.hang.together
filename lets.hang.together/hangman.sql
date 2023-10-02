-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 04, 2023 at 09:16 PM
-- Server version: 8.0.31
-- PHP Version: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hangman`
--

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'admin'),
(2, 'user');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `surname` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int NOT NULL,
  `level` int NOT NULL,
  `score` int NOT NULL,
  `blocked` tinyint(1) NOT NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `surname`, `password`, `role_id`, `level`, `score`, `blocked`, `username`) VALUES
(1, 'Marko', 'Markovic', 'marko', 2, 1, 7, 0, 'marko.markovic'),
(2, 'Admin', 'Admin', 'admin', 1, 1, 0, 0, 'admin'),
(3, 'Tijana', 'Petrovic', 'tijana', 2, 1, 116, 0, 'tijana.petrovic'),
(8, 'Nemanja', 'Vidic', 'nemanja', 1, 0, 0, 0, 'nemanja.vidic'),
(9, 'Branko', 'Miljkovic', 'branko', 2, 0, 22, 0, 'branko.miljkovic');

-- --------------------------------------------------------

--
-- Table structure for table `words`
--

DROP TABLE IF EXISTS `words`;
CREATE TABLE IF NOT EXISTS `words` (
  `id` int NOT NULL AUTO_INCREMENT,
  `level` int NOT NULL,
  `word` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `words`
--

INSERT INTO `words` (`id`, `level`, `word`) VALUES
(1, 1, 'apple'),
(2, 4, 'bookmarker'),
(3, 1, 'apple'),
(4, 1, 'cat'),
(5, 1, 'dog'),
(6, 1, 'ball'),
(7, 1, 'happy'),
(8, 2, 'banana'),
(9, 2, 'chair'),
(10, 2, 'tree'),
(11, 2, 'sun'),
(12, 2, 'jump'),
(13, 3, 'notebook'),
(14, 3, 'computer'),
(15, 3, 'table'),
(16, 3, 'book'),
(17, 3, 'running'),
(18, 4, 'elephant'),
(19, 4, 'guitar'),
(20, 4, 'flower'),
(21, 4, 'desk'),
(22, 4, 'dancing'),
(23, 5, 'television'),
(24, 5, 'keyboard'),
(25, 5, 'mountain'),
(26, 5, 'lamp'),
(27, 5, 'singing'),
(28, 6, 'dictionary'),
(29, 6, 'telephone'),
(30, 6, 'valley'),
(31, 6, 'couch'),
(32, 6, 'painting'),
(33, 7, 'architecture'),
(34, 7, 'microphone'),
(35, 7, 'ocean'),
(36, 7, 'bed'),
(37, 7, 'sculpture'),
(38, 8, 'astronomy'),
(39, 8, 'airplane'),
(40, 8, 'jungle'),
(41, 8, 'dresser'),
(42, 8, 'composition'),
(43, 9, 'philosophy'),
(44, 9, 'helicopter'),
(45, 9, 'savanna'),
(46, 9, 'wardrobe'),
(47, 9, 'symphony'),
(48, 10, 'biotechnology'),
(49, 10, 'submarine'),
(50, 10, 'rainforest'),
(51, 10, 'nightstand'),
(52, 10, 'masterpiece');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
