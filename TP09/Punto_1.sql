/*

1 SUB-CONSULTAS: 	Usando la base de datos de LIBRERÍA, escriba las consultas para resolver los siguientes requerimientos
    
	a) Muestre las empresas de envío que no fueron utilizadas por la librería para realizar entregas entre el 01-01-2020 y el 31-05-2020.
		
		
        SELECT envio FROM envio
        WHERE id_envio NOT IN (
							   SELECT id_envio FROM envio 
							   INNER JOIN venta USING(id_envio) 
                               WHERE fecha_envio BETWEEN '2020-01-01' and '2020-05-31' 
                               )


	b) Liste el nombre de las ciudades a las cuales no se envió nunca un artículo.

		SELECT ciudad FROM ciudad
        WHERE id_ciudad NOT IN ( 
								SELECT id_ciudad FROM socio						
                                INNER JOIN venta USING(id_socio)
                                WHERE id_envio IS NOT NULL 
                                GROUP BY(id_socio)
								)

	c) Liste todas las funciones que no fueron asignadas a ningún empleado.
		
        SELECT funcion FROM funcion 
        WHERE funcion IS NOT NULL AND id_funcion NOT IN (
														SELECT id_funcion FROM empleado
														)

	d) Muestre las empresas de envío que fueron utilizadas por la librería para entregar las compras entre los días 01-01-2019 y 
       31-12-2019 a las provincias de 'La Rioja' y 'Mendoza'.
       
			SELECT envio FROM envio 
        WHERE id_envio IN (
							SELECT id_envio FROM venta
                            INNER JOIN socio USING(id_socio)
                            INNER JOIN ciudad USING(id_ciudad)
                            INNER JOIN provincia USING(id_provincia)
                            WHERE fecha_envio between  '2019-01-01' AND '2019-12-31'  AND provincia IN ('La Rioja', 'Mendoza')
                            )

	e) Obtenga el número de venta, el id y nombre del socio, el id y nombre del empleado, fecha y el importe de todas las ventas que 
		superaron el importe promedio de venta, ordenado por importe de mayor a menor, fecha y socio.
        
        
        SELECT id_venta, id_socio AS socio, PE.nombre AS NombreSocio, id_empleado, PERS.nombre AS NombreEmpleado, fecha, importe FROM venta
        INNER JOIN socio S USING(id_socio)
        INNER JOIN persona PE ON PE.id_persona = id_socio   
        
        INNER JOIN empleado EMP USING(id_empleado)
        INNER JOIN persona PERS ON (PERS.id_persona = id_empleado)             
        WHERE importe > (
						 SELECT AVG(importe) FROM venta 
                         )
		ORDER BY importe DESC, fecha, socio

	f) Liste el id, nombre, la ciudad y la provincia de todos los socios que hayan comprado artículos del género ‘Acción’ desde 
		el 01-01-2019 en adelante, ordenados alfabéticamente.
        
        
        SELECT id_socio, nombre, ciudad, provincia FROM socio
        INNER JOIN persona ON id_persona = id_socio
        INNER JOIN ciudad USING(id_ciudad)
        INNER JOIN provincia USING(id_provincia)
        WHERE id_socio IN (
							SELECT id_socio FROM venta
                            INNER JOIN detalle_venta USING(id_venta)
                            INNER JOIN articulo USING(id_articulo)
                            INNER JOIN genero USING(id_genero)
                            WHERE genero = 'Accion' AND fecha < '2019-01-01'
                            #GROUP BY(id_socio) 							   #Si coloco el agrupamiento, de alguna manera estoy disminuyendo el 
						   )												   # el numero de comparaciones que se realizan.???

																			&&&&&&&&&&&&&&&&&&&&&&&&&&&&
																			%%                        %%
																			%%          #####         %%
													             			%%       ###     ###      %%      
																			%%            ###         %%
																			%%           ##           %%
																			%%                        %%
																			%%           #            %%
																			%%                        %%
																			%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	g) Obtenga el socio, el empleado, título y la fecha de todos los artículos que fueron vendidos en ‘Tucumán’, ‘Salta’ y ‘Jujuy’ y 
       tienen el mismo autor del artículo de título ‘Cien Años De Soledad’. Ordenado por título, fecha y empleado.
       
       
		SELECT PERS.nombre AS NombreSocio, PE.nombre AS NombreEmpleado, titulo, fecha FROM articulo
        INNER JOIN detalle_venta USING(id_articulo)
        INNER JOIN venta USING(id_venta)
        
        INNER JOIN socio S USING(id_socio)
        INNER JOIN persona PERS ON (PERS.id_persona = id_socio)
        
        INNER JOIN empleado USING(id_empleado)
        INNER JOIN persona PE ON (PE.id_persona = id_empleado )
        
        INNER JOIN ciudad USING(id_ciudad)
        INNER JOIN provincia USING(id_provincia)
        WHERE provincia IN ('Tucumán', 'Salta', 'Jujuy') AND id_autor IN (
																			SELECT id_autor FROM articulo 
                                                                            WHERE titulo = 'Cien Años De Soledad'
                                                                            GROUP BY id_autor 
																		 )
		ORDER BY titulo, fecha, id_empleado;
                                                                         
										
    h) Muestre el nombre y la función de todos los empleados y, en caso de tener familiares, debe listar junto a los datos de cada empleado, 
       el nombre y el parentesco del mismo. Ordenar del modo adecuado para mostrar primero los empleados que no tienen familiares.
		
        SELECT PER.nombre, funcion, F.nombre, F.parentesco FROM empleado
		LEFT JOIN persona PER ON (id_persona = id_empleado)
		LEFT JOIN familiar F USING(id_empleado)
		LEFT JOIN funcion USING(id_funcion)
			
	i) Muestre género, el origen, el título y el precio de todos los artículos; y en caso no tener información de origen o género, debe 
       mostrar el título. El listado sólo debe mostrar los artículos que no tiene información del año de creación. 
       NOTA: Debe usar LEFT Y RIGHT JOIN
       
        SELECT genero, origen, titulo, precio FROM articulo
		LEFT JOIN genero USING(id_genero) 
		LEFT JOIN origen USING(id_origen)
		WHERE id_articulo IN (
							  SELECT id_articulo FROM articulo
							  WHERE anio IS NULL
							 )
       
       
	j) Liste todas las ciudades y la provincia a la que pertenece, y, en caso de que haya socios registrados en las mismas, también mostrar 
	   el socio, ordenado por ciudad en forma descendente y por socio alfabéticamente.

		SELECT * FROM ciudad 
		INNER JOIN provincia USING(id_provincia)
		INNER JOIN socio USING(id_ciudad)
		INNER JOIN persona PE ON id_persona = id_socio
		ORDER BY id_ciudad DESC, id_socio;
		
	k) Muestre el id, nombre, función y el monto total de ventas realizadas, de los empleados que no hayan superado
	   en monto a "Carrascosa Laura Fabiola".
       
		SELECT id_empleado, nombre, funcion, SUM(total) AS TotalVendido FROM empleado
        INNER JOIN funcion USING(id_funcion)
        INNER JOIN persona ON id_persona = id_empleado
        INNER JOIN venta USING(id_empleado)
        GROUP BY(id_empleado)
        HAVING TotalVendido < (
							SELECT SUM(total) FROM venta
                            INNER JOIN empleado USING(id_empleado)
                            INNER JOIN persona ON id_persona = id_empleado
                            WHERE nombre = 'Carrascosa Laura Fabiola'
                            group by(id_empleado)
							)
		
       
       
       l) Muestre el id, nombre, la ciudad y la cantidad de artículos comprados por los socios que no sean de 'Chaco', 'Formosa', 
          'Corrientes' ni 'Misiones' y que hayan comprado más artículos que la cantidad total vendida del articulo 'Harry Potter Y 
          La Orden del Fénix'.
          
            SELECT id_socio, nombre, ciudad, SUM(id_venta) AS CantArticulos FROM socio
			INNER JOIN persona ON id_persona = id_socio
			INNER JOIN ciudad USING(id_ciudad)
			INNER JOIN venta USING(id_socio)
			INNER JOIN provincia USING(id_provincia)            
			WHERE provincia NOT IN ('Chaco', 'Formosa', 'Corrientes', 'Misiones') 
            GROUP BY(id_socio) 
            HAVING CantArticulos > ANY (
									   SELECT SUM(id_articulo) FROM detalle_venta
									   INNER JOIN articulo USING(id_articulo)
									   WHERE titulo = 'Harry Poter Y La Orden Del Fenix'
									   )
		m) Liste todas las funciones existentes, y en caso de haber sido asignada a algún empleado, también debe mostrar
           el nombre y el sueldo del mismo.
           
            SELECT funcion, nombre, sueldo FROM funcion
            LEFT JOIN empleado USING(id_funcion)
            LEFT JOIN persona ON id_persona = id_empleado
	      
		
        n) Obtenga una lista con el id, nombre, función, sueldo, antigüedad y año de ingreso de todos los empleados que posean por lo 
           menos 1 año de antigüedad y cuyo año de ingreso sea posterior al año de ingreso de 'Vega Miranda Americo Raul'. 
		   Ordenado por antigüedad de mayor a menor.
	
		   SELECT id_empleado, nombre, funcion, sueldo, timestampdiff(year, fecha_alta,curdate()) AS Antiguedad, fecha_alta FROM empleado
		   INNER JOIN persona ON id_persona = id_empleado
		   INNER JOIN funcion USING(id_funcion)
		   WHERE timestampdiff(year, fecha_alta,curdate()) >= 1 AND fecha_alta > (
																				  SELECT fecha_alta FROM empleado
																				  INNER JOIN persona ON (id_persona = id_empleado)
																				  WHERE nombre = 'Vega Miranda Americo Raul'
																				  )
		
        o) Muestre el id y el nombre de TODAS las empresas de envío, y también mostrar la cantidad de entregas realizadas por c/empresa 
           a cada provincia (de haberlo hecho). Ordenar de mayor a menor por cantidad de envíos.
      
		   SELECT id_envio, envio, SUM(V.id_envio) AS EnviosTotales, provincia FROM envio
		   LEFT JOIN venta V USING(id_envio)
		   LEFT JOIN socio USING(id_socio)
		   LEFT JOIN ciudad USING(id_ciudad)
		   LEFT JOIN provincia USING(id_provincia)
		   GROUP BY(id_envio)
                                                                            
                                                                            
		p) Muestre el id, nombre, función y monto total de ventas de los empleados que hayan vendido menos que el 10% del monto
           total de las ventas enviadas por “FedEx”.
           
			SELECT id_empleado, nombre, funcion, SUM(total) AS TotalVentas FROM empleado
			INNER JOIN persona ON id_persona = id_empleado 
			INNER JOIN funcion USING(id_funcion)
			INNER JOIN venta USING(id_empleado)
            group by id_empleado
			HAVING SUM(total)  < (	
								 SELECT SUM(total) FROM venta
								 INNER JOIN envio USING(id_envio)
								 WHERE envio = 'FedEx'
								) /10
		q) Modifique el gasto de envío, aumentando un 5%, a las ventas enviadas por ‘UPS’, ‘DHL’ o ‘FedEx’
        
			UPDATE venta SET gasto_envio = (gasto_envio + (gasto_envio*5)/100)
			WHERE id_envio IN  (
							   SELECT id_envio FROM envio
							   WHERE envio IN ('UPS', 'DHL', 'FedEx')
							   )
                               
		r) Modifique el monto de la multa, aumentando un 10%, de todos los préstamos, de aquellos artículos que tienen origen España, 
		   Colombia o Irlanda y el autor no sea 'Gustavo Adolfo Bécquer'.
           
		UPDATE prestamo SET multa = (multa + (multa*10))
        WHERE id_articulo IN  (
							  SELECT id_articulo FROM articulo
                              INNER JOIN origen USING(id_origen)
                              INNER JOIN autor USING(id_autor)
							  WHERE origen IN ('España', 'Colombia', 'Irlanda') AND autor <> 'Gustavo Adolfo Bécquer'
                              )
		
		s) Elimine las empresas de envío que nunca fueron utilizadas.
			DELETE FROM envio
			WHERE id_envio IN   (
								SELECT id_envio FROM envio
								LEFT JOIN venta USING(id_envio)
								WHERE gasto_envio IS NULL
								)
                                
			DELETE FROM envio
			WHERE id_envio NOT IN (SELECT distinct id_envio
								   FROM venta);
                                
			DELETE FROM envio
			WHERE id_envio NOT IN (
									SELECT id_envio FROM venta	
									)
                                                                            
        t) Elimine todos los préstamos realizados entre ’01-01-2019’ y 31-12-2020’ y que hayan pagado multa, de aquellos artículos de los 
           cuales no se tiene información del origen del mismo.
           
           DELETE FROM prestamo
            WHERE inicio_prestamo BETWEEN '2019-01-01' AND '2020-12-31' AND id_socio IN (
																						SELECT id_socio FRom prestamo
																						LEFT JOIN socio USING(id_socio)
																						LEFT JOIN articulo USING(id_articulo)
																						WHERE multa IS NOT NULL AND id_origen IS NULL
																					   )
	
    
    2 VISTAS: Usando los comandos adecuados cree las vistas necesarias para satisfacer las siguientes necesidades:
		
        a) Genere una vista llamada info_venta que muestre el nombre del empleado, el nombre y la provincia del socio, el título del 
           artículo, autor, género, origen, editorial y el precio (tabla detalle_venta) de todos los artículos vendidos, la fecha de 
           envío cada uno de los artículos, la empresa por la que fue enviado, la fecha de entrega y si fue entregado, ordenado por 
           artículo y la fecha de venta.
           
            CREATE VIEW Info_Venta AS
			SELECT EMP.nombre AS NombreEmpleado, S.nombre AS NombreSocio, provincia, titulo, autor, genero, editorial, DV.precio, 
				   fecha_envio, envio, entregado FROM venta
			INNER JOIN socio USING(id_socio)
			INNER JOIN persona S ON (S.id_persona = id_socio)
			INNER JOIN empleado USING(id_empleado)
			INNER JOIN persona EMP ON (EMP.id_persona = id_empleado)
			INNER JOIN ciudad USING(id_ciudad)
			INNER JOIN provincia USING(id_provincia)
			INNER JOIN detalle_venta DV USING(id_venta)
			INNER JOIN articulo USING(id_articulo)
			INNER JOIN autor USING(id_autor)
			INNER JOIN genero USING(id_genero)
			INNER JOIN editorial USING(id_editorial)
			INNER JOIN envio USING(id_envio) 
			ORDER BY(id_articulo, fecha)
	
		b) Genere una vista llamada info_prestamos que muestre el nombre, la ciudad y provincia del socio, el título del artículo, autor, 
           género, origen, editorial, el monto y la multa de todos los artículos prestados, la fecha de inicio préstamo, fecha del fin, 
           fecha de devolución, la cantidad de días agendada para el préstamo (de acuerdo a las fechas de inicio y fin) y la cantidad de 
           días que duró cada préstamo realmente, considerando la fecha de inicio y devolución.
		   Una vez creada la vista muestre nombre del socio, título del artículo, y la diferencia en días de mora en la devolución.
		
			CREATE VIEW info_prestamos AS
			SELECT nombre, ciudad, provincia, titulo, autor, genero, origen, editorial, monto, multa, inicio_prestamo, fin_prestamo, 
				   fecha_devolucion, DATEDIFF(inicio_prestamo, fin_prestamo) AS CantDiasEstipuladoPrestamo, 
				   DATEDIFF(inicio_prestamo, fecha_devolucion) AS CantDiasPrestamo
			FROM socio
			INNER JOIN persona ON id_persona = id_socio
			INNER JOIN ciudad USING(id_ciudad)
			INNER JOIN provincia USING(id_provincia)
			INNER JOIN prestamo USING(id_socio)
			INNER JOIN articulo USING(id_articulo)
			INNER JOIN autor USING(id_autor) 
			INNER JOIN genero USING(id_genero) 
			INNER JOIN origen USING(id_origen) 
			INNER JOIN editorial USING(id_editorial) 
            
            SELECT nombre, titulo, (CantDiasPrestamo - CantDiasEstipuladoPrestamo) AS DiasDeMoraDevolucion FROM info_prestamos
    */



    
			
            
		
    
		
       

    
        									  
							
		


