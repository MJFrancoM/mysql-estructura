-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema optica_bd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica_bd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica_bd` DEFAULT CHARACTER SET utf8mb3 ;
USE `optica_bd` ;

-- -----------------------------------------------------
-- Table `optica_bd`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_bd`.`clientes` (
  `idclientes` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `direccion_postal` VARCHAR(45) NOT NULL,
  `telefono` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `fecha_registro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `recomendado_por` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idclientes`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `optica_bd`.`marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_bd`.`marca` (
  `idmarca` INT NOT NULL AUTO_INCREMENT,
  `idproveedor` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idmarca`),
  INDEX `fk_proveedor_idx` (`idproveedor` ASC) VISIBLE,
  CONSTRAINT `fk_proveedor`
    FOREIGN KEY (`idproveedor`)
    REFERENCES `optica_bd`.`compra_proveedor` (`id_proveedor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica_bd`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_bd`.`gafas` (
  `idgafas` INT NOT NULL AUTO_INCREMENT,
  `idmarca` INT NOT NULL,
  `graduacion_vidrio_der` FLOAT NOT NULL,
  `graduacion_vidrio_izq` FLOAT NOT NULL,
  `tipo_montura` VARCHAR(45) CHARACTER SET 'utf8mb3' NOT NULL,
  `color_montura` VARCHAR(45) CHARACTER SET 'utf8mb3' NOT NULL,
  `color_vidrio_der` VARCHAR(45) CHARACTER SET 'utf8mb3' NOT NULL,
  `color_vidrio_izq` VARCHAR(45) CHARACTER SET 'utf8mb3' NOT NULL,
  `precio_gafas` FLOAT NOT NULL,
  PRIMARY KEY (`idgafas`),
  INDEX `fk_gafas_idmarca_idx` (`idmarca` ASC) VISIBLE,
  CONSTRAINT `fk_marca_idmarca`
    FOREIGN KEY (`idmarca`)
    REFERENCES `optica_bd`.`marca` (`idmarca`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica_bd`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_bd`.`proveedor` (
  `idproveedor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `carrer` VARCHAR(45) NOT NULL,
  `número` VARCHAR(45) NOT NULL,
  `piso` VARCHAR(45) NOT NULL,
  `puerta` VARCHAR(45) NOT NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `telefono` INT NOT NULL,
  `fax` INT NOT NULL,
  `NIF` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idproveedor`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `optica_bd`.`compra_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_bd`.`compra_proveedor` (
  `idcompra_proveedor` INT NOT NULL AUTO_INCREMENT,
  `id_proveedor` INT NOT NULL,
  `id_gafas` INT NOT NULL,
  `cantidad_gafas_compradas` INT NOT NULL,
  `fecha_venta` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcompra_proveedor`),
  INDEX `fk_idproveedor_idx` (`id_proveedor` ASC) VISIBLE,
  INDEX `fk_id_gafas_idx` (`id_gafas` ASC) VISIBLE,
  CONSTRAINT `fk_idgafas`
    FOREIGN KEY (`id_gafas`)
    REFERENCES `optica_bd`.`gafas` (`idgafas`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_idproveedor`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `optica_bd`.`proveedor` (`idproveedor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica_bd`.`vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_bd`.`vendedor` (
  `idvendedor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `DNI` VARCHAR(10) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idvendedor`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `optica_bd`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_bd`.`venta` (
  `idventa_cliente` INT NOT NULL AUTO_INCREMENT,
  `idvendedor` INT NOT NULL,
  `idcliente` INT NOT NULL,
  `gafas_idgafas` INT NOT NULL,
  `cantidad_gafas_vendidas` INT NOT NULL,
  `fecha_venta` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idventa_cliente`),
  INDEX `fk_factura_venta_vendedor_id_idx` (`idvendedor` ASC) VISIBLE,
  INDEX `fk_factura_venta_cliente_id_idx` (`idcliente` ASC) VISIBLE,
  INDEX `fk_factura_venta_gafas1_idx` (`gafas_idgafas` ASC) VISIBLE,
  CONSTRAINT `fk_factura_venta_idcliente`
    FOREIGN KEY (`idcliente`)
    REFERENCES `optica_bd`.`clientes` (`idclientes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_factura_venta_idvendedor`
    FOREIGN KEY (`idvendedor`)
    REFERENCES `optica_bd`.`vendedor` (`idvendedor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_venta_gafas`
    FOREIGN KEY (`gafas_idgafas`)
    REFERENCES `optica_bd`.`gafas` (`idgafas`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
