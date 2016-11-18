-- MySQL dump 10.13  Distrib 5.7.15, for Linux (x86_64)
--
-- Host: localhost    Database: path_lab
-- ------------------------------------------------------
-- Server version	5.7.15-0ubuntu0.16.04.1

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `ID` varchar(15) DEFAULT NULL,
  `password` char(32) DEFAULT NULL,
  `emailid` varchar(25) NOT NULL,
  UNIQUE KEY `emailid` (`emailid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('ADM001','0192023a7bbd73250516f069df18b500','admin1@gmail.com'),('ADM002','0192023a7bbd73250516f069df18b500','admin2@gmail.com');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agent`
--

DROP TABLE IF EXISTS `agent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agent` (
  `ID` varchar(10) NOT NULL,
  `FName` varchar(15) NOT NULL,
  `Lname` varchar(15) DEFAULT NULL,
  `DOB` date NOT NULL,
  `Age` int(11) DEFAULT NULL,
  `Gender` varchar(6) NOT NULL,
  `Hno` varchar(8) NOT NULL,
  `Street` varchar(15) NOT NULL,
  `Locality` varchar(20) NOT NULL,
  `AddLine` varchar(20) DEFAULT NULL,
  `Landmark` varchar(20) DEFAULT NULL,
  `City` varchar(15) NOT NULL,
  `State` varchar(15) NOT NULL,
  `pincode` int(11) DEFAULT NULL,
  `phno` char(15) NOT NULL,
  `emailid` varchar(25) NOT NULL,
  `password` char(32) NOT NULL,
  `working` varchar(3) DEFAULT 'YES',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `emailid` (`emailid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agent`
--

LOCK TABLES `agent` WRITE;
/*!40000 ALTER TABLE `agent` DISABLE KEYS */;
INSERT INTO `agent` VALUES ('A001','Ramesh','Arora','1986-12-12',20,'male','2','main','punjabi bagh','east pb','metro','Mumbai','Maharashrta',400001,'7091317209','ramesh@yahoo.com','6eea9b7ef19179a06954edd0f6c05ceb','YES'),('A002','Rakesh','Kumar','1981-01-12',35,'male','2','main street','Tech Park','West State','City Mall','Bangalore','Karnataka',600123,'7091317209','rakesh@outlook.com','6eea9b7ef19179a06954edd0f6c05ceb','YES'),('A003','Ravi','Ram','1981-01-12',35,'male','2-B','main','Tech Area','Long State','City','Bangalore','Karnataka',700123,'8891317209','ravi@outlook.com','6eea9b7ef19179a06954edd0f6c05ceb','L'),('A019','Raj','Arora','1986-12-12',20,'male','2','main street','punjabi bagh','east pb','metro','Delhi','delhi',110026,'7091318036','raj@gmail.com','6eea9b7ef19179a06954edd0f6c05ceb','NO'),('A1022','Swati','Sinha','1984-02-11',32,'Female','2-T','Dawn','Pitampura','','','Delhi','New Delhi',110022,'9835950503','swatishn@outlook.com','6eea9b7ef19179a06954edd0f6c05ceb','YES'),('A111','Babloo','Kumar','1991-12-03',25,'male','234','Downing','Lanka','','BHU','Varanasi','UP',221005,'9877994521','babloo@yahoo.com','6eea9b7ef19179a06954edd0f6c05ceb','YES'),('A992','Babloo','Gupta','1970-11-02',36,'male','12','Apple','Palasia','','','Sunam','Punjab',213321,'8668668667','guptab@gmail.com','6eea9b7ef19179a06954edd0f6c05ceb','YES');
/*!40000 ALTER TABLE `agent` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER agent_ins
BEFORE INSERT
ON agent
FOR EACH ROW
BEGIN
IF NEW.ID = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.emailid = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.password = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF (NEW.phno REGEXP '^(\\+?[0-9]{1,4}-)?[0-9]{3,10}$' ) = 0 THEN
SIGNAL SQLSTATE '12345';
END IF;
IF NEW.emailid NOT LIKE '%_@%_.__%' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.Age > 50 THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.Age < 18 THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.DOB > NOW() THEN
SIGNAL SQLSTATE '45000';
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER agent_upd
BEFORE UPDATE
ON agent
FOR EACH ROW
BEGIN
IF NEW.ID = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.emailid = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.password = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF (NEW.phno REGEXP '^(\\+?[0-9]{1,4}-)?[0-9]{3,10}$' ) = 0 THEN
SIGNAL SQLSTATE '12345';
END IF;
IF NEW.Age > 50 THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.Age < 18 THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.emailid NOT LIKE '%_@%_.__%' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.DOB > NOW() THEN
SIGNAL SQLSTATE '45000';
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `app_leaves`
--

DROP TABLE IF EXISTS `app_leaves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_leaves` (
  `ID` varchar(10) DEFAULT NULL,
  `start` date DEFAULT NULL,
  `end` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_leaves`
--

LOCK TABLES `app_leaves` WRITE;
/*!40000 ALTER TABLE `app_leaves` DISABLE KEYS */;
INSERT INTO `app_leaves` VALUES ('A003','2016-10-24','2016-10-26');
/*!40000 ALTER TABLE `app_leaves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coll_centre`
--

DROP TABLE IF EXISTS `coll_centre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coll_centre` (
  `ID` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `Street` varchar(15) NOT NULL,
  `Locality` varchar(20) NOT NULL,
  `City` varchar(15) NOT NULL,
  `State` varchar(15) NOT NULL,
  `pincode` int(11) DEFAULT NULL,
  `phno` char(12) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `phno` (`phno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coll_centre`
--

LOCK TABLES `coll_centre` WRITE;
/*!40000 ALTER TABLE `coll_centre` DISABLE KEYS */;
INSERT INTO `coll_centre` VALUES ('C001','Shyam Pharma','Boring Road','Digha','Delhi','Delhi',110024,'9811234554'),('C002','Aman Labs','Main Road','Kadma','Delhi','Delhi',110024,'9898764554'),('C003','Shankar Labs','Mall Road','Vashi','Mumbai','Maharashtra',400401,'8098764554'),('C004','Lal Labs','Bull Road','Tech Park','Bangalore','Karnataka',542001,'7208764554'),('C005','Lal Pahrma','Bull Street','Tech Area','Hyderabad','Andhra Pradesh',876212,'7208764773'),('C006','Narayan Pharma','Peach Road','Howrah','Kolkata','West Bengal',321765,'9129922567');
/*!40000 ALTER TABLE `coll_centre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab_test`
--

DROP TABLE IF EXISTS `lab_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lab_test` (
  `ID` varchar(10) NOT NULL,
  `TestID` varchar(10) NOT NULL,
  `LabID` varchar(10) NOT NULL,
  `Cost` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_test` (`TestID`),
  KEY `fk_lab` (`LabID`),
  CONSTRAINT `fk_lab` FOREIGN KEY (`LabID`) REFERENCES `labs` (`ID`),
  CONSTRAINT `fk_test` FOREIGN KEY (`TestID`) REFERENCES `tests` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab_test`
--

LOCK TABLES `lab_test` WRITE;
/*!40000 ALTER TABLE `lab_test` DISABLE KEYS */;
INSERT INTO `lab_test` VALUES ('LT001','T001','L002',200),('LT002','T002','L003',150),('LT003','T003','L001',250),('LT004','T004','L005',350),('LT005','T005','L003',300),('LT006','T006','L002',300),('LT007','T007','L001',200),('LT008','T008','L001',400),('LT009','T009','L004',100),('LT010','T010','L005',200);
/*!40000 ALTER TABLE `lab_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `labs`
--

DROP TABLE IF EXISTS `labs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labs` (
  `ID` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `Street` varchar(15) NOT NULL,
  `Locality` varchar(20) NOT NULL,
  `City` varchar(15) NOT NULL,
  `State` varchar(15) NOT NULL,
  `pincode` int(11) DEFAULT NULL,
  `phno` char(12) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `phno` (`phno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `labs`
--

LOCK TABLES `labs` WRITE;
/*!40000 ALTER TABLE `labs` DISABLE KEYS */;
INSERT INTO `labs` VALUES ('L001','Shyam Pharma','Boring Road','Digha','Delhi','Delhi',110024,'9811234554'),('L002','Aman Labs','Main Road','Kadma','Delhi','Delhi',110024,'9898764554'),('L003','Shankar Labs','Mall Road','Vashi','Mumbai','Maharashtra',400401,'8098764554'),('L004','Lal Labs','Bull Road','Tech Park','Bangalore','Karnataka',542001,'7208764554'),('L005','Lal Pahrma','Bull Street','Tech Area','Hyderabad','Andhra Pradesh',876212,'7208764773'),('L006','Shyamlal Pharma','Road 29','Andheri','Ambala','Punjab',556955,'7779922567');
/*!40000 ALTER TABLE `labs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nominee`
--

DROP TABLE IF EXISTS `nominee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nominee` (
  `ID` varchar(10) NOT NULL,
  `UserID` varchar(10) DEFAULT NULL,
  `FName` varchar(15) NOT NULL,
  `Lname` varchar(15) DEFAULT NULL,
  `DOB` date NOT NULL,
  `Age` int(11) DEFAULT NULL,
  `Gender` varchar(6) NOT NULL,
  `Hno` varchar(8) NOT NULL,
  `Street` varchar(15) NOT NULL,
  `Locality` varchar(20) NOT NULL,
  `AddLine` varchar(20) DEFAULT NULL,
  `Landmark` varchar(20) DEFAULT NULL,
  `City` varchar(15) NOT NULL,
  `State` varchar(15) NOT NULL,
  `pincode` int(11) DEFAULT NULL,
  `phno` char(15) NOT NULL,
  `emailid` varchar(25) NOT NULL,
  `password` char(32) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `emailid` (`emailid`),
  KEY `fk_nom` (`UserID`),
  CONSTRAINT `fk_nom` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nominee`
--

LOCK TABLES `nominee` WRITE;
/*!40000 ALTER TABLE `nominee` DISABLE KEYS */;
INSERT INTO `nominee` VALUES ('N001','U002','Aman','Bansal','2011-12-12',5,'male','2','wall street','shalimar bagh','Vashi','City Park','Mumbai','Maharashtra',400003,'8187916748','amam1@gmail.com','6eea9b7ef19179a06954edd0f6c05ceb'),('N002','U003','Ayush','Agarwal','2011-12-02',5,'male','2','Bull street','Tech Park','Go city','City Mall','Bangalore','Karantaka',400002,'8187916712','ayuss@gmail.com','6eea9b7ef19179a06954edd0f6c05ceb'),('N110','U001','Sneha','Pandey','2003-12-12',13,'Female','3','Baking','Sigra','','','Varanasi','UP',221007,'8187916748','pandeysneha@gmail.com','6eea9b7ef19179a06954edd0f6c05ceb'),('N129','U001','Virat','Bansal','2011-12-12',5,'male','2','main street','punjabi bagh','east pb','metro','Delhi','delhi',110026,'9835307331','robin@gmail.com','6eea9b7ef19179a06954edd0f6c05ceb'),('N543','U001','Sakshi','Gupta','1970-11-02',36,'male','32','Bull','Tech Zone','','','Jammu','Jammu Kashmir',220022,'9876556789','saksho@gmail.com','6eea9b7ef19179a06954edd0f6c05ceb'),('N990','U001','Surya','Mallik','1985-09-12',31,'male','4','Palle','Vidyapati','','Patel Club','Ranchi','Bihar',834112,'8187916748','surya@outlook.com','6eea9b7ef19179a06954edd0f6c05ceb');
/*!40000 ALTER TABLE `nominee` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER nomi_ins
BEFORE INSERT
ON nominee
FOR EACH ROW
BEGIN
IF NEW.ID = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.UserID = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.emailid = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.password = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF (NEW.phno REGEXP '^(\\+?[0-9]{1,4}-)?[0-9]{3,10}$' ) = 0 THEN
SIGNAL SQLSTATE '12345';
END IF;
IF NEW.emailid NOT LIKE '%_@%_.__%' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.Age > 100 THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.Age < 0 THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.DOB > NOW() THEN
SIGNAL SQLSTATE '45000';
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER nomi_upd
BEFORE UPDATE
ON nominee
FOR EACH ROW
BEGIN
IF NEW.ID = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.UserID = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.emailid = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.password = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF (NEW.phno REGEXP '^(\\+?[0-9]{1,4}-)?[0-9]{3,10}$' ) = 0 THEN
SIGNAL SQLSTATE '12345';
END IF;
IF NEW.emailid NOT LIKE '%_@%_.__%' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.Age > 100 THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.Age < 0 THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.DOB > NOW() THEN
SIGNAL SQLSTATE '45000';
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `reg_tests`
--

DROP TABLE IF EXISTS `reg_tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reg_tests` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LTID` varchar(10) NOT NULL,
  `UserID` varchar(10) NOT NULL,
  `PatientID` varchar(10) NOT NULL,
  `homesmap` varchar(10) NOT NULL DEFAULT 'NO',
  `venuesamp` varchar(10) DEFAULT NULL,
  `AgentID` varchar(10) NOT NULL,
  `RegDate` date NOT NULL,
  `DueDate` date NOT NULL,
  `cost` int(11) NOT NULL,
  `paid` int(11) NOT NULL,
  `pay_comp` char(3) DEFAULT 'NO',
  `sampling` char(3) DEFAULT 'NO',
  `samp_pack` char(3) DEFAULT 'NO',
  `samp_ship` char(3) DEFAULT 'NO',
  `samp_dest` char(3) DEFAULT 'NO',
  `test_start` char(3) DEFAULT 'NO',
  `test_comp` char(3) DEFAULT 'NO',
  `rep_gen` char(3) DEFAULT 'NO',
  PRIMARY KEY (`ID`),
  KEY `fk_agent` (`AgentID`),
  KEY `fk_LT` (`LTID`),
  CONSTRAINT `fk_LT` FOREIGN KEY (`LTID`) REFERENCES `lab_test` (`ID`),
  CONSTRAINT `fk_agent` FOREIGN KEY (`AgentID`) REFERENCES `agent` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reg_tests`
--

LOCK TABLES `reg_tests` WRITE;
/*!40000 ALTER TABLE `reg_tests` DISABLE KEYS */;
INSERT INTO `reg_tests` VALUES (7,'LT001','U001','U001','NO','YES','A001','2016-10-21','2016-10-23',150,150,'YES','0','0','0','0','0','0','YES'),(9,'LT002','U001','N129','YES','NO','A001','2016-10-21','2016-10-23',150,0,'NO','NO','NO','NO','NO','NO','NO','YES'),(10,'LT005','U001','U001','NO','YES','A003','2016-10-21','2016-10-23',300,200,'NO','YES','YES','YES','YES','YES','YES','YES'),(11,'LT005','U001','U001','NO','YES','A003','2016-10-21','2016-10-23',300,50,'NO','YES','YES','NO','NO','NO','NO','NO'),(12,'LT005','U009','U009','NO','YES','A001','2016-10-21','2016-10-23',300,0,'NO','NO','NO','NO','NO','NO','NO','NO'),(13,'LT003','U001','U001','NO','YES','A003','2016-10-21','2016-10-23',250,0,'NO','NO','NO','NO','NO','NO','NO','NO'),(14,'LT010','U001','N129','NO','YES','A001','2016-10-21','2016-10-23',200,0,'NO','NO','NO','NO','NO','NO','NO','NO'),(15,'LT006','U001','N990','NO','YES','A003','2016-10-21','2016-10-24',300,0,'NO','NO','NO','NO','NO','NO','NO','NO'),(16,'LT009','U001','N543','YES','NO','A002','2016-10-21','2016-10-24',100,0,'NO','NO','NO','NO','NO','NO','NO','NO'),(17,'LT010','U001','N543','YES','NO','A001','2016-10-22','2016-10-26',300,0,'NO','NO','NO','NO','NO','NO','NO','NO'),(18,'LT005','U001','N129','NO','YES','A002','2016-10-24','2016-10-29',300,0,'NO','NO','NO','NO','NO','NO','NO','NO'),(19,'LT005','U001','N543','NO','YES','A001','2016-12-08','2016-12-13',300,0,'NO','NO','NO','NO','NO','NO','NO','NO'),(20,'LT004','U001','N990','YES','NO','A1022','2016-08-12','2016-08-16',450,0,'NO','NO','NO','NO','NO','NO','NO','NO'),(21,'LT010','U001','U001','YES','NO','A002','2016-12-08','2016-12-12',300,0,'NO','NO','NO','NO','NO','NO','NO','NO');
/*!40000 ALTER TABLE `reg_tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sanc`
--

DROP TABLE IF EXISTS `sanc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sanc` (
  `ID` varchar(8) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sanc`
--

LOCK TABLES `sanc` WRITE;
/*!40000 ALTER TABLE `sanc` DISABLE KEYS */;
INSERT INTO `sanc` VALUES ('A003');
/*!40000 ALTER TABLE `sanc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tests`
--

DROP TABLE IF EXISTS `tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tests` (
  `ID` varchar(10) NOT NULL,
  `Type` varchar(20) NOT NULL,
  `Name` varchar(30) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests`
--

LOCK TABLES `tests` WRITE;
/*!40000 ALTER TABLE `tests` DISABLE KEYS */;
INSERT INTO `tests` VALUES ('T001','Diabetes','Glucose'),('T002','Diabetes','Fructosamine'),('T003','Allergy','Allergy Screen'),('T004','Allergy','Home Dust'),('T005','Drugs','Cocaine'),('T006','Drugs','Nicotene'),('T007','Viral','Dengue'),('T008','Viral','Rubella'),('T009','Poison','Arsenic'),('T010','Poison','Osmolal Gap');
/*!40000 ALTER TABLE `tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `ID` varchar(10) NOT NULL,
  `FName` varchar(15) NOT NULL,
  `Lname` varchar(15) DEFAULT NULL,
  `DOB` date NOT NULL,
  `Age` int(11) DEFAULT NULL,
  `Gender` varchar(6) NOT NULL,
  `Hno` varchar(8) NOT NULL,
  `Street` varchar(15) NOT NULL,
  `Locality` varchar(20) NOT NULL,
  `AddLine` varchar(20) DEFAULT NULL,
  `Landmark` varchar(20) DEFAULT NULL,
  `City` varchar(15) NOT NULL,
  `State` varchar(15) NOT NULL,
  `pincode` int(11) DEFAULT NULL,
  `phno` char(15) NOT NULL,
  `emailid` varchar(25) NOT NULL,
  `password` char(32) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `emailid` (`emailid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('U001','Ram','Kumar','1987-12-01',29,'male','7-C','Baker','Sigra','','','Varanasi','Uttar Pradesh',221006,'9835307221','ram@hotmail.com','5d41402abc4b2a76b9719d911017c592'),('U002','Ramesh','Singh','1987-12-01',29,'male','7','Baker','Lanka','','','Varanasi','Uttar Pradesh',221006,'9835307221','ramesh@gmail.com','5d41402abc4b2a76b9719d911017c592'),('U003','Piyush','Agrawal','1987-12-01',29,'male','7','Baker','Lanka','','','Varanasi','Uttar Pradesh',221006,'9835307221','piyush@gmail.com','5d41402abc4b2a76b9719d911017c592'),('U004','Ankita','Kumari','1987-12-01',29,'female','7','Baker','Lanka','','','Varanasi','Uttar Pradesh',221006,'9835307221','ankita@gmail.com','5d41402abc4b2a76b9719d911017c592'),('U005','Katrina','Singh','1987-12-01',29,'female','7','Baker','Lanka','','','Varanasi','Uttar Pradesh',221006,'9835307221','katrina@yahoo.com','5d41402abc4b2a76b9719d911017c592'),('U008','Rohit','Kumar','1995-05-15',29,'male','7','Baker','Lanka','','','Varanasi','Uttar Pradesh',221006,'9835307221','rohit@yahoo.com','6eea9b7ef19179a06954edd0f6c05ceb'),('U009','Robin','Chawla','2011-12-12',29,'male','7','Baker','Lanka','','','Varanasi','Uttar Pradesh',221006,'9835307221','robin@gmail.com','6eea9b7ef19179a06954edd0f6c05ceb'),('U1200','Divik','Jain','1985-12-11',31,'male','6-c','Down','Palasia','East Punjabi Bagh','','Delhi','Delhi',110026,'9835307331','jaindivik@gmail.com','6eea9b7ef19179a06954edd0f6c05ceb');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER user_ins
BEFORE INSERT
ON user
FOR EACH ROW
BEGIN
IF NEW.ID = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.emailid = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.password = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF (NEW.phno REGEXP '^(\\+?[0-9]{1,4}-)?[0-9]{3,10}$' ) = 0 THEN
SIGNAL SQLSTATE '12345';
END IF;
IF NEW.emailid NOT LIKE '%_@%_.__%' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.Age > 100 THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.Age < 0 THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.DOB > NOW() THEN
SIGNAL SQLSTATE '45000';
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER user_upd
BEFORE UPDATE
ON user
FOR EACH ROW
BEGIN
IF NEW.ID = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.emailid = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.password = '' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF (NEW.phno REGEXP '^(\\+?[0-9]{1,4}-)?[0-9]{3,10}$' ) = 0 THEN
SIGNAL SQLSTATE '12345';
END IF;
IF NEW.Age > 100 THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.Age < 0 THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.emailid NOT LIKE '%_@%_.__%' THEN
SIGNAL SQLSTATE '45000';
END IF;
IF NEW.DOB > NOW() THEN
SIGNAL SQLSTATE '45000';
END IF;
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


use mysql

GRANT USAGE on *.* to 'alluser'@'localhost' identified by 'alluser';
DROP USER 'alluser'@'localhost';
CREATE USER 'alluser'@'localhost' identified by 'alluser';
GRANT ALL PRIVILEGES ON path_lab.* to 'alluser'@'localhost' identified by 'alluser';



-- Dump completed on 2016-10-22 16:39:34
