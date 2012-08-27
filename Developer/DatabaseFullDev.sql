-- MySQL dump 10.13  Distrib 5.5.25a, for Win32 (x86)
--
-- Host: localhost    Database: dayz
-- ------------------------------------------------------
-- Server version	5.5.25a

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `dayz`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `dayz` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `dayz`;

--
-- Table structure for table `instances`
--

DROP TABLE IF EXISTS `instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instances` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `instance` int(2) unsigned NOT NULL COMMENT 'Identification number for instance',
  `timezone` int(1) NOT NULL DEFAULT '0' COMMENT 'Set the timezone for the instance relative to the DB time',
  `loadout` varchar(1024) NOT NULL DEFAULT '[]' COMMENT 'Starting inventory for every player. Has to be a valid inventory string to work',
  `mvisibility` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Sets which messages will be executed by the scheduler',
  `reserverd` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Not yet implemented',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instances`
--

LOCK TABLES `instances` WRITE;
/*!40000 ALTER TABLE `instances` DISABLE KEYS */;
INSERT INTO `instances` VALUES (1,1,0,'[]',0,0);
/*!40000 ALTER TABLE `instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_code`
--

DROP TABLE IF EXISTS `log_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_code` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_log_code` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_code`
--

LOCK TABLES `log_code` WRITE;
/*!40000 ALTER TABLE `log_code` DISABLE KEYS */;
INSERT INTO `log_code` VALUES (1,'Login','Player has logged in'),(2,'Logout','Player has logged out'),(3,'Ban','Player was banned'),(4,'Connect','Player has connected'),(5,'Disconnect','Player has disconnected');
/*!40000 ALTER TABLE `log_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_entry`
--

DROP TABLE IF EXISTS `log_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_entry` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `profile_id` varchar(50) NOT NULL,
  `log_code_id` int(11) unsigned NOT NULL,
  `text` varchar(1024) DEFAULT '',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk1_log_entry` (`log_code_id`),
  CONSTRAINT `fk1_log_entry` FOREIGN KEY (`log_code_id`) REFERENCES `log_code` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_entry`
--

LOCK TABLES `log_entry` WRITE;
/*!40000 ALTER TABLE `log_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_tool`
--

DROP TABLE IF EXISTS `log_tool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_tool` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(255) DEFAULT NULL,
  `user` varchar(255) NOT NULL DEFAULT '',
  `timestamp` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_tool`
--

LOCK TABLES `log_tool` WRITE;
/*!40000 ALTER TABLE `log_tool` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_tool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main`
--

DROP TABLE IF EXISTS `main`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(128) NOT NULL COMMENT 'Player ID generated from CDKEY used for identification',
  `name` varchar(32) NOT NULL DEFAULT 'GI Joe' COMMENT 'Name of the player',
  `pos` varchar(255) NOT NULL DEFAULT '[]' COMMENT 'Position of the player. [] means random at the beach',
  `inventory` varchar(2048) NOT NULL DEFAULT '[]',
  `backpack` varchar(2048) NOT NULL DEFAULT '[]',
  `medical` varchar(255) NOT NULL DEFAULT '[false,false,false,false,false,false,false,12000,[],[0,0],0]',
  `death` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is player dead? 0 for alive, 1 for dead',
  `model` varchar(128) NOT NULL DEFAULT 'Survivor2_DZ' COMMENT 'Model of the player',
  `state` varchar(128) NOT NULL DEFAULT '["","aidlpercmstpsnonwnondnon_player_idlesteady04",36]',
  `humanity` int(2) NOT NULL DEFAULT '2500',
  `hkills` int(2) unsigned NOT NULL DEFAULT '0' COMMENT 'Human kills',
  `bkills` int(2) unsigned NOT NULL DEFAULT '0' COMMENT 'Bandit kills',
  `kills` int(2) unsigned NOT NULL DEFAULT '0' COMMENT 'Zombie kills',
  `hs` int(2) unsigned NOT NULL DEFAULT '0' COMMENT 'Zombie headshots',
  `late` int(2) unsigned NOT NULL DEFAULT '0' COMMENT 'Last time player ate in mins',
  `ldrank` int(2) unsigned NOT NULL DEFAULT '0' COMMENT 'Last time player drank in mins',
  `stime` int(2) unsigned NOT NULL DEFAULT '0' COMMENT 'Playtime in minutes',
  `lastupdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update to the player data',
  `survival` datetime NOT NULL COMMENT 'Creation date of the account used to calculate survival time',
  PRIMARY KEY (`id`),
  KEY `idx1_main` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main`
--

LOCK TABLES `main` WRITE;
/*!40000 ALTER TABLE `main` DISABLE KEYS */;
/*!40000 ALTER TABLE `main` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migration_schema_log`
--

DROP TABLE IF EXISTS `migration_schema_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migration_schema_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `schema_name` varchar(255) NOT NULL,
  `event_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `old_version` varchar(255) NOT NULL,
  `new_version` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migration_schema_log`
--

LOCK TABLES `migration_schema_log` WRITE;
/*!40000 ALTER TABLE `migration_schema_log` DISABLE KEYS */;
INSERT INTO `migration_schema_log` VALUES (1,'Bliss','2012-08-27 13:47:48','0.000000','0.010000'),(2,'Bliss','2012-08-27 13:47:48','0.010000','0.020000'),(3,'Bliss','2012-08-27 13:47:48','0.020000','0.030000'),(4,'Bliss','2012-08-27 13:47:48','0.030000','0.040000'),(5,'Bliss','2012-08-27 13:47:48','0.040000','0.050000'),(6,'Bliss','2012-08-27 13:47:49','0.050000','0.060000'),(7,'Bliss','2012-08-27 13:47:49','0.060000','0.070000');
/*!40000 ALTER TABLE `migration_schema_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migration_schema_version`
--

DROP TABLE IF EXISTS `migration_schema_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migration_schema_version` (
  `name` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migration_schema_version`
--

LOCK TABLES `migration_schema_version` WRITE;
/*!40000 ALTER TABLE `migration_schema_version` DISABLE KEYS */;
INSERT INTO `migration_schema_version` VALUES ('Bliss','0.070000');
/*!40000 ALTER TABLE `migration_schema_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objects`
--

DROP TABLE IF EXISTS `objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `objects` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL DEFAULT '0' COMMENT 'Object game generated ID',
  `pos` varchar(255) NOT NULL DEFAULT '[]' COMMENT 'Postition of the object',
  `inventory` varchar(2048) NOT NULL DEFAULT '[]',
  `health` varchar(1024) NOT NULL DEFAULT '[]' COMMENT 'Broken parts of the object',
  `fuel` double NOT NULL DEFAULT '0' COMMENT 'Ammount of fuel. 0-1',
  `damage` double NOT NULL DEFAULT '0' COMMENT 'Overall damage value. 0-1',
  `otype` varchar(255) NOT NULL DEFAULT 'none' COMMENT 'Type of the object',
  `oid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Owner of the object. Only relevant for tents',
  `instance` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Instance number in which object resides',
  `lastupdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update to the object',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx1_objects` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects`
--

LOCK TABLES `objects` WRITE;
/*!40000 ALTER TABLE `objects` DISABLE KEYS */;
/*!40000 ALTER TABLE `objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objects_classes`
--

DROP TABLE IF EXISTS `objects_classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `objects_classes` (
  `Classname` varchar(128) NOT NULL DEFAULT '',
  `Type` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`Classname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects_classes`
--

LOCK TABLES `objects_classes` WRITE;
/*!40000 ALTER TABLE `objects_classes` DISABLE KEYS */;
INSERT INTO `objects_classes` VALUES ('ATV_CZ_EP1','ATV'),('ATV_US_EP1','ATV'),('BAF_Offroad_W','Car'),('car_hatchback','Car'),('car_sedan','Car'),('datsun1_civil_3_open','Car'),('Fishing_Boat','large Boat'),('Hedgehog_DZ','Hedgehog'),('hilux1_civil_1_open','Car'),('hilux1_civil_2_covered','Car'),('hilux1_civil_3_open','Car'),('HMMWV','Car'),('Ikarus','Bus'),('Ikarus_TK_CIV_EP1','Bus'),('Kamaz','Truck'),('LandRover_TK_CIV_EP1','Car'),('MH6J_EP1','Helicopter'),('Old_bike_TK_CIV_EP1','Bike'),('Old_bike_TK_INS_EP1','Bike'),('PBX','small Boat'),('S1203_TK_CIV_EP1','Bus'),('Skoda','Car'),('SkodaBlue','Car'),('SkodaGreen','Car'),('Smallboat_1','medium Boat'),('Smallboat_2','medium Boat'),('SUV_TK_CIV_EP1','Car'),('TentStorage','Tent'),('Tractor','Farmvehicle'),('TT650_Ins','Motorcycle'),('TT650_TK_CIV_EP1','Motorcycle'),('TT650_TK_EP1','Motorcycle'),('UAZ_INS','Car'),('UAZ_RU','Car'),('UAZ_Unarmed_TK_CIV_EP1','Car'),('UAZ_Unarmed_TK_EP1','Car'),('UAZ_Unarmed_UN_EP1','Car'),('UH1H_DZ','Helicopter'),('UralCivil','Truck'),('UralCivil2','Truck'),('V3S_Civ','Truck'),('V3S_Gue','Truck'),('V3S_TK_GUE_EP1','Truck'),('VolhaLimo_TK_CIV_EP1','Car'),('Volha_1_TK_CIV_EP1','Car'),('Volha_2_TK_CIV_EP1','Car'),('VWGolf','Car'),('Wire_cat1','Wire');
/*!40000 ALTER TABLE `objects_classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler`
--

DROP TABLE IF EXISTS `scheduler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(1024) NOT NULL COMMENT 'Text of the message',
  `mtype` varchar(1) NOT NULL DEFAULT 'm' COMMENT 'Type of the message: g Global, m Side, l Logic, s Script',
  `looptime` int(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The time delay before the message is executed again. 0 means message will be executed only ones',
  `mstart` int(3) unsigned NOT NULL DEFAULT '10' COMMENT 'The time before the message is processed in seconds',
  `visibility` int(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Set on which instance message will be executed',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler`
--

LOCK TABLES `scheduler` WRITE;
/*!40000 ALTER TABLE `scheduler` DISABLE KEYS */;
INSERT INTO `scheduler` VALUES (1,'This server is managed through Crosires Private Server Controlcenter! Have fun!','l',0,3,0);
/*!40000 ALTER TABLE `scheduler` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spawns`
--

DROP TABLE IF EXISTS `spawns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spawns` (
  `id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `pos` varchar(128) NOT NULL COMMENT 'Spawn location',
  `otype` varchar(128) NOT NULL DEFAULT 'Smallboat_1' COMMENT 'Type of the spawning object',
  `uuid` int(2) unsigned NOT NULL,
  `world` varchar(50) NOT NULL DEFAULT 'chernarus',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=196 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spawns`
--

LOCK TABLES `spawns` WRITE;
/*!40000 ALTER TABLE `spawns` DISABLE KEYS */;
INSERT INTO `spawns` VALUES (1,'[0,[12140.168, 12622.802,0]]','UAZ_Unarmed_TK_EP1',1,'chernarus'),(2,'[0,[6279.4966, 7810.3691,0]]','UAZ_Unarmed_TK_CIV_EP1',2,'chernarus'),(3,'[0,[6865.2432, 2481.6943,0]]','UAZ_Unarmed_UN_EP1',3,'chernarus'),(4,'[157,[3693.0386, 5969.1489,0]]','UAZ_RU',4,'chernarus'),(5,'[100,[13292.147, 11938.206, 0]]','UAZ_Unarmed_TK_CIV_EP1',5,'chernarus'),(6,'[223,[4817.6572, 2556.5034,0]]','UAZ_INS',6,'chernarus'),(7,'[-23,[8120.3057, 9305.4912]]','UAZ_Unarmed_TK_EP1',7,'chernarus'),(8,'[0,[3312.2793, 11270.755,0]]','ATV_US_EP1',8,'chernarus'),(9,'[50,[3684.0366, 5999.0117,0]]','ATV_US_EP1',9,'chernarus'),(10,'[202,[11464.035, 11381.071,0]]','ATV_CZ_EP1',10,'chernarus'),(11,'[-107,[11459.299, 11386.546,0]]','ATV_US_EP1',11,'chernarus'),(12,'[-25,[8856.8359, 2893.7903,0]]','ATV_CZ_EP1',12,'chernarus'),(13,'[-7,[12869.565, 4450.4077,0]]','SkodaBlue',13,'chernarus'),(14,'[223,[6288.416, 7834.3521,0]]','Skoda',14,'chernarus'),(15,'[-54,[8125.7075, 3166.3708,0]]','SkodaGreen',15,'chernarus'),(16,'[-76,[8854.9082, 2891.5762,0]]','ATV_US_EP1',16,'chernarus'),(17,'[-69,[11945.78, 9099.3633,0]]','TT650_Ins',17,'chernarus'),(18,'[-209,[6592.686, 2906.8245,0]]','TT650_TK_EP1',18,'chernarus'),(19,'[372,[8762.8516, 11727.877,0]]','TT650_TK_CIV_EP1',19,'chernarus'),(20,'[52,[8713.4893, 7103.0518,0]]','TT650_TK_CIV_EP1',20,'chernarus'),(21,'[50,[8040.6777, 7086.5356,0]]','Old_bike_TK_CIV_EP1',21,'chernarus'),(22,'[-44,[7943.5068, 6988.1763,0]]','Old_bike_TK_CIV_EP1',22,'chernarus'),(23,'[201,[8070.6958, 3358.7793,0]]','Old_bike_TK_INS_EP1',23,'chernarus'),(24,'[179,[3474.3989, 2562.4915,0]]','Old_bike_TK_INS_EP1',24,'chernarus'),(25,'[-124,[1773.9318, 2351.6221,0]]','Old_bike_TK_INS_EP1',25,'chernarus'),(26,'[0,[3699.9189, 2474.2119,0]]','Old_bike_TK_CIV_EP1',26,'chernarus'),(27,'[73,[8350.0947, 2480.542,0]]','Old_bike_TK_CIV_EP1',27,'chernarus'),(28,'[35,[8345.7227, 2482.6855,0]]','Old_bike_TK_INS_EP1',28,'chernarus'),(29,'[23,[3203.0916, 3988.6379,0]]','Old_bike_TK_CIV_EP1',29,'chernarus'),(30,'[-169,[2782.7134, 5285.5342,0]]','Old_bike_TK_INS_EP1',30,'chernarus'),(31,'[-205,[8680.75, 2445.5315,0]]','Old_bike_TK_INS_EP1',31,'chernarus'),(32,'[0,[12158.999, 3468.7563,0]]','Old_bike_TK_CIV_EP1',32,'chernarus'),(33,'[-110,[11984.01, 3835.9231,0]]','Old_bike_TK_INS_EP1',33,'chernarus'),(34,'[-105,[10153.068, 2219.3547,0]]','Old_bike_TK_CIV_EP1',34,'chernarus'),(35,'[0,[11251.41, 4274.8184, 19.607342]]','UH1H_DZ',35,'chernarus'),(36,'[-121,[4523.5947, 10782.407,0]]','UH1H_DZ',36,'chernarus'),(37,'[89,[6914.1348, 11429.448, 30.22456]]','UH1H_DZ',37,'chernarus'),(38,'[-162,[10510.669, 2294.2346, 10.909807]]','UH1H_DZ',38,'chernarus'),(39,'[0,[6404.6675, 2767.1914, 10.798054]]','UH1H_DZ',39,'chernarus'),(40,'[-16,[2045.3989, 7267.4165,0]]','hilux1_civil_3_open',40,'chernarus'),(41,'[133,[8310.9902, 3348.3579,0]]','hilux1_civil_3_open',41,'chernarus'),(42,'[124,[11309.963, 6646.3989,0]]','hilux1_civil_3_open',42,'chernarus'),(43,'[6,[11240.744, 5370.6128,0]]','hilux1_civil_3_open',43,'chernarus'),(44,'[-130,[3762.5764, 8736.1709,0]]','Ikarus_TK_CIV_EP1',44,'chernarus'),(45,'[-81,[10628.433, 8037.8188,0]]','Ikarus',45,'chernarus'),(46,'[-115,[4580.3203, 4515.9282,0]]','Ikarus',46,'chernarus'),(47,'[-27,[6040.0923, 7806.5439,0]]','Ikarus_TK_CIV_EP1',47,'chernarus'),(48,'[76,[10314.745, 2147.5374,0]]','Ikarus',48,'chernarus'),(49,'[59,[6705.8887, 2991.9358,0]]','Ikarus_TK_CIV_EP1',49,'chernarus'),(50,'[-165,[9681.8213, 8947.2354,0]]','Tractor',50,'chernarus'),(51,'[-98,[3825.1318, 8941.4873,0]]','Tractor',51,'chernarus'),(52,'[19,[11246.52, 7534.7954,0]]','Tractor',52,'chernarus'),(53,'[0,[11066.828, 7915.2275,0]]','S1203_TK_CIV_EP1',53,'chernarus'),(54,'[-8,[12058.555, 3577.8667,0]]','S1203_TK_CIV_EP1',54,'chernarus'),(55,'[218,[11940.854, 8872.8389,0]]','S1203_TK_CIV_EP1',55,'chernarus'),(56,'[-14,[13386.471, 6604.0098,0]]','S1203_TK_CIV_EP1',56,'chernarus'),(57,'[178,[13276.482, 6098.4463,0]]','V3S_Gue',57,'chernarus'),(58,'[-22,[1890.9952, 12417.333,0]]','UralCivil',58,'chernarus'),(59,'[226,[1975.1283, 9150.0195,0]]','car_hatchback',59,'chernarus'),(60,'[-45,[7429.4849, 5157.8682,0]]','car_hatchback',60,'chernarus'),(61,'[0,[8317.2676, 2348.6055,0]]','Fishing_Boat',61,'chernarus'),(62,'[0,[13222.181, 10015.431,0]]','Fishing_Boat',62,'chernarus'),(63,'[55,[13454.882, 13731.796,0]]','PBX',63,'chernarus'),(64,'[-115,[14417.589, 12886.104,0]]','Smallboat_1',64,'chernarus'),(65,'[268,[13098.13, 8250.8828,0]]','Smallboat_1',65,'chernarus'),(66,'[-155,[9731.1514, 8937.7998,0]]','Volha_2_TK_CIV_EP1',66,'chernarus'),(67,'[-23,[9715.0352, 6522.8286,0]]','Volha_1_TK_CIV_EP1',67,'chernarus'),(68,'[-119,[2614.0862, 5079.6357,0]]','Volha_1_TK_CIV_EP1',68,'chernarus'),(69,'[18,[10827.634, 2701.5688,0]]','Volha_2_TK_CIV_EP1',69,'chernarus'),(70,'[-138,[5165.7231, 2375.7642,0]]','Volha_1_TK_CIV_EP1',70,'chernarus'),(71,'[-153,[1740.8503, 3622.6938,0]]','Volha_2_TK_CIV_EP1',71,'chernarus'),(72,'[266,[9157.8408, 11019.819,0]]','SUV_TK_CIV_EP1',72,'chernarus'),(73,'[222,[12360.468, 10817.882,0]]','car_sedan',73,'chernarus'),(129,'[130,[13129.8,11560,0.0706997]]','UAZ_Unarmed_TK_EP1',1303114,'lingor'),(130,'[3,[7107.41,5825.43,0]]','UAZ_Unarmed_TK_CIV_EP1',1379054,'lingor'),(131,'[271,[6424,6777.25,0.00143909]]','UAZ_Unarmed_UN_EP1',1391556,'lingor'),(132,'[5,[4150.78,1426.02,0.0821762]]','UAZ_RU',1418552,'lingor'),(133,'[87,[2476.24,4105.05,0.00119781]]','UAZ_Unarmed_TK_CIV_EP1',1461138,'lingor'),(134,'[177,[4073.41,5156.29,0.00143814]]','UAZ_INS',1597984,'lingor'),(135,'[9,[6457.83,6660.57,0]]','SUV_TK_CIV_EP1',1600270,'lingor'),(136,'[355,[6888.25,3147.13,0.00132751]]','ATV_US_EP1',1620134,'lingor'),(137,'[17,[5968.15,6595.98,0.00117016]]','ATV_US_EP1',1624318,'lingor'),(138,'[186,[3546.66,3740.02,0.00143433]]','ATV_CZ_EP1',1704164,'lingor'),(139,'[75,[3287.92,6434.28,0.00110245]]','ATV_US_EP1',1817908,'lingor'),(140,'[51,[5927.38,6616.12,0.00140476]]','ATV_CZ_EP1',2097619,'lingor'),(141,'[3,[5805.57,4727.47,0.00143814]]','SkodaBlue',2732512,'lingor'),(142,'[0,[6115.49,5859.39,0]]','Skoda',2819485,'lingor'),(143,'[208,[1748.81,642.642,14.1062]]','UH1H_DZ',2889931,'lingor'),(144,'[323,[1199.85,5270.49,10.8326]]','ATV_US_EP1',3032853,'lingor'),(145,'[267,[4080.74,1130.51,0.00143909]]','TT650_Ins',3094055,'lingor'),(146,'[-209,[6592.686, 2906.8245,0]]','TT650_TK_EP1',3224021,'lingor'),(147,'[179,[5802.9,4712.73,0.00143814]]','TT650_TK_CIV_EP1',3281806,'lingor'),(148,'[97,[4589.57,2616.75,0.00136948]]','TT650_TK_CIV_EP1',4631620,'lingor'),(149,'[271,[6424,6777.25,0.00143909]]','hilux1_civil_3_open_EP1',4839368,'lingor'),(150,'[90,[6821.08,2497.89,0.00143909]]','UralCivil2',4885355,'lingor'),(151,'[310,[1967.18,9147.22,0.00106812]]','LandRover_CZ_EP1',4913990,'lingor'),(152,'[254,[3933.37,4220.77,0.00143433]]','Old_bike_TK_INS_EP1',4917659,'lingor'),(153,'[184,[3551.31,3739.72,0.0010376]]','Old_bike_TK_INS_EP1',5004305,'lingor'),(154,'[163,[5985.63,5351.37,0.00143909]]','hilux1_civil_3_open_EP1',5075087,'lingor'),(155,'[10,[8819.02,8023.86,0.00143814]]','Old_bike_TK_CIV_EP1',5146500,'lingor'),(156,'[279,[5796.81,4688.25,0.00143814]]','Old_bike_TK_INS_EP1',5172558,'lingor'),(157,'[0,[5671.37,796.868,0.00129175]]','Old_bike_TK_CIV_EP1',5222930,'lingor'),(158,'[0,[969.451,1275.39,0.00255895]]','ATV_CZ_EP1',5468412,'lingor'),(159,'[9,[6593.81,5728.57,0]]','SUV_TK_CIV_EP1',5499609,'lingor'),(160,'[94,[621.466,4631.81,0.00143814]]','Volha_2_TK_CIV_EP1',5574573,'lingor'),(161,'[5,[3360.08,1126.39,0.00143862]]','UH1H_DZ',5591243,'lingor'),(162,'[18,[3956.76,4229.46,0.00143433]]','UH1H_DZ',5640172,'lingor'),(163,'[168,[602.249,4686.56,6.81655]]','UH1H_DZ',5688809,'lingor'),(164,'[89,[6597.37,6767.08,0]]','UH1H_DZ',5769153,'lingor'),(165,'[274,[6863.03,4451.83,0.00143814]]','UH1H_DZ',5825353,'lingor'),(166,'[79,[3472.71,1374.62,0.00143909]]','Ikarus_TK_CIV_EP1',6093204,'lingor'),(167,'[79,[3572.71,1374.62,0.00143909]]','Ikarus',6320860,'lingor'),(168,'[180,[5775.69,4724.98,0.00143814]]','Ikarus',6492547,'lingor'),(169,'[209,[835.536,5520.96,7.97942]]','Ikarus_TK_CIV_EP1',6511235,'lingor'),(170,'[9,[6572.64,5970.13,0]]','Ikarus',6638577,'lingor'),(171,'[9,[6472.64,5970.13,0]]','Ikarus_TK_CIV_EP1',7016936,'lingor'),(172,'[272,[2837.28,5328.06,0.373938]]','TT650_TK_CIV_EP1',7235098,'lingor'),(173,'[89,[7971.34,1091.71,0.00143909]]','Tractor',7311582,'lingor'),(174,'[317,[2645.8,6945.16,0.00143909]]','Tractor',7339114,'lingor'),(175,'[285,[4290.23,4935.53,0.00152206]]','S1203_TK_CIV_EP1',7469049,'lingor'),(176,'[5,[4198.66,4442.61,0.00143814]]','S1203_TK_CIV_EP1',7497356,'lingor'),(177,'[3,[5796.71,4721.43,0.00143814]]','S1203_TK_CIV_EP1',7535863,'lingor'),(178,'[167,[13367.5,6601.11,0.0126638]]','S1203_TK_CIV_EP1',7575100,'lingor'),(179,'[4,[4401.8,1702.02,0.121414]]','V3S_Civ',7632814,'lingor'),(180,'[137,[3800.27,2307.3,4.6834]]','Fishing_Boat',7636081,'lingor'),(181,'[137,[3700.27,2307.3,4.6834]]','Fishing_Boat',7931058,'lingor'),(182,'[291,[5873.05,5326.02,0.00148487]]','PBX',8076073,'lingor'),(183,'[147,[8433.71,7797.2,2.1895]]','Smallboat_1',8083737,'lingor'),(184,'[310,[3822.1,2299.23,0.000923157]]','Smallboat_1',8387143,'lingor'),(185,'[94,[621.466,4631.81,0.00143814]]','Volha_2_TK_CIV_EP1',8560255,'lingor'),(186,'[272,[6827.53,5927.34,0.00143909]]','Volha_1_TK_CIV_EP1',8611345,'lingor'),(187,'[356,[8039.13,2916.39,0.00257635]]','Volha_1_TK_CIV_EP1',8625660,'lingor'),(188,'[274,[3697.02,1404.02,0.00143909]]','Volha_2_TK_CIV_EP1',8875184,'lingor'),(189,'[260,[8299.95,2358.95,1.28169]]','Volha_1_TK_CIV_EP1',9212090,'lingor'),(190,'[47,[4149.76,1537.27,0.0821762]]','Volha_2_TK_CIV_EP1',9575283,'lingor'),(191,'[183,[5784.84,4712.17,0.00143814]]','SUV_TK_CIV_EP1',9642843,'lingor'),(192,'[222,[12360.468,10817.882,0]]','car_sedan',9752273,'lingor'),(193,'[273,[8842.5,921.916,0.00130701]]','Fishing_Boat',9791945,'lingor'),(194,'[249,[7563.33,1693.72,0.00143909]]','UAZ_Unarmed_TK_EP1',9936994,'lingor'),(195,'[195,[6800.51,2828.05,0.00150663]]','Fishing_Boat',9938094,'lingor');
/*!40000 ALTER TABLE `spawns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` smallint(8) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(32) NOT NULL DEFAULT '',
  `salt` char(3) NOT NULL DEFAULT '',
  `lastlogin` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','4f749f2c908b8ead47c20db6da1b04aa','l=i',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `whitelist`
--

DROP TABLE IF EXISTS `whitelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Allowed UIDs';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `whitelist`
--

LOCK TABLES `whitelist` WRITE;
/*!40000 ALTER TABLE `whitelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `whitelist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'dayz'
--
/*!50003 DROP PROCEDURE IF EXISTS `delO` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `delO`(IN myuid VARCHAR(50))
BEGIN
      DELETE FROM objects WHERE uid=myuid; --
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getLoadout` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `getLoadout`(IN myinstance INT)
BEGIN
    SELECT IF((SELECT loadout FROM instances WHERE instance=myinstance) IS NULL,"[]",(SELECT loadout FROM instances WHERE instance=myinstance)); --
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getO` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `getO`(in myinstance int, in page int)
begin
  set @i = myinstance; -- 
  set @s = 5; -- 
  set @p = (page * @s); -- 
  prepare stmt1 from 'SELECT id,otype,oid,pos,inventory,health,fuel,damage FROM objects WHERE instance=? LIMIT ?, ?'; -- 
  execute stmt1 using @i,@p,@s; -- 
  deallocate prepare stmt1; -- 
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getOC` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `getOC`(in myinstance int)
begin
  select floor(count(*) / 5) from objects where instance = myinstance; -- 
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getTasks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `getTasks`(in myinstance int, in page int)
begin
  set @i = myinstance; -- 
  set @s = 10; -- 
  set @p = (page * @s); -- 
  prepare stmt1 from 'SELECT message,mtype,looptime,mstart FROM scheduler JOIN instances ON mvisibility=visibility WHERE instance=? LIMIT ?, ?'; -- 
  execute stmt1 using @i,@p,@s; -- 
  deallocate prepare stmt1; -- 
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getTC` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `getTC`(in myinstance int)
begin
  select floor(count(*) / 10) from scheduler join instances on mvisibility = visibility where instance = myinstance; -- 
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getTime` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `getTime`(IN myinstance INT)
BEGIN
      SELECT DATE_FORMAT(NOW(),'%d-%m-%Y'), TIME_FORMAT(CURRENT_TIMESTAMP + INTERVAL (SELECT if((SELECT timezone FROM instances WHERE instance=myinstance) IS NULL,0,(SELECT timezone FROM instances WHERE instance=myinstance))) HOUR,'%T'); --
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insOselI` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `insOselI`(IN myuid VARCHAR(50),IN mytype VARCHAR(255),IN myhealth VARCHAR(1024),IN myhp DOUBLE,IN myfuel DOUBLE,IN myowner INT,IN mypos VARCHAR(255),IN myinstance INT)
BEGIN
      INSERT INTO objects (uid,otype,health,damage,oid,pos,fuel,instance) VALUES (myuid,mytype,myhealth,myhp,myowner,mypos,myfuel,myinstance); --
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insUNselI` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `insUNselI`(in myuid varchar(128), in myname varchar(255))
begin
      insert into main (uid, name,survival) values (myuid, myname, now()); --
      select last_insert_id(); --
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `logLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `logLogin`(in unique_id varchar(50))
begin
  insert into
    log_entry (profile_id, log_code_id)
  values (unique_id, 1); --
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `logLogout` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `logLogout`(in unique_id varchar(50))
begin
  insert into
    log_entry (profile_id, log_code_id)
  values (unique_id, 2); --
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selIIBSM` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `selIIBSM`(in myuid varchar(128))
begin
      select id, inventory, backpack, floor(time_to_sec(timediff(now(),survival))/60), model, late, ldrank from main where uid = myuid and death = 0; --
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selIPIBMSSS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `selIPIBMSSS`(in myuid varchar(128))
begin
      select id, pos, inventory, backpack, medical, floor(time_to_sec(timediff(now(),survival))/60), kills, state, late, ldrank, hs, hkills, bkills from main where uid = myuid and death = 0; --
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selMPSSH` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `selMPSSH`(IN myid INT)
BEGIN
      SELECT medical, pos, kills, state, humanity, hs, hkills, bkills FROM main WHERE id=myid AND death=0; --
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `setCD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `setCD`(IN myid INT)
BEGIN
      UPDATE main SET death=1 WHERE id=myid; --
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `update`(in myid int, in mypos varchar(1024), in myinv varchar(2048), in myback varchar(2048), in mymed varchar(1024), in myate int, in mydrank int, in mytime int, in mymod varchar(255), in myhum int, in myk int, in myhs int, in myhk int, in mybk int, in mystate varchar(255))
begin
      update main set kills=kills+myk,hs=hs+myhs,bkills=bkills+mybk,hkills=hkills+myhk,
      	state=mystate,model=if(mymod='any',model,mymod),late=if(myate=-1,0,late+myate),ldrank=if(mydrank=-1,0,ldrank+mydrank),stime=stime+mytime,
        pos=if(mypos='[]',pos,mypos),humanity=if(myhum=0,humanity,myhum),medical=if(mymed='[]',medical,mymed),
        backpack=if(myback='[]',backpack,myback),inventory=if(myinv='[]',inventory,myinv)
      where id=myid; --
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updIH` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `updIH`(IN myid INT,IN myhealth VARCHAR(1024),IN myhp DOUBLE)
BEGIN
      UPDATE objects SET health=myhealth,damage=myhp WHERE id=myid; --
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updII` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `updII`(in myid int, in myinv varchar(1024))
begin
      update objects set inventory=myinv where id=myid; --
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updIPF` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `updIPF`(IN myid INT,IN mypos VARCHAR(255),IN myfuel DOUBLE)
BEGIN
      UPDATE objects SET pos=if(mypos='[]',pos,mypos),fuel=myfuel WHERE id=myid; --
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updUI` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `updUI`(in myuid varchar(50), in myinv varchar(2048))
begin
  update objects set inventory = myinv where uid not like '%.%' and convert(uid, unsigned integer) between (convert(myuid, unsigned integer) - 2) and (convert(myuid, unsigned integer) + 2); -- 
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updV` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `updV`(IN myuid VARCHAR(50),IN mytype VARCHAR(255) ,IN mypos VARCHAR(255), IN myhealth VARCHAR(1024))
BEGIN
      UPDATE objects SET otype=if(mytype='',otype,mytype),health=myhealth,pos=if(mypos='[]',pos,mypos) WHERE uid=myuid; --
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-08-27 15:58:27