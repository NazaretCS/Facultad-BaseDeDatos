#INSERT INTO `esquemarepaso2`.`alumno` (`idalumno`, `alumno`, `dni`) VALUES ('201', 'alumno uno ', '22222222');

#INSERT INTO `esquemarepaso2`.`profesores` (`idprofesor`, `profesor`, `cuil`) VALUES ('301', 'profesor uno', '3333333');



/*

-- MySQL Workbench Synchronization
-- Generated: 2022-11-29 06:41
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: nazar

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `esquemarepaso3`.`ejemplar` (
  `cod_ejemplar` INT(11) NOT NULL,
  `cod_libro` INT(11) NOT NULL,
  PRIMARY KEY (`cod_ejemplar`, `cod_libro`),
  INDEX `fk_ejemplar_libro_idx` (`cod_libro` ASC) VISIBLE,
  UNIQUE INDEX `cod_ejemplar_UNIQUE` (`cod_ejemplar` ASC) VISIBLE,
  CONSTRAINT `fk_ejemplar_libro`
    FOREIGN KEY (`cod_libro`)
    REFERENCES `esquemarepaso3`.`libro` (`cod_libro`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `esquemarepaso3`.`libro` (
  `cod_libro` INT(11) NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `anio` VARCHAR(45) NULL DEFAULT NULL,
  `cod_idioma` INT(11) NOT NULL,
  PRIMARY KEY (`cod_libro`),
  INDEX `fk_libro_idioma1_idx` (`cod_idioma` ASC) VISIBLE,
  UNIQUE INDEX `cod_libro_UNIQUE` (`cod_libro` ASC) VISIBLE,
  CONSTRAINT `fk_libro_idioma1`
    FOREIGN KEY (`cod_idioma`)
    REFERENCES `esquemarepaso3`.`idioma` (`cod_idioma`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `esquemarepaso3`.`idioma` (
  `cod_idioma` INT(11) NOT NULL,
  `descripcion` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`cod_idioma`),
  UNIQUE INDEX `cod_idioma_UNIQUE` (`cod_idioma` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `esquemarepaso3`.`prestamo` (
  `cod_libro` INT(11) NOT NULL,
  `cod_ejemplar` INT(11) NOT NULL,
  `cod_socio` INT(11) NOT NULL,
  `fecha_prest` DATE NOT NULL,
  `fecha_dev` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`cod_libro`, `cod_ejemplar`),
  INDEX `fk_prestamo_ejemplar1_idx` (`cod_ejemplar` ASC) VISIBLE,
  INDEX `fk_prestamo_socio1_idx` (`cod_socio` ASC) VISIBLE,
  CONSTRAINT `fk_prestamo_libro1`
    FOREIGN KEY (`cod_libro`)
    REFERENCES `esquemarepaso3`.`libro` (`cod_libro`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_prestamo_ejemplar1`
    FOREIGN KEY (`cod_ejemplar`)
    REFERENCES `esquemarepaso3`.`ejemplar` (`cod_ejemplar`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_prestamo_socio1`
    FOREIGN KEY (`cod_socio`)
    REFERENCES `esquemarepaso3`.`socio` (`cod_socio`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `esquemarepaso3`.`socio` (
  `cod_socio` INT(11) NOT NULL,
  `dni` VARCHAR(45) NULL DEFAULT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_nac` DATE NULL DEFAULT NULL,
  `domicilio` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`cod_socio`),
  UNIQUE INDEX `cod_socio_UNIQUE` (`cod_socio` ASC) VISIBLE,
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `esquemarepaso3`.`autor` (
  `cod_autor` INT(11) NOT NULL,
  `dni` VARCHAR(45) NULL DEFAULT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cod_autor`),
  UNIQUE INDEX `cod_autor_UNIQUE` (`cod_autor` ASC) VISIBLE,
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `esquemarepaso3`.`escrive` (
  `cod_autor` INT(11) NOT NULL,
  `cod_libro` INT(11) NOT NULL,
  PRIMARY KEY (`cod_autor`, `cod_libro`),
  INDEX `fk_escrive_libro1_idx` (`cod_libro` ASC) VISIBLE,
  CONSTRAINT `fk_escrive_autor1`
    FOREIGN KEY (`cod_autor`)
    REFERENCES `esquemarepaso3`.`autor` (`cod_autor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_escrive_libro1`
    FOREIGN KEY (`cod_libro`)
    REFERENCES `esquemarepaso3`.`libro` (`cod_libro`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


*/


/*

INSERT INTO `esquemarepaso3`.`socio` (`cod_socio`, `dni`, `nombre`, `fecha_nac`, `domicilio`) 
VALUES ('101', '11111111', 'Carrizo', '1999-12-01', 'av. roca 1900');

*/

/*
INSERT INTO `esquemarepaso3`.`socio` (`cod_socio`, `dni`, `nombre`, `fecha_nac`, `domicilio`) 
VALUES ('201', '22222222', 'Pérez', '1985-5-22');
Imposible insertar si falta un campo


INSERT INTO `esquemarepaso3`.`socio` (`cod_socio`, `dni`, `nombre`, `fecha_nac`, `domicilio`) 
VALUES ('301', '33333333', 'Sánchez', '1977-1-31', 'Larrea 1324');


INSERT INTO `esquemarepaso3`.`socio` (`cod_socio`, `dni`, `nombre`, `fecha_nac`, `domicilio`) 
VALUES ('201', '22222222', 'Pérez', '1985-5-22', 'San Martín 215');

SELECT * FROM socio 
WHERE domicilio LIKE '%San Martín 215%'


DELETE FROM `esquemarepaso3`.`socio` WHERE (`nombre` LIKE '%ez');
DELETE FROM `socio` WHERE (`nombre` LIKE '%ez');
SELECT * FROM socio
*/ 

UPDATE `esquemarepaso3`.`socio` SET `nombre` = 'Carriza' WHERE (`cod_socio` = '101');





