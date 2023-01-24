#SELECT * FROM ciudad;


# a
/*
SELECT AVG(precio) AS Prom_PrecioArticulos
FROM articulo;
*/

# B
/*
SELECT MAX(sueldo) AS SueldoMaximo
FROM empleado
*/


# C  	Liste el valor más económico de las membresías que no sea la membresía ‘basico’, el campo debe llamarse “membresía más barata”.
/*
SELECT MIN(precio) AS Membresía_Más_Barata
FROM membresia
WHERE membresia <> 'basico'
*/


# D 	Obtenga la cantidad de préstamos de los artículos 101, 169, 182, 218, 368 y 392. Llamar el campo como “cantidad de préstamos”.
/*
SELECT COUNT(id_articulo) AS CantidadDePréstamos
FROM prestamo
WHERE id_articulo IN (101, 169, 182, 218, 368, 392)
GROUP BY id_articulo;
*/


# E    Muestre la cantidad de los préstamos que aún no fueron devueltos, llamar el campo como “no devueltos”.
/*
SELECT COUNT(id_articulo) AS NoDevueltos
FROM prestamo
WHERE fecha_devolucion IS NULL

*/


# F    Obtenga el monto total de todas las ventas realizadas entre el ‘10-05-2019’ y ‘31-07-2020’.

/*
SELECT SUM(total) AS MontoTotalVentas
FROM venta
WHERE fecha BETWEEN  '2019-05-10' AND '2020-07-31'
*/


/* G		Muestre la cantidad de socios proveniente de cada ciudad. Debe mostrar el nombre de la ciudad, la provincia y la cantidad de 
			socios, ordenados alfabéticamente por provincia y luego por ciudad   */
            
/*
SELECT COUNT(id_ciudad) AS CantSociosPorCiudad, ciudad, provincia
FROM socio 
INNER JOIN ciudad USING(id_ciudad)
INNER JOIN provincia USING(id_provincia)
GROUP BY id_ciudad
ORDER BY provincia, ciudad;
  # Consultar lo del ordenbamiento 
*/


# H      Obtenga el listado de los empleados que tienen familiares, mostrando el nombre del empleado y la cantidad de familiares que tiene.
/*
SELECT  nombre, COUNT(id_empleado) AS CantFamiliares
FROM empleado
INNER JOIN familiar USING(id_empleado)
GROUP BY(id_empleado)
*/


/*I 	Muestre el monto total vendido por cada empleado, indicando el id, nombre y función del mismo. El monto debe llamarse total de ventas.
		Ordenado por nombre alfabéticamente.  */
/*
SELECT id_empleado, nombre, funcion, SUM(total) AS total_ventas FROM venta
INNER JOIN empleado USING(id_empleado)
INNER JOIN persona ON id_empleado = id_persona
INNER JOIN funcion USING(id_funcion)
GROUP BY id_empleado
ORDER BY nombre;
*/


/* J 	Liste la cantidad de préstamos solicitados por los socios que no sean de “Córdoba” ni “Buenos Aires”. Debe mostrar el nombre del 
		socio y la ciudad a la que pertenece, la cantidad debe llamarse “cant_prest”. Ordenado alfabéticamente por ciudad, luego de forma 
        descendente por cantidad de mayor a menor y por último por nombre del socio.  */

/*
SELECT  nombre, ciudad, COUNT(id_socio) as Cant_Prest
FROM socio
INNER JOIN persona ON id_persona = id_socio
INNER JOIN ciudad USING(id_ciudad)
INNER JOIN provincia USING(id_provincia)
WHERE provincia <> 'Córdoba' and provincia <> 'Buenos Aires'
GROUP BY(id_socio)
#ORDER BY(id_socio)
ORDER BY ciudad, Cant_Prest DESC, nombre;
*/


/*   K 		Muestre el código, título y el precio de los 20 artículos más vendidos en los años 2019 y 2020, donde la “cantidad_total” 
			sea menor a 25 */
     
/*
SELECT A.id_articulo, A.titulo, A.precio, COUNT(id_articulo) as Cantidad_total
FROM articulo A
INNER JOIN detalle_venta DV USING(id_articulo)
INNER JOIN venta V USING(id_venta)
WHERE YEAR(fecha) BETWEEN 2019 and 2020
GROUP BY(id_articulo)
HAVING Cantidad_total < 25
ORDER BY(Cantidad_total) DESC
LIMIT 20;
*/


/*   L		Obtenga la cantidad de membresías vendidas hasta el ’01-07-2021’, mostrando lo recaudado por cada membresía en cada mes 
			y año, donde la recaudación sea mayor a 40000. 	*/

/*
SELECT SUM(id_membresia) as CantMembreias, mes, anio, SUM(precio) as Recaudado
FROM membresia 
INNER JOIN pago USING(id_membresia)
WHERE  	fecha_pago < '2021-07-01'
GROUP BY id_membresia ,mes, anio
HAVING Recaudado > 40000
ORDER BY mes, anio
*/
# Si le saco el HAVING no me deveria mostrar todos los meses con sus respectivos años y demas datos.?? 1 - 2018; 2 - 2018; 3 - 2018... ect  o es posible que halla meses donde no se registraron membresias.??


/*	M		Muestre el total de artículos comprados por los socios, indicando el nombre y la provincia del socio, la cantidad de artículos 
comprados y el monto gastado por dichas compras. De los socios que sean de “Córdoba” o “Buenos Aires”. Donde las cantidades sean mayores 
o iguales a 10. Ordenado por cantidad de mayor a menor y luego por el total de manera descendente.   */


/*
SELECT SUM(DV.id_venta) AS CantArticulos, PE.nombre, P.provincia, COUNT(V.id_venta) AS ArtComprados, SUM(V.total) AS Total
FROM detalle_venta DV
INNER JOIN venta V USING(id_venta)
INNER JOIN socio S USING(id_socio)
INNER JOIN persona PE ON id_persona = id_socio
INNER JOIN ciudad USING(id_ciudad)
INNER JOIN provincia P USING(id_provincia)
WHERE P.provincia IN ('Córdoba', 'Buenos Aires')
GROUP BY S.id_socio
HAVING ArtComprados < 10
ORDER BY ArtComprados DESC, Total;
*/


# 	N		Muestre el nombre, la función, el sueldo y la antigüedad de los empleados en la empresa.

/*
SELECT nombre, funcion, sueldo, timestampdiff(year, fecha_alta,curdate()) AS Antiguedad
FROM empleado
INNER JOIN persona ON id_persona = id_empleado
INNER JOIN funcion USING(id_funcion)
#ORDER BY (nombre)
*/


/*	O 		Muestre el nombre, el domicilio, la ciudad y la provincia de cada socio. El domicilio, la ciudad y la provincia deben estar en 
			una sola columna separados por coma (domicilio, ciudad, provincia). Provincia debe estar en mayúsculas.		*/

/*
SELECT nombre as Nombre, CONCAT(domicilio, ',  ', ciudad, ',  ', UPPER(provincia)) AS Dirección
FROM socio
INNER JOIN persona ON id_persona = id_socio
INNER JOIN ciudad USING(id_ciudad)
INNER JOIN provincia USING(id_provincia)
*/


# 	P 		Muestre la cantidad de empleados que tienen 1, 2 y 3 años de antigüedad

/*
SELECT SUM(id_empleado)
FROM empleado
WHERE timestampdiff(year, fecha_alta,curdate()) BETWEEN 1 AND 3
*/


/* 	Q 		Liste todos los empleados indicando el nombre, la fecha de alta y la función (la misma debe estar abreviada indicando solo las 
			3 primeras letras). Ordene alfabéticamente por la función.  */
 
 /*
SELECT nombre, fecha_alta, SUBSTR(funcion,1,3) AS Funcion
FROM empleado
INNER JOIN persona ON id_persona = id_empleado  
INNER JOIN funcion USING(id_funcion)
ORDER BY Funcion
*/


#	R		Muestre el nombre más largo de entre todas las personas.

/*
SELECT 	LENGTH(nombre) as Largo, nombre
FROM persona
ORDER BY Largo DESC
LIMIT 1;
*/

#Consultar otras formas de hacerlo


#	S 		Muestre el promedio de sueldos (debe estar redondeado a 2 decimales)

/*
SELECT round(AVG(sueldo),2) AS Promedio_De_Sueldos
FROM empleado
*/


#	T		Muestre el total a pagar de los préstamos que tienen multas (monto + multa) donde la multa sea mayor al monto del préstamo

/*
SELECT id_socio, monto, multa, (monto + multa) AS TotalAPagar
FROM prestamo
WHERE multa IS NOT NULL and multa > monto
GROUP BY(id_socio)
*/

/*	U 		Muestre el nombre del empleado, la fecha de alta y la antigüedad, teniendo en cuenta que, para este caso, la antigüedad se 
			computa por año completo, es decir, realice el cálculo desde el 1 de enero del año siguiente a la fecha de alta.	*/

/*
SELECT nombre, fecha_alta, timestampdiff(year, date_add(fecha_alta, interval 1 year), curdate()) as antiguedad 
FROM persona 
INNER JOIN empleado on id_persona = id_empleado
*/



