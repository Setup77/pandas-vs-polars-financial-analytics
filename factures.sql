-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : dim. 18 oct. 2026 à 17:14
-- Version du serveur : 9.1.0
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `factures`
--

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `client_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `siret_nif` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_client_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`id`, `user_id`, `client_name`, `address`, `email`, `siret_nif`) VALUES
(1, 1, 'Mahima', '456 Avenue des Développeurs, Lyon', 'contact@mahima.com', '98765432100011'),
(2, 2, 'Kodex', 'Londre rue jouber', 'popo@gmail.com', '2345677888'),
(3, 2, 'MarkLound', 'New York , USA', 'Marklound@marklound.com', '34T566Y677'),
(4, 3, 'CrystalLabs', 'Paris, jooble', 'CrystalLabs@gmail.com', '76547YH43'),
(5, 2, 'Alibaba', 'chine young ZU', 'alibaba@gmail.com', '2635YH-TTRR'),
(6, 3, 'Brasseries', 'Douala , Ndokoti', 'sca@gmail.com', '8765544FR-tgFE23'),
(7, 1, 'Alibaba', 'France , Paris rue Joubert', 'contact@alibaba.com', '4574349-ytr'),
(8, 4, 'TKD construction', 'Bouou , Andem', 'dkdConstruction@gmail.com', 'RTY5643RED');

-- --------------------------------------------------------

--
-- Structure de la table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
CREATE TABLE IF NOT EXISTS `invoices` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `client_id` int UNSIGNED NOT NULL,
  `invoice_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_issue` date NOT NULL,
  `date_due` date NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_invoice_number` (`invoice_number`),
  KEY `idx_invoice_user` (`user_id`),
  KEY `idx_invoice_client` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `invoices`
--

INSERT INTO `invoices` (`id`, `user_id`, `client_id`, `invoice_number`, `date_issue`, `date_due`, `status`, `is_public`, `created_at`) VALUES
(18, 2, 3, 'FAC-2026-791', '2026-08-29', '2026-08-29', 'paid', 0, '2026-08-29 16:31:06'),
(20, 2, 2, 'FAC-2026-163', '2026-08-29', '2026-08-29', 'sent', 0, '2026-08-29 16:37:55'),
(21, 2, 2, 'FAC-2026-394', '2026-08-29', '2026-08-29', 'sent', 1, '2026-08-29 17:24:31'),
(22, 3, 4, 'FAC-2026-484', '2026-08-29', '2026-08-29', 'sent', 0, '2026-08-29 17:27:13'),
(28, 2, 3, 'FAC-2026-284', '2026-08-29', '2026-09-02', 'sent', 0, '2026-08-29 18:30:25'),
(29, 2, 2, 'FAC-2026-319', '2026-08-29', '2026-08-29', 'paid', 1, '2026-08-29 18:31:19'),
(34, 2, 5, 'FAC-2026-546', '2026-08-29', '2026-08-29', 'sent', 0, '2026-08-29 19:11:03'),
(35, 3, 6, 'FAC-2026-768', '2026-08-29', '2026-08-29', 'paid', 1, '2026-08-29 19:19:26'),
(39, 1, 1, 'FAC-2026-493', '2026-08-30', '2026-08-30', 'sent', 1, '2026-08-30 09:20:05'),
(40, 2, 2, 'FAC-2026-617', '2026-08-30', '2026-08-30', 'paid', 1, '2026-08-30 09:21:03'),
(41, 1, 7, 'FAC-2026-144', '2026-08-30', '2026-09-02', 'sent', 0, '2026-08-30 09:33:18'),
(42, 4, 8, 'FAC-2026-213', '2026-08-12', '2026-08-12', 'paid', 1, '2026-08-30 11:09:04');

-- --------------------------------------------------------

--
-- Structure de la table `invoice_items`
--

DROP TABLE IF EXISTS `invoice_items`;
CREATE TABLE IF NOT EXISTS `invoice_items` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `invoice_id` int UNSIGNED NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` decimal(10,2) NOT NULL DEFAULT '1.00',
  `unit_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `vat_rate` decimal(5,2) NOT NULL DEFAULT '20.00',
  PRIMARY KEY (`id`),
  KEY `idx_item_invoice` (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `invoice_items`
--

INSERT INTO `invoice_items` (`id`, `invoice_id`, `description`, `quantity`, `unit_price`, `vat_rate`) VALUES
(4, 20, 'sf fsdf fsdf fdsdf fsdf sdfdf', 1.00, 10.00, 20.00),
(6, 22, 'design', 1.00, 50.00, 20.00),
(7, 28, 'Maintenance', 1.00, 200.00, 20.00),
(17, 34, 'Maintenance', 1.00, 110.00, 20.00),
(28, 39, 'maintenance', 1.00, 100.00, 20.00),
(30, 29, 'sécurité', 1.00, 100.00, 20.00),
(31, 18, 'Développement backendd', 2.00, 200.00, 20.00),
(32, 18, 'déploiement en lignes', 1.00, 100.00, 20.00),
(33, 40, 'Sécurité', 1.00, 1000.00, 20.00),
(34, 21, 'Marketing digital', 1.00, 100.00, 20.00),
(35, 41, 'Livraison des ordinateurs', 15.00, 700.00, 20.00),
(36, 35, 'Maintenances', 1.00, 150.00, 20.00),
(40, 42, 'Livraison de ciments', 45.00, 15.00, 20.00),
(41, 42, 'Livraison Toles', 215.00, 30.00, 20.00),
(42, 42, 'Barre de Fer', 115.00, 5.00, 20.00);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'nokewi@gmail.com', '$2y$10$xzDDjKOaNGsQdIY0kDQUOuQwrVpANRcGjvSs6Kuahg6Fs/WujkqhO', 'user', '2026-08-29 10:29:47'),
(2, 'jojo@gmail.com', '$2y$10$SvV.1/fczzz3qAlp3VgcO.iOmLWT8U85pqgRUJEvLlUG6WK3.aIiq', 'user', '2026-08-29 11:21:28'),
(3, 'diane@yahoo.fr', '$2y$10$TnmW1m5.wfQi1/zsOxpNWuh93zqcxnngktWUaXHXPad9J910nJKte', 'user', '2026-08-29 11:23:32'),
(4, 'Padem@gmail.com', '$2y$10$Fb3UHcemGSeAg5qYrg5p8.HttFTN20T9Yx86jU5KLgNUuxTSP9oRa', 'user', '2026-08-30 11:06:01');

-- --------------------------------------------------------

--
-- Structure de la table `user_profiles`
--

DROP TABLE IF EXISTS `user_profiles`;
CREATE TABLE IF NOT EXISTS `user_profiles` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `company_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_contact` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `siret_nif` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vat_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_profile_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user_profiles`
--

INSERT INTO `user_profiles` (`id`, `user_id`, `company_name`, `address`, `phone`, `email_contact`, `siret_nif`, `vat_number`) VALUES
(1, 1, 'HotakouLabs', 'Douala pk 11', '+237673186359', 'contact@hotakoulabs.com', '15615171TY7151Y-54', 'CM TRFD4355'),
(2, 2, 'TOUT FEU TOUT FLAME', 'Angleterre', '+6547433', 'toutfeutoutflamme@gmail.com', '234545UJYD545', 'FR UYRF5466'),
(3, 3, 'Bayant School', 'Cameroun , Douala , Bssadi', '+33 764 654', 'contact@bayant.com', '1273635TYGF-RDD', 'FR YTFDS4356'),
(4, 4, 'Padem Sarl et Fils', 'BurKina Fasso', '+223 567 786', 'contact@padem.com', '435576TRF-TRE', 'BR YTR654333');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `fk_client_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `fk_invoice_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `fk_invoice_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD CONSTRAINT `fk_item_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD CONSTRAINT `fk_profile_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
