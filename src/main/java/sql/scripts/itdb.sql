-- MySQL Script generated by MySQL Workbench
-- 07/29/18 22:07:04
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema itdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `itdb` ;

-- -----------------------------------------------------
-- Schema itdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `itdb` DEFAULT CHARACTER SET utf8 ;
USE `itdb` ;

-- -----------------------------------------------------
-- Table `itdb`.`ITcompany`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itdb`.`ITcompany` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `reg_number` VARCHAR(45) NOT NULL,
  `year` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `reg_number_UNIQUE` (`reg_number` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itdb`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itdb`.`Employee` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itdb`.`Owner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itdb`.`Owner` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Employee_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Owner_Employee1_idx` (`Employee_id` ASC),
  CONSTRAINT `fk_Owner_Employee1`
    FOREIGN KEY (`Employee_id`)
    REFERENCES `itdb`.`Employee` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itdb`.`Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itdb`.`Country` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itdb`.`City`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itdb`.`City` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `Country_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_City_Country1_idx` (`Country_id` ASC),
  CONSTRAINT `fk_City_Country1`
    FOREIGN KEY (`Country_id`)
    REFERENCES `itdb`.`Country` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itdb`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itdb`.`Address` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `house` VARCHAR(45) NOT NULL,
  `City_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Address_City1_idx` (`City_id` ASC),
  CONSTRAINT `fk_Address_City1`
    FOREIGN KEY (`City_id`)
    REFERENCES `itdb`.`City` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itdb`.`Office`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itdb`.`Office` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `phone` VARCHAR(45) NULL,
  `adress_id` INT UNSIGNED NOT NULL,
  `ITcompany_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_office_adress1_idx` (`adress_id` ASC),
  INDEX `fk_Office_ITcompany1_idx` (`ITcompany_id` ASC),
  CONSTRAINT `fk_office_adress1`
    FOREIGN KEY (`adress_id`)
    REFERENCES `itdb`.`Address` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Office_ITcompany1`
    FOREIGN KEY (`ITcompany_id`)
    REFERENCES `itdb`.`ITcompany` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itdb`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itdb`.`Customer` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `Address_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Customer_Address1_idx` (`Address_id` ASC),
  CONSTRAINT `fk_Customer_Address1`
    FOREIGN KEY (`Address_id`)
    REFERENCES `itdb`.`Address` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itdb`.`Developers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itdb`.`Developers` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `project` VARCHAR(45) NOT NULL,
  `Employee_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Developers_Employee1_idx` (`Employee_id` ASC),
  CONSTRAINT `fk_Developers_Employee1`
    FOREIGN KEY (`Employee_id`)
    REFERENCES `itdb`.`Employee` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itdb`.`Sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itdb`.`Sales` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_count` INT NOT NULL,
  `Employee_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Sales_Employee1_idx` (`Employee_id` ASC),
  CONSTRAINT `fk_Sales_Employee1`
    FOREIGN KEY (`Employee_id`)
    REFERENCES `itdb`.`Employee` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itdb`.`Economists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itdb`.`Economists` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `analize_type` VARCHAR(45) NOT NULL,
  `Employee_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Economists_Employee1_idx` (`Employee_id` ASC),
  CONSTRAINT `fk_Economists_Employee1`
    FOREIGN KEY (`Employee_id`)
    REFERENCES `itdb`.`Employee` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itdb`.`ITcompany_has_Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itdb`.`ITcompany_has_Customer` (
  `ITcompany_id` INT UNSIGNED NOT NULL,
  `Customer_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ITcompany_id`, `Customer_id`),
  INDEX `fk_ITcompany_has_Customer_Customer1_idx` (`Customer_id` ASC),
  INDEX `fk_ITcompany_has_Customer_ITcompany1_idx` (`ITcompany_id` ASC),
  CONSTRAINT `fk_ITcompany_has_Customer_ITcompany1`
    FOREIGN KEY (`ITcompany_id`)
    REFERENCES `itdb`.`ITcompany` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ITcompany_has_Customer_Customer1`
    FOREIGN KEY (`Customer_id`)
    REFERENCES `itdb`.`Customer` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itdb`.`ITcompany_has_Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itdb`.`ITcompany_has_Employee` (
  `ITcompany_id` INT UNSIGNED NOT NULL,
  `Employee_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ITcompany_id`, `Employee_id`),
  INDEX `fk_ITcompany_has_Employee_Employee1_idx` (`Employee_id` ASC),
  INDEX `fk_ITcompany_has_Employee_ITcompany1_idx` (`ITcompany_id` ASC),
  CONSTRAINT `fk_ITcompany_has_Employee_ITcompany1`
    FOREIGN KEY (`ITcompany_id`)
    REFERENCES `itdb`.`ITcompany` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ITcompany_has_Employee_Employee1`
    FOREIGN KEY (`Employee_id`)
    REFERENCES `itdb`.`Employee` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;