-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3307
-- Généré le : mar. 17 sep. 2024 à 13:59
-- Version du serveur : 11.3.2-MariaDB
-- Version de PHP : 8.2.18

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Base de données : `char_charlespitz`
--

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
                                                             `version` varchar(191) NOT NULL,
                                                             `executed_at` datetime DEFAULT NULL,
                                                             `execution_time` int(11) DEFAULT NULL,
                                                             PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
                                                                                           ('DoctrineMigrations\\Version20240917081253', '2024-09-17 08:13:20', 889),
                                                                                           ('DoctrineMigrations\\Version20240917082314', '2024-09-17 08:23:22', 230),
                                                                                           ('DoctrineMigrations\\Version20240917104604', '2024-09-17 10:47:06', 127),
                                                                                           ('DoctrineMigrations\\Version20240917104815', '2024-09-17 10:48:41', 123);

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
CREATE TABLE IF NOT EXISTS `messenger_messages` (
                                                    `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                                    `body` longtext NOT NULL,
                                                    `headers` longtext NOT NULL,
                                                    `queue_name` varchar(190) NOT NULL,
                                                    `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
                                                    `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
                                                    `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
                                                    PRIMARY KEY (`id`),
                                                    KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
                                                    KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
                                                    KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phrase`
--

DROP TABLE IF EXISTS `phrase`;
CREATE TABLE IF NOT EXISTS `phrase` (
                                        `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                                        `title` varchar(350) NOT NULL,
                                        `published` tinyint(1) NOT NULL DEFAULT 0,
                                        PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phrase_section`
--

DROP TABLE IF EXISTS `phrase_section`;
CREATE TABLE IF NOT EXISTS `phrase_section` (
                                                `phrase_id` int(10) UNSIGNED NOT NULL,
                                                `section_id` int(10) UNSIGNED NOT NULL,
                                                PRIMARY KEY (`phrase_id`,`section_id`),
                                                KEY `IDX_19C2BA98671F084` (`phrase_id`),
                                                KEY `IDX_19C2BA9D823E37A` (`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `section`
--

DROP TABLE IF EXISTS `section`;
CREATE TABLE IF NOT EXISTS `section` (
                                         `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                                         `title` varchar(60) NOT NULL,
                                         `slug_title` varchar(65) NOT NULL,
                                         PRIMARY KEY (`id`),
                                         UNIQUE KEY `UNIQ_2D737AEFFECEFC96` (`slug_title`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `section`
--

INSERT INTO `section` (`id`, `title`, `slug_title`) VALUES
                                                        (1, 'L\'univers', 'l-univers'),
                                                        (2, 'La pensée', 'la-pensee'),
                                                        (3, 'La mort', 'la-mort'),
                                                        (4, 'Divers', 'divers');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
                                      `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                                      `username` varchar(180) NOT NULL,
                                      `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`roles`)),
                                      `password` varchar(255) NOT NULL,
                                      `complete_name` varchar(150) NOT NULL,
                                      PRIMARY KEY (`id`),
                                      UNIQUE KEY `UNIQ_IDENTIFIER_USERNAME` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `phrase_section`
--
ALTER TABLE `phrase_section`
    ADD CONSTRAINT `FK_19C2BA98671F084` FOREIGN KEY (`phrase_id`) REFERENCES `phrase` (`id`) ON DELETE CASCADE,
    ADD CONSTRAINT `FK_19C2BA9D823E37A` FOREIGN KEY (`section_id`) REFERENCES `section` (`id`) ON DELETE CASCADE;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;
