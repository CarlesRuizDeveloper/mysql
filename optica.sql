-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET latin1 ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`clients` (
  `ClientID` INT(11) NOT NULL AUTO_INCREMENT,
  `NomClient` VARCHAR(255) NULL DEFAULT NULL,
  `AdrecaPostal` VARCHAR(255) NULL DEFAULT NULL,
  `Telefon` INT(11) NULL DEFAULT NULL,
  `CorreuElectronic` VARCHAR(255) NULL DEFAULT NULL,
  `DataRegistre` DATE NULL DEFAULT NULL,
  `ClientRecomanadorID` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ClientID`),
  INDEX `ClientRecomanadorID` (`ClientRecomanadorID` ASC) VISIBLE,
  CONSTRAINT `clients_ibfk_1`
    FOREIGN KEY (`ClientRecomanadorID`)
    REFERENCES `optica`.`clients` (`ClientID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `optica`.`empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`empleats` (
  `EmpleatID` INT(11) NOT NULL AUTO_INCREMENT,
  `NomEmpleat` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`EmpleatID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `optica`.`marquesulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`marquesulleres` (
  `MarcaID` INT(11) NOT NULL AUTO_INCREMENT,
  `NomMarca` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`MarcaID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `optica`.`proveidors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveidors` (
  `ProveedorID` INT(11) NOT NULL AUTO_INCREMENT,
  `NomProveedor` VARCHAR(255) NULL DEFAULT NULL,
  `Adreca` VARCHAR(255) NULL DEFAULT NULL,
  `Telefon` INT(11) NULL DEFAULT NULL,
  `Fax` INT(11) NULL DEFAULT NULL,
  `NIF` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`ProveedorID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `optica`.`proveidor_marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveidor_marca` (
  `ProveedorID` INT(11) NOT NULL,
  `MarcaID` INT(11) NOT NULL,
  PRIMARY KEY (`ProveedorID`, `MarcaID`),
  INDEX `fk_marca_proveedor` (`MarcaID` ASC) VISIBLE,
  CONSTRAINT `fk_marca_proveedor`
    FOREIGN KEY (`MarcaID`)
    REFERENCES `optica`.`marquesulleres` (`MarcaID`),
  CONSTRAINT `fk_proveedor_marca`
    FOREIGN KEY (`ProveedorID`)
    REFERENCES `optica`.`proveidors` (`ProveedorID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `optica`.`ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`ulleres` (
  `UlleresID` INT(11) NOT NULL AUTO_INCREMENT,
  `ProveedorID` INT(11) NULL DEFAULT NULL,
  `MarcaID` INT(11) NULL DEFAULT NULL,
  `GraduacioVidres` DECIMAL(5,2) NULL DEFAULT NULL,
  `TipusMuntura` ENUM('flotant', 'pasta', 'metàl·lica') NULL DEFAULT NULL,
  `ColorMuntura` VARCHAR(20) NULL DEFAULT NULL,
  `ColorVidre` VARCHAR(20) NULL DEFAULT NULL,
  `Preu` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`UlleresID`),
  INDEX `fk_ulleres_proveidor` (`ProveedorID` ASC) VISIBLE,
  INDEX `fk_ulleres_marca` (`MarcaID` ASC) VISIBLE,
  CONSTRAINT `fk_ulleres_marca`
    FOREIGN KEY (`MarcaID`)
    REFERENCES `optica`.`marquesulleres` (`MarcaID`),
  CONSTRAINT `fk_ulleres_proveidor`
    FOREIGN KEY (`ProveedorID`)
    REFERENCES `optica`.`proveidors` (`ProveedorID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `optica`.`vendes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`vendes` (
  `VendaID` INT(11) NOT NULL AUTO_INCREMENT,
  `ClientID` INT(11) NULL DEFAULT NULL,
  `UlleresID` INT(11) NULL DEFAULT NULL,
  `DataVenda` DATE NULL DEFAULT NULL,
  `EmpleatID` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`VendaID`),
  INDEX `ClientID` (`ClientID` ASC) VISIBLE,
  INDEX `UlleresID` (`UlleresID` ASC) VISIBLE,
  INDEX `EmpleatID` (`EmpleatID` ASC) VISIBLE,
  CONSTRAINT `vendes_ibfk_1`
    FOREIGN KEY (`ClientID`)
    REFERENCES `optica`.`clients` (`ClientID`),
  CONSTRAINT `vendes_ibfk_2`
    FOREIGN KEY (`UlleresID`)
    REFERENCES `optica`.`ulleres` (`UlleresID`),
  CONSTRAINT `vendes_ibfk_3`
    FOREIGN KEY (`EmpleatID`)
    REFERENCES `optica`.`empleats` (`EmpleatID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
