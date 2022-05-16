-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pizzeria_bd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria_bd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria_bd` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `pizzeria_bd` ;

-- -----------------------------------------------------
-- Table `pizzeria_bd`.`categoria_pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria_bd`.`categoria_pizza` (
  `idcategoria_pizza` INT NOT NULL AUTO_INCREMENT,
  `nombre_categoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcategoria_pizza`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria_bd`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria_bd`.`provincia` (
  `idprovincia` INT NOT NULL AUTO_INCREMENT,
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idprovincia`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria_bd`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria_bd`.`cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo_postal` INT NOT NULL,
  `telefono` INT NOT NULL,
  `provincia_idprovincia` INT NOT NULL,
  PRIMARY KEY (`idcliente`),
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC) VISIBLE,
  INDEX `fk_cliente_provincia1_idx` (`provincia_idprovincia` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_provincia1`
    FOREIGN KEY (`provincia_idprovincia`)
    REFERENCES `pizzeria_bd`.`provincia` (`idprovincia`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria_bd`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria_bd`.`tienda` (
  `idtienda` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) NOT NULL,
  `correo_postal` INT NOT NULL,
  `provincia_idprovincia` INT NOT NULL,
  PRIMARY KEY (`idtienda`),
  INDEX `fk_tienda_provincia1_idx` (`provincia_idprovincia` ASC) VISIBLE,
  CONSTRAINT `fk_tienda_provincia1`
    FOREIGN KEY (`provincia_idprovincia`)
    REFERENCES `pizzeria_bd`.`provincia` (`idprovincia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria_bd`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria_bd`.`empleados` (
  `idempleados` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(10) NOT NULL,
  `telefono` INT NOT NULL,
  `tipo_empleado` ENUM('cocinero', 'repartidor') NOT NULL,
  `tienda_idtienda` INT NOT NULL,
  PRIMARY KEY (`idempleados`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC) VISIBLE,
  INDEX `fk_empleados_tienda1_idx` (`tienda_idtienda` ASC) VISIBLE,
  CONSTRAINT `fk_empleados_tienda1`
    FOREIGN KEY (`tienda_idtienda`)
    REFERENCES `pizzeria_bd`.`tienda` (`idtienda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria_bd`.`entrega_domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria_bd`.`entrega_domicilio` (
  `identrega_domicilio` INT NOT NULL AUTO_INCREMENT,
  `fecha_entrega` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `empleados_idempleados` INT NOT NULL,
  PRIMARY KEY (`identrega_domicilio`),
  INDEX `fk_entrega_domicilio_empleados1_idx` (`empleados_idempleados` ASC) VISIBLE,
  CONSTRAINT `fk_entrega_domicilio_empleados1`
    FOREIGN KEY (`empleados_idempleados`)
    REFERENCES `pizzeria_bd`.`empleados` (`idempleados`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria_bd`.`comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria_bd`.`comanda` (
  `idcomanda` INT NOT NULL AUTO_INCREMENT,
  `forma_entrega` VARCHAR(45) NOT NULL,
  `fecha_comanda` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `precio_total` DOUBLE NOT NULL,
  `cliente_idcliente` INT NOT NULL,
  `entrega_domicilio_identrega_domicilio` INT NULL DEFAULT NULL,
  `tienda_idtienda` INT NOT NULL,
  PRIMARY KEY (`idcomanda`),
  INDEX `fk_comanda_cliente1_idx` (`cliente_idcliente` ASC) VISIBLE,
  INDEX `fk_comanda_entrega_domicilio1_idx` (`entrega_domicilio_identrega_domicilio` ASC) VISIBLE,
  INDEX `fk_comanda_tienda1_idx` (`tienda_idtienda` ASC) VISIBLE,
  CONSTRAINT `fk_comanda_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `pizzeria_bd`.`cliente` (`idcliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comanda_entrega_domicilio1`
    FOREIGN KEY (`entrega_domicilio_identrega_domicilio`)
    REFERENCES `pizzeria_bd`.`entrega_domicilio` (`identrega_domicilio`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comanda_tienda1`
    FOREIGN KEY (`tienda_idtienda`)
    REFERENCES `pizzeria_bd`.`tienda` (`idtienda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria_bd`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria_bd`.`producto` (
  `idproducto` INT NOT NULL AUTO_INCREMENT,
  `nombre_producto` VARCHAR(45) NOT NULL,
  `tipo_producto` ENUM('pizza', 'hamburguesa', 'bebida') NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `imagen` VARCHAR(45) NULL DEFAULT NULL,
  `precio_producto` DOUBLE NOT NULL,
  `id_categoria_pizza` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idproducto`),
  INDEX `fk_categoria_pizza_idx` (`id_categoria_pizza` ASC) VISIBLE,
  CONSTRAINT `fk_categoria_pizza`
    FOREIGN KEY (`id_categoria_pizza`)
    REFERENCES `pizzeria_bd`.`categoria_pizza` (`idcategoria_pizza`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria_bd`.`detalle_comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria_bd`.`detalle_comanda` (
  `comanda_idcomanda` INT NOT NULL,
  `producto_idproducto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precio` DOUBLE NOT NULL,
  PRIMARY KEY (`comanda_idcomanda`, `producto_idproducto`),
  INDEX `fk_comanda_has_producto_producto1_idx` (`producto_idproducto` ASC) VISIBLE,
  INDEX `fk_comanda_has_producto_comanda1_idx` (`comanda_idcomanda` ASC) VISIBLE,
  CONSTRAINT `fk_comanda_has_producto_comanda1`
    FOREIGN KEY (`comanda_idcomanda`)
    REFERENCES `pizzeria_bd`.`comanda` (`idcomanda`),
  CONSTRAINT `fk_comanda_has_producto_producto1`
    FOREIGN KEY (`producto_idproducto`)
    REFERENCES `pizzeria_bd`.`producto` (`idproducto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria_bd`.`localidad_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria_bd`.`localidad_cliente` (
  `idlocalidad_cliente` INT NOT NULL AUTO_INCREMENT,
  `localidad` VARCHAR(45) NOT NULL,
  `id_provincia` INT NOT NULL,
  PRIMARY KEY (`idlocalidad_cliente`),
  INDEX `fk_localidad_idprovincia_idx` (`id_provincia` ASC) VISIBLE,
  CONSTRAINT `fk_localidad_idprovincia`
    FOREIGN KEY (`id_provincia`)
    REFERENCES `pizzeria_bd`.`provincia` (`idprovincia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
