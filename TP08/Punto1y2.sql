/*
	PUNTO 1)  DDL (DATA DEFINITION LANGUAGE - LENGUAJE DE DEFINICIÓN DE DATOS)
	
    Insiso b) 
    Escribir las sentencias SQL-DDL que le permitan realizar las modificaciones solicitadas en la base de datos Librería. Utilizando la 
    sentencia ALTER TABLE agregar las siguientes restricciones.
    
    i. Los campos “importe, gastoenvio y total” de la tabla venta debe tener por defecto el valor 0 (cero).
    
		ALTER TABLE venta 
		ALTER importe SET DEFAULT 0,
		ALTER gasto_envio SET DEFAULT 0,
		ALTER total SET DEFAULT 0;
    
    
    ii. El campo “cantidad” de la tabla detalle_venta no puede menor que 1 (uno)
    
		ALTER TABLE detalle_venta 
		ADD CONSTRAINT chkCantidad CHECK (cantidad>0)
    
									&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                                    %%                        %%
                                    %%          #####         %%
                                    %%       ###     ###      %%       Donde me puedo fijar si los resultados 
                                    %%       ##     ###       %%       son los esperados...
                                    %%            ###         %%
                                    %%           ##           %%
                                    %%                        %%
                                    %%           #            %%
                                    %%                        %%
                                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                    
                                    
	iii. Los campos “dni y empleado” de la tabla empleado no pueden ser nulos.
    
		ALTER TABLE `persona`
		CHANGE COLUMN `dni` `dni` VARCHAR(8) NOT NULL,
		CHANGE COLUMN `nombre` `nombre` VARCHAR(100) NOT NULL;	
	
    
    iv. Agregue el campo estado_multa VARCHAR (8) a la tabla préstamo.
		ALTER TABLE prestamo
		ADD COLUMN estado_multa VARCHAR(8)
    
    
    
    
    Insiso c) 
    Crear la tabla proveedor, como se detalla en la imagen. ¿Cuántos productos pueden proveer cada proveedor? Explicar.
    
		CREATE TABLE provedor 
		(
			id_provedor INT NOT NULL,
			nombre VARCHAR(100) NOT NULL,
			dni VARCHAR(8) NOT NULL,
			domicilio VARCHAR(100) NULL,
			telefono VARCHAR(9) NULL,
			id_articulo INT NOT NULL,
			CONSTRAINT pkprovedor PRIMARY KEY (id_provedor),
			CONSTRAINT refarticulo FOREIGN KEY (id_articulo) REFERENCES articulo (id_articulo)
		)
      
         
        SELECT * FROM provedor
			 LOAD DATA LOCAL INFILE 'C:/Users/nazar/Downloads/proveedor.csv' 
			 INTO TABLE libreria2.provedor 
			 FIELDS TERMINATED BY ','
			 ENCLOSED BY '"'
			 LINES TERMINATED BY '\n'
			 IGNORE 1 rows;
             
                                    &&&&&&&&&&&&&&&&&&&&&&&&&&&&
                                    %%                        %%
                                    %%          #####         %%
                                    %%       ###     ###      %%       Pudieron insertar e
                                    %%       ##     ###       %%       
                                    %%            ###         %%
                                    %%           ##           %%
                                    %%                        %%
                                    %%           #            %%
                                    %%                        %%
                                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
		select * from provedor

	
			
    
   
	INSERT INTO provedor 
    ( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
    VALUES ( 1, "Abaca Amado Daniel", 29608470, "Rivadavia 1266", 913270012, "1" )



	ALTER TABLE provedor
	ADD COLUMN id_articulo INT NOT NULL
	CONSTRAINT refarticulo FOREIGN KEY id_articulo REFERENCES articulo (id_articulo)
    
    Falta el punto 1 e, el 2 a de la tabla articulo
 

		CREATE TABLE provedor 
		(
			id_provedor INT NOT NULL,
			nombre VARCHAR(100) NOT NULL,
			dni VARCHAR(8) NOT NULL,
			domicilio VARCHAR(100) NULL,
			telefono VARCHAR(9) NULL,
			id_articulo INT NOT NULL,
			CONSTRAINT pkprovedor PRIMARY KEY (id_provedor),
			CONSTRAINT refarticulo FOREIGN KEY (id_articulo) REFERENCES articulo (id_articulo)
		);

		INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 1, "Abaca Amado Daniel", 29608470, "Rivadavia 1266", 913270012, "1" );
        
        INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 2, "Aballay, Hugo Hector", 13601726, " Santa Fe 266", 913224578, "2" );
        
        INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 3, "Abdo, Fco. Enrique", 17531657, "M. Moreno", 913232367, "3" );
        
        INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 4, "Abila, Antonio Enrique", 20191194, " B°El Carmen-Alvarado 2424", 913231212, "4" );
        
        INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 5, "Abrahan, Medardo Manuel", 11705042, "Ameghino 407", 913224451, "5" );
        
        INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 6, "Abregu, Luis Jose", 5944406, "Sgo Del Estero 1687", 913270765, "6" );
        
        INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 7, "Acosta, Magdalena Maria", 17659734, " San Juan 2400-Bk.H-Dt.101", 913259633, "7" );
        
        INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 8, "Aguero, Pablo Jose", 13835586, "España 253", 913235847, "8" );
        
        INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 9, "Aguilar, Dario Oscar", 24837296, " Olavarria 873", 913226878, "9" );
        
        INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 10, "Aguilar, Jose Juan", 11300774, "Alvarado 70", 913761221, "10" );
        
        INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 11, "Alderete, Alberto Jorge", 16260406, "B°Postal Pje U Casa 2", 913274556, "11" );
        
        INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 12, "Alfaro, Elena Luisa", 11407748, "Sgo Del Estero 1121", 913236594, "12" );
        
        INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 13, "Alfaro, Francisco Felix", 14291044, " Mendoza 1235", 913277415, "13" );
        
        INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 14, "Alfaro, Delfin Mario", 16563588, "Pje. Las Piedras 2356", 913278394, "14" );
        
        INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 15, "Alvarez, Isidro Gabriel", 10401834, " Pje Publico Mz.A C.6", 916548911, "15" );
        
        INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 16, "Amaya, Froilan Mario", 24186200, "Macueta", 916654320, "16" );
        
        INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 17, "Amaya, M. Orlando", 16336594, "Los Crisantemos 55", 912347865, "17" );
        
        INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 18, "Aranda, Oscar Alberto", 20775459, "Las Margaritas 245", 913564895, "18" );
        
        INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 19, "Arguello, Antonio Rolando", 13390359, " Urquiza 1456", 917654329, "19" );
		
		INSERT INTO provedor 
		( id_provedor, nombre, dni, domicilio, telefono, id_articulo) 
		VALUES ( 20, "Arrieta, Antonio Hector", 13835657, "B°100 Viv. Mz.C Casa 14", 913235568, "20" );
*/
	
	
/*

	2 	DML 	(DATA MANIPULATION LANGUAGE - LENGUAJE DE MANIPULACIÓN DE DATOS)
		 INSERT:  Haga las siguientes inserciones en las tablas que correspondan:

			INSERT INTO autor (id_autor, autor, tipo)
			VALUES ( 149 , "Beynon-Davies, Paul", "autor");
			
			INSERT INTO autor (id_autor, autor, tipo)
			VALUES ( 150 , "CUADRA, Dolores ", "autor");
			
			INSERT INTO autor (id_autor, autor, tipo)
			VALUES ( 151 , "Juan Carlos Orós", "autor");
            
            
            INSERT INTO genero (id_genero, genero)
			VALUES ( 42 , "informática");
            
            
            
			INSERT INTO editorial (id_editorial, editorial, tipo)
			VALUES ( 84 , "Editorial Reverté", "editorial");
            
            INSERT INTO editorial (id_editorial, editorial, tipo)
			VALUES ( 85 , "RA-MA", "editorial");
            
            INSERT INTO editorial (id_editorial, editorial, tipo)
			VALUES ( 86 , "RC libros", "editorial");
            
            
		b) DELETE: Borre los siguietes registros
        
            a) Elimine la empresa de envio “Andreani”.
            
				DELETE FROM envio
				WHERE 'envio' = "Andreani";
                
			b) Elimine los departamentos “Bolivar”, “Bragado”, “Brandsen”, “Campana”, “Cañuelas”.
				
                DELETE FROM ciudad
                WHERE 'ciudad' = ('Bolivar')
                
                DELETE FROM ciudad
                WHERE 'ciudad' = ('Bragado')
                
                DELETE FROM ciudad
                WHERE 'ciudad' = ('Brandsen')
                
                DELETE FROM ciudad
                WHERE 'ciudad' = ('Campana')
                
                DELETE FROM ciudad
                WHERE 'ciudad' = ('Cañuelas')
                
                
			c) Elimine los préstamos de los socios que hayan sido multados entre el 02-01-2015 y 31-03-2015
            
				DELETE FROM prestamo
				WHERE 'inicio_prestamo' BETWEEN '2015-01-02' AND '2015-03-31'
		
        
        c) UPDATE: Modifique los siguientes registros en las tablas que correspondan:
			
            a) Modifique el campo sueldo de la tabla empleados, aumentando en un 5%, de aquellos empleados cuyo sueldo supere los $100000.
            
				UPDATE empleado 
				SET sueldo = sueldo + (5 * sueldo)/100
				WHERE sueldo > 100000;
			
            b) Modifique el campo entregado de la tabla venta, con el valor “entregado” a todos los registros cuya fecha_envio sea 23-12-2021.
            
				UPDATE venta
				SET entregado = "entregado"
				WHERE fecha_envio = '2021-12-23';
                
                
			c) Modifique la tabla préstamo, el campo estado_multa, con el valor “pagado” y el campo devolución con la fecha del sistema, 
			   a todos los registros que hayan tenido multa entre el 02-01-2018 y el 31-12-2020.
               
                UPDATE prestamo 
				SET estado_multa = "pagado", fecha_devolucion = CURDATE() 
				WHERE multa > 0 AND fin_prestamo BETWEEN "2018-01-02" AND "2020-12-31";
                
                
									&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                                    %%                        %%
                                    %%          #####         %%
                                    %%       ###     ###      %%       Consultar los updates y los delete
                                    %%       ##     ###       %%       no son los esperados...
                                    %%            ###         %%
                                    %%           ##           %%       Recordar siempre ver los metodos de cascada y de modificacion...
                                    %%                        %%
                                    %%           #            %%
                                    %%                        %%
                                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
   */         
			
            
         
            
				DELETE FROM envio
				WHERE envio LIKE 'Andreani';
				
            
 /*
 
 #######      EJEJMPLOS DE LA TEORIA        ######
 
 UPDATE EMPLEADO SET SALARIO = 38400
WHERE APELLIDO = 'Pérez';
 
DELETE FROM table_name
WHERE condition;

DELETE FROM EMPLEADO
WHERE APELLIDO = 'Pérez';

 */


