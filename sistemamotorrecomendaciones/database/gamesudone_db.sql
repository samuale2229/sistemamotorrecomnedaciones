-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: gamesudone_db
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `game_genres`
--

DROP TABLE IF EXISTS `game_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_genres` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `game_id` bigint NOT NULL,
  `genre_id` bigint NOT NULL,
  `relevance_weight` decimal(4,2) NOT NULL DEFAULT '1.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_game_genre` (`game_id`,`genre_id`),
  KEY `idx_game_genres_genre` (`genre_id`),
  CONSTRAINT `fk_game_genres_game` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_game_genres_genre` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_genres`
--

LOCK TABLES `game_genres` WRITE;
/*!40000 ALTER TABLE `game_genres` DISABLE KEYS */;
INSERT INTO `game_genres` VALUES (1,101,2,1.00,'2026-11-25 18:10:51'),(2,101,1,0.60,'2026-11-25 18:10:51'),(3,102,3,1.00,'2026-11-25 18:10:51'),(4,102,1,0.75,'2026-11-25 18:10:51'),(5,103,4,1.00,'2026-11-25 18:10:51'),(6,104,6,1.00,'2026-11-25 18:10:51'),(7,104,1,0.80,'2026-11-25 18:10:51'),(8,104,5,0.70,'2026-11-25 18:10:51'),(9,105,6,0.95,'2026-11-25 18:10:51'),(10,105,5,0.85,'2026-11-25 18:10:51'),(11,106,7,1.00,'2026-11-25 18:10:51'),(12,107,8,1.00,'2026-11-25 18:10:51'),(13,107,5,0.65,'2026-11-25 18:10:51'),(14,108,5,1.00,'2026-11-25 18:10:51'),(15,109,1,1.00,'2026-11-25 18:10:51'),(16,109,2,0.55,'2026-11-25 18:10:51');
/*!40000 ALTER TABLE `game_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_ratings`
--

DROP TABLE IF EXISTS `game_ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_ratings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `game_id` bigint NOT NULL,
  `score` int NOT NULL,
  `review_text` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_game` (`user_id`,`game_id`),
  UNIQUE KEY `UK36wgavhbysjxxb1j7owsd7s7o` (`user_id`,`game_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_game_id` (`game_id`),
  CONSTRAINT `fk_ratings_game` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ratings_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `game_ratings_chk_1` CHECK ((`score` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_ratings`
--

LOCK TABLES `game_ratings` WRITE;
/*!40000 ALTER TABLE `game_ratings` DISABLE KEYS */;
INSERT INTO `game_ratings` VALUES (2,1,1,5,'¡Excelente juego, muy recomendado!','2026-11-05 19:02:50','2026-11-05 19:02:50');
/*!40000 ALTER TABLE `game_ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_sessions`
--

DROP TABLE IF EXISTS `game_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_sessions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `game_id` bigint NOT NULL,
  `duration_minutes` int NOT NULL DEFAULT '0',
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `session_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_sessions_game` (`game_id`),
  KEY `idx_sessions_user_game` (`user_id`,`game_id`),
  CONSTRAINT `fk_sessions_game` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_sessions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_sessions`
--

LOCK TABLES `game_sessions` WRITE;
/*!40000 ALTER TABLE `game_sessions` DISABLE KEYS */;
INSERT INTO `game_sessions` VALUES (1,1,1,45,0,'2026-11-10 22:30:00'),(2,1,1,90,1,'2026-11-13 00:15:00'),(3,1,1,65,1,'2026-11-14 23:00:00'),(4,1,1,30,0,'2026-11-17 01:10:00'),(5,1,1,110,1,'2026-11-18 21:40:00'),(6,1,1,25,1,'2026-11-24 23:36:00'),(7,1,1,15,0,'2026-11-24 23:36:03'),(8,1,1,0,0,'2026-11-24 23:36:03');
/*!40000 ALTER TABLE `game_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `games` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `genre` varchar(50) NOT NULL,
  `popularity_score` double DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games`
--

LOCK TABLES `games` WRITE;
/*!40000 ALTER TABLE `games` DISABLE KEYS */;
INSERT INTO `games` VALUES (1,'Cyberpunk 2077','RPG',4.5,'2026-11-05 19:02:40'),(101,'Chronicles of Aethelgard','RPG',88.5,'2026-11-25 18:10:51'),(102,'Iron Vanguard Ops','Shooter',91.2,'2026-11-25 18:10:51'),(103,'Citadel Command','Strategy',76.4,'2026-11-25 18:10:51'),(104,'Hollow Spire','Metroidvania',84,'2026-11-25 18:10:51'),(105,'Moonlit Labyrinth','Metroidvania',72.1,'2026-11-25 18:10:51'),(106,'Echoes in the Fog','Survival Horror',79.8,'2026-11-25 18:10:51'),(107,'Loop Protocol Zero','Roguelike',81.3,'2026-11-25 18:10:51'),(108,'Pixel Drift Arena','Indie',65,'2026-11-25 18:10:51'),(109,'Shadow Blade Chronicles','Action',86.7,'2026-11-25 18:10:51');
/*!40000 ALTER TABLE `games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_genres_name` (`name`),
  UNIQUE KEY `uq_genres_slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (1,'Action','action','Combate dinámico, reflejos y ritmo rápido','2026-11-25 18:10:51'),(2,'RPG','rpg','Progresión de personaje, atributos y narrativa','2026-11-25 18:10:51'),(3,'Shooter','shooter','Mecánicas de disparo en primera o tercera persona','2026-11-25 18:10:51'),(4,'Strategy','strategy','Planificación táctica, gestión de recursos y decisiones','2026-11-25 18:10:51'),(5,'Indie','indie','Desarrollos independientes con propuestas variadas','2026-11-25 18:10:51'),(6,'Metroidvania','metroidvania','Exploración interconectada y desbloqueo de habilidades','2026-11-25 18:10:51'),(7,'Survival Horror','survival-horror','Tensión, recursos limitados y supervivencia','2026-11-25 18:10:51'),(8,'Roguelike','roguelike','Partidas procedurales y alto riesgo por ciclo','2026-11-25 18:10:51');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_game_history`
--

DROP TABLE IF EXISTS `user_game_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_game_history` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `game_id` bigint NOT NULL,
  `total_playtime_minutes` int NOT NULL DEFAULT '0',
  `sessions_count` int NOT NULL DEFAULT '0',
  `last_played_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_game_history` (`user_id`,`game_id`),
  KEY `fk_history_game` (`game_id`),
  CONSTRAINT `fk_history_game` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_history_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_game_history`
--

LOCK TABLES `user_game_history` WRITE;
/*!40000 ALTER TABLE `user_game_history` DISABLE KEYS */;
INSERT INTO `user_game_history` VALUES (1,1,1,380,8,'2026-11-24 23:36:03');
/*!40000 ALTER TABLE `user_game_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_preferences`
--

DROP TABLE IF EXISTS `user_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_preferences` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `genre_id` bigint NOT NULL,
  `affinity_score` decimal(4,2) NOT NULL DEFAULT '1.00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_genre_pref` (`user_id`,`genre_id`),
  KEY `fk_user_preferences_genre` (`genre_id`),
  KEY `idx_user_preferences_user` (`user_id`),
  CONSTRAINT `fk_user_preferences_genre` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_preferences_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_preferences`
--

LOCK TABLES `user_preferences` WRITE;
/*!40000 ALTER TABLE `user_preferences` DISABLE KEYS */;
INSERT INTO `user_preferences` VALUES (1,201,2,0.95,'2026-11-25 18:10:51'),(2,201,1,0.80,'2026-11-25 18:10:51'),(3,201,4,0.50,'2026-11-25 18:10:51'),(4,202,6,0.90,'2026-11-25 18:10:51'),(5,202,7,0.85,'2026-11-25 18:10:51');
/*!40000 ALTER TABLE `user_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'samuel_cortez','samuel@udone.edu.ve','2026-11-05 19:00:39'),(201,'player_hybrid_test','hybrid.test@example.local','2026-11-25 18:10:51'),(202,'player_niche_test','niche.test@example.local','2026-11-25 18:10:51'),(203,'player_coldstart','coldstart.test@example.local','2026-11-25 18:10:51');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-25 19:09:02
