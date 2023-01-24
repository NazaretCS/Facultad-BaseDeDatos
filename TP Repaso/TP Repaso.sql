/*

1 a) Realizar las siguientes consultas en MySQL Workbench, para ello, cree una base de datos cbd1 y levante el archivo de backup adjunto, 
	 que responde al modelo relacional superior.
     
     i. Muestre los expresos que no hayan realizado ningún envío a clientes de México o Brasil en el periodo del 01/06/2015 hasta el 30/06/2016
     
		 SELECT expreso FROM expreso
			WHERE idexpreso NOT IN (
									SELECT idexpreso FROM pedidos
									INNER JOIN clientes USING(idcliente)
									 WHERE  DATE(fechapedido) < '2015-06-01' OR DATE(fechapedido) > '2016-06-30' 
                                     AND pais NOT IN ('México', 'Brasil')
									)
                                    
                                    
	ii. Liste los empleados que sean de los países de “Alemania”, “Francia” o “Reino Unido”, y que hayan realizado algún pedido entre 
        01/09/15 y el 31/05/16 y que no sean “Director”, “Jefe de Sector” ni “Gerente Gral”, cuyo monto sea mayor que el promedio de 
        pedidos (promedio de los montos de los pedidos). Solo debe mostrar una vez a cada empleado y deben estar ordenados por orden 
        alfabético.
        
			SELECT empleado FROM empleados 
			INNER JOIN pedidos USING(idempleado)
			INNER JOIN cargos USING(idcargo)
			WHERE pais IN ('Alemania', 'Francia', 'Reino Unido') 
			AND fechapedido BETWEEN '2015-09-01' AND '2016-05-31'
			AND cargo NOT IN ('Director', 'Jefe de Sector', 'Gerente Gral')
			AND monto > (
						 SELECT AVG(monto) FROM pedidos
						)
			GROUP BY(idempleado)
			ORDER BY(empleado)
        
	iii. Muestre todos los clientes que sean de las ciudades de “México D.F.” o “Londres” que la suma total de sus pedidos (monto) supere 
		 la suma total de pedidos (monto) de “Antonio Moreno Taquería”, debe mostrar el id y el nombre del cliente y monto total de pedidos 
         ordenado de mayor a menor.
         
			SELECT idcliente, cliente, COUNT(idpedido) AS CantidadPedidos FROM clientes 
			INNER JOIN pedidos USING(idcliente)
			WHERE ciudad IN ('México D.F.', 'Londres') 
			GROUP BY(idcliente)
			HAVING SUM(monto) > (
							  SELECT SUM(monto) FROM clientes
							  INNER JOIN pedidos USING(idcliente)
							  WHERE cliente = 'Antonio Moreno Taquería'
							 )
			ORDER BY CantidadPedidos DESC
            
	iv. Muestre el nombre, cargo y sector de todos los empleados que residan en “Reino Unido” y en caso de tener familiares debe listar 
		junto a los datos de cada empleado el nombre y el parentesco del mismo. (Debe mostrar el Cargo y el Sector, no los id de los mismos)
        
			SELECT empleado, cargo, sector, nombrefliar, parentesco FROM empleados
            LEFT JOIN cargos USING(idcargo)
            LEFT JOIN sector USING(idsector)
            LEFT JOIN familiares USING(idempleado)
            WHERE pais = 'Reino Unido'
            
		
	v. Muestre el nombre, la categoría, el precio y el proveedor de los productos provenientes de “Alemania” y “Japon” que figuran en más 
	   de 30 pedidos, ordenados en forma descendente por el nombre del producto. (Debe mostrar la categoría y el proveedor, no los id 
       de los mismos)
       
			SELECT producto, categoria, precio, proveedor FROM productos
            INNER JOIN categorias USING(idcategoria)
            INNER JOIN proveedores USING(idproveedor)
			WHERE pais IN ('Alemania', 'Japon') AND idproducto IN (
																	SELECT idproducto FROM detalledepedidos
                                                                    WHERE iddetalle > 30
                                                                    GROUP BY(idproducto) 
																   )
			
	vi. Muestre el id, nombre, cargo, sector y monto total de venta (suma del monto de todos los pedidos en los que interviene el empleado) 
		de los empleados que hayan vendido más que el monto promedio de venta (promedio de todos los montos de los pedidos) de los pedidos 
        enviados por el expreso “FedEx Express”. (Debe mostrar el nombre del Cargo y el Sector, no los id de los mismos)
        
			SELECT idempleado, empleado, cargo, sector, SUM(monto) AS MontoTotalVenta FROM empleados
            INNER JOIN cargos USING(idcargo)
            INNER JOIN sector USING(idsector)
            INNER JOIN pedidos USING(idempleado)
            INNER JOIN expreso USING(idexpreso)
            WHERE expreso = 'FedEx Express'
            GROUP BY(idempleado)
            HAVING MontoTotalVenta > (
									  SELECT AVG(monto) FROM pedidos	
									 ) 
                                     
	vii. Muestre el nombre, categoría, precio y proveedor de los productos que fueron pedidos por todos los clientes. 
		(Debe mostrar la categoría y el proveedor, no los id de los mismos)
        
			
            SELECT producto, categoria, precio, proveedor FROM productos
            INNER JOIN proveedores USING(idproveedor)
            INNER JOIN categorias USING(idcategoria)
            GROUP BY(idproducto)
            HAVING COUNT( DISTINCT( idproducto ) ) IN (
													    SELECT COUNT(idcliente) FROM clientes														
														INNER JOIN pedidos USING(idcliente)
														INNER JOIN detalledepedidos USING(idpedido)
														GROUP BY(idcliente)
                                                     )
			# Revisar 
            
            
	viii. Obtenga una lista con el id, nombre, sector, cargo y sueldo de todos los empleados del sector “compras” o “ventas” cuyo sueldo 
		  es mayor o igual que el sueldo promedio de todos los empleados del sector “Gerencia”, ordenado por sector, cargo y sueldo. 
          (Debe mostrar el Cargo y el Sector, no los id de los mismos)
          
			SELECT idempleado, empleado, sector, cargo, sueldo FROM empleados 
			INNER JOIN sector USING(idsector)
			INNER JOIN cargos USING(idcargo)
			WHERE sector IN ('compras','ventas') AND sueldo >= (
																SELECT AVG(sueldo) FROM empleados
																INNER JOIN sector USING(idsector)
																WHERE sector = 'Gerencia'
																) 
			ORDER BY sector, cargo, sueldo


	ix.	 Muestre el nombre de todos los empleados que no hayan intervenido en ningún pedido entre el '01-05-2015' y ’30-04-2016'.
		
			SELECT empleado, fechapedido  FROM empleados
			FULL OUTER JOIN pedidos USING(idempleado)
			WHERE fechapedido NOT BETWEEN '2015-05-01' AND '2016-04-30'
			GROUP BY(idempleado)
    
    
    x. 	Muestre los expresos que no hayan realizado ningún envío.
		
			SELECT expreso, idexpreso FROM expreso
			WHERE idexpreso NOT IN (
									SELECT distinct idexpreso FROM pedidos
									WHERE  idexpreso IS NOT NULL
									)
                                    
	xi. Liste a los empleados que tengan más de 55 años de edad y 15 años de antigüedad. Debe mostrar el id, nombre, edad, antigüedad, 
		cargo que ocupa y el sector donde trabaja, ordenados por edad de manera descendente y por antigüedad de manera ascendente 
        (los nombres, no idcargo e idsector).
        
			SELECT idempleado, empleado, TIMESTAMPDIFF(year, fechanacimiento,curdate()) AS Edad, TIMESTAMPDIFF(year, fechacontratacion,curdate()) 
				   AS Antiguedad, cargo, sector FROM empleados
			INNER JOIN cargos USING(idcargo)
			INNER JOIN sector USING(idsector)
			HAVING Edad > 55 AND Antiguedad > 15
			ORDER BY Edad DESC,  Antiguedad ASC
		
	
    xii. Muestre todos los empleados que sean de las ciudades de “Seattle” o “Londres” cuya edad no supere los 50 años y que la suma total 
		 de sus ventas (monto) supere la suma total de ventas (monto) de “UGARTE SILVINA”, debe mostrar los datos del empleado y monto total 
         de ventas ordenado de mayor a menor.
			
            SELECT idempleado, empleado, TIMESTAMPDIFF(year, fechanacimiento,curdate()) AS Edad, SUM(monto) AS TotalVendido  FROM empleados 
            INNER JOIN pedidos USING(idempleado)
            WHERE ciudad IN ('Seattle','Londres') 
            GROUP BY(idempleado)
            HAVING Edad < 50 AND TotalVendido > (
												 SELECT SUM(monto) FROM empleados
                                                 INNER JOIN pedidos USING(idempleado)
                                                 WHERE empleado LIKE '%UGARTE  SILVINA%'                                                 
												)
	xiii. Liste los clientes que sean de los países de “Canadá”, “Francia” o “Finlandia”, y que hayan realizado pedidos en los que el monto 
		  del mismo supere el promedio del monto de todos los pedidos. Solo debe mostrar una vez a cada cliente y deben estar ordenados por 
          orden alfabético.
			
            	SELECT cliente, pais, monto as MontoPedido FROM clientes
				INNER JOIN pedidos USING(idcliente)
				WHERE pais IN ('Francia','Finlandia','Canadá') AND monto > (
																			 SELECT AVG(monto) FROM pedidos
																			)
				GROUP BY(idcliente)
				ORDER BY cliente
*/


		
		
            

	
    
		
        
			                    
		
        
		
			
            
            
            
            
            
            
            
            
		
		
		
		
		