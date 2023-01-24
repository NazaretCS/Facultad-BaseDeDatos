#SELECT * FROM articulo;
#SELECT * FROM envio;

# a) SELECT * FROM personas;

# b) SELECT  id_articulo, titulo, precio FROM articulo;

# c) SELECT envio FROM envio;

# d) SELECT * FROM prestamo WHERE inicio_prestamo > "2019-02-15";

# e) SELECT id_autor, autor FROM autor order by autor;

# f) SELECT editorial FROM editorial order by editorial;

# g) SELECT id_venta, total FROM ventas WHERE total < 6500;

# h) SELECT id_articulo, fin_prestamo, fin_prestamo FROM prestamo 
#    WHERE fecha_devolucion is null;

# i) SELECT nombre, sueldo, fecha_alta FROM empleado, personas 
#    WHERE empleado.id_empleado = personas.id_persona;

# j)
/*
SELECT nombre, ciudad, provincia FROM socio
INNER JOIN personas ON id_socio = id_persona
INNER JOIN ciudad USING(id_ciudad) 
INNER JOIN provincia USING(id_provincia);
*/

# k) 
/*
SELECT * FROM ventas 
INNER JOIN envio USING(id_envio)
WHERE envio <> "DHL" Or envio <> "FedEx"
*/


# l)
/* SELECT p.nombre, f.nombre, parentesco FROM personas p
INNER JOIN empleado ON id_empleado = id_persona
INNER JOIN familiar f USING(id_empleado)
*/

# m
/*
SELECT nombre, fecha_pago FROM socio 
INNER JOIN personas ON id_socio = id_persona
INNER JOIN pago USING(id_socio)
WHERE anio = 2019;
*/

# n
/*
SELECT * FROM articulo
INNER JOIN 	origen USING(id_origen)
INNER JOIN genero USING(id_genero)
WHERE origen IN ("Alemania", "Argentina", "Colombia") AND genero = "Novela"
*/

# o
/*
SELECT id_socio, nombre, domicilio FROM socio
INNER JOIN personas ON id_persona = id_socio
INNER JOIN ciudad USING(id_ciudad)
INNER JOIN provincia USING(id_provincia)
WHERE provincia <> "Buenos Aires" and provincia <> "Cordoba";
*/

# p) 
/*
SELECT P.nombre, Emp.sueldo, Emp.fecha_alta FROM personas P 
INNER JOIN empleado Emp ON P.id_persona LIKE Emp.id_empleado 
WHERE Emp.sueldo > 85000 and Emp.fecha_alta > "2020-12-31" 
order by Emp.sueldo DESC;
*/

# p) 
/*
SELECT P.nombre, Emp.sueldo, Emp.fecha_alta FROM personas P 
INNER JOIN empleado Emp ON P.id_persona LIKE Emp.id_empleado 
WHERE Emp.sueldo > 85000 and Emp.fecha_alta > "2020-12-31" 
order by P.nombre;
*/

# q
/*
SELECT DISTINCT id_editorial, editorial FROM editorial
INNER JOIN articulo USING(id_editorial)
INNER JOIN origen USING(id_origen)
WHERE origen IN ("Colombia", "Francia");
*/

# r
/*
SELECT id_socio, nombre, multa FROM socio 
INNER JOIN personas ON id_socio = id_persona
INNER JOIN prestamo USING(id_socio)
WHERE multa is NOT NULL
ORDER BY nombre;
*/

# r
/*
SELECT id_socio, nombre, multa FROM socio 
INNER JOIN personas ON id_socio = id_persona
INNER JOIN prestamo USING(id_socio)
WHERE multa is NOT NULL
ORDER BY multa;
*/


# s
/*
SELECT id_articulo, titulo, genero, origen, editorial, autor FROM articulo
INNER JOIN origen USING(id_origen)
INNER JOIN autor USING(id_autor)
INNER JOIN editorial USING(id_editorial)
INNER JOIN genero USING(id_genero)
WHERE autor IN ("Spike Lee", "Clint Eastwood");
*/

# t
/*
SELECT titulo, origen FROM articulo 
INNER JOIN origen USING(id_origen)
WHERE anio is NULL and precio < 4500;
*/

# u) 
/*
SELECT * FROM articulo a
INNER JOIN	autor atr USING(id_autor)
INNER JOIN	prestamo pr USING(id_articulo)
WHERE pr.inicio_prestamo not between '2016-01-01' and '2020-12-31' 	AND  (atr.autor = 'Alejandro Dumas' OR atr.autor= 'Oscar Wilde');
*/

# v
/*
SELECT * FROM ciudad 
INNER JOIN provincia USING(id_provincia)
INNER JOIN socio USING(id_ciudad)
ORDER BY ciudad DESC;
*/

# v
/*
SELECT * FROM ciudad 
INNER JOIN provincia USING(id_provincia)
INNER JOIN socio USING(id_ciudad)
ORDER BY socio
*/


# w
/*
SELECT * FROM socio 
INNER JOIN pago USING(id_socio)
WHERE fecha_pago > '2018-12-31';
*/


/*
	divino la mayoria del TP, unicamente en V no se hacia en 2 insisos separados bruto...
    
    SELECT * FROM ciudad 
	INNER JOIN provincia USING(id_provincia)
	INNER JOIN socio USING(id_ciudad)
	ORDER BY socio, ciudad DESC;
*/