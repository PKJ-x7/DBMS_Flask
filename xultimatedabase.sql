-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: phone_directory
-- ------------------------------------------------------
-- Server version	8.0.31

create database phone_directory;
use phone_directory;

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
-- Table structure for table `alumni`
--

DROP TABLE IF EXISTS `alumni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumni` (
  `alumni_id` int NOT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `email_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`alumni_id`),
  UNIQUE KEY `email_id` (`email_id`),
  CONSTRAINT `alumni_id_8digits` CHECK (((`alumni_id` >= 10000000) and (`alumni_id` <= 99999999)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumni`
--

LOCK TABLES `alumni` WRITE;
/*!40000 ALTER TABLE `alumni` DISABLE KEYS */;
INSERT INTO `alumni` VALUES (13110001,'Lila','Orn','lilao@iitgn.ac.in'),(13110002,'Van','Conn','vanc@iitgn.ac.in'),(13110003,'Alena','Nader','alenan@iitgn.ac.in'),(13110004,'Laverne','D\'Amore','laverned@iitgn.ac.in'),(13110005,'Vaughn','Upton','vaughnu@iitgn.ac.in'),(13110006,'Aisha','Brown','aishab@iitgn.ac.in'),(13110007,'Mikel','Berge','mikelb@iitgn.ac.in'),(13110008,'Kristoff','Rodriguez','kristoffr@iitgn.ac.in');
/*!40000 ALTER TABLE `alumni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alumni_enrolled`
--

DROP TABLE IF EXISTS `alumni_enrolled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumni_enrolled` (
  `alumni_id` int NOT NULL,
  `program_name` varchar(30) DEFAULT NULL,
  `start_year` int DEFAULT NULL,
  `end_year` int DEFAULT NULL,
  `dept_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`alumni_id`),
  KEY `fk_dept_alumn_enrolled` (`dept_name`),
  KEY `fk_program_enrolled_alum` (`program_name`),
  KEY `fk_prog_start_enrolled_alum` (`start_year`),
  KEY `fk_prog_end_enrolled_alum` (`end_year`),
  CONSTRAINT `fk_alumni_enrollemt` FOREIGN KEY (`alumni_id`) REFERENCES `alumni` (`alumni_id`) on delete cascade,
  CONSTRAINT `fk_dept_alumn_enrolled` FOREIGN KEY (`dept_name`) REFERENCES `departments` (`dept_name`) on delete cascade,
  CONSTRAINT `fk_prog_end_enrolled_alum` FOREIGN KEY (`end_year`) REFERENCES `program` (`end_year`) on delete cascade,
  CONSTRAINT `fk_prog_start_enrolled_alum` FOREIGN KEY (`start_year`) REFERENCES `program` (`start_year`) on delete cascade,
  CONSTRAINT `fk_program_enrolled_alum` FOREIGN KEY (`program_name`) REFERENCES `program` (`program_name`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumni_enrolled`
--

LOCK TABLES `alumni_enrolled` WRITE;
/*!40000 ALTER TABLE `alumni_enrolled` DISABLE KEYS */;
INSERT INTO `alumni_enrolled` VALUES (13110001,'BTech',2013,2017,'Electrical Engineering'),(13110002,'MTech',2013,2015,'Computer Science and Engineering'),(13110003,'MSc',2013,2015,'Cognitive Science'),(13110004,'MASC',2013,2015,'Humanities and Social Sciences'),(13110005,'BTech',2013,2017,'Materials Engineering'),(13110006,'MTech',2013,2015,'Mechanical Engineering'),(13110007,'MSc',2013,2015,'Mathematics'),(13110008,'MASC',2013,2015,'Humanities and Social Sciences');
/*!40000 ALTER TABLE `alumni_enrolled` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alumni_phone_number`
--

DROP TABLE IF EXISTS `alumni_phone_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumni_phone_number` (
  `alumni_id` int NOT NULL,
  `phone_number` bigint NOT NULL,
  PRIMARY KEY (`alumni_id`,`phone_number`),
  CONSTRAINT `fk_phone_alumni` FOREIGN KEY (`alumni_id`) REFERENCES `alumni` (`alumni_id`) on delete cascade,
  CONSTRAINT `alumni_phone_number_10digits` CHECK (((`phone_number` >= 7000000000) and (`phone_number` <= 9999999999)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumni_phone_number`
--

LOCK TABLES `alumni_phone_number` WRITE;
/*!40000 ALTER TABLE `alumni_phone_number` DISABLE KEYS */;
INSERT INTO `alumni_phone_number` VALUES (13110001,9039933585),(13110002,9303214499),(13110003,7065576798),(13110003,8855015439),(13110004,7737620163),(13110004,9155973599),(13110005,8642889034),(13110005,9181157394),(13110006,7384101336),(13110006,9015873745),(13110007,9322099978),(13110007,9683031779),(13110008,8656457248);
/*!40000 ALTER TABLE `alumni_phone_number` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `centre`
--

DROP TABLE IF EXISTS `centre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `centre` (
  `centre_name` varchar(200) NOT NULL,
  `email_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`centre_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centre`
--

LOCK TABLES `centre` WRITE;
/*!40000 ALTER TABLE `centre` DISABLE KEYS */;
INSERT INTO `centre` VALUES ('CCL','ccl@iitgn.ac.in'),('Maker Bhavan','maker.bhavan@iitgn.ac.in'),('Neev','neev@iitgn.ac.in'),('Nyasa','nyasa@iitgn.ac.in'),('Research Park','research.park@iitgn.ac.in'),('Tinkerers\' Lab','tl@iitgn.ac.in'),('Writing Studio','writing.studio@iitgn.ac.in');
/*!40000 ALTER TABLE `centre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `centre_office`
--

DROP TABLE IF EXISTS `centre_office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `centre_office` (
  `centre_name` varchar(50) NOT NULL,
  `block_no` int DEFAULT NULL,
  `room_no` int DEFAULT NULL,
  PRIMARY KEY (`centre_name`),
  KEY `fk_block_room_centre` (`block_no`,`room_no`),
  CONSTRAINT `fk_block_room_centre` FOREIGN KEY (`block_no`, `room_no`) REFERENCES `office` (`block_no`, `room_no`) on delete cascade,
  CONSTRAINT `fk_service_name_centre` FOREIGN KEY (`centre_name`) REFERENCES `centre` (`centre_name`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centre_office`
--

LOCK TABLES `centre_office` WRITE;
/*!40000 ALTER TABLE `centre_office` DISABLE KEYS */;
INSERT INTO `centre_office` VALUES ('Research Park',5,105),('Maker Bhavan',5,106),('Nyasa',5,107),('Neev',5,108),('Tinkerers\' Lab',6,215),('Writing Studio',6,220),('CCL',6,230);
/*!40000 ALTER TABLE `centre_office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `centre_staff`
--

DROP TABLE IF EXISTS `centre_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `centre_staff` (
  `staff_id` int NOT NULL,
  `centre_name` varchar(50) DEFAULT NULL,
  `roles` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `fk_centre_name_cs` (`centre_name`),
  CONSTRAINT `fk_centre_name_cs` FOREIGN KEY (`centre_name`) REFERENCES `centre` (`centre_name`) on delete cascade,
  CONSTRAINT `fk_staff_ID_cs` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centre_staff`
--

LOCK TABLES `centre_staff` WRITE;
/*!40000 ALTER TABLE `centre_staff` DISABLE KEYS */;
INSERT INTO `centre_staff` VALUES (10637940,'Research Park','Researcher'),(10637941,'Maker Bhavan','Maker'),(10637942,'Nyasa','Kid Controller'),(10637943,'Neev','Stuff Maker'),(10637944,'CCL','Creative Lead'),(10637945,'Writing Studio','Writer'),(10637946,'Tinkerers\' Lab','Tinkerer');
/*!40000 ALTER TABLE `centre_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `council_advisor`
--

DROP TABLE IF EXISTS `council_advisor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `council_advisor` (
  `faculty_id` int DEFAULT NULL,
  `council_name` varchar(30) NOT NULL,
  PRIMARY KEY (`council_name`),
  KEY `fk_council_faculty_ID` (`faculty_id`),
  CONSTRAINT `fk_council_faculty_ID` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`) on delete cascade,
  CONSTRAINT `fk_council_faculty_name` FOREIGN KEY (`council_name`) REFERENCES `student_council` (`council_name`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `council_advisor`
--

LOCK TABLES `council_advisor` WRITE;
/*!40000 ALTER TABLE `council_advisor` DISABLE KEYS */;
INSERT INTO `council_advisor` VALUES (10861895,'Academic Council'),(11643101,'Welfare Council'),(12340912,'Technical Council'),(12340913,'Cultural Council'),(12340914,'Sports Council'),(12340915,'PDC Council'),(12340916,'IR&P Council'),(12340917,'General Council'),(12340918,'Student Senate');
/*!40000 ALTER TABLE `council_advisor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `dept_name` varchar(500) NOT NULL,
  PRIMARY KEY (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES ('Biological Engineering'),('Chemical Engineering'),('Chemistry'),('Civil Engineering'),('Cognitive Science'),('Computer Science and Engineering'),('Earth Sciences'),('Electrical Engineering'),('Humanities and Social Sciences'),('Materials Engineering'),('Mathematics'),('Mechanical Engineering'),('Physics');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emergency_contact`
--

DROP TABLE IF EXISTS `emergency_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emergency_contact` (
  `student_id` int NOT NULL,
  `emergency_id` int DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  CONSTRAINT `fk_emergency_id` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) on delete cascade,
  CONSTRAINT `fk_student_emergency` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emergency_contact`
--

LOCK TABLES `emergency_contact` WRITE;
/*!40000 ALTER TABLE `emergency_contact` DISABLE KEYS */;
INSERT INTO `emergency_contact` VALUES (19110001,19110003),(19110002,19110007),(19110003,19110005),(19110004,19110007),(19110005,19110003),(19110006,20110003),(19110007,20110006),(19110008,19110003),(20110001,20110004),(20110002,20110006),(20110003,19110008),(20110004,20110008),(20110005,20110008),(20110006,20110005),(20110007,19110003),(20110008,19110007);
/*!40000 ALTER TABLE `emergency_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty`
--

DROP TABLE IF EXISTS `faculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty` (
  `faculty_id` int NOT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `email_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`faculty_id`),
  UNIQUE KEY `email_id` (`email_id`),
  CONSTRAINT `faculty_id_8digits` CHECK (((`faculty_id` >= 10000000) and (`faculty_id` <= 99999999)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty`
--

LOCK TABLES `faculty` WRITE;
/*!40000 ALTER TABLE `faculty` DISABLE KEYS */;
INSERT INTO `faculty` VALUES (10861895,'Lucy','Goodwin','lucyg@iitgn.ac.in'),(11643101,'Jarett','Hessel','jarreth@iitgn.ac.in'),(12340912,'Lauren','Blick','laurenb@iitgn.ac.in'),(12340913,'Nona','Wehner','nonaw@iitgn.ac.in'),(12340914,'Kailyn','Kuhlman','kailynk@iitgn.ac.in'),(12340915,'Brandt','Rohan','brandtr@iitgn.ac.in'),(12340916,'Max','Lowe','maxl@iitgn.ac.in'),(12340917,'Janessa','Schuster','janessas@iitgn.ac.in'),(12340918,'Barry','Yost','barryy@iitgn.ac.in'),(12340919,'Mikayla','Windler','mikaylaw@iitgn.ac.in'),(12340920,'Brandy','Nienow','brandyn@iitgn.ac.in'),(12340921,'Vivien','Bashirian','vivienb@iitgn.ac.in'),(12340922,'Jaunita','Stracker','jaunitas@iitgn.ac.in');
/*!40000 ALTER TABLE `faculty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty_dept`
--

DROP TABLE IF EXISTS `faculty_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty_dept` (
  `faculty_id` int NOT NULL,
  `dept_name` varchar(50) NOT NULL,
  `designation` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`faculty_id`,`dept_name`),
  KEY `fk_dept_naam` (`dept_name`),
  CONSTRAINT `fk_dept_naam` FOREIGN KEY (`dept_name`) REFERENCES `departments` (`dept_name`) on delete cascade,
  CONSTRAINT `fk_faculty_ID` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty_dept`
--

LOCK TABLES `faculty_dept` WRITE;
/*!40000 ALTER TABLE `faculty_dept` DISABLE KEYS */;
INSERT INTO `faculty_dept` VALUES (10861895,'Biological Engineering','Associate Professor'),(11643101,'Civil Engineering','Associate Professor'),(12340912,'Chemical Engineering','Assistant Professor'),(12340913,'Computer Science and Engineering','Department Head'),(12340914,'Electrical Engineering','Department Head'),(12340915,'Mechanical Engineering','Assistant Professor'),(12340916,'Materials Engineering','Associate Professor'),(12340918,'Mathematics','Department Head'),(12340919,'Physics','Associate Professor'),(12340920,'Cognitive Science','Assistant Professor'),(12340921,'Earth Sciences','Associate Professor'),(12340922,'Humanities and Social Sciences','Department Head');
/*!40000 ALTER TABLE `faculty_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty_head_centre`
--

DROP TABLE IF EXISTS `faculty_head_centre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty_head_centre` (
  `faculty_id` int NOT NULL,
  `centre_name` varchar(50) DEFAULT NULL,
  `designation` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`faculty_id`),
  KEY `fk_centre_name` (`centre_name`),
  CONSTRAINT `fk_centre_name` FOREIGN KEY (`centre_name`) REFERENCES `centre` (`centre_name`) on delete cascade,
  CONSTRAINT `fk_faculty__ID` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty_head_centre`
--

LOCK TABLES `faculty_head_centre` WRITE;
/*!40000 ALTER TABLE `faculty_head_centre` DISABLE KEYS */;
INSERT INTO `faculty_head_centre` VALUES (12340919,'Maker Bhavan','Making Coordinator'),(12340920,'Nyasa','Child Lover'),(12340921,'Neev','Art and Craft Lover'),(12340922,'CCL','Creative Learner');
/*!40000 ALTER TABLE `faculty_head_centre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty_head_lab`
--

DROP TABLE IF EXISTS `faculty_head_lab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty_head_lab` (
  `faculty_id` int NOT NULL,
  `lab_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`faculty_id`),
  KEY `fk_lab_name_faculty` (`lab_name`),
  CONSTRAINT `fk_faculty_ID_lab` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`) on delete cascade,
  CONSTRAINT `fk_lab_name_faculty` FOREIGN KEY (`lab_name`) REFERENCES `lab` (`lab_name`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty_head_lab`
--

LOCK TABLES `faculty_head_lab` WRITE;
/*!40000 ALTER TABLE `faculty_head_lab` DISABLE KEYS */;
INSERT INTO `faculty_head_lab` VALUES (12340918,'Computational Nanoelectronic Lab'),(12340919,'Electrical Engineering Lab'),(12340917,'Experimental Complex Fluids Lab'),(12340920,'Material Characterization Lab'),(12340921,'Wet Chemistry Lab');
/*!40000 ALTER TABLE `faculty_head_lab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty_head_service`
--

DROP TABLE IF EXISTS `faculty_head_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty_head_service` (
  `faculty_id` int NOT NULL,
  `service_name` varchar(50) DEFAULT NULL,
  `designation` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`faculty_id`),
  KEY `fk_sercive_name` (`service_name`),
  CONSTRAINT `fk_faculty_service__ID` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`) on delete cascade,
  CONSTRAINT `fk_sercive_name` FOREIGN KEY (`service_name`) REFERENCES `service` (`service_name`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty_head_service`
--

LOCK TABLES `faculty_head_service` WRITE;
/*!40000 ALTER TABLE `faculty_head_service` DISABLE KEYS */;
INSERT INTO `faculty_head_service` VALUES (12340915,'Lost and Found','Finder'),(12340916,'Sports Complex','Sports Enthusiast'),(12340917,'Library','Thinker'),(12340918,'CDS','Career Expert'),(12340919,'Guest House','Hospitality Lead'),(12340920,'Hostel Office','Hosteller'),(12340921,'Student Affairs','Student Dean'),(12340922,'Medical Centre','Doctor');
/*!40000 ALTER TABLE `faculty_head_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty_office`
--

DROP TABLE IF EXISTS `faculty_office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty_office` (
  `faculty_id` int NOT NULL,
  `block_no` int DEFAULT NULL,
  `room_no` int DEFAULT NULL,
  PRIMARY KEY (`faculty_id`),
  KEY `fk_office_block_fac` (`block_no`),
  KEY `fk_office_room_fac` (`room_no`),
  CONSTRAINT `fk_facultees` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`) on delete cascade,
  CONSTRAINT `fk_office_block_fac` FOREIGN KEY (`block_no`) REFERENCES `office` (`block_no`) on delete cascade,
  CONSTRAINT `fk_office_room_fac` FOREIGN KEY (`room_no`) REFERENCES `office` (`room_no`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty_office`
--

LOCK TABLES `faculty_office` WRITE;
/*!40000 ALTER TABLE `faculty_office` DISABLE KEYS */;
INSERT INTO `faculty_office` VALUES (10861895,3,101),(11643101,3,102),(12340912,3,103),(12340913,3,104),(12340914,3,303),(12340915,3,304),(12340916,3,305),(12340917,3,306),(12340918,4,201),(12340919,4,202),(12340920,4,203),(12340921,4,203),(12340922,5,301);
/*!40000 ALTER TABLE `faculty_office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty_phone_number`
--

DROP TABLE IF EXISTS `faculty_phone_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty_phone_number` (
  `faculty_id` int NOT NULL,
  `phone_number` bigint NOT NULL,
  PRIMARY KEY (`faculty_id`,`phone_number`),
  CONSTRAINT `fk_phone_faculty` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`) on delete cascade,
  CONSTRAINT `faculty_phone_number_10digits` CHECK (((`phone_number` >= 1000000000) and (`phone_number` <= 9999999999)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty_phone_number`
--

LOCK TABLES `faculty_phone_number` WRITE;
/*!40000 ALTER TABLE `faculty_phone_number` DISABLE KEYS */;
INSERT INTO `faculty_phone_number` VALUES (10861895,7821206984),(11643101,9118275475),(12340912,7118567696),(12340913,7952894498),(12340914,8970775330),(12340915,7501683615),(12340915,9317377416),(12340916,8509168418),(12340916,8525030570),(12340917,7165817436),(12340917,9179283791),(12340918,8616334124),(12340918,8652960219),(12340919,7339225972),(12340919,7373870719),(12340920,7698298379),(12340920,9483675231),(12340921,7419477060),(12340921,8071345509),(12340922,9147490486);
/*!40000 ALTER TABLE `faculty_phone_number` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_part_of`
--

DROP TABLE IF EXISTS `group_part_of`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_part_of` (
  `group_name` varchar(50) NOT NULL,
  `council_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`group_name`),
  KEY `fk_council_ID` (`council_name`),
  CONSTRAINT `fk_council_ID` FOREIGN KEY (`council_name`) REFERENCES `student_council` (`council_name`) on delete cascade,
  CONSTRAINT `fk_group_ID` FOREIGN KEY (`group_name`) REFERENCES `student_group` (`group_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_part_of`
--

LOCK TABLES `group_part_of` WRITE;
/*!40000 ALTER TABLE `group_part_of` DISABLE KEYS */;
INSERT INTO `group_part_of` VALUES ('Sargam','Cultural Council'),('Vinteo','Cultural Council'),('Amalthea','General Council'),('Blithchron','General Council'),('Annuity','PDC Council'),('Hallabol','Sports Council'),('Digis','Technical Council'),('Metis','Technical Council'),('Mess ','Welfare Council');
/*!40000 ALTER TABLE `group_part_of` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostel`
--

DROP TABLE IF EXISTS `hostel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hostel` (
  `hostel_name` varchar(10) NOT NULL,
  `phone_number` bigint DEFAULT NULL,
  PRIMARY KEY (`hostel_name`),
  CONSTRAINT `hostel_chk_1` CHECK (((`phone_number` >= 1000000000) and (`phone_number` <= 9999999999)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostel`
--

LOCK TABLES `hostel` WRITE;
/*!40000 ALTER TABLE `hostel` DISABLE KEYS */;
INSERT INTO `hostel` VALUES ('Aibaan',9123812345),('Beauki',9123534545),('Chimair',9234412345),('Duven',9287452353),('Emiet',9125735767),('Firpeal',9356916545),('Griwiksh',9025782576),('Hiqom',9292674926),('Ijokha',9086842663),('Jurqia',8287469245),('Kyzeel',7928475340);
/*!40000 ALTER TABLE `hostel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab`
--

DROP TABLE IF EXISTS `lab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab` (
  `lab_name` varchar(50) NOT NULL,
  `email_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`lab_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab`
--

LOCK TABLES `lab` WRITE;
/*!40000 ALTER TABLE `lab` DISABLE KEYS */;
INSERT INTO `lab` VALUES ('Analog CKT Lab','analog-ckt-lab.pvtgroup@iitgn.ac.in'),('Brain & Informatics','brainlab.pvtgroup@iitgn.ac.in'),('Computational Nanoelectronic Lab','conrel@iitgn.ac.in'),('Computer Vision Imaging and Graphics Lab','cvig@iitgn.ac.in'),('Design and Innovation Lab','designinnovationlab.pvtgroup@iitgn.ac.in'),('Electrical Engineering Lab','eelabs@iitgn.ac.in'),('Experimental Complex Fluids Lab','ecfl@iitgn.ac.in'),('Material Characterization Lab','matchrlab@iitgn.ac.in'),('Soil Testing Lab','touchgrass@iitgn.ac.in'),('Wet Chemistry Lab','iamwet@iitgn.ac.in');
/*!40000 ALTER TABLE `lab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab_dept`
--

DROP TABLE IF EXISTS `lab_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab_dept` (
  `lab_name` varchar(50) NOT NULL,
  `dept_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`lab_name`),
  KEY `fk_dept_name` (`dept_name`),
  CONSTRAINT `fk_dept_name` FOREIGN KEY (`dept_name`) REFERENCES `departments` (`dept_name`) on delete cascade,
  CONSTRAINT `fk_lab_name` FOREIGN KEY (`lab_name`) REFERENCES `lab` (`lab_name`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab_dept`
--

LOCK TABLES `lab_dept` WRITE;
/*!40000 ALTER TABLE `lab_dept` DISABLE KEYS */;
INSERT INTO `lab_dept` VALUES ('Experimental Complex Fluids Lab','Chemical Engineering'),('Design and Innovation Lab','Civil Engineering'),('Brain & Informatics','Cognitive Science'),('Computational Nanoelectronic Lab','Computer Science and Engineering'),('Computer Vision Imaging and Graphics Lab','Computer Science and Engineering'),('Soil Testing Lab','Earth Sciences'),('Analog CKT Lab','Electrical Engineering'),('Electrical Engineering Lab','Electrical Engineering'),('Material Characterization Lab','Materials Engineering');
/*!40000 ALTER TABLE `lab_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab_office`
--

DROP TABLE IF EXISTS `lab_office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab_office` (
  `lab_name` varchar(50) NOT NULL,
  `block_no` int DEFAULT NULL,
  `room_no` int DEFAULT NULL,
  PRIMARY KEY (`lab_name`),
  KEY `fk_office_block` (`block_no`),
  KEY `fk_office_room` (`room_no`),
  CONSTRAINT `fk_lab` FOREIGN KEY (`lab_name`) REFERENCES `lab` (`lab_name`) on delete cascade,
  CONSTRAINT `fk_office_block` FOREIGN KEY (`block_no`) REFERENCES `office` (`block_no`) on delete cascade,
  CONSTRAINT `fk_office_room` FOREIGN KEY (`room_no`) REFERENCES `office` (`room_no`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab_office`
--

LOCK TABLES `lab_office` WRITE;
/*!40000 ALTER TABLE `lab_office` DISABLE KEYS */;
INSERT INTO `lab_office` VALUES ('Analog CKT Lab',5,304),('Brain & Informatics',5,302),('Computational Nanoelectronic Lab',6,315),('Computer Vision Imaging and Graphics Lab',5,303),('Design and Innovation Lab',6,330),('Electrical Engineering Lab',3,201),('Experimental Complex Fluids Lab',6,320),('Material Characterization Lab',3,202),('Soil Testing Lab',3,204),('Wet Chemistry Lab',3,203);
/*!40000 ALTER TABLE `lab_office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab_staff`
--

DROP TABLE IF EXISTS `lab_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab_staff` (
  `staff_id` int NOT NULL,
  `lab_name` varchar(50) DEFAULT NULL,
  `roles` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `fk_lab_name_staff` (`lab_name`),
  CONSTRAINT `fk_lab_name_staff` FOREIGN KEY (`lab_name`) REFERENCES `lab` (`lab_name`) on delete cascade,
  CONSTRAINT `fk_staff_ID` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab_staff`
--

LOCK TABLES `lab_staff` WRITE;
/*!40000 ALTER TABLE `lab_staff` DISABLE KEYS */;
INSERT INTO `lab_staff` VALUES (10637922,'Brain & Informatics','Brain Expert'),(10637923,'Computer Vision Imaging and Graphics Lab','Vision Guy'),(10637924,'Analog CKT Lab','Digital Hater'),(10637925,'Design and Innovation Lab','Innovating Lead'),(10637926,'Experimental Complex Fluids Lab','Complex Man'),(10637927,'Computational Nanoelectronic Lab','Nano Sized Guy'),(10637928,'Electrical Engineering Lab','Engineer Dude'),(10637929,'Material Characterization Lab','Main Character'),(10637930,'Wet Chemistry Lab','Dryness Disliker'),(10637931,'Soil Testing Lab','Earthworm Lover');
/*!40000 ALTER TABLE `lab_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office`
--

DROP TABLE IF EXISTS `office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `office` (
  `block_no` int NOT NULL,
  `room_no` int NOT NULL,
  `office_phone_number` bigint DEFAULT NULL,
  PRIMARY KEY (`block_no`,`room_no`),
  KEY `idx_block_no` (`block_no`),
  KEY `idx_room_no` (`room_no`),
  CONSTRAINT `office_chk_1` CHECK (((`block_no` >= 1) and (`block_no` <= 9))),
  CONSTRAINT `office_chk_2` CHECK (((`room_no` > 100) and (`room_no` < 500))),
  CONSTRAINT `office_chk_3` CHECK (((`office_phone_number` >= 1000000000) and (`office_phone_number` <= 9999999999)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `office`
--

LOCK TABLES `office` WRITE;
/*!40000 ALTER TABLE `office` DISABLE KEYS */;
INSERT INTO `office` VALUES (3,101,9206468795),(3,102,9885201804),(3,103,9556788048),(3,104,7598279544),(3,201,9232280679),(3,202,9556196434),(3,203,9113424429),(3,204,7661836773),(3,205,8966865778),(3,206,9472829198),(3,207,7058345946),(3,208,8075565369),(3,303,7313061424),(3,304,7613606677),(3,305,7249562277),(3,306,9104689062),(4,101,7746988182),(4,102,7568942485),(4,103,8436994002),(4,104,8909434660),(4,201,9866162808),(4,202,9063577650),(4,203,8924582281),(5,105,7201112330),(5,106,7726598799),(5,107,8376777959),(5,108,8296921100),(5,301,8536023832),(5,302,7635270492),(5,303,8951151328),(5,304,9117583346),(5,403,7110433614),(6,215,8455305730),(6,220,7557673832),(6,230,7891685388),(6,315,9943835412),(6,320,7442323179),(6,330,7792291105),(6,401,7683730690),(6,402,8363674698);
/*!40000 ALTER TABLE `office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program` (
  `program_name` varchar(30) NOT NULL,
  `start_year` int NOT NULL,
  `end_year` int NOT NULL,
  PRIMARY KEY (`program_name`,`start_year`,`end_year`),
  KEY `idx_start_year` (`start_year`),
  KEY `idx_end_year` (`end_year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program`
--

LOCK TABLES `program` WRITE;
/*!40000 ALTER TABLE `program` DISABLE KEYS */;
INSERT INTO `program` VALUES ('BTech',2013,2017),('MASC',2013,2015),('MSc',2013,2015),('MTech',2013,2015),('BTech',2019,2023),('MASC',2019,2021),('MSc',2019,2021),('MTech',2019,2021),('BTech',2020,2024),('MASC',2020,2022),('MSc',2020,2022),('MTech',2020,2022);
/*!40000 ALTER TABLE `program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `service_name` varchar(255) NOT NULL,
  `email_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`service_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES ('CDS','cds@iitgn.ac.in'),('Guest House','guesthouse@iitgn.ac.in'),('Hostel Office','hosteloffice@iitgn.ac.in'),('Library','library@iitgn.ac.in'),('Lost and Found','bvpuvar@iitgn.ac.in'),('Medical Centre','medicalcentre@iitgn.ac.in'),('Sports Complex','sportscomplex@iitgn.ac.in'),('Student Affairs','student.affairs@iitgn.ac.in');
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_office`
--

DROP TABLE IF EXISTS `service_office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_office` (
  `service_name` varchar(50) NOT NULL,
  `block_no` int DEFAULT NULL,
  `room_no` int DEFAULT NULL,
  PRIMARY KEY (`service_name`),
  KEY `fk_block_room` (`block_no`,`room_no`),
  CONSTRAINT `fk_block_room` FOREIGN KEY (`block_no`, `room_no`) REFERENCES `office` (`block_no`, `room_no`) on delete cascade,
  CONSTRAINT `fk_service_name_` FOREIGN KEY (`service_name`) REFERENCES `service` (`service_name`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_office`
--

LOCK TABLES `service_office` WRITE;
/*!40000 ALTER TABLE `service_office` DISABLE KEYS */;
INSERT INTO `service_office` VALUES ('Lost and Found',3,205),('Sports Complex',3,206),('Library',3,207),('CDS',3,208),('Guest House',4,101),('Hostel Office',4,102),('Student Affairs',4,103),('Medical Centre',4,104);
/*!40000 ALTER TABLE `service_office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_staff`
--

DROP TABLE IF EXISTS `service_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_staff` (
  `staff_id` int NOT NULL,
  `service_name` varchar(50) DEFAULT NULL,
  `roles` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `fk_service_name` (`service_name`),
  CONSTRAINT `fk_service_name` FOREIGN KEY (`service_name`) REFERENCES `service` (`service_name`) on delete cascade,
  CONSTRAINT `fk_staff_ID_service` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_staff`
--

LOCK TABLES `service_staff` WRITE;
/*!40000 ALTER TABLE `service_staff` DISABLE KEYS */;
INSERT INTO `service_staff` VALUES (10637932,'Lost and Found','BV Puvar'),(10637933,'Sports Complex','Fitness Checker'),(10637934,'Library','Silence Enforcer'),(10637935,'CDS','Company Finder'),(10637936,'Guest House','Guest Receiver'),(10637937,'Hostel Office','Room Alloter '),(10637938,'Student Affairs','SSAC Verifier'),(10637939,'Medical Centre','Nurse');
/*!40000 ALTER TABLE `service_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `email_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `email_id` (`email_id`),
  CONSTRAINT `staff_id_8digits` CHECK (((`staff_id` >= 10000000) and (`staff_id` <= 99999999)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (10637922,'Darwin','Doyle','darwind@iitgn.ac.in'),(10637923,'Lyric','Legros','lyricl@iitgn.ac.in'),(10637924,'Jeff','Bartell','jeffb@iitgn.ac.in'),(10637925,'Coralie','Herman','coralieh@iitgn.ac.in'),(10637926,'Clark','Goyette','clarkg@iitgn.ac.in'),(10637927,'Sunny','Renner','sunnyr@iitgn.ac.in'),(10637928,'Nicholous','Sanford','sanfordn@iitgn.ac.in'),(10637929,'Eudora','Gutkowski','eudorag@iitgn.ac.in'),(10637930,'Casimir','Morissette','casimirm@iitgn.ac.in'),(10637931,'Janae ','Stanton','janaes@iitgn.ac.in'),(10637932,'Jerrold','Littel','jerroldl@iitgn.ac.in'),(10637933,'Madisyn ','Fisher','madisynf@iitgn.ac.in'),(10637934,'Libby','Thompson','libbyt@iitgn.ac.in'),(10637935,'Houston','Wisozk','houstonw@iitgn.ac.in'),(10637936,'Burnice','Boehm','burniceb@iitgn.ac.in'),(10637937,'Reyes','Hoppe','reyesh@iitgn.ac.in'),(10637938,'Hope ','Van','hopev@iitgn.ac.in'),(10637939,'Scott','Lang','scottl@iitgn.ac.in'),(10637940,'Armano','Waters','armanow@iitgn.ac.in'),(10637941,'Trevion','White','trevionw@iitgn.ac.in'),(10637942,'Alexis ','Wisoky','alexisw@iitgn.ac.in'),(10637943,'Phil','Coulson','phlic@iitgn.ac.in'),(10637944,'Edyth','Braun','edythb@iitgn.ac.in'),(10637945,'Nedra','Reynolds','nedrar@iitgn.ac.in'),(10637946,'Jamey','Volkman','jameyv@iitgn.ac.in');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_phone_number`
--

DROP TABLE IF EXISTS `staff_phone_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff_phone_number` (
  `staff_id` int NOT NULL,
  `phone_number` bigint NOT NULL,
  PRIMARY KEY (`staff_id`,`phone_number`),
  CONSTRAINT `fk_phone_staff` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) on delete cascade,
  CONSTRAINT `sphone_number_10digits` CHECK (((`phone_number` >= 7000000000) and (`phone_number` <= 9999999999)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_phone_number`
--

LOCK TABLES `staff_phone_number` WRITE;
/*!40000 ALTER TABLE `staff_phone_number` DISABLE KEYS */;
INSERT INTO `staff_phone_number` VALUES (10637922,7852125951),(10637923,8303087663),(10637924,7233469009),(10637925,7956523820),(10637926,7991672368),(10637927,8601396564),(10637928,9868633159),(10637929,9734605575),(10637930,7224503759),(10637931,8688000587),(10637932,9352593501),(10637933,7139422139),(10637934,7722750891),(10637935,7971348959),(10637936,9623931925),(10637937,7021786779),(10637937,7069947193),(10637938,7951481178),(10637938,9384549214),(10637939,7260665907),(10637939,9923920818),(10637940,7860308195),(10637940,8952451779),(10637941,7931224115),(10637941,9058764258),(10637942,8222426669),(10637943,9668140116),(10637944,9483568847),(10637945,7239118232),(10637946,7376247988);
/*!40000 ALTER TABLE `staff_phone_number` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `student_id` int NOT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `email_id` varchar(50) DEFAULT NULL,
  `street` varchar(20) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `home_phone_number` bigint DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `email_id` (`email_id`),
  CONSTRAINT `shome_phone_number_10digits` CHECK (((`home_phone_number` >= 7000000000) and (`home_phone_number` <= 9999999999))),
  CONSTRAINT `student_id_8digits` CHECK (((`student_id` >= 10000000) and (`student_id` <= 99999999)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (19110001,'Casey','Weissnat','casey.weissnat@iitgn.ac.in','Cade Points','Francoview','Florida',7420756229),(19110002,'Yasmine','Graham','yasmine.graham@iitgn.ac.in','Kale Tunnel','East Valentinefort','District of Columbia',8902852250),(19110003,'Catalna ','Lind','catalnalind@iitgn.ac.in','Hazle Station','East Hayleburgh','Colarado',7959743868),(19110004,'Feltcher','Bogan','feltcherb@iitgn.ac.in','Roberts Garden','Laishamouth','Maine',7525013163),(19110005,'Camelo ','Parisian','camelop@iitgn.ac.in','Waylon Track','East Lucileborough','North Carolina',7938069726),(19110006,'Kavon ','Trump','ktrump@iitgn.ac.in','Tia Mission','North Wyman','Louisiana',9230914497),(19110007,'Orpha ','Jones','orphaj@iitgn.ac.in','Herman Mountains','West Montana','Tennessee',7198247250),(19110008,'Walter','White','waltuh@iitgn.ac.in','Negra Arroyo Lane','Alberquerque','New Mexico',7382248525),(20110001,'Jesse ','Pinkman','jessep@iitgn.ac.in','Trailer','Alberquerque','Ohio',7517524660),(20110002,'Skyler ','White','skyleryo@iitgn.ac.in','Negra Arroyo Lane','Alberquerque','New Mexico',8097938974),(20110003,'Fabian ','Hane','fabhane@iitgn.ac.in','Klein Vista','West Kathrynstad','Utah',7084424593),(20110004,'Cedrick ','Swaniwaski','cedswa@iitgn.ac.in','Waelchi Walk','Lake Montana','Arizona',9097124004),(20110005,'Gustavo ','Fring','susgus@iitgn.ac.in','Los Pollos Hermanos','Alberquerque','New Mexico',8275973220),(20110006,'Emelie','Altenwerth','emeat@iitgn.ac.in','Cheyenne Mountain','West Tarunmouth','North Carolina',7076223211),(20110007,'Ned ','Fisher','nedfish@iitgn.ac.in','Krajok Ports','Ashleyborough','New York',9466266178),(20110008,'Margaret','Parisian','margaretp@iitgn.ac.in','Desiree Plains','Powlowskimouth','North Dakota',9970710298);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_council`
--

DROP TABLE IF EXISTS `student_council`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_council` (
  `council_name` varchar(30) NOT NULL,
  `email_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`council_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_council`
--

LOCK TABLES `student_council` WRITE;
/*!40000 ALTER TABLE `student_council` DISABLE KEYS */;
INSERT INTO `student_council` VALUES ('Academic Council','academic.council@iitgn.ac.in'),('Cultural Council','cultural.council@iitgn.ac.in'),('General Council','general.council@iitgn.ac.in'),('IR&P Council','irp.council@iitgn.ac.in'),('PDC Council','pdc.council@iitgn.ac.in'),('Sports Council','sports.council@iitgn.ac.in'),('Student Senate','student.senate@iitgn.ac.in'),('Technical Council','technical.council@iitgn.ac.in'),('Welfare Council','welfare.council@iitgn.ac.in');
/*!40000 ALTER TABLE `student_council` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_council_member`
--

DROP TABLE IF EXISTS `student_council_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_council_member` (
  `student_id` int NOT NULL,
  `council_name` varchar(30) DEFAULT NULL,
  `position` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `fk_council_name` (`council_name`),
  CONSTRAINT `fk_council_name` FOREIGN KEY (`council_name`) REFERENCES `student_council` (`council_name`) on delete cascade,
  CONSTRAINT `fk_student_ID` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_council_member`
--

LOCK TABLES `student_council_member` WRITE;
/*!40000 ALTER TABLE `student_council_member` DISABLE KEYS */;
INSERT INTO `student_council_member` VALUES (19110001,'Academic Council','General Member'),(19110002,'Welfare Council','General Member'),(19110003,'Technical Council','Secretary'),(19110004,'Cultural Council','Coordinator'),(19110005,'Sports Council','Advisor'),(19110006,'PDC Council','Secretary'),(19110007,'IR&P Council','Projects Coordinator'),(19110008,'General Council','Secretary'),(20110001,'Student Senate','Member');
/*!40000 ALTER TABLE `student_council_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_enrolled`
--

DROP TABLE IF EXISTS `student_enrolled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_enrolled` (
  `student_id` int NOT NULL,
  `program_name` varchar(30) DEFAULT NULL,
  `start_year` int DEFAULT NULL,
  `end_year` int DEFAULT NULL,
  `dept_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `fk_dept_student_enrolled` (`dept_name`),
  KEY `fk_program_enrolled` (`program_name`),
  KEY `fk_prog_start_enrolled` (`start_year`),
  KEY `fk_prog_end_enrolled` (`end_year`),
  CONSTRAINT `fk_dept_student_enrolled` FOREIGN KEY (`dept_name`) REFERENCES `departments` (`dept_name`) on delete cascade,
  CONSTRAINT `fk_prog_end_enrolled` FOREIGN KEY (`end_year`) REFERENCES `program` (`end_year`) on delete cascade,
  CONSTRAINT `fk_prog_start_enrolled` FOREIGN KEY (`start_year`) REFERENCES `program` (`start_year`) on delete cascade,
  CONSTRAINT `fk_program_enrolled` FOREIGN KEY (`program_name`) REFERENCES `program` (`program_name`) on delete cascade,
  CONSTRAINT `fk_student_enrollemt` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_enrolled`
--

LOCK TABLES `student_enrolled` WRITE;
/*!40000 ALTER TABLE `student_enrolled` DISABLE KEYS */;
INSERT INTO `student_enrolled` VALUES (19110001,'BTech',2019,2023,'Electrical Engineering'),(19110002,'MTech',2019,2021,'Computer Science and Engineering'),(19110003,'MSc',2019,2021,'Cognitive Science'),(19110004,'MASC',2019,2021,'Humanities and Social Sciences'),(19110005,'BTech',2019,2023,'Materials Engineering'),(19110006,'MTech',2019,2021,'Mechanical Engineering'),(19110007,'MSc',2019,2021,'Mathematics'),(19110008,'MSc',2019,2021,'Physics'),(20110001,'BTech',2020,2024,'Civil Engineering'),(20110002,'MTech',2020,2022,'Chemical Engineering'),(20110003,'MSc',2020,2022,'Chemistry'),(20110004,'MASC',2020,2022,'Humanities and Social Sciences'),(20110005,'BTech',2020,2024,'Mechanical Engineering'),(20110006,'MTech',2020,2022,'Materials Engineering'),(20110007,'MSc',2020,2022,'Mathematics'),(20110008,'BTech',2020,2024,'Chemical Engineering');
/*!40000 ALTER TABLE `student_enrolled` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_group`
--

DROP TABLE IF EXISTS `student_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_group` (
  `group_name` varchar(50) NOT NULL,
  `email_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_group`
--

LOCK TABLES `student_group` WRITE;
/*!40000 ALTER TABLE `student_group` DISABLE KEYS */;
INSERT INTO `student_group` VALUES ('Amalthea','amalthea@iitgn.ac.in'),('Annuity','annuity@iitgn.ac.in'),('Blithchron','blithchron@iitgn.ac.in'),('Digis','digis@iitgn.ac.in'),('Hallabol','hallabol@iitgn.ac.in'),('Mess ','mess@iitgn.ac.in'),('Metis','metis@iitgn.ac.in'),('Sargam','sargam@iitgn.ac.in'),('Vinteo','vinteo@iitgn.ac.in');
/*!40000 ALTER TABLE `student_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_group_member`
--

DROP TABLE IF EXISTS `student_group_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_group_member` (
  `student_id` int NOT NULL,
  `group_name` varchar(50) DEFAULT NULL,
  `position` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `fk_group_name` (`group_name`),
  CONSTRAINT `fk_group_name` FOREIGN KEY (`group_name`) REFERENCES `student_group` (`group_name`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_for_group_ID` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_group_member`
--

LOCK TABLES `student_group_member` WRITE;
/*!40000 ALTER TABLE `student_group_member` DISABLE KEYS */;
INSERT INTO `student_group_member` VALUES (19110001,'Digis','Secretary'),(19110002,'Amalthea','Coordinator'),(20110002,'Vinteo','Club Member'),(20110003,'Mess ','Secretary'),(20110004,'Annuity','Club Member'),(20110005,'Metis','Club Member'),(20110006,'Blithchron','Core'),(20110007,'Hallabol','Core'),(20110008,'Sargam','Secretary');
/*!40000 ALTER TABLE `student_group_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_lives`
--

DROP TABLE IF EXISTS `student_lives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_lives` (
  `student_id` int NOT NULL,
  `hostel_name` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `fk_hostel_name` (`hostel_name`),
  CONSTRAINT `fk_hostel_name` FOREIGN KEY (`hostel_name`) REFERENCES `hostel` (`hostel_name`) on delete cascade,
  CONSTRAINT `fk_stud_ID` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_lives`
--

LOCK TABLES `student_lives` WRITE;
/*!40000 ALTER TABLE `student_lives` DISABLE KEYS */;
INSERT INTO `student_lives` VALUES (19110001,'Aibaan'),(20110004,'Aibaan'),(19110002,'Beauki'),(20110005,'Beauki'),(19110003,'Chimair'),(20110006,'Chimair'),(19110004,'Duven'),(20110007,'Duven'),(19110005,'Emiet'),(20110008,'Emiet'),(19110006,'Firpeal'),(19110007,'Griwiksh'),(19110008,'Hiqom'),(20110001,'Ijokha'),(20110002,'Jurqia'),(20110003,'Kyzeel');
/*!40000 ALTER TABLE `student_lives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_phone_number`
--

DROP TABLE IF EXISTS `student_phone_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_phone_number` (
  `student_id` int NOT NULL,
  `phone_number` bigint NOT NULL,
  PRIMARY KEY (`student_id`,`phone_number`),
  CONSTRAINT `fk_phone_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) on delete cascade,
  CONSTRAINT `student_phone_number_10digits` CHECK (((`phone_number` >= 7000000000) and (`phone_number` <= 9999999999)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_phone_number`
--

LOCK TABLES `student_phone_number` WRITE;
/*!40000 ALTER TABLE `student_phone_number` DISABLE KEYS */;
INSERT INTO `student_phone_number` VALUES (19110001,8159769661),(19110001,8165028752),(19110001,8804152916),(19110001,9398906745),(19110002,9771208212),(19110003,8614080580),(19110004,8714478256),(19110005,7013566814),(19110006,7217678201),(19110006,8072074640),(19110006,8656756166),(19110007,7282866955),(19110007,9307025151),(19110007,9910043121),(19110008,8361396801),(19110008,8448612592),(19110008,9998259360),(20110001,7184552459),(20110001,8697935861),(20110002,7994029455),(20110002,9267706467),(20110003,7729657502),(20110003,9799284633),(20110004,8823848952),(20110005,8069179350),(20110006,7448870514),(20110007,9609678354),(20110008,9826695562);
/*!40000 ALTER TABLE `student_phone_number` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_works`
--

DROP TABLE IF EXISTS `student_works`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_works` (
  `student_id` int NOT NULL,
  `lab_name` varchar(50) NOT NULL,
  `position` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`student_id`,`lab_name`),
  KEY `fk_lab_for_student` (`lab_name`),
  CONSTRAINT `fk_lab_for_student` FOREIGN KEY (`lab_name`) REFERENCES `lab` (`lab_name`) on delete cascade,
  CONSTRAINT `fk_student_for_lab` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_works`
--

LOCK TABLES `student_works` WRITE;
/*!40000 ALTER TABLE `student_works` DISABLE KEYS */;
INSERT INTO `student_works` VALUES (19110006,'Brain & Informatics','Brain Guy'),(19110007,'Computer Vision Imaging and Graphics Lab','Artificial Intelligence '),(19110007,'Electrical Engineering Lab','Electrician'),(19110008,'Analog CKT Lab','Doot Dooter'),(19110008,'Material Characterization Lab','Materialistic Dude'),(20110001,'Design and Innovation Lab','Innovator'),(20110001,'Wet Chemistry Lab','Wetness Checker'),(20110002,'Experimental Complex Fluids Lab','Experimenter'),(20110003,'Computational Nanoelectronic Lab','Computer');
/*!40000 ALTER TABLE `student_works` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `view1`
--

DROP TABLE IF EXISTS `view1`;
/*!50001 DROP VIEW IF EXISTS `view1`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view1` AS SELECT 
 1 AS `student_id`,
 1 AS `first_name`,
 1 AS `council_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `view1`
--

/*!50001 DROP VIEW IF EXISTS `view1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view1` AS select `student`.`student_id` AS `student_id`,`student`.`first_name` AS `first_name`,`student_council_member`.`council_name` AS `council_name` from (`student` join `student_council_member`) where (`student`.`student_id` = `student_council_member`.`student_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

show tables;

select student.first_name, student.last_name, student_enrolled.program_name, student_enrolled.dept_name
FROM student
join student_enrolled
on student.student_id = student_enrolled.student_id;

select alumni.first_name, alumni.last_name, alumni_enrolled.program_name, alumni_enrolled.dept_name, alumni_enrolled.end_year
FROM alumni
join alumni_enrolled
on alumni.alumni_id = alumni_enrolled.alumni_id;

select council_advisor.council_name, student_council.email_id, faculty.first_name, faculty.last_name
from council_advisor
join faculty
on faculty.faculty_id = council_advisor.faculty_id
join student_council
on student_council.council_name = council_advisor.council_name;


select student.first_name, student.last_name, student_council_member.position, student_enrolled.program_name, student_enrolled.dept_name
from student
join student_council_member
on student.student_id = student_council_member.student_id
join student_enrolled
on student.student_id = student_enrolled.student_id
where student_council_member.council_name = "Welfare Council";

select group_part_of.group_name, student_group.email_id, group_part_of.council_name
from group_part_of
join student_group
on student_group.group_name = group_part_of.group_name;


select student.first_name, student.last_name, student_group_member.position, student_enrolled.program_name, student_enrolled.dept_name
from student
join student_group_member
on student.student_id = student_group_member.student_id
join student_enrolled
on student.student_id = student_enrolled.student_id
where student_group_member.group_name = "Vinteo";

select service.service_name, service.email_id, service_office.block_no, service_office.room_no, office.office_phone_number, faculty.first_name, faculty.last_name, faculty_head_service.designation
from faculty_head_service
join service
on service.service_name = faculty_head_service.service_name
join faculty
on faculty_head_service.faculty_id = faculty.faculty_id
join service_office
on service_office.service_name = service.service_name
join office
on service_office.block_no = office.block_no and service_office.room_no = office.room_no;

select staff.first_name, staff.last_name, service_staff.roles
from staff
join service_staff
on staff.staff_id = service_staff.staff_id
where service_staff.service_name = "Student Affairs";

select centre.centre_name, centre.email_id, centre_office.block_no, centre_office.room_no, office.office_phone_number, faculty.first_name, faculty.last_name, faculty_head_centre.designation
from faculty_head_centre
join centre
on centre.centre_name = faculty_head_centre.centre_name
join faculty
on faculty_head_centre.faculty_id = faculty.faculty_id
join centre_office
on centre_office.centre_name = centre.centre_name
join office
on centre_office.block_no = office.block_no and centre_office.room_no = office.room_no;

select staff.first_name, staff.last_name, centre_staff.roles
from staff
join centre_staff
on staff.staff_id = centre_staff.staff_id
where centre_staff.centre_name = "CCL";

select lab.lab_name, lab.email_id, lab_dept.dept_name, lab_office.block_no, lab_office.room_no, office.office_phone_number
from lab_dept
join lab
on lab.lab_name = lab_dept.lab_name
join lab_office
on lab_office.lab_name = lab.lab_name
join office
on lab_office.block_no = office.block_no and lab_office.room_no = office.room_no;

select staff.first_name, staff.last_name, lab_staff.roles
from staff
join lab_staff
on staff.staff_id = lab_staff.staff_id
where lab_staff.lab_name = "Design and Innovation Lab";

SELECT faculty.first_name, faculty.last_name, faculty_dept.dept_name, faculty_dept.designation, faculty_office.block_no, faculty_office.room_no, office.office_phone_number 
FROM faculty 
join faculty_dept
on faculty.faculty_id = faculty_dept.faculty_id
join faculty_office
on faculty.faculty_id = faculty_office.faculty_id
join office
on faculty_office.block_no = office.block_no and faculty_office.room_no = office.room_no;

select * from faculty_head_lab;

select student.first_name, student.last_name, student.email_id, group_concat(student_phone_number.phone_number separator '\n') as phone_numbers
from student
join student_phone_number
on student.student_id = student_phone_number.student_id
where student.student_id = '19110001';

select faculty.first_name, faculty.last_name, faculty.email_id, faculty_phone_number.phone_number
from faculty
join faculty_phone_number
on faculty.faculty_id = faculty_phone_number.faculty_id
where faculty.faculty_id = '19110001';

select alumni.first_name, alumni.last_name, alumni.email_id, alumni_phone_number.phone_number
from alumni
join alumni_phone_number
on alumni.alumni_id = alumni_phone_number.alumni_id
where alumni.alumni_id = '19110001';
select * from student;








-- Dump completed on 2023-03-19 21:29:57
