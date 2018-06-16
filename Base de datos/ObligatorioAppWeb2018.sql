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
pass VARCHAR(6) NOT NULL CHECK (LEN(pass) = 6),
nombre VARCHAR(100) NOT NULL,
activo BIT NOT NULL DEFAULT 1
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
codigo VARCHAR(3) NOT NULL PRIMARY KEY CHECK (codigo LIKE '[a-z][a-z][a-z]'),
ciudad VARCHAR(50) NOT NULL,
pais VARCHAR (50) NOT NULL CHECK (pais IN ('Argentina','Brasil','Paraguay','Uruguay')),
activo BIT NOT NULL DEFAULT 1
)
GO

--Se crea la tabla de Facilidades
CREATE TABLE Facilidades(
nombre VARCHAR(50) NOT NULL,
terminal VARCHAR(3) NOT NULL FOREIGN KEY REFERENCES Terminales(codigo),
CONSTRAINT PK_Facilidades PRIMARY KEY (terminal, nombre)
)
GO

--Se crea la tabla de viajes
CREATE TABLE Viajes(
numero INT NOT NULL PRIMARY KEY, 
compania VARCHAR(50) NOT NULL FOREIGN KEY REFERENCES Companias(nombre),
destino VARCHAR(3) NOT NULL FOREIGN KEY REFERENCES Terminales(codigo),
fecha_partida datetime NOT NULL,
fecha_arribo datetime NOT NULL,
asientos INT NOT NULL CHECK(asientos > 0),
empleado VARCHAR(9) NOT NULL FOREIGN KEY REFERENCES Empleados(cedula),
CHECK (fecha_arribo>fecha_partida)
)
GO

--Se crea la tabla de Viajes Nacionales
CREATE TABLE Nacionales(
numero INT NOT NULL PRIMARY KEY,
paradas INT NOT NULL CHECK(paradas>=0),
CONSTRAINT FK_Nacionales FOREIGN KEY (numero) REFERENCES Viajes(numero)
)
GO

--Se crea la tabla de Viajes internacionales
CREATE TABLE internacionales(
numero int NOT NULL PRIMARY KEY, 
servicio BIT NOT NULL, 
documentacion VARCHAR(200),
CONSTRAINT FK_internacionales FOREIGN KEY (numero) REFERENCES Viajes(numero)
)
GO

-- -----------------------------------------------------------------------------------------------
-- CREACIÓN DE STORED PROCEDURES
-- -----------------------------------------------------------------------------------------------

-- ***********************************************************************************************
-- -----------------------------------------------------------------------------------------------
-- ***********************************************************************************************
-- EMPLEADOS
-- ***********************************************************************************************
-- -----------------------------------------------------------------------------------------------
-- ***********************************************************************************************

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA LOGIN DE EMPLEADOS
CREATE PROCEDURE Login_Empleado
@cedula VARCHAR(9),
@pass VARCHAR(6)
AS
BEGIN
	SELECT * FROM Empleados WHERE cedula = @cedula AND pass = @pass AND activo = 1
END
GO

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA BÚSQUEDA DE EMPLEADOS
CREATE PROCEDURE Buscar_Empleado
@cedula VARCHAR(9)
AS
BEGIN
	SELECT * FROM Empleados WHERE cedula = @cedula AND activo = 1
END
GO
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA BÚSQUEDA DE TODOS LOS EMPLEADOS
CREATE PROCEDURE BuscarTodos_Empleado
@cedula VARCHAR(9)
AS
BEGIN
	SELECT * FROM Empleados WHERE cedula = @cedula
END
GO
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA ALTA DE EMPLEADO
CREATE PROCEDURE Alta_Empleado
@cedula VARCHAR(9),
@pass VARCHAR(6),
@nombre VARCHAR(100)
AS
BEGIN
	IF EXISTS(SELECT * FROM Empleados WHERE cedula = @cedula AND activo = 1)
		RETURN -1
		
	IF EXISTS(SELECT * FROM Empleados WHERE cedula = @cedula AND activo = 0)
	BEGIN
		UPDATE Empleados SET activo = 1, pass = @pass, nombre = @nombre WHERE cedula = @cedula
		IF (@@ERROR = 0)
			RETURN 1
		ELSE
			RETURN -2
	END
	
	ELSE
		INSERT INTO Empleados (cedula, pass, nombre) VALUES (@cedula, @pass, @nombre)
		IF (@@ERROR = 0)
			RETURN 1
		ELSE
			RETURN -2
END
GO
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA ELIMINAR EMPLEADO
CREATE PROCEDURE Eliminar_Empleado
@cedula VARCHAR(9)
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM Empleados WHERE cedula = @cedula)
		RETURN -1
		
	IF EXISTS(SELECT * FROM Viajes WHERE empleado = @cedula)
		BEGIN
			UPDATE Empleados SET activo=0 WHERE cedula = @cedula
			RETURN 1
		END
		
	ELSE
		BEGIN
			DELETE FROM Empleados WHERE cedula = @cedula
			IF(@@ERROR = 0)
				RETURN 1
			ELSE
				RETURN -2
		END
END
GO
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA MODIFICAR EMPLEADO
CREATE PROCEDURE Modificar_Empleado
@cedula VARCHAR(9),
@pass VARCHAR(6),
@nombre VARCHAR(100)
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM Empleados WHERE cedula = @cedula AND activo = 1)
		RETURN -1
	
	ELSE
		BEGIN
			UPDATE Empleados SET pass = @pass, nombre = @nombre	WHERE cedula = @cedula
			IF(@@ERROR = 0)
				RETURN 1
			ELSE
				RETURN -2
		END
END
GO
-- -----------------------------------------------------------------------------------------------

-- ***********************************************************************************************
-- -----------------------------------------------------------------------------------------------
-- ***********************************************************************************************
-- COMPAÑÍAS
-- ***********************************************************************************************
-- -----------------------------------------------------------------------------------------------
-- ***********************************************************************************************

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA BÚSQUEDA DE COMPAÑÍA
CREATE PROCEDURE Buscar_Compania
@nombre VARCHAR(50)
AS
BEGIN
	SELECT * FROM Companias WHERE nombre = @nombre AND activo = 1
END
GO
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA BÚSQUEDA DE TODAS LAS COMPAÑÍAS
CREATE PROCEDURE BuscarTodos_Compania
@nombre VARCHAR(50)
AS
BEGIN
	SELECT * FROM Empleados WHERE nombre = @nombre
END
GO
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA ALTA DE COMPAÑÍA
CREATE PROCEDURE Alta_Compania
@nombre VARCHAR(50),
@direccion VARCHAR(100),
@telefono VARCHAR(20)
AS
BEGIN
	IF EXISTS(SELECT * FROM Companias WHERE nombre = @nombre AND activo = 1)
		RETURN -1
		
	IF EXISTS(SELECT * FROM Companias WHERE nombre = @nombre AND activo = 0)
	BEGIN
		UPDATE Companias SET activo = 1, direccion = @direccion , telefono = @telefono
		WHERE nombre = @nombre
		IF (@@ERROR = 0)
			RETURN 1
		ELSE
			RETURN -2
	END
	
	ELSE
		INSERT INTO Companias (nombre, direccion, telefono) VALUES (@nombre, @direccion, @telefono)
		IF (@@ERROR = 0)
			RETURN 1
		ELSE
			RETURN -2
END
GO
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA ELIMINAR COMPAÑÍA
CREATE PROCEDURE Eliminar_Compania
@nombre VARCHAR(9)
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM Companias WHERE nombre = @nombre)
		RETURN -1
		
	IF EXISTS(SELECT * FROM Viajes WHERE compania = @nombre)
		BEGIN
			UPDATE Companias SET activo=0 WHERE nombre = @nombre
			RETURN 1
		END
		
	ELSE
		BEGIN
			DELETE FROM Companias WHERE nombre = @nombre
			IF(@@ERROR = 0)
				RETURN 1
			ELSE
				RETURN -2
		END
END
GO
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA MODIFICAR COMPAÑÍA
CREATE PROCEDURE Modificar_Compania
@nombre VARCHAR(50),
@direccion VARCHAR(100),
@telefono VARCHAR(20)
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM Companias WHERE nombre = @nombre AND activo = 1)
		RETURN -1
	
	ELSE
		BEGIN
			UPDATE Companias SET direccion = @direccion, telefono = @telefono 
			WHERE nombre = @nombre
			IF(@@ERROR = 0)
				RETURN 1
			ELSE
				RETURN -2
		END
END
GO
-- -----------------------------------------------------------------------------------------------

-- ***********************************************************************************************
-- -----------------------------------------------------------------------------------------------
-- ***********************************************************************************************
-- TERMINALES
-- ***********************************************************************************************
-- -----------------------------------------------------------------------------------------------
-- ***********************************************************************************************

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA BÚSQUEDA DE TERMINAL
CREATE PROCEDURE Buscar_Terminal
@codigo VARCHAR(3)
AS
BEGIN
	SELECT * FROM Terminales WHERE codigo = @codigo AND activo = 1
END
GO
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA BÚSQUEDA DE TODAS LAS TERMINALES
CREATE PROCEDURE BuscarTodos_Terminal
@codigo VARCHAR(50)
AS
BEGIN
	SELECT * FROM Terminales WHERE codigo = @codigo
END
GO
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA ALTA DE TERMINAL
CREATE PROCEDURE Alta_Terminal
@codigo VARCHAR(3),
@ciudad VARCHAR(50),
@pais VARCHAR (50)
AS
BEGIN
	IF EXISTS(SELECT * FROM Terminales WHERE codigo = @codigo AND activo = 1)
		RETURN -1
		
	IF EXISTS(SELECT * FROM Terminales WHERE codigo = @codigo AND activo = 0)
	BEGIN
		UPDATE Terminales SET activo = 1, ciudad = @ciudad , pais = @pais
		WHERE codigo = @codigo
		IF (@@ERROR = 0)
			RETURN 1
		ELSE
			RETURN -2
	END
	
	ELSE
		INSERT INTO Terminales (codigo, ciudad, pais) VALUES (@codigo, @ciudad, @pais)
		IF (@@ERROR = 0)
			RETURN 1
		ELSE
			RETURN -2
END
GO
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA ELIMINAR TERMINAL
CREATE PROCEDURE Eliminar_Terminal
@codigo VARCHAR(9)
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM Terminales WHERE codigo = @codigo)
		RETURN -1
		
	IF EXISTS(SELECT * FROM Viajes WHERE destino = @codigo)
		BEGIN
			UPDATE Terminales SET activo=0 WHERE codigo = @codigo
			RETURN 1
		END
		
	ELSE
		BEGIN
			DELETE FROM Terminales WHERE codigo = @codigo
			IF(@@ERROR = 0)
				RETURN 1
			ELSE
				RETURN -2
		END
END
GO
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA MODIFICAR TERMINAL
CREATE PROCEDURE Modificar_Terminal
@codigo VARCHAR(3),
@ciudad VARCHAR(50),
@pais VARCHAR (50)
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM Terminales WHERE codigo = @codigo AND activo = 1)
		RETURN -1
	
	ELSE
		BEGIN
			UPDATE Terminales SET ciudad = @ciudad, pais = @pais 
			WHERE codigo = @codigo
			IF(@@ERROR = 0)
				RETURN 1
			ELSE
				RETURN -2
		END
END
GO
-- -----------------------------------------------------------------------------------------------
