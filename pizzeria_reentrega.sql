-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;   
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET latin1 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`productes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`productes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NULL DEFAULT NULL,
  `descripcio` TEXT NULL DEFAULT NULL,
  `imatge` VARCHAR(255) NULL DEFAULT NULL,
  `preu` DECIMAL(10,2) NULL DEFAULT NULL,
  `tipus` ENUM('pizza', 'hamburguesa', 'beguda') NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pizzeria`.`begudes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`begudes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom_beguda` VARCHAR(255) NULL DEFAULT NULL,
  `id_producte` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_producte` (`id_producte` ASC) VISIBLE,
  CONSTRAINT `begudes_ibfk_1`
    FOREIGN KEY (`id_producte`)
    REFERENCES `pizzeria`.`productes` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pizzeria`.`botigues`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`botigues` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `adreca` VARCHAR(255) NULL DEFAULT NULL,
  `codi_postal` INT(10) NULL DEFAULT NULL,
  `localitat` VARCHAR(255) NULL DEFAULT NULL,
  `provincia` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pizzeria`.`categoriespizzes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categoriespizzes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom_categoria` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pizzeria`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`clients` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NULL DEFAULT NULL,
  `cognoms` VARCHAR(255) NULL DEFAULT NULL,
  `adreca` VARCHAR(255) NULL DEFAULT NULL,
  `codi_postal` INT(10) NULL DEFAULT NULL,
  `localitat` VARCHAR(255) NULL DEFAULT NULL,
  `provincia` VARCHAR(255) NULL DEFAULT NULL,
  `telefon` INT(15) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pizzeria`.`comandes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`comandes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `data_hora` DATETIME NULL DEFAULT NULL,
  `tipus_comanda` VARCHAR(50) NULL DEFAULT NULL,
  `preu_total` DECIMAL(10,2) NULL DEFAULT NULL,
  `id_client` INT(11) NULL DEFAULT NULL,
  `repartida` TINYINT(1) NULL DEFAULT '0',
  `id_botiga` INT(11) NULL DEFAULT NULL,
  `quantitat_productes` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_client` (`id_client` ASC) VISIBLE,
  INDEX `id_botiga` (`id_botiga` ASC) VISIBLE,
  CONSTRAINT `comandes_ibfk_1`
    FOREIGN KEY (`id_client`)
    REFERENCES `pizzeria`.`clients` (`id`),
  CONSTRAINT `comandes_ibfk_2`
    FOREIGN KEY (`id_botiga`)
    REFERENCES `pizzeria`.`botigues` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleats` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NULL DEFAULT NULL,
  `cognoms` VARCHAR(255) NULL DEFAULT NULL,
  `nif` VARCHAR(15) NULL DEFAULT NULL,
  `telefon` INT(15) NULL DEFAULT NULL,
  `tipus_empleat` VARCHAR(50) NULL DEFAULT NULL,
  `id_botiga` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_botiga` (`id_botiga` ASC) VISIBLE,
  CONSTRAINT `empleats_ibfk_1`
    FOREIGN KEY (`id_botiga`)
    REFERENCES `pizzeria`.`botigues` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pizzeria`.`hamburgueses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`hamburgueses` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom_hamburguesa` VARCHAR(255) NULL DEFAULT NULL,
  `id_producte` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_producte` (`id_producte` ASC) VISIBLE,
  CONSTRAINT `hamburgueses_ibfk_1`
    FOREIGN KEY (`id_producte`)
    REFERENCES `pizzeria`.`productes` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pizzeria`.`lliuraments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`lliuraments` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `data_hora_lliurament` DATETIME NULL DEFAULT NULL,
  `id_repartidor` INT(11) NULL DEFAULT NULL,
  `id_comanda` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_repartidor` (`id_repartidor` ASC) VISIBLE,
  INDEX `id_comanda` (`id_comanda` ASC) VISIBLE,
  CONSTRAINT `lliuraments_ibfk_1`
    FOREIGN KEY (`id_repartidor`)
    REFERENCES `pizzeria`.`empleats` (`id`),
  CONSTRAINT `lliuraments_ibfk_2`
    FOREIGN KEY (`id_comanda`)
    REFERENCES `pizzeria`.`comandes` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizzes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizzes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom_pizza` VARCHAR(255) NULL DEFAULT NULL,
  `id_categoria` INT(11) NULL DEFAULT NULL,
  `id_producte` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_categoria` (`id_categoria` ASC) VISIBLE,
  INDEX `id_producte` (`id_producte` ASC) VISIBLE,
  CONSTRAINT `pizzes_ibfk_1`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `pizzeria`.`categoriespizzes` (`id`),
  CONSTRAINT `pizzes_ibfk_2`
    FOREIGN KEY (`id_producte`)
    REFERENCES `pizzeria`.`productes` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pizzeria`.`comandes_has_productes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`comandes_has_productes` (
  `comandes_id` INT(11) NOT NULL,
  `productes_id` INT(11) NOT NULL,
  `quantitatProductes` INT NULL,
  PRIMARY KEY (`comandes_id`, `productes_id`),
  INDEX `fk_comandes_has_productes_productes1_idx` (`productes_id` ASC) VISIBLE,
  INDEX `fk_comandes_has_productes_comandes1_idx` (`comandes_id` ASC) VISIBLE,
  CONSTRAINT `fk_comandes_has_productes_comandes1`
    FOREIGN KEY (`comandes_id`)
    REFERENCES `pizzeria`.`comandes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comandes_has_productes_productes1`
    FOREIGN KEY (`productes_id`)
    REFERENCES `pizzeria`.`productes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
