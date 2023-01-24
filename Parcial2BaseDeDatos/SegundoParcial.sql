/*
	--------------------------------------------------------------------------------------------------------------------------------------
    
    SEGUNDO PARCIAL DE BASE DE DATOS.
    NOMBRE: CAMPOS NESTOR NAZARET
    CARRERA: PROGRADOR UNIVERSITARIO
    
    --------------------------------------------------------------------------------------------------------------------------------------
    
    EJERCICIO N° 1: Consultas
		Realizar las siguientes consultas en MySQL Workbench utilizando la base de datos LIBRERÍA:
		
        i. Obtenga el nombre del socio, el título del artículo prestado, la fecha inicio, de fin y devolución del préstamo, monto, la multa, 
			la duración, en días, del préstamo y los días que se excedió (días que el socio retuvo el artículo después de la finalización del 
            préstamo hasta que lo devolvió),de aquellos préstamos realizados entre 01-01-2018 y 31-12-2020, que hayan devuelto el artículo,
			cuyo monto sea menor que $ 2900 y la multa sea mayor a $ 1000. Ordenados de mayor a menor por la cantidad de días y por nombre 
            del socio alfabéticamente. Solución → 322 filas.


		SELECT nombre, titulo, inicio_prestamo, fin_prestamo, fecha_devolucion, monto, multa, 
		TIMESTAMPDIFF(day, inicio_prestamo, fin_prestamo) AS DuracionPrestamo, TIMESTAMPDIFF(day, fin_prestamo, fecha_devolucion) AS DiasExedido
		FROM socio 
		INNER JOIN persona ON id_persona = id_socio 
		INNER JOIN prestamo USING(id_socio)
		INNER JOIN articulo USING(id_articulo)
		WHERE inicio_prestamo BETWEEN '2018/01/01' AND '2020/12/31' AND fecha_devolucion IS NOT NULL AND monto < '2900' AND multa > '1000'
		ORDER BY DiasExedido DESC, nombre ASC
        
        
        ii. Liste para cada empleado, el nombre, la función, el sueldo y también la cantidad de familiares y el parentesco 
        (ejemplo 2 hijo, 1 esposa, 1 padre). En caso de no tener familiares, debe mostrar 0 (cero). Ordenado alfabéticamente por 
        empleado y luego por parentesco. Solución → 1482 filas
        
			SELECT P.nombre, funcion, sueldo, COUNT(F.id_empleado), F.parentesco FROM empleado EMP
			LEFT JOIN persona P ON id_persona = EMP.id_empleado
			LEFT JOIN funcion USING(id_funcion)
			LEFT JOIN familiar F USING(id_empleado)
			GROUP BY id_empleado, parentesco
			ORDER BY P.nombre ASC, parentesco
						
		iii. Muestre, para cada empresa en envío, el id, nombre, la cantidad de envíos realizados y la cantidad de artículos entregados 
			por cada una, para los casos donde la cantidad de entregas sea menor a 380. Ordenado por la cantidad de artículos entregados 
			en forma descendente y luego por empresa de envío alfabéticamente. Solución → 10 filas
		
			SELECT id_envio, envio, COUNT(V.id_envio) AS CantidadEnviosRealizados, COUNT(V.id_envio) * cantidad AS CantidadArticulosEntregados
			FROM envio
			INNER JOIN venta V USING(id_envio)
			INNER JOIN detalle_venta DV USING(id_venta)
			WHERE cantidad < 380
			GROUP BY(id_envio)
			ORDER BY CantidadArticulosEntregados DESC, envio ASC
	
    
    iv. Liste el total recaudado por el pago de cada membresía -exceptuando la denominada ‘premium plus’-, en cada una de las provincias 
		-exceptuando 'Salta' y 'Chaco’-, cuyo monto total sea mayor al total recaudado por el pago de la membresía ‘plata’ en las provincias 
		de 'Salta' y 'Chaco’. Ordenado por membresía y por provincia alfabéticamente y por recaudación de mayor a menor. 
		Solución → 43 filas
        
        
			  SELECT membresia, provincia, SUM(precio) AS TotalRecaudado  FROM membresia
			  INNER JOIN pago USING(id_membresia)
			  INNER JOIN socio USING(id_socio)
			  INNER JOIN ciudad USING(id_ciudad)
			  INNER JOIN provincia USING(id_provincia)
			  WHERE membresia <> 'premium plus' AND provincia NOT IN ('Salta','Chaco') 
			  GROUP BY id_membresia, provincia
			  HAVING  TotalRecaudado > (
										SELECT SUM(precio) FROM membresia
										INNER JOIN pago USING(id_membresia)
										INNER JOIN socio USING(id_socio)
										INNER JOIN ciudad USING(id_ciudad)
										INNER JOIN provincia USING(id_provincia)
										WHERE membresia LIKE '%plata%' AND provincia IN ('Salta','Chaco') 
										)
				ORDER BY membresia, provincia ASC, TotalRecaudado DESC
	
    v. 	Genere una vista llamada info_venta que muestre el id_venta (con el título en la columna que sea “número de venta”), el nombre del 
		socio, los campos ciudad y provincia del mismo separados por coma en un solo campo llamado “domicilio”, el nombre del empleado, el 
        sueldo y la función del mismo, la fecha y el total de la venta, el nombre empresa, el gasto y la fecha de envío y por último: la 
        diferencia en días que hay entre la fecha de la venta y la fecha de envío, bajo el título de columna “plazo_de_entrega”. 
        Ordenado por fecha deventa. 
        Solución → 1830
        
			CREATE VIEW info_venta AS
		   SELECT id_venta AS NúmeroDeVenta, S.nombre AS NombreSocio, CONCAT( ciudad, ',  ', provincia) AS Domicilio, EMP.nombre AS NombreEmpleado,
				sueldo, funcion, fecha, total, envio, gasto_envio, fecha_envio, DATEDIFF(fecha_envio, fecha) AS plazo_de_entrega
		   FROM venta
		   INNER JOIN socio USING(id_socio)
		   INNER JOIN persona S ON (S.id_persona = id_socio)
		   INNER JOIN empleado USING(id_empleado)
		   INNER JOIN persona EMP ON (EMP.id_persona = id_empleado)
		   INNER JOIN ciudad USING(id_ciudad)
		   INNER JOIN provincia USING(id_provincia)
		   INNER JOIN funcion USING(id_funcion)
		   INNER JOIN envio USING(id_envio)
		   Order BY(fecha)
           
		*/
		
       
      
      
      /*
      
		EJERCICIO 2) a),  b) y c)      
      
		-- MySQL Workbench Synchronization
		-- Generated: 2022-11-29 17:40
		-- Model: New Model
		-- Version: 1.0
		-- Project: Name of the project
		-- Author: nazar

		SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
		SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
		SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

		CREATE TABLE IF NOT EXISTS `esquemaparcial`.`persona` (
		  `id_persona` INT(11) NOT NULL,
		  `nombre` VARCHAR(45) NOT NULL,
		  PRIMARY KEY (`id_persona`))
		ENGINE = InnoDB
		DEFAULT CHARACTER SET = utf8;

		CREATE TABLE IF NOT EXISTS `esquemaparcial`.`duenio` (
		  `id_duenio` INT(11) NOT NULL,
		  `domicilio` VARCHAR(100) NOT NULL,
		  PRIMARY KEY (`id_duenio`),
		  CONSTRAINT `fk_duenio_persona1`
			FOREIGN KEY (`id_duenio`)
			REFERENCES `esquemaparcial`.`persona` (`id_persona`)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION)
		ENGINE = InnoDB
		DEFAULT CHARACTER SET = utf8;

		CREATE TABLE IF NOT EXISTS `esquemaparcial`.`veterinario` (
		  `id_veterinario` INT(11) NOT NULL,
		  `especialidad` VARCHAR(100) NOT NULL,
		  PRIMARY KEY (`id_veterinario`),
		  CONSTRAINT `fk_veterinario_persona`
			FOREIGN KEY (`id_veterinario`)
			REFERENCES `esquemaparcial`.`persona` (`id_persona`)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION)
		ENGINE = InnoDB
		DEFAULT CHARACTER SET = utf8;

		CREATE TABLE IF NOT EXISTS `esquemaparcial`.`mascota` (
		  `id_mascota` INT(11) NOT NULL,
		  `mascota` VARCHAR(40) NOT NULL,
		  `edad` INT(11) NOT NULL,
		  `id_duenio` INT(11) NOT NULL,
		  `id_raza` INT(11) NOT NULL,
		  PRIMARY KEY (`id_mascota`),
		  INDEX `fk_mascota_raza1_idx` (`id_raza` ASC) VISIBLE,
		  INDEX `fk_mascota_duenio1_idx` (`id_duenio` ASC) VISIBLE,
		  CONSTRAINT `fk_mascota_raza1`
			FOREIGN KEY (`id_raza`)
			REFERENCES `esquemaparcial`.`raza` (`id_raza`)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
		  CONSTRAINT `fk_mascota_duenio1`
			FOREIGN KEY (`id_duenio`)
			REFERENCES `esquemaparcial`.`duenio` (`id_duenio`)
			ON DELETE CASCADE
			ON UPDATE NO ACTION)
		ENGINE = InnoDB
		DEFAULT CHARACTER SET = utf8;

		CREATE TABLE IF NOT EXISTS `esquemaparcial`.`raza` (
		  `id_raza` INT(11) NOT NULL,
		  `raza` VARCHAR(50) NOT NULL,
		  `caracteristicas` VARCHAR(100) NOT NULL,
		  PRIMARY KEY (`id_raza`),
		  UNIQUE INDEX `raza_UNIQUE` (`raza` ASC) VISIBLE)
		ENGINE = InnoDB
		DEFAULT CHARACTER SET = utf8;

		CREATE TABLE IF NOT EXISTS `esquemaparcial`.`consulta` (
		  `fecha` DATE NOT NULL,
		  `id_veterinario` INT(11) NOT NULL,
		  `id_mascota` INT(11) NOT NULL,
		  `pagado` INT(11) NOT NULL,
		  `id_tratamiento` INT(11) NOT NULL,
		  `id_diagnostico` INT(11) NOT NULL,
		  PRIMARY KEY (`fecha`, `id_veterinario`, `id_mascota`),
		  INDEX `fk_consulta_veterinario1_idx` (`id_veterinario` ASC) VISIBLE,
		  INDEX `fk_consulta_mascota1_idx` (`id_mascota` ASC) VISIBLE,
		  INDEX `fk_consulta_tratamiento1_idx` (`id_tratamiento` ASC) VISIBLE,
		  INDEX `fk_consulta_diagnostico1_idx` (`id_diagnostico` ASC) VISIBLE,
		  CONSTRAINT `fk_consulta_veterinario1`
			FOREIGN KEY (`id_veterinario`)
			REFERENCES `esquemaparcial`.`veterinario` (`id_veterinario`)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
		  CONSTRAINT `fk_consulta_mascota1`
			FOREIGN KEY (`id_mascota`)
			REFERENCES `esquemaparcial`.`mascota` (`id_mascota`)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
		  CONSTRAINT `fk_consulta_tratamiento1`
			FOREIGN KEY (`id_tratamiento`)
			REFERENCES `esquemaparcial`.`tratamiento` (`id_tratamiento`)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
		  CONSTRAINT `fk_consulta_diagnostico1`
			FOREIGN KEY (`id_diagnostico`)
			REFERENCES `esquemaparcial`.`diagnostico` (`id_diagnostico`)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION)
		ENGINE = InnoDB
		DEFAULT CHARACTER SET = utf8;

		CREATE TABLE IF NOT EXISTS `esquemaparcial`.`tratamiento` (
		  `id_tratamiento` INT(11) NOT NULL,
		  `tratamiento` VARCHAR(45) NOT NULL,
		  PRIMARY KEY (`id_tratamiento`))
		ENGINE = InnoDB
		DEFAULT CHARACTER SET = utf8;

		CREATE TABLE IF NOT EXISTS `esquemaparcial`.`diagnostico` (
		  `id_diagnostico` INT(11) NOT NULL,
		  `diagnostico` VARCHAR(40) NOT NULL,
		  PRIMARY KEY (`id_diagnostico`))
		ENGINE = InnoDB
		DEFAULT CHARACTER SET = utf8;


		SET SQL_MODE=@OLD_SQL_MODE;
		SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
		SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
        
      */
       
    /*
		EJERCICIO 2)  B)  
        iii)  Cada vez que se borre un registro de la tabla veterinario o mascota, en la tabla consulta se deben conservar todos los 
			  registros, agregando un valor nulo en el campo eliminado. ¿Es posible realizar esta tarea? Explique.
              
              Esta tarea no es posible de realizar ya que los campos provinientes de veterinario o mascota forman parte de la PK de 
              la tabla consulta, y por restriciones los campos que conforman la PK de una tabla no pueden tomar el valor nulo.
              
    */
    
    
    /*
			EJERCICIO 2) D) Sugiera un orden de creación y llenado de las tablas. Justifique su respuesta.
            
            ORDEN DE CREACION Y LLENADO DE LAS TABLAS:
            1 - persona
            2 - duenio
            3 - veterinario
            4 - raza
            5 - mascota
            6 - tratamiento
            7 - diagnostico
            8 - consulta
            
            Considero que este orden es el mejor ya que primero trabajo con aquellas tablas que no requieren de algun campo de una tabla exterior
            no podriamos crear la tabla "dueño" sin antes haber creado la tabla de "persona" para propagarle la clave de la generalizacion, muchisimo
            menos podriamos cargarle los datos. Por la misma razon es que busco crear primero aquellas tablas como raza, diagnostico y tratamiento 
            antes de crear la ded consultas, o la de mascota. 
            
    */

   