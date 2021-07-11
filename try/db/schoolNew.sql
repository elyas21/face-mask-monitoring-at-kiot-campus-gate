-- MySQL dump 10.13  Distrib 5.7.33, for Linux (x86_64)
--
-- Host: localhost    Database: schoolNew
-- ------------------------------------------------------
-- Server version	5.7.33-0ubuntu0.18.04.1

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
-- Table structure for table `Address`
--

DROP TABLE IF EXISTS `Address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `softDelete` tinyint(1) DEFAULT '0',
  `region` varchar(255) DEFAULT NULL,
  `zone` varchar(255) DEFAULT NULL,
  `kifleKetema` varchar(255) DEFAULT NULL,
  `wereda` varchar(255) DEFAULT NULL,
  `kebele` int(2) unsigned DEFAULT NULL,
  `houseNo` int(5) unsigned DEFAULT NULL,
  `phoneNo` int(15) unsigned DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `poBox` varchar(255) DEFAULT NULL,
  `emergencyContactName` varchar(50) DEFAULT NULL,
  `emPhoneNoe` int(15) unsigned DEFAULT NULL,
  `homephno` int(12) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Address`
--

LOCK TABLES `Address` WRITE;
/*!40000 ALTER TABLE `Address` DISABLE KEYS */;
/*!40000 ALTER TABLE `Address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Admin`
--

DROP TABLE IF EXISTS `Admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Admin` (
  `adminId` varchar(20) NOT NULL,
  `adminName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`adminId`),
  UNIQUE KEY `adminId` (`adminId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admin`
--

LOCK TABLES `Admin` WRITE;
/*!40000 ALTER TABLE `Admin` DISABLE KEYS */;
INSERT INTO `Admin` VALUES ('admin','adminEla');
/*!40000 ALTER TABLE `Admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Attendance`
--

DROP TABLE IF EXISTS `Attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Attendance` (
  `1` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `2` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `3` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `4` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `5` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `6` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `7` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `8` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `9` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `10` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `11` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `12` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `13` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `14` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `15` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `16` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `17` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `18` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `19` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `20` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `21` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `22` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `23` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `24` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `25` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `26` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `27` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `28` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `29` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `30` enum('A','S','H','W','P','F','L') DEFAULT 'P',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `softDelete` tinyint(1) DEFAULT '0',
  `date` datetime DEFAULT '2021-03-06 07:30:34',
  `month` enum('1','2','3','4','5','6','7','8','9','10','11','12') DEFAULT NULL,
  `monthStart` enum('1','2','3','4','5','6','7') DEFAULT NULL,
  `student` varchar(30) DEFAULT NULL,
  `section` int(11) DEFAULT NULL,
  `classYear` int(11) DEFAULT NULL,
  `school` varchar(20) DEFAULT NULL,
  `teacher` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student` (`student`),
  KEY `section` (`section`),
  KEY `classYear` (`classYear`),
  KEY `school` (`school`),
  KEY `teacher` (`teacher`),
  CONSTRAINT `Attendance_ibfk_1` FOREIGN KEY (`student`) REFERENCES `Student` (`studentId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Attendance_ibfk_2` FOREIGN KEY (`section`) REFERENCES `Section` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Attendance_ibfk_3` FOREIGN KEY (`classYear`) REFERENCES `ClassYearMap` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Attendance_ibfk_4` FOREIGN KEY (`school`) REFERENCES `School` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Attendance_ibfk_5` FOREIGN KEY (`teacher`) REFERENCES `Teacher` (`teacherId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Attendance`
--

LOCK TABLES `Attendance` WRITE;
/*!40000 ALTER TABLE `Attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `Attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ClassYearMap`
--

DROP TABLE IF EXISTS `ClassYearMap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ClassYearMap` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` int(5) unsigned NOT NULL,
  `start` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `isClosed` tinyint(1) DEFAULT '1',
  `semisterType` int(1) unsigned DEFAULT '2',
  `softDelete` tinyint(1) DEFAULT '0',
  `school` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ClassYearMap`
--

LOCK TABLES `ClassYearMap` WRITE;
/*!40000 ALTER TABLE `ClassYearMap` DISABLE KEYS */;
INSERT INTO `ClassYearMap` VALUES (1,2011,NULL,NULL,1,2,0,'school-0'),(2,2012,NULL,NULL,1,2,0,'school-0'),(3,2013,NULL,NULL,1,2,0,'school-0'),(4,2014,NULL,NULL,1,2,0,'school-0'),(5,2015,NULL,NULL,1,2,0,'school-0');
/*!40000 ALTER TABLE `ClassYearMap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Course`
--

DROP TABLE IF EXISTS `Course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Course` (
  `courseId` varchar(20) NOT NULL,
  `school` varchar(255) DEFAULT NULL,
  `courseName` varchar(255) DEFAULT NULL,
  `softDelete` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`courseId`),
  UNIQUE KEY `courseId` (`courseId`),
  KEY `school` (`school`),
  CONSTRAINT `Course_ibfk_1` FOREIGN KEY (`school`) REFERENCES `School` (`schoolId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Course`
--

LOCK TABLES `Course` WRITE;
/*!40000 ALTER TABLE `Course` DISABLE KEYS */;
INSERT INTO `Course` VALUES ('amh-grade-1','school-0',NULL,0),('amh-grade-2','school-0',NULL,0),('amh-grade-3','school-0',NULL,0),('amh-grade-4','school-0',NULL,0),('amh-grade-5','school-0',NULL,0),('amh-grade-6','school-0',NULL,0),('amh-kg-1','school-0',NULL,0),('amh-kg-2','school-0',NULL,0),('amh-kg-3','school-0',NULL,0),('eng-grade-1','school-0',NULL,0),('eng-grade-2','school-0',NULL,0),('eng-grade-3','school-0',NULL,0),('eng-grade-4','school-0',NULL,0),('eng-grade-5','school-0',NULL,0),('eng-grade-6','school-0',NULL,0),('eng-kg-1','school-0',NULL,0),('eng-kg-2','school-0',NULL,0),('eng-kg-3','school-0',NULL,0),('history-grade-1','school-0',NULL,0),('history-grade-2','school-0',NULL,0),('history-grade-3','school-0',NULL,0),('history-grade-4','school-0',NULL,0),('history-grade-5','school-0',NULL,0),('history-grade-6','school-0',NULL,0),('history-kg-1','school-0',NULL,0),('history-kg-2','school-0',NULL,0),('history-kg-3','school-0',NULL,0),('mat-grade-1','school-0',NULL,0),('mat-grade-2','school-0',NULL,0),('mat-grade-3','school-0',NULL,0),('mat-grade-4','school-0',NULL,0),('mat-grade-5','school-0',NULL,0),('mat-grade-6','school-0',NULL,0),('mat-kg-1','school-0',NULL,0),('mat-kg-2','school-0',NULL,0),('mat-kg-3','school-0',NULL,0),('science-grade-1','school-0',NULL,0),('science-grade-2','school-0',NULL,0),('science-grade-3','school-0',NULL,0),('science-grade-4','school-0',NULL,0),('science-grade-5','school-0',NULL,0),('science-grade-6','school-0',NULL,0),('science-kg-1','school-0',NULL,0),('science-kg-2','school-0',NULL,0),('science-kg-3','school-0',NULL,0);
/*!40000 ALTER TABLE `Course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CourseGradeing`
--

DROP TABLE IF EXISTS `CourseGradeing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CourseGradeing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `school` varchar(255) DEFAULT NULL,
  `assignment` int(5) unsigned DEFAULT '0',
  `term` int(1) unsigned DEFAULT '0',
  `midExam` int(5) unsigned DEFAULT '0',
  `finalExam` int(5) unsigned DEFAULT '0',
  `sttudentGrade` int(5) unsigned DEFAULT '0',
  `expectedGrade` int(5) unsigned DEFAULT NULL,
  `status` enum('opend','staged-h','approve-h','deny-h','approve-d','deny-d','approve-p','deny-p','closed') DEFAULT 'opend',
  `softDelete` tinyint(1) DEFAULT '0',
  `student` varchar(30) DEFAULT NULL,
  `classYear` int(11) DEFAULT NULL,
  `section` int(11) DEFAULT NULL,
  `course` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `school` (`school`),
  KEY `student` (`student`),
  KEY `classYear` (`classYear`),
  KEY `section` (`section`),
  KEY `course` (`course`),
  CONSTRAINT `CourseGradeing_ibfk_1` FOREIGN KEY (`school`) REFERENCES `School` (`schoolId`),
  CONSTRAINT `CourseGradeing_ibfk_2` FOREIGN KEY (`student`) REFERENCES `Student` (`studentId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `CourseGradeing_ibfk_3` FOREIGN KEY (`classYear`) REFERENCES `ClassYearMap` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `CourseGradeing_ibfk_4` FOREIGN KEY (`section`) REFERENCES `Section` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `CourseGradeing_ibfk_5` FOREIGN KEY (`course`) REFERENCES `Course` (`courseId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CourseGradeing`
--

LOCK TABLES `CourseGradeing` WRITE;
/*!40000 ALTER TABLE `CourseGradeing` DISABLE KEYS */;
/*!40000 ALTER TABLE `CourseGradeing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Director`
--

DROP TABLE IF EXISTS `Director`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Director` (
  `directorId` varchar(20) NOT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `middleName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `softDelete` tinyint(1) DEFAULT '0',
  `school` varchar(20) DEFAULT NULL,
  `address` int(11) DEFAULT NULL,
  PRIMARY KEY (`directorId`),
  UNIQUE KEY `directorId` (`directorId`),
  KEY `address` (`address`),
  CONSTRAINT `Director_ibfk_1` FOREIGN KEY (`address`) REFERENCES `Address` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Director`
--

LOCK TABLES `Director` WRITE;
/*!40000 ALTER TABLE `Director` DISABLE KEYS */;
INSERT INTO `Director` VALUES ('director-0',NULL,NULL,NULL,0,'school-0',NULL),('director-1',NULL,NULL,NULL,0,'school-1',NULL),('director-2',NULL,NULL,NULL,0,'school-2',NULL),('director-3',NULL,NULL,NULL,1,'school-3',NULL),('director-4',NULL,NULL,NULL,0,'school-4',NULL);
/*!40000 ALTER TABLE `Director` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Finace`
--

DROP TABLE IF EXISTS `Finace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Finace` (
  `finaceId` varchar(20) NOT NULL,
  `finaceName` varchar(255) DEFAULT NULL,
  `softDelete` tinyint(1) DEFAULT '0',
  `school` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`finaceId`),
  UNIQUE KEY `finaceId` (`finaceId`),
  KEY `school` (`school`),
  CONSTRAINT `Finace_ibfk_1` FOREIGN KEY (`school`) REFERENCES `School` (`schoolId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Finace`
--

LOCK TABLES `Finace` WRITE;
/*!40000 ALTER TABLE `Finace` DISABLE KEYS */;
INSERT INTO `Finace` VALUES ('finace-0',NULL,0,NULL);
/*!40000 ALTER TABLE `Finace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Grade`
--

DROP TABLE IF EXISTS `Grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Grade` (
  `id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `gradeId` varchar(20) NOT NULL,
  `grade` int(2) DEFAULT NULL,
  `gradeName` varchar(255) DEFAULT NULL,
  `softDelete` tinyint(1) DEFAULT '0',
  `school` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`gradeId`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `gradeId` (`gradeId`),
  KEY `school` (`school`),
  CONSTRAINT `Grade_ibfk_1` FOREIGN KEY (`school`) REFERENCES `School` (`schoolId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Grade`
--

LOCK TABLES `Grade` WRITE;
/*!40000 ALTER TABLE `Grade` DISABLE KEYS */;
INSERT INTO `Grade` VALUES (7,'G-1',1,'grade-1',0,'school-0'),(3,'G-2',2,'grade-2',0,'school-0'),(4,'G-3',3,'grade-3',0,'school-0'),(5,'G-4',4,'grade-4',0,'school-0'),(8,'G-5',5,'grade-5',0,'school-0'),(9,'G-6',6,'grade-6',0,'school-0'),(1,'G-kg-1',-2,'kg-1',0,'school-0'),(2,'G-kg-2',-1,'kg-2',0,'school-0'),(6,'G-kg-3',0,'kg-3',0,'school-0');
/*!40000 ALTER TABLE `Grade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GradeMap`
--

DROP TABLE IF EXISTS `GradeMap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GradeMap` (
  `2012` enum('G-1','G-2','G-3','G-4','G-5','G-6','G-7','G-8','G-9','G-10','G-11','G-12','G-kg-1','G-kg-2','G-kg-3') DEFAULT NULL,
  `2013` enum('G-1','G-2','G-3','G-4','G-5','G-6','G-7','G-8','G-9','G-10','G-11','G-12','G-kg-1','G-kg-2','G-kg-3') DEFAULT NULL,
  `2014` enum('G-1','G-2','G-3','G-4','G-5','G-6','G-7','G-8','G-9','G-10','G-11','G-12','G-kg-1','G-kg-2','G-kg-3') DEFAULT NULL,
  `2015` enum('G-1','G-2','G-3','G-4','G-5','G-6','G-7','G-8','G-9','G-10','G-11','G-12','G-kg-1','G-kg-2','G-kg-3') DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `softDelete` tinyint(1) DEFAULT '0',
  `school` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `school` (`school`),
  CONSTRAINT `GradeMap_ibfk_1` FOREIGN KEY (`school`) REFERENCES `School` (`schoolId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GradeMap`
--

LOCK TABLES `GradeMap` WRITE;
/*!40000 ALTER TABLE `GradeMap` DISABLE KEYS */;
/*!40000 ALTER TABLE `GradeMap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Parent`
--

DROP TABLE IF EXISTS `Parent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Parent` (
  `parentId` varchar(20) NOT NULL,
  `parentName` varchar(255) DEFAULT NULL,
  `softDelete` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`parentId`),
  UNIQUE KEY `parentId` (`parentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Parent`
--

LOCK TABLES `Parent` WRITE;
/*!40000 ALTER TABLE `Parent` DISABLE KEYS */;
/*!40000 ALTER TABLE `Parent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Payment`
--

DROP TABLE IF EXISTS `Payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Payment` (
  `paymentId` varchar(20) NOT NULL,
  `term1` int(8) unsigned DEFAULT NULL,
  `term2` int(8) unsigned DEFAULT NULL,
  `term3` int(8) unsigned DEFAULT NULL,
  `term4` int(8) unsigned DEFAULT NULL,
  `term5` int(8) unsigned DEFAULT NULL,
  `term6` int(8) unsigned DEFAULT NULL,
  `term7` int(8) unsigned DEFAULT NULL,
  `term8` int(8) unsigned DEFAULT NULL,
  `term9` int(8) unsigned DEFAULT NULL,
  `term10` int(8) unsigned DEFAULT NULL,
  `classYear` int(11) DEFAULT NULL,
  `school` varchar(20) DEFAULT NULL,
  `student` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`paymentId`),
  UNIQUE KEY `paymentId` (`paymentId`),
  KEY `classYear` (`classYear`),
  KEY `school` (`school`),
  KEY `student` (`student`),
  CONSTRAINT `Payment_ibfk_1` FOREIGN KEY (`classYear`) REFERENCES `ClassYearMap` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Payment_ibfk_2` FOREIGN KEY (`school`) REFERENCES `School` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Payment_ibfk_3` FOREIGN KEY (`student`) REFERENCES `Student` (`studentId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Payment`
--

LOCK TABLES `Payment` WRITE;
/*!40000 ALTER TABLE `Payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `Payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Registra`
--

DROP TABLE IF EXISTS `Registra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Registra` (
  `registraId` varchar(20) NOT NULL,
  `registraName` varchar(255) DEFAULT NULL,
  `softDelete` tinyint(1) DEFAULT '0',
  `school` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`registraId`),
  UNIQUE KEY `registraId` (`registraId`),
  KEY `school` (`school`),
  CONSTRAINT `Registra_ibfk_1` FOREIGN KEY (`school`) REFERENCES `School` (`schoolId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Registra`
--

LOCK TABLES `Registra` WRITE;
/*!40000 ALTER TABLE `Registra` DISABLE KEYS */;
INSERT INTO `Registra` VALUES ('registra-0','registra-0',0,'school-0');
/*!40000 ALTER TABLE `Registra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `School`
--

DROP TABLE IF EXISTS `School`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `School` (
  `schoolId` varchar(20) NOT NULL,
  `schoolName` varchar(255) DEFAULT NULL,
  `softDelete` tinyint(1) DEFAULT '0',
  `DirectorId` varchar(20) DEFAULT NULL,
  `lastClassYear` int(11) DEFAULT NULL,
  `currentClassYear` int(11) DEFAULT NULL,
  `address` int(11) DEFAULT NULL,
  PRIMARY KEY (`schoolId`),
  UNIQUE KEY `schoolId` (`schoolId`),
  KEY `DirectorId` (`DirectorId`),
  KEY `lastClassYear` (`lastClassYear`),
  KEY `currentClassYear` (`currentClassYear`),
  KEY `address` (`address`),
  CONSTRAINT `School_ibfk_1` FOREIGN KEY (`DirectorId`) REFERENCES `Director` (`directorId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `School_ibfk_2` FOREIGN KEY (`lastClassYear`) REFERENCES `ClassYearMap` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `School_ibfk_3` FOREIGN KEY (`currentClassYear`) REFERENCES `ClassYearMap` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `School_ibfk_4` FOREIGN KEY (`address`) REFERENCES `Address` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `School`
--

LOCK TABLES `School` WRITE;
/*!40000 ALTER TABLE `School` DISABLE KEYS */;
INSERT INTO `School` VALUES ('school-0','SCHOOL-0',0,NULL,NULL,NULL,NULL),('school-1','SCHOOL-1',0,NULL,NULL,NULL,NULL),('school-2','SCHOOL-2',0,NULL,NULL,NULL,NULL),('school-3','SCHOOL-3',0,NULL,NULL,NULL,NULL),('school-4','SCHOOL-4',0,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `School` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Section`
--

DROP TABLE IF EXISTS `Section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Section` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` varchar(20) NOT NULL,
  `sectionName` varchar(255) DEFAULT NULL,
  `noOfStudents` int(3) unsigned DEFAULT '0',
  `noOfMaleStudents` int(3) unsigned DEFAULT '0',
  `noOfFemaleStudents` int(3) unsigned DEFAULT '0',
  `gradeNo` int(2) DEFAULT NULL,
  `softDelete` tinyint(1) DEFAULT '0',
  `homeroomTeacher` varchar(20) DEFAULT NULL,
  `school` varchar(20) DEFAULT NULL,
  `grade` varchar(20) DEFAULT NULL,
  `classYear` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sectionId` (`sectionId`),
  KEY `homeroomTeacher` (`homeroomTeacher`),
  KEY `school` (`school`),
  KEY `grade` (`grade`),
  KEY `classYear` (`classYear`),
  CONSTRAINT `Section_ibfk_1` FOREIGN KEY (`homeroomTeacher`) REFERENCES `Teacher` (`teacherId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Section_ibfk_2` FOREIGN KEY (`school`) REFERENCES `School` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Section_ibfk_3` FOREIGN KEY (`grade`) REFERENCES `Grade` (`gradeId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Section_ibfk_4` FOREIGN KEY (`classYear`) REFERENCES `ClassYearMap` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Section`
--

LOCK TABLES `Section` WRITE;
/*!40000 ALTER TABLE `Section` DISABLE KEYS */;
INSERT INTO `Section` VALUES (1,'sec-0-1-a','grade 1 A',0,0,0,2,0,NULL,'school-0','G-2',1),(2,'sec-0-1-b','grade 1 b',0,0,0,2,0,NULL,'school-0','G-1',1),(3,'sec-0-2-a','grade 2 A',0,0,0,2,0,NULL,'school-0','G-2',2),(4,'sec-0-3-a','grade 3 A',0,0,0,3,0,NULL,'school-0','G-3',2),(5,'sec-0-3-b','grade 3 B',0,0,0,3,0,NULL,'school-0','G-3',1),(6,'sec-0-4-a','grade 4 A',0,0,0,4,0,NULL,'school-0','G-4',2),(7,'sec-0-4-b','grade 4 b',0,0,0,4,0,NULL,'school-0','G-4',2),(8,'sec-0-1a','grade 1 A',0,0,0,1,0,NULL,'school-0','G-1',1),(9,'section-5-A','section-5-A',0,0,0,5,0,NULL,'school-0',NULL,NULL);
/*!40000 ALTER TABLE `Section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SectionMap`
--

DROP TABLE IF EXISTS `SectionMap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SectionMap` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `softDelete` tinyint(1) DEFAULT '0',
  `school` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `school` (`school`),
  CONSTRAINT `SectionMap_ibfk_1` FOREIGN KEY (`school`) REFERENCES `School` (`schoolId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SectionMap`
--

LOCK TABLES `SectionMap` WRITE;
/*!40000 ALTER TABLE `SectionMap` DISABLE KEYS */;
/*!40000 ALTER TABLE `SectionMap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SemisterMap`
--

DROP TABLE IF EXISTS `SemisterMap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SemisterMap` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `semisterStart` date DEFAULT NULL,
  `semisterClassEnd` date DEFAULT NULL,
  `semisterEnd` date DEFAULT NULL,
  `isClosed` tinyint(1) DEFAULT '1',
  `softDelete` tinyint(1) DEFAULT '0',
  `school` varchar(20) DEFAULT NULL,
  `semisterClassYear` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `school` (`school`),
  KEY `semisterClassYear` (`semisterClassYear`),
  CONSTRAINT `SemisterMap_ibfk_1` FOREIGN KEY (`school`) REFERENCES `School` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `SemisterMap_ibfk_2` FOREIGN KEY (`semisterClassYear`) REFERENCES `ClassYearMap` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SemisterMap`
--

LOCK TABLES `SemisterMap` WRITE;
/*!40000 ALTER TABLE `SemisterMap` DISABLE KEYS */;
INSERT INTO `SemisterMap` VALUES (1,'1',NULL,NULL,NULL,1,0,NULL,NULL),(2,'2',NULL,NULL,NULL,1,0,NULL,NULL),(3,'1',NULL,NULL,NULL,1,0,NULL,NULL),(4,'2',NULL,NULL,NULL,1,0,NULL,NULL),(5,'2',NULL,NULL,NULL,1,0,NULL,NULL),(6,'1',NULL,NULL,NULL,1,0,NULL,NULL),(7,'1',NULL,NULL,NULL,1,0,NULL,NULL),(8,'2',NULL,NULL,NULL,1,0,NULL,NULL),(9,'1',NULL,NULL,NULL,1,0,NULL,NULL),(10,'2',NULL,NULL,NULL,1,0,NULL,NULL);
/*!40000 ALTER TABLE `SemisterMap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student`
--

DROP TABLE IF EXISTS `Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Student` (
  `id` int(15) unsigned NOT NULL AUTO_INCREMENT,
  `studentId` varchar(30) NOT NULL,
  `firstName` varchar(20) DEFAULT NULL,
  `middleName` varchar(20) DEFAULT NULL,
  `lastName` varchar(20) DEFAULT NULL,
  `currentGrade` int(2) DEFAULT NULL,
  `lastGrade` int(2) DEFAULT NULL,
  `sex` enum('male','female') DEFAULT NULL,
  `studentName` varchar(255) DEFAULT NULL,
  `regCandidate` tinyint(1) DEFAULT '1',
  `softDelete` tinyint(1) DEFAULT '0',
  `school` varchar(20) DEFAULT NULL,
  `currentSection` int(11) DEFAULT NULL,
  `classYear` int(11) DEFAULT NULL,
  `gradeMap` int(11) DEFAULT NULL,
  `paymentInfo` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`studentId`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `studentId` (`studentId`),
  KEY `school` (`school`),
  KEY `currentSection` (`currentSection`),
  KEY `classYear` (`classYear`),
  KEY `gradeMap` (`gradeMap`),
  CONSTRAINT `Student_ibfk_1` FOREIGN KEY (`school`) REFERENCES `School` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Student_ibfk_2` FOREIGN KEY (`currentSection`) REFERENCES `Section` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Student_ibfk_3` FOREIGN KEY (`classYear`) REFERENCES `ClassYearMap` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Student_ibfk_4` FOREIGN KEY (`gradeMap`) REFERENCES `GradeMap` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student`
--

LOCK TABLES `Student` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Student` VALUES (5,'sstu-100','First','Middle','last',4,4,'male',NULL,1,0,'school-0',NULL,NULL,NULL,NULL),(7,'sstu-101','First','Middle','last',4,4,'male',NULL,1,0,'school-0',NULL,NULL,NULL,NULL),(9,'sstu-102','First','Middle','last',4,4,'male',NULL,1,0,'school-0',NULL,NULL,NULL,NULL),(8,'sstu-103','First','Middle','last',4,4,'male',NULL,1,0,'school-0',NULL,NULL,NULL,NULL),(10,'sstu-104','First','Middle','last',4,4,'male',NULL,1,0,'school-0',NULL,NULL,NULL,NULL),(11,'sstu-105','First','Middle','last',4,4,'male',NULL,1,0,'school-0',NULL,NULL,NULL,NULL),(12,'sstu-106','First','Middle','last',4,4,'female',NULL,1,0,'school-0',NULL,NULL,NULL,NULL),(16,'sstu-107','First','Middle','last',4,4,'female',NULL,1,0,'school-0',NULL,NULL,NULL,NULL),(15,'sstu-108','First','Middle','last',4,4,'female',NULL,1,0,'school-0',NULL,NULL,NULL,NULL),(14,'sstu-109','First','Middle','last',4,4,'female',NULL,1,0,'school-0',NULL,NULL,NULL,NULL),(13,'sstu-110','First','Middle','last',4,4,'female',NULL,1,0,'school-0',NULL,NULL,NULL,NULL),(17,'sstu-112','First','Middle','last',4,4,'female',NULL,1,0,'school-0',NULL,NULL,NULL,NULL),(20,'sstu-113','First','Middle','last',4,4,'female',NULL,1,0,'school-0',NULL,NULL,NULL,NULL),(19,'sstu-114','First','Middle','last',4,4,'female',NULL,1,0,'school-0',NULL,NULL,NULL,NULL),(18,'sstu-115','First','Middle','last',4,4,'female',NULL,1,0,'school-0',NULL,NULL,NULL,NULL),(1,'stu-00',NULL,NULL,NULL,4,4,NULL,'stu-ela-0',1,0,'school-0',NULL,NULL,NULL,NULL),(2,'stu-01',NULL,NULL,NULL,4,4,NULL,'stu-ela-1',1,0,'school-0',NULL,NULL,NULL,NULL),(4,'stu-02',NULL,NULL,NULL,4,4,NULL,'stu-ela-2',1,0,'school-0',NULL,NULL,NULL,NULL),(3,'stu-03',NULL,NULL,NULL,4,4,NULL,'stu-ela-3',1,0,'school-0',NULL,NULL,NULL,NULL),(6,'stu-04',NULL,NULL,NULL,4,4,NULL,'stu-ela-4',1,0,'school-0',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TCS`
--

DROP TABLE IF EXISTS `TCS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TCS` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `school` varchar(255) DEFAULT NULL,
  `softDelete` tinyint(1) DEFAULT '0',
  `teacher` varchar(20) DEFAULT NULL,
  `section` int(11) DEFAULT NULL,
  `course` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `school` (`school`),
  KEY `teacher` (`teacher`),
  KEY `section` (`section`),
  KEY `course` (`course`),
  CONSTRAINT `TCS_ibfk_1` FOREIGN KEY (`school`) REFERENCES `School` (`schoolId`),
  CONSTRAINT `TCS_ibfk_2` FOREIGN KEY (`teacher`) REFERENCES `Teacher` (`teacherId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `TCS_ibfk_3` FOREIGN KEY (`section`) REFERENCES `Section` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `TCS_ibfk_4` FOREIGN KEY (`course`) REFERENCES `Course` (`courseId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TCS`
--

LOCK TABLES `TCS` WRITE;
/*!40000 ALTER TABLE `TCS` DISABLE KEYS */;
INSERT INTO `TCS` VALUES (1,'school-0',0,NULL,1,'amh-grade-2'),(2,'school-0',0,NULL,2,'amh-grade-2'),(3,'school-0',0,NULL,7,'amh-grade-4'),(4,'school-0',0,NULL,4,'amh-grade-3'),(5,'school-0',0,'lec-amh',5,'amh-grade-3'),(6,'school-0',0,NULL,6,'amh-grade-4'),(7,'school-0',0,NULL,3,'amh-grade-2'),(8,'school-0',0,NULL,1,'eng-grade-2'),(9,'school-0',0,NULL,2,'eng-grade-2'),(10,'school-0',0,NULL,7,'eng-grade-4'),(11,'school-0',0,NULL,8,'amh-grade-1'),(12,'school-0',0,NULL,4,'eng-grade-3'),(13,'school-0',0,NULL,3,'eng-grade-2'),(14,'school-0',0,NULL,5,'eng-grade-3'),(15,'school-0',0,NULL,6,'eng-grade-4'),(16,'school-0',0,NULL,1,'history-grade-2'),(17,'school-0',0,NULL,7,'history-grade-4'),(18,'school-0',0,NULL,2,'history-grade-2'),(19,'school-0',0,NULL,8,'eng-grade-1'),(20,'school-0',0,NULL,4,'history-grade-3'),(21,'school-0',0,NULL,3,'history-grade-2'),(22,'school-0',0,NULL,1,'mat-grade-2'),(23,'school-0',0,NULL,7,'mat-grade-4'),(24,'school-0',0,NULL,6,'history-grade-4'),(25,'school-0',0,NULL,5,'history-grade-3'),(26,'school-0',0,NULL,2,'mat-grade-2'),(27,'school-0',0,NULL,3,'mat-grade-2'),(28,'school-0',0,NULL,1,'science-grade-2'),(29,'school-0',0,NULL,4,'mat-grade-3'),(30,'school-0',0,NULL,8,'history-grade-1'),(31,'school-0',0,NULL,7,'science-grade-4'),(32,'school-0',0,NULL,6,'mat-grade-4'),(33,'school-0',0,NULL,5,'mat-grade-3'),(34,'school-0',0,NULL,2,'science-grade-2'),(35,'school-0',0,NULL,3,'science-grade-2'),(36,'school-0',0,NULL,4,'science-grade-3'),(37,'school-0',0,NULL,6,'science-grade-4'),(38,'school-0',0,NULL,8,'mat-grade-1'),(39,'school-0',0,NULL,5,'science-grade-3'),(40,'school-0',0,NULL,8,'science-grade-1'),(41,'school-0',0,'lec-amh',9,'amh-grade-5'),(42,'school-0',0,'lec-eng',9,'eng-grade-5'),(43,'school-0',0,NULL,9,'history-grade-5'),(44,'school-0',0,NULL,9,'mat-grade-5'),(45,'school-0',0,NULL,9,'science-grade-5');
/*!40000 ALTER TABLE `TCS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Teacher`
--

DROP TABLE IF EXISTS `Teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Teacher` (
  `teacherId` varchar(20) NOT NULL,
  `teacherName` varchar(255) DEFAULT NULL,
  `softDelete` tinyint(1) DEFAULT '0',
  `school` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`teacherId`),
  UNIQUE KEY `teacherId` (`teacherId`),
  KEY `school` (`school`),
  CONSTRAINT `Teacher_ibfk_1` FOREIGN KEY (`school`) REFERENCES `School` (`schoolId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Teacher`
--

LOCK TABLES `Teacher` WRITE;
/*!40000 ALTER TABLE `Teacher` DISABLE KEYS */;
INSERT INTO `Teacher` VALUES ('amh-00','amh-00',0,'school-0'),('lec-amh','lec-amh',0,'school-0'),('lec-eng','lec-eng',0,'school-0'),('lec-mat','lec-mat',0,'school-0');
/*!40000 ALTER TABLE `Teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `userId` varchar(10) NOT NULL,
  `role` enum('finace','admin','director','registra','lecture','student','parent') DEFAULT NULL,
  `openPassword` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `softDelete` tinyint(1) DEFAULT '0',
  `school` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `userId` (`userId`),
  KEY `school` (`school`),
  CONSTRAINT `User_ibfk_1` FOREIGN KEY (`school`) REFERENCES `School` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES ('admin','admin',NULL,'$2a$08$JzeT85KbgFq7F31Q9Dv2xOrU2hA2b6UFYLsSJpWRn9Wav3IO7JnX2',0,NULL),('amh-00','lecture',NULL,'$2a$08$qaUpC8.yi/omxYHz42WnEud2oRjMI5oH3cT00wJk7po2vrK6RirD.',0,'school-0'),('director-0','director',NULL,'$2a$08$vfvil5eQPxPZawDRYdzAHuZTS8fIxpMg9EN6qdBJo0pHjY.4tWS7u',0,'school-0'),('director-1','director',NULL,'$2a$08$LILSaua3VeUr0cZt5YWGBujz/2lZUhZsZiFCcOlmKsCLi1LRLCNiy',0,'school-1'),('director-2','director',NULL,'$2a$08$rb2ZJNvDuMy.c.hc6E71Nez74bzb8pKDiIi0BhcOwNQDHg61wpp3y',0,'school-2'),('director-3','director',NULL,'$2a$08$t9Xm0Kx/rvaGzZ/nwuf7KO3/Pfu3BbTboIqA/vu0kyRdyrtD0uLYy',0,'school-3'),('director-4','director',NULL,'$2a$08$TTO30danH6eQuc..Vu6dsOcnicicBRMv/VhWParnJd6fHUZnEqPBW',0,'school-4'),('finace-0','finace',NULL,'$2a$08$y42qB0A40Yy6Y9A6alVNCuVDxNV7EuIqnmXFW9lMWQ/Itk9g7ZeTm',0,NULL),('lec-amh','lecture',NULL,'lec-amh',0,'school-0'),('lec-eng','lecture',NULL,'lec-eng',0,'school-0'),('lec-mat','lecture',NULL,'lec-mat',0,'school-0'),('registra-0','registra',NULL,'$2a$08$LMDG8XSO7ITB2fodx2ZFtuRLBGjMOyrkuaAznaWrAMlZl3npMBLL2',0,'school-0'),('sstu-100','student','sstu-100','$2a$08$YNzr3gB46Yfba9Tmx7smx.lFrMta6okKFFBwoVvj9E6YHnKvugph6',0,'school-0'),('sstu-101','student','sstu-101','$2a$08$x7kyfk1Rq4wKt/7fLh4jd.taKns9UqetZ6o8TfcNXfBlyUlFA4T5u',0,'school-0'),('sstu-102','student','sstu-102','$2a$08$d6HLETu4nMJk2G1CxNPh2eHdI8WHdj5OTUw/niO0QuhzkTi1UNO0a',0,'school-0'),('sstu-103','student','sstu-103','$2a$08$mTcRvlfvGF7CAUfq/pJFEukwEMcO77aEDG.DRlaxhpYwg7/mnE7Me',0,'school-0'),('sstu-104','student','sstu-104','$2a$08$br/2ZJJZq7xsDqkG2eJ1Luf/nlftP8qP7mywR2hvROB/Zm/0sUC1O',0,'school-0'),('sstu-105','student','sstu-105','$2a$08$Bk2ipVSEBdSGXY8YAPEk/OnS.4gkOhEb8UMe.QdYo.4GK5BTHPa9K',0,'school-0'),('sstu-106','student','sstu-106','$2a$08$VqjQT5SZ7uhGHMUNcNLXsunUz35dgwtLIaE6CE4GrN3hFz14S9yOe',0,'school-0'),('sstu-107','student','sstu-107','$2a$08$8UcKWBJCOeyTAAEi976MH.vrnZrLy9f0EUoRec4iRVnb9Xp5Kpcla',0,'school-0'),('sstu-108','student','sstu-108','$2a$08$1uRhb5TusUDghoa0DRJH1.qj873zjwn.e2Ccdu0TdXzn2jrk/mZl2',0,'school-0'),('sstu-109','student','sstu-109','$2a$08$fWey4FP84dEYSO/k/nc.z.kMps8ykgncPBg14GypAbTxWqmUpQNPK',0,'school-0'),('sstu-110','student','sstu-110','$2a$08$1Tgzj3jBdVe2MiWMCeiCYe0r61VF8dzdsDqTNdDTfjXw2tTsOjobK',0,'school-0'),('sstu-112','student','sstu-112','$2a$08$SLVezFSfsNIKgKNFj5taJuWtuE9xkH6r.WkIxS0xK2rqHMSkqHK9C',0,'school-0'),('sstu-113','student','sstu-113','$2a$08$WAA8EyGKIZOU2zo.T7GzMOwdooaikf4e90n9ObXGGRNUcm6v9YArq',0,'school-0'),('sstu-114','student','sstu-114','$2a$08$9zXD8G83rz/StYIsqvkVQO7bca4.8K7siSjLw5BSMmL5LxcR0jfom',0,'school-0'),('sstu-115','student','sstu-115','$2a$08$pnQiPSrF6E4dQAtIWR3vg.8nsg1KvQbgLn/qkhVVt1p.IBA5ag64a',0,'school-0'),('stu-00','student','stu-00','$2a$08$/gQfWc7xijzZ.RRIddfVMOK9d3/2QQ0JqXJVfnX5POGX3nA6XEF5i',0,'school-0'),('stu-01','student','stu-01','$2a$08$sEXnjTRLulnInT32elowuuvclyAre72mHWRYdKVOdSY4EY4/SPVAC',0,'school-0'),('stu-02','student','stu-02','$2a$08$uUbBNg6QqtxA1P95DsnVWuF1ibtjmaCVKUJMcDrUho.ec.vgxYed2',0,'school-0'),('stu-03','student','stu-03','$2a$08$4fjs3GTnyYYUckb8tYUt0Obh9O0N9va9jGKSmxKBmGBpwLRfutU7O',0,'school-0'),('stu-04','student','stu-04','$2a$08$dX5fjhSuAhItZ2VjHXnCOu6IQ5nmjjvHT3bTl8YaA493hrj4KNsFm',0,'school-0');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courseGrade`
--

DROP TABLE IF EXISTS `courseGrade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courseGrade` (
  `GradeGradeId` varchar(20) NOT NULL,
  `CourseCourseId` varchar(20) NOT NULL,
  PRIMARY KEY (`GradeGradeId`,`CourseCourseId`),
  KEY `CourseCourseId` (`CourseCourseId`),
  CONSTRAINT `courseGrade_ibfk_1` FOREIGN KEY (`GradeGradeId`) REFERENCES `Grade` (`gradeId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `courseGrade_ibfk_2` FOREIGN KEY (`CourseCourseId`) REFERENCES `Course` (`courseId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courseGrade`
--

LOCK TABLES `courseGrade` WRITE;
/*!40000 ALTER TABLE `courseGrade` DISABLE KEYS */;
INSERT INTO `courseGrade` VALUES ('G-1','amh-grade-1'),('G-2','amh-grade-2'),('G-3','amh-grade-3'),('G-4','amh-grade-4'),('G-5','amh-grade-5'),('G-6','amh-grade-6'),('G-kg-1','amh-kg-1'),('G-kg-2','amh-kg-2'),('G-kg-3','amh-kg-3'),('G-1','eng-grade-1'),('G-2','eng-grade-2'),('G-3','eng-grade-3'),('G-4','eng-grade-4'),('G-5','eng-grade-5'),('G-6','eng-grade-6'),('G-kg-1','eng-kg-1'),('G-kg-2','eng-kg-2'),('G-kg-3','eng-kg-3'),('G-1','history-grade-1'),('G-2','history-grade-2'),('G-3','history-grade-3'),('G-4','history-grade-4'),('G-5','history-grade-5'),('G-6','history-grade-6'),('G-kg-1','history-kg-1'),('G-kg-2','history-kg-2'),('G-kg-3','history-kg-3'),('G-1','mat-grade-1'),('G-2','mat-grade-2'),('G-3','mat-grade-3'),('G-4','mat-grade-4'),('G-5','mat-grade-5'),('G-6','mat-grade-6'),('G-kg-1','mat-kg-1'),('G-kg-2','mat-kg-2'),('G-kg-3','mat-kg-3'),('G-1','science-grade-1'),('G-2','science-grade-2'),('G-3','science-grade-3'),('G-4','science-grade-4'),('G-5','science-grade-5'),('G-6','science-grade-6'),('G-kg-1','science-kg-1'),('G-kg-2','science-kg-2'),('G-kg-3','science-kg-3');
/*!40000 ALTER TABLE `courseGrade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schoolClassYear`
--

DROP TABLE IF EXISTS `schoolClassYear`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schoolClassYear` (
  `SchoolSchoolId` varchar(20) NOT NULL,
  `ClassYearMapId` int(11) NOT NULL,
  PRIMARY KEY (`SchoolSchoolId`,`ClassYearMapId`),
  KEY `ClassYearMapId` (`ClassYearMapId`),
  CONSTRAINT `schoolClassYear_ibfk_1` FOREIGN KEY (`SchoolSchoolId`) REFERENCES `School` (`schoolId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `schoolClassYear_ibfk_2` FOREIGN KEY (`ClassYearMapId`) REFERENCES `ClassYearMap` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schoolClassYear`
--

LOCK TABLES `schoolClassYear` WRITE;
/*!40000 ALTER TABLE `schoolClassYear` DISABLE KEYS */;
/*!40000 ALTER TABLE `schoolClassYear` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sectionMapper`
--

DROP TABLE IF EXISTS `sectionMapper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sectionMapper` (
  `StudentStudentId` varchar(30) NOT NULL,
  `SectionId` int(11) NOT NULL,
  PRIMARY KEY (`StudentStudentId`,`SectionId`),
  KEY `SectionId` (`SectionId`),
  CONSTRAINT `sectionMapper_ibfk_1` FOREIGN KEY (`StudentStudentId`) REFERENCES `Student` (`studentId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sectionMapper_ibfk_2` FOREIGN KEY (`SectionId`) REFERENCES `Section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sectionMapper`
--

LOCK TABLES `sectionMapper` WRITE;
/*!40000 ALTER TABLE `sectionMapper` DISABLE KEYS */;
/*!40000 ALTER TABLE `sectionMapper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semistersInfo`
--

DROP TABLE IF EXISTS `semistersInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `semistersInfo` (
  `ClassYearMapId` int(11) NOT NULL,
  `SemisterMapId` int(11) NOT NULL,
  PRIMARY KEY (`ClassYearMapId`,`SemisterMapId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semistersInfo`
--

LOCK TABLES `semistersInfo` WRITE;
/*!40000 ALTER TABLE `semistersInfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `semistersInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentInSection`
--

DROP TABLE IF EXISTS `studentInSection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studentInSection` (
  `SectionId` int(11) NOT NULL,
  `StudentStudentId` varchar(30) NOT NULL,
  PRIMARY KEY (`SectionId`,`StudentStudentId`),
  KEY `StudentStudentId` (`StudentStudentId`),
  CONSTRAINT `studentInSection_ibfk_1` FOREIGN KEY (`SectionId`) REFERENCES `Section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `studentInSection_ibfk_2` FOREIGN KEY (`StudentStudentId`) REFERENCES `Student` (`studentId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentInSection`
--

LOCK TABLES `studentInSection` WRITE;
/*!40000 ALTER TABLE `studentInSection` DISABLE KEYS */;
/*!40000 ALTER TABLE `studentInSection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentParetingId`
--

DROP TABLE IF EXISTS `studentParetingId`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studentParetingId` (
  `ParentParentId` varchar(20) NOT NULL,
  `StudentStudentId` varchar(30) NOT NULL,
  PRIMARY KEY (`ParentParentId`,`StudentStudentId`),
  KEY `StudentStudentId` (`StudentStudentId`),
  CONSTRAINT `studentParetingId_ibfk_1` FOREIGN KEY (`ParentParentId`) REFERENCES `Parent` (`parentId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `studentParetingId_ibfk_2` FOREIGN KEY (`StudentStudentId`) REFERENCES `Student` (`studentId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentParetingId`
--

LOCK TABLES `studentParetingId` WRITE;
/*!40000 ALTER TABLE `studentParetingId` DISABLE KEYS */;
/*!40000 ALTER TABLE `studentParetingId` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-10  9:11:26
