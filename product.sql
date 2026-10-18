-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : dim. 04 oct. 2026 à 15:19
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
-- Base de données : `stock_api`
--

-- --------------------------------------------------------

--
-- Structure de la table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext,
  `price` double NOT NULL,
  `stock_quantity` int NOT NULL,
  `created_at` datetime NOT NULL,
  `category_id` int DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D34A04AD12469DE2` (`category_id`),
  KEY `IDX_D34A04ADA76ED395` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `product`
--

INSERT INTO `product` (`id`, `name`, `description`, `price`, `stock_quantity`, `created_at`, `category_id`, `image`, `user_id`) VALUES
(13, 'Chaussures Homme', 'Cette activité s\'exerce pour le compte de sociétés privées, d\'administrations (services de l\'Etat…), et\r\nde particuliers, en contact avec une clientèle diversifiée. ', 140, 12, '2026-07-18 14:39:34', 9, '/uploads/products/Annonces-par-nojeva-07-07-2023-modele-unique-sasort-loc-1688724337-6a5ca60f6d7b3.jpg', 1),
(23, 'Ordinateur de bureau', 'des ordinateurs connectés partout', 200, 38, '2026-07-18 19:01:42', 5, NULL, 1),
(22, 'Ordinateur de bureau', 'des ordinateurs connectés partout', 200, 38, '2026-07-18 19:01:44', 5, NULL, 1),
(16, 'Produit Exemple 5', ' l’expérience et requiert, éventuellement, d’autres compétences\r\nprofessionnelles en termes de langue, de sécurité, de permis... Ces raisons font qu’il ne sera pas\r\ndéveloppé dans cette grappe de métiers. ', 100000, 71, '2026-07-18 14:39:34', 10, '/uploads/products/Annonces-par-lewill-09-11-2023-bmw-sasort-loc-1699487385-6a5ca38038ccc.jpg', 2),
(17, 'Produit Exemple 6', 'Description automatique pour le produit numéro 6', 30.3, 64, '2026-07-18 14:39:34', 6, NULL, 1),
(18, 'Produit Exemple 7', 'Description automatique pour le produit numéro 7', 28, 17, '2026-07-18 14:39:34', 6, NULL, 1),
(19, 'Produit Exemple 8', 'Description automatique pour le produit numéro 8', 5.6, 43, '2026-07-18 14:39:34', 7, NULL, 2),
(20, 'Produit Exemple 9', 'Description automatique pour le produit numéro 9', 83.1, 86, '2026-07-18 14:39:34', 6, NULL, 1),
(21, 'ToFou maison', 'tigieuse, permettant de répondre à toutes les attentes en matière de transport haut de gamme\r\nde personnes avec chauffeur (V.I.P., personnalité liées au monde des arts et du spectacle, clientèle\r\ndésireuse de se déplacer dans des véhicules de luxe…) ', 12, 54, '2026-07-18 14:39:34', 9, '/uploads/products/about-main-6a5ca3bcc89fb.jpg', 2),
(24, 'dfsdfsdfsdf', 'fdssdf dsfsdf', 23, 2, '2026-07-18 19:38:46', 5, NULL, 1),
(26, 'montre connecté', 'toujours savoir le moment exacte', 2000, 26, '2026-07-18 20:25:18', 5, '/uploads/products/Annonces-par-BlackM-30-07-2023-7000EUR-ledossier-loc-1690725024-6a5be12eabf03.jpg', 1),
(27, 'Tennis sport', 'Le métier de chauffeur de véhicule pour « Very Important Person » (V.I.P.) est une spécialisation qui\r\ndépend principalement ', 350, 43, '2026-07-19 09:27:54', 5, '/uploads/products/Annonces-par-gaga-28-07-2023-450EUR-sasort-loc-1690561586-6a5c989a4382c.jpg', 2),
(28, 'Smartphone', 'Téléphoner et explorer internet avec tous les réseaux sociaux', 750, 4, '2026-07-19 10:01:07', 5, '/uploads/products/Annonces-par-bee-11-07-2023-750-Euro-sasort-loc-1689056749-6a5ca0637062c.jpg', 2),
(31, 'Villa à vendre', 'Villa , 2 chambres , terrasse , 2 douches , cuisine , piscine', 120000, 3, '2026-09-10 18:47:50', 14, '/uploads/products/Annonces-par-judicatiel-09-07-2023-images-2022-09-15T155917-860-sasort-loc-1688886656-6aa2fb5642134.jpg', 4);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
