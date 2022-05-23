-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 29, 2020 at 09:54 AM
-- Server version: 5.7.26
-- PHP Version: 7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+07:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tiketku`
--

-- --------------------------------------------------------

--
-- Table structure for table `airports`
--

DROP TABLE IF EXISTS `airports`;
CREATE TABLE IF NOT EXISTS `airports` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `airport_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `airports`
--

INSERT INTO `airports` (`id`, `code`, `city`, `airport_name`, `created_at`, `updated_at`) VALUES
(1, 'HLP', 'Jakarta', 'Halim Perdana Kusuma', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(2, 'CGK', 'Tanggerang', 'Soekarno - Hatta', '2020-11-29 03:52:38', '2020-11-29 03:52:38');

-- --------------------------------------------------------

--
-- Table structure for table `bank_accounts`
--

DROP TABLE IF EXISTS `bank_accounts`;
CREATE TABLE IF NOT EXISTS `bank_accounts` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `bank` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bank_accounts`
--

INSERT INTO `bank_accounts` (`id`, `bank`, `account_name`, `account_number`, `created_at`, `updated_at`) VALUES
(1, 'BCA', 'TiketKuBCA', '13579', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(2, 'BRI', 'TiketKuBRI', '24680', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(3, 'Mandiri', 'TiketKuMandiri', '12345', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(4, 'BNI', 'TiketKuBNI', '67890', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(5, 'CIMB Niaga', 'TiketKuCIMB', '09876', '2020-11-29 03:52:38', '2020-11-29 03:52:38');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
CREATE TABLE IF NOT EXISTS `bookings` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `schedule_id` int(11) NOT NULL,
  `booking_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bill` decimal(10,2) NOT NULL,
  `expire` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bookings_user_id_foreign` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Triggers `bookings`
--
DROP TRIGGER IF EXISTS `restore_booking`;
DELIMITER $$
CREATE TRIGGER `restore_booking` BEFORE DELETE ON `bookings` FOR EACH ROW BEGIN
          SET @oldP = (SELECT passenger FROM detail_bookings WHERE booking_id = OLD.id);
          SET @oldC = (SELECT class FROM detail_bookings WHERE booking_id = OLD.id);
          IF old.vehicle = 'plane' THEN
            IF @oldC = 'eco_seat' THEN
              UPDATE plane_schedules SET eco_seat = eco_seat + @oldP WHERE id = OLD.schedule_id;
            ELSEIF @oldC = 'bus_seat' THEN
              UPDATE plane_schedules SET bus_seat = bus_seat + @oldP WHERE id = OLD.schedule_id;
            ELSEIF @oldC = 'first_seat' THEN
              UPDATE plane_schedules SET first_seat = first_seat + @oldP WHERE id = OLD.schedule_id;
            END IF;
          END IF;
        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detail_bookings`
--

DROP TABLE IF EXISTS `detail_bookings`;
CREATE TABLE IF NOT EXISTS `detail_bookings` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `booking_id` int(10) UNSIGNED NOT NULL,
  `passenger` int(11) NOT NULL,
  `class` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `detail_bookings_booking_id_foreign` (`booking_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `group` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `group`, `created_at`, `updated_at`) VALUES
(1, 'admin', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(2, 'member', '2020-11-29 03:52:38', '2020-11-29 03:52:38');

-- --------------------------------------------------------

--
-- Table structure for table `group_user`
--

DROP TABLE IF EXISTS `group_user`;
CREATE TABLE IF NOT EXISTS `group_user` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_user_group_id_foreign` (`group_id`),
  KEY `group_user_user_id_foreign` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `group_user`
--

INSERT INTO `group_user` (`id`, `group_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(2, 2, 2, '2020-11-29 03:52:38', '2020-11-29 03:52:38');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2014_10_12_100001_create_groups_table', 1),
(4, '2014_10_12_100002_create_group_user_table', 1),
(5, '2018_01_25_154144_create_bookings_table', 1),
(6, '2018_01_25_154250_create_detail_bookings_table', 1),
(7, '2018_01_25_154251_create_transactions_table', 1),
(8, '2018_01_25_154314_create_passengers_table', 1),
(9, '2018_01_25_154441_create_planes_table', 1),
(10, '2018_01_25_154442_create_plane_fares_table', 1),
(11, '2018_01_25_154443_create_airports_table', 1),
(12, '2018_01_25_154453_create_plane_schedules_table', 1),
(17, '2018_02_21_084438_create_bank_accounts_table', 1),
(18, '2018_03_10_210210_create_trigger_booking', 1);

-- --------------------------------------------------------

--
-- Table structure for table `passengers`
--

DROP TABLE IF EXISTS `passengers`;
CREATE TABLE IF NOT EXISTS `passengers` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `detail_booking_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `passengers_detail_booking_id_foreign` (`detail_booking_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `planes`
--

DROP TABLE IF EXISTS `planes`;
CREATE TABLE IF NOT EXISTS `planes` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `plane_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `eco_seat` int(11) NOT NULL,
  `bus_seat` int(11) NOT NULL,
  `first_seat` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `planes`
--

INSERT INTO `planes` (`id`, `plane_name`, `eco_seat`, `bus_seat`, `first_seat`, `created_at`, `updated_at`) VALUES
(1, 'Garuda Indonesia', 2, 1, 12, '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(2, 'Air Asia', 7, 13, 7, '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(3, 'Batik Air', 2, 16, 4, '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(4, 'Citilink', 11, 14, 3, '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(5, 'Lion Air', 12, 9, 16, '2020-11-29 03:52:38', '2020-11-29 03:52:38');

-- --------------------------------------------------------

--
-- Table structure for table `plane_fares`
--

DROP TABLE IF EXISTS `plane_fares`;
CREATE TABLE IF NOT EXISTS `plane_fares` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `plane_id` int(10) UNSIGNED NOT NULL,
  `eco_seat` decimal(10,2) NOT NULL,
  `bus_seat` decimal(10,2) NOT NULL,
  `first_seat` decimal(10,2) NOT NULL,
  `unique_code` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plane_fares_plane_id_foreign` (`plane_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plane_fares`
--

INSERT INTO `plane_fares` (`id`, `plane_id`, `eco_seat`, `bus_seat`, `first_seat`, `unique_code`, `created_at`, `updated_at`) VALUES
(1, 1, '10000.00', '10000.00', '10000.00', '871.00', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(2, 2, '15000.00', '15000.00', '15000.00', '921.00', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(3, 3, '15000.00', '15000.00', '15000.00', '952.00', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(4, 4, '10000.00', '10000.00', '10000.00', '85.00', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(5, 5, '5000.00', '5000.00', '5000.00', '138.00', '2020-11-29 03:52:38', '2020-11-29 03:52:38');

-- --------------------------------------------------------

--
-- Table structure for table `plane_schedules`
--

DROP TABLE IF EXISTS `plane_schedules`;
CREATE TABLE IF NOT EXISTS `plane_schedules` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `airport_id` int(10) UNSIGNED NOT NULL,
  `plane_id` int(10) UNSIGNED NOT NULL,
  `from` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `destination` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `destination_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `eco_seat` int(11) NOT NULL,
  `bus_seat` int(11) NOT NULL,
  `first_seat` int(11) NOT NULL,
  `boarding_time` datetime NOT NULL,
  `duration` int(11) NOT NULL,
  `gate` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plane_schedules_plane_id_foreign` (`plane_id`),
  KEY `plane_schedules_airport_id_foreign` (`airport_id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plane_schedules`
--

INSERT INTO `plane_schedules` (`id`, `airport_id`, `plane_id`, `from`, `destination`, `from_code`, `destination_code`, `eco_seat`, `bus_seat`, `first_seat`, `boarding_time`, `duration`, `gate`, `created_at`, `updated_at`) VALUES
(1, 2, 3, 'Soekarno - Hatta', 'Halim Perdana Kusuma', 'CGK', 'HLP', 6, 8, 1, '2018-06-03 10:52:38', 92, '79', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(2, 2, 2, 'Soekarno - Hatta', 'Halim Perdana Kusuma', 'CGK', 'HLP', 3, 5, 9, '2018-06-13 10:52:38', 94, '38', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(3, 2, 1, 'Soekarno - Hatta', 'Halim Perdana Kusuma', 'CGK', 'HLP', 10, 1, 8, '2018-07-04 10:52:38', 32, '10', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(4, 2, 3, 'Soekarno - Hatta', 'Halim Perdana Kusuma', 'CGK', 'HLP', 4, 3, 5, '2018-06-19 10:52:38', 74, '2', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(5, 2, 3, 'Soekarno - Hatta', 'Halim Perdana Kusuma', 'CGK', 'HLP', 4, 7, 9, '2018-07-16 10:52:38', 47, '80', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(6, 1, 2, 'Halim Perdana Kusuma', 'Soekarno - Hatta', 'HLP', 'CGK', 9, 9, 1, '2018-06-07 10:52:38', 56, '92', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(7, 2, 4, 'Soekarno - Hatta', 'Halim Perdana Kusuma', 'CGK', 'HLP', 2, 6, 8, '2018-06-16 10:52:38', 14, '66', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(8, 2, 5, 'Soekarno - Hatta', 'Halim Perdana Kusuma', 'CGK', 'HLP', 4, 3, 2, '2018-06-22 10:52:38', 51, '73', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(9, 2, 5, 'Soekarno - Hatta', 'Halim Perdana Kusuma', 'CGK', 'HLP', 5, 5, 2, '2018-06-14 10:52:38', 83, '73', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(10, 2, 3, 'Soekarno - Hatta', 'Halim Perdana Kusuma', 'CGK', 'HLP', 8, 3, 2, '2018-06-25 10:52:38', 98, '32', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(11, 1, 1, 'Halim Perdana Kusuma', 'Soekarno - Hatta', 'HLP', 'CGK', 7, 9, 2, '2018-05-21 10:52:38', 26, '42', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(12, 1, 5, 'Halim Perdana Kusuma', 'Soekarno - Hatta', 'HLP', 'CGK', 8, 6, 7, '2018-06-07 10:52:38', 74, '90', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(13, 2, 1, 'Soekarno - Hatta', 'Halim Perdana Kusuma', 'CGK', 'HLP', 4, 5, 1, '2018-06-13 10:52:38', 22, '32', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(14, 2, 4, 'Soekarno - Hatta', 'Halim Perdana Kusuma', 'CGK', 'HLP', 8, 9, 2, '2018-07-12 10:52:38', 83, '71', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(15, 2, 1, 'Soekarno - Hatta', 'Halim Perdana Kusuma', 'CGK', 'HLP', 1, 7, 2, '2018-06-24 10:52:38', 85, '35', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(16, 1, 4, 'Halim Perdana Kusuma', 'Soekarno - Hatta', 'HLP', 'CGK', 1, 4, 8, '2018-05-23 10:52:38', 56, '68', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(17, 1, 2, 'Halim Perdana Kusuma', 'Soekarno - Hatta', 'HLP', 'CGK', 5, 8, 2, '2018-06-11 10:52:38', 73, '64', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(18, 2, 2, 'Soekarno - Hatta', 'Halim Perdana Kusuma', 'CGK', 'HLP', 8, 8, 10, '2018-06-22 10:52:38', 74, '37', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(19, 1, 1, 'Halim Perdana Kusuma', 'Soekarno - Hatta', 'HLP', 'CGK', 5, 9, 5, '2018-07-18 10:52:38', 28, '72', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(20, 2, 3, 'Soekarno - Hatta', 'Halim Perdana Kusuma', 'CGK', 'HLP', 2, 10, 10, '2018-06-10 10:52:38', 7, '94', '2020-11-29 03:52:38', '2020-11-29 03:52:38');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `booking_id` int(10) UNSIGNED NOT NULL,
  `bank` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sender_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ammount` decimal(10,2) DEFAULT NULL,
  `receipt` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transactions_booking_id_foreign` (`booking_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` enum('Tuan','Nyonya','Nona') COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `verification_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `first_name`, `last_name`, `title`, `phone`, `email`, `password`, `verified`, `verification_token`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin TiketKu', 'Admin', 'TiketKu', 'Tuan', '081234567890', 'admin@tiketku.com', '$2y$10$LDg.ZEP1IzflXuB5swzCpuiDcUNP61RLdeD9.i959xzejjIhoThL6', 1, '123tokena', 'snIkY2A200Z40yzJ5c5cqgoBuVt77Uinra3cDzzpvGbKTFZ4PMrALmX0InJd', '2020-11-29 03:52:38', '2020-11-29 03:52:38'),
(2, 'Member TiketKu', 'Member', 'TiketKu', 'Tuan', '080987654321', 'member@tiketku.com', '$2y$10$MnAR9nKryfJpDEiJ85RJdebqaXO8ik1pnQHGmZbHXG8brjm4cxFNq', 1, '123tokenm', NULL, '2020-11-29 03:52:38', '2020-11-29 03:52:38');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
