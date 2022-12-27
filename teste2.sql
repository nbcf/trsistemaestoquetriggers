# MySQL-Front 5.1  (Build 4.13)

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;


# Host: localhost    Database: teste2
# ------------------------------------------------------
# Server version 5.5.5-10.4.27-MariaDB

#
# Source for table tabela_02
#

DROP TABLE IF EXISTS `tabela_02`;
CREATE TABLE `tabela_02` (
  `Tabela_02` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Table_01_codigo` int(10) unsigned NOT NULL,
  `item` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Tabela_02`),
  KEY `Tabela_02_FKIndex1` (`Table_01_codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

#
# Dumping data for table tabela_02
#

LOCK TABLES `tabela_02` WRITE;
/*!40000 ALTER TABLE `tabela_02` DISABLE KEYS */;
INSERT INTO `tabela_02` VALUES (1,1,'120');
INSERT INTO `tabela_02` VALUES (3,2,'50');
INSERT INTO `tabela_02` VALUES (4,0,'100');
INSERT INTO `tabela_02` VALUES (5,2,'60');
INSERT INTO `tabela_02` VALUES (6,1,'300');
INSERT INTO `tabela_02` VALUES (13,2,'22');
/*!40000 ALTER TABLE `tabela_02` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table table_01
#

DROP TABLE IF EXISTS `table_01`;
CREATE TABLE `table_01` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ITEM1` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

#
# Dumping data for table table_01
#

LOCK TABLES `table_01` WRITE;
/*!40000 ALTER TABLE `table_01` DISABLE KEYS */;
INSERT INTO `table_01` VALUES (1,5);
INSERT INTO `table_01` VALUES (2,22);
INSERT INTO `table_01` VALUES (3,10);
/*!40000 ALTER TABLE `table_01` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table table_02
#

DROP TABLE IF EXISTS `table_02`;
CREATE TABLE `table_02` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Table_01_ID` int(10) unsigned NOT NULL,
  `PEGA_ITEM1` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Table_02_FKIndex1` (`Table_01_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

#
# Dumping data for table table_02
#

LOCK TABLES `table_02` WRITE;
/*!40000 ALTER TABLE `table_02` DISABLE KEYS */;
INSERT INTO `table_02` VALUES (1,1,5);
INSERT INTO `table_02` VALUES (2,1,3);
INSERT INTO `table_02` VALUES (3,1,2);
INSERT INTO `table_02` VALUES (4,2,9);
INSERT INTO `table_02` VALUES (5,3,40);
INSERT INTO `table_02` VALUES (6,2,21);
INSERT INTO `table_02` VALUES (7,0,NULL);
/*!40000 ALTER TABLE `table_02` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for trigger atualiza
#

DROP TRIGGER IF EXISTS `teste2`.`atualiza`;
CREATE DEFINER='root'@'localhost' TRIGGER `teste2`.`atualiza` AFTER UPDATE ON `teste2`.`table_02`
  FOR EACH ROW begin
update table_01 set ITEM1=ITEM1+Old.PEGA_ITEM1
where table_01.ID=Old.Table_01_ID;
update table_01 set ITEM1=ITEM1-New.PEGA_ITEM1
where table_01.ID=New.Table_01_ID;
end;


#
# Source for trigger atualiza_estoque
#

DROP TRIGGER IF EXISTS `teste2`.`atualiza_estoque`;
CREATE DEFINER='root'@'localhost' TRIGGER `teste2`.`atualiza_estoque` AFTER UPDATE ON `teste2`.`tabela_02`
  FOR EACH ROW begin
update table_01 set ITEM1=ITEM1-Old.item
where table_01.ID=Old.Table_01_codigo;
update table_01 set ITEM1=ITEM1+New.item
where table_01.ID=New.Table_01_codigo;
end;


#
# Source for trigger deleta_estoque
#

DROP TRIGGER IF EXISTS `teste2`.`deleta_estoque`;
CREATE DEFINER='root'@'localhost' TRIGGER `teste2`.`deleta_estoque` AFTER DELETE ON `teste2`.`tabela_02`
  FOR EACH ROW begin
update table_01 set ITEM1=ITEM1-Old.item
where table_01.ID=Old.Table_01_codigo;
end;


#
# Source for trigger deletando
#

DROP TRIGGER IF EXISTS `teste2`.`deletando`;
CREATE DEFINER='root'@'localhost' TRIGGER `teste2`.`deletando` AFTER DELETE ON `teste2`.`table_02`
  FOR EACH ROW begin
update table_01 set ITEM1=ITEM1+Old.PEGA_ITEM1
where table_01.ID=Old.Table_01_ID;
end;


#
# Source for trigger inserindo
#

DROP TRIGGER IF EXISTS `teste2`.`inserindo`;
CREATE DEFINER='root'@'localhost' TRIGGER `teste2`.`inserindo` AFTER INSERT ON `teste2`.`table_02`
  FOR EACH ROW begin

update table_01 set ITEM1=ITEM1-New.PEGA_ITEM1
where table_01.ID=New.Table_01_ID;
end;


#
# Source for trigger inserir_estoque
#

DROP TRIGGER IF EXISTS `teste2`.`inserir_estoque`;
CREATE DEFINER='root'@'localhost' TRIGGER `teste2`.`inserir_estoque` AFTER INSERT ON `teste2`.`tabela_02`
  FOR EACH ROW begin

update table_01 set ITEM1=ITEM1+New.item
where table_01.ID=New.Table_01_codigo;
end;


/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
