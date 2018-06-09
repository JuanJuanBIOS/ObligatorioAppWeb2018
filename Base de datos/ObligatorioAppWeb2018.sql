USE MASTER
GO

IF EXISTS(SELECT * FROM sysDATABASEs WHERE name = 'Terminal')
BEGin
	ALTER DATABASE Terminal SET single_USEr WITH ROLLBACK IMMEDIATE
	DROP DATABASE Terminal
end
GO

--Se crea la base de datos
CREATE DATABASE Terminal
GO


--Se selecciona la base de datos
USE Terminal
GO

-- ------------------------------------------------------------------------------------------------
-- CREACIÓN DE TABLAS 
-- ------------------------------------------------------------------------------------------------

--Se crea la tabla de Empleados
CREATE TABLE Empleados(
cedula VARCHAR(9) NOT NULL PRIMARY KEY,
pass VARCHAR(6) NOT NULL,
nombre VARCHAR(100),
activo BIT NOT NULL DEFAULT 1,
CHECK (LEN(pass) = 6)
)
GO

-- Se crea la tabla de Compañías
CREATE TABLE Companias(
nombre VARCHAR(50) NOT NULL PRIMARY KEY,
direccion VARCHAR(100) NOT NULL,
telefono VARCHAR(20) NOT NULL,
activo BIT NOT NULL DEFAULT 1
)
GO

--Se crea la tabla de Terminales
CREATE TABLE Terminales(
codigo VARCHAR(3) NOT NULL PRIMARY KEY,
ciudad VARCHAR(50) NOT NULL,
pais VARCHAR (50),
activo BIT NOT NULL DEFAULT 1,
CHECK (LEN(codigo) = 3 AND pais IN ('Argentina','Brasil','Paraguay','Uruguay'))
)
GO

--Se crea la tabla de Facilidades
CREATE TABLE Facilidades(
nombre VARCHAR(50) NOT NULL,
terminal VARCHAR(3) NOT NULL FOREIGN KEY REFERENCES Terminales(codigo),
CONSTRAint PK_Facilidades PRIMARY KEY (terminal, nombre)
)
GO

--Se crea la tabla de viajes
CREATE TABLE Viajes(
numero INT NOT NULL PRIMARY KEY, 
compania VARCHAR(50) NOT NULL FOREIGN KEY REFERENCES Companias(nombre),
destino VARCHAR(3) NOT NULL FOREIGN KEY REFERENCES Terminales(codigo),
fecha_partida datetime NOT NULL,
fecha_arribo datetime NOT NULL,
asientos INT NOT NULL,
empleado VARCHAR(9) NOT NULL FOREIGN KEY REFERENCES Empleados(cedula),
activo BIT NOT NULL DEFAULT 1
)
GO

--Se crea la tabla de Viajes Nacionales
CREATE TABLE Nacionales(
numero INT NOT NULL PRIMARY KEY,
paradas INT NOT NULL
CONSTRAint FK_Nacionales FOREIGN KEY (numero) REFERENCES Viajes(numero)
)
GO

--Se crea la tabla de Viajes internacionales
CREATE TABLE internacionales(
numero int NOT NULL PRIMARY KEY, 
servicio BIT NOT NULL, 
documentacion VARCHAR(200) NOT NULL,
CONSTRAint FK_internacionales FOREIGN KEY (numero) REFERENCES Viajes(numero)
)
GO
