
CREATE TABLE persona 
(`codPersona` INT NOT NULL,
`nombre` varchar(100) NOT NULL,
`dni` INT,
`domicilio` VARCHAR(100) DEFAULT NULL,
`nacionalidad` VARCHAR(100),
CONSTRAINT pkcodpersona PRIMARY KEY (`codPersona`),
CONSTRAINT dni UNIQUE (`dni`)
);


/*
CREATE TABLE persona
(codPersona INT NOT NULL,
nombre varchar(100) NOT NULL,
dni INT NOT NULL,
domicilio VARCHAR(100) DEFAULT NULL,
nacionalidad VARCHAR(100) NOT NULL,
CONSTRAINT pkcodpersona PRIMARY KEY (codPersona),
CONSTRAINT dni UNIQUE (dni)
);

Habria alguna diferencia entre crear la tabla poniendo las comillas en el nombre de los campos y no haciendolo.?
                                    &&&&&&&&&&&&&&&&&&&&&&&&&&&&
                                    %%                        %%
                                    %%          #####         %%
                                    %%       ###     ###      %%
                                    %%       ##     ###       %%
                                    %%            ###         %%
                                    %%           ##           %%
                                    %%                        %%
                                    %%           #            %%
                                    %%                        %%
                                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
*/

CREATE TABLE deportista
(
	codDeportista INT NOT NULL,
    CONSTRAINT pkdeportsita PRIMARY KEY (codDeportista),
    CONSTRAINT refcodPersona FOREIGN KEY (codDeportista) REFERENCES persona (codPersona)
);



CREATE TABLE diciplina 
(
	codDiciplina INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    CONSTRAINT pkdiciplina PRIMARY KEY (codDiciplina)
);

CREATE TABLE arbitro
(
	codArbitro INT NOT NULL,
    asociacion VARCHAR(100) NOT NULL,
    codDiciplina INT NOT NULL,
    codArbitroAsistente INT NOT NULL,
    CONSTRAINT refcodArbitroAsistente FOREIGN KEY (codArbitroAsistente) REFERENCES arbitro (codArbitro),
    CONSTRAINT refcodDiciplina FOREIGN KEY (codDiciplina) REFERENCES diciplina (codDiciplina),
    CONSTRAINT pkarbitro PRIMARY KEY (codArbitro),
    CONSTRAINT refcodPersonaa FOREIGN KEY (codArbitro) REFERENCES persona (codPersona)
);



CREATE TABLE sede
(
	codSede INT NOT NULL,
    nombreSede VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    CONSTRAINT pkSede PRIMARY KEY (codSede)
);

CREATE TABLE evento
(
	codEvento INT NOT NULL,
    nombreEvento VARCHAR(100) NOT NULL,
    fechaEvento DATE NOT NULL,
    codSede INT NOT NULL,
    CONSTRAINT pkevento PRIMARY KEY (codEvento),
    CONSTRAINT refcodSede FOREIGN KEY (codSede) REFERENCES sede (codSede)
);


 CREATE TABLE entrenador
 (
	codEntrenador INT NOT NULL,
    codDeportista INT NOT NULL, 
    nombre VARCHAR(100) NOT NULL,
    CONSTRAINT pkentrenador PRIMARY KEY (codEntrenador),
    CONSTRAINT refcodDeportista FOREIGN KEY (codDeportista) REFERENCES deportista (codDeportista)
 );
 
 


CREATE TABLE practica 
(
	codDeportista INT NOT NULL,
    codDiciplina INT NOT NULL,
    CONSTRAINT pkpractica PRIMARY KEY(codDeportista, codDiciplina),
    CONSTRAINT refcodDeportista2 FOREIGN KEY (codDeportista) REFERENCES deportista (codDeportista),
    CONSTRAINT refcodDiciplina2 FOREIGN KEY (codDiciplina) REFERENCES diciplina (codDiciplina)
);
 

 CREATE TABLE dirige 
 (
	codArbitro INT NOT NULL,
    codEvento INT NOT NULL,
    fecha DATE NOT NULL,
    CONSTRAINT pkdirige PRIMARY KEY(codArbitro, codEvento),
    CONSTRAINT refcodArbitro FOREIGN KEY (codArbitro) REFERENCES arbitro (codArbitro),
    CONSTRAINT refcodEvento FOREIGN KEY (codEvento) REFERENCES evento (codEvento)
 );
 
  


CREATE TABLE participa 
(
	codDeportista INT NOT NULL,
    codEvento INT NOT NULL,
    fecha DATE NOT NULL,
    CONSTRAINT pkParticipa PRIMARY KEY (codDeportista, codEvento),
    CONSTRAINT refcodDeportista3 FOREIGN KEY (codDeportista) REFERENCES deportista (codDeportista),
    CONSTRAINT refcodEvento3 FOREIGN KEY (codEvento) REFERENCES evento (codEvento)
);



CREATE TABLE telefono 
(
	codPersona INT NOT NULL,
    telefono VARCHAR(9) NOT NULL,
    CONSTRAINT pktelefono PRIMARY KEY (codPersona, telefono),
    CONSTRAINT refcodPersona3 FOREIGN KEY (codPersona) REFERENCES persona (codPersona)
)







/*

####      COMENTARIOS USADOS PARA GUIARME    ####

 ``
 Resstriciones de tipo 2

CREATE TABLE tab1 (col1 INTEGER,
col2 CHAR(25) NOT NULL,
col3 CHAR(10),
col4 INTEGER,
col5 INT,
CONSTRAINT pk PRIMARY KEY (col1),
CONSTRAINT uni1 UNIQUE (col3),
CONSTRAINT fk5 FOREIGN KEY (col5) REFERENCES
tab2 );


CREATE TABLE ALUMNOS
(`idAlumno` INT NOT NULL,
`Apellido_nom` VARCHAR(45) NOT NULL,
`Socio_Biblioteca` INT NULL,
`Fecha_Ingreso` DATE NULL,
PRIMARY KEY (`idAlumno`),
UNIQUE INDEX `Socio_Biblioteca_UNIQUE` (`Socio_Biblioteca`);



CREATE TABLE tabla1
(campo tipo_datos
CONSTRAINT nombre FOREIGN KEY REFERENCES tabla2)
 CONSTRAINT `Refpersona18` FOREIGN KEY (`id_socio`) REFERENCES `persona` (`id_persona`)
*/