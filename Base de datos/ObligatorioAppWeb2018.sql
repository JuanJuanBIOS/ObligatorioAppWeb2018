USE MASTER
SET LANGUAGE Spanish
GO

IF EXISTS(SELECT * FROM sysDATABASEs WHERE name = 'Terminal')
BEGIN
	ALTER DATABASE Terminal SET single_USER WITH ROLLBACK IMMEDIATE
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
terminal VARCHAR(3) NOT NULL FOREIGN KEY REFERENCES Terminales(codigo),
nombre VARCHAR(50) NOT NULL,
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
CREATE TABLE Internacionales(
numero int NOT NULL PRIMARY KEY, 
servicio BIT NOT NULL, 
documentacion VARCHAR(200),
CONSTRAINT FK_Internacionales FOREIGN KEY (numero) REFERENCES Viajes(numero)
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
-- Prueba Login_Empleado '11111111', '111111'
-- Prueba Login_Empleado '22222222', '222222'
-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA BÚSQUEDA DE EMPLEADOS
CREATE PROCEDURE Buscar_Empleado
@cedula VARCHAR(9)
AS
BEGIN
	SELECT * FROM Empleados WHERE cedula = @cedula AND activo = 1
END
GO
-- Prueba Buscar_Empleado '11111111'
-- Prueba Buscar_Empleado '22222222'
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
-- Prueba BuscarTodos_Empleado '11111111'
-- Prueba BuscarTodos_Empleado '22222222'
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
		UPDATE Empleados SET activo = 1, pass = @pass, nombre = @nombre 
		WHERE cedula = @cedula
		IF (@@ERROR = 0)
			RETURN 1
		ELSE
			RETURN -2
	END

	INSERT INTO Empleados (cedula, pass, nombre) VALUES (@cedula, @pass, @nombre)
	IF (@@ERROR = 0)
		RETURN 1
	ELSE
		RETURN -2
END
GO
-- Prueba Alta_Empleado '44444444', '444444', 'Empleado4'
-- Prueba Alta_Empleado '22222222', '123456', 'Empleado02'
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

	DELETE FROM Empleados WHERE cedula = @cedula
	IF(@@ERROR = 0)
		RETURN 1
	ELSE
		RETURN -2

END
GO
--Prueba Eliminar_Empleado '11111111'
--Prueba Eliminar_Empleado '44444444'
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

	UPDATE Empleados SET pass = @pass, nombre = @nombre	WHERE cedula = @cedula
	IF(@@ERROR = 0)
		RETURN 1
	ELSE
		RETURN -2

END
GO
--Prueba Modificar_Empleado '11111111', '111111', 'Empleado01'
--Prueba Modificar_Empleado '22222222', '222222', 'Empleado2'
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
-- Prueba Buscar_Compania 'Compania 1'
-- Prueba Buscar_Compania 'Compania 2'
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA BÚSQUEDA DE TODAS LAS COMPAÑÍAS
CREATE PROCEDURE BuscarTodos_Compania
@nombre VARCHAR(50)
AS
BEGIN
	SELECT * FROM Companias WHERE nombre = @nombre
END
GO
-- Prueba BuscarTodos_Compania 'Compania 1'
-- Prueba BuscarTodos_Compania 'Compania 2'
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

	INSERT INTO Companias (nombre, direccion, telefono) 
	VALUES (@nombre, @direccion, @telefono)
	IF (@@ERROR = 0)
		RETURN 1
	ELSE
		RETURN -2
END
GO
-- Prueba Alta_Compania 'Compania 4', 'Calle 4', '099444444'
-- Prueba Alta_Compania 'Compania 2', 'Calle 02', '099222222'
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA ELIMINAR COMPAÑÍA
CREATE PROCEDURE Eliminar_Compania
@nombre VARCHAR(50)
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM Companias WHERE nombre = @nombre)
		RETURN -1
		
	IF EXISTS(SELECT * FROM Viajes WHERE compania = @nombre)
		BEGIN
			UPDATE Companias SET activo=0 WHERE nombre = @nombre
			RETURN 1
		END

	DELETE FROM Companias WHERE nombre = @nombre
	IF(@@ERROR = 0)
		RETURN 1
	ELSE
		RETURN -2
END
GO
-- Prueba Eliminar_Compania 'Compania 2'
-- Prueba Eliminar_Compania 'Compania 4'
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

	UPDATE Companias SET direccion = @direccion, telefono = @telefono 
	WHERE nombre = @nombre
	IF(@@ERROR = 0)
		RETURN 1
	ELSE
		RETURN -2
END
GO
-- Prueba Modificar_Compania 'Compania 1', 'Calle 01', '099111111'
-- Prueba Modificar_Compania 'Compania 2', 'Calle 2', '099222222'
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA LISTAR COMPANIAS
CREATE PROCEDURE Listar_Companias
AS
BEGIN
	Select * from Companias where activo = 1 
END
GO
-- Prueba Listar_Companias
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
-- Prueba Buscar_Terminal 'AAA'
-- Prueba Buscar_Terminal 'CCC'
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA BÚSQUEDA DE FACILIDADES
CREATE PROCEDURE Buscar_Facilidades
@terminal VARCHAR(3)
AS
BEGIN
	SELECT * FROM Facilidades WHERE terminal = @terminal
END
GO
-- Prueba Buscar_Facilidades 'AAA'
-- Prueba Buscar_Facilidades 'CCC'
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA BÚSQUEDA DE TODAS LAS TERMINALES
CREATE PROCEDURE BuscarTodos_Terminal
@codigo VARCHAR(3)
AS
BEGIN
	SELECT * FROM Terminales WHERE codigo = @codigo
END
GO
-- Prueba BuscarTodos_Terminal 'AAA'
-- Prueba BuscarTodos_Terminal 'CCC'
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

	INSERT INTO Terminales (codigo, ciudad, pais) VALUES (@codigo, @ciudad, @pais)
	IF (@@ERROR = 0)
		RETURN 1
	ELSE
		RETURN -2
END
GO
-- Prueba Alta_Terminal 'GGG', 'Ciudad 7', 'Argentina'
-- Prueba Alta_Terminal 'CCC', 'Ciudad 03', 'Uruguay'
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA ALTA DE FACILIDADES
CREATE PROCEDURE Alta_Facilidades
@terminal VARCHAR(3),
@nombre VARCHAR(50)
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM Terminales WHERE codigo = @terminal AND activo = 1)
		RETURN -1
	
	INSERT INTO Facilidades (terminal, nombre) VALUES (@terminal, @nombre)
	IF (@@ERROR = 0)
		RETURN 1
	ELSE
		RETURN -2
END
GO
--Prueba Alta_Facilidades 'GGG', 'Facilidad 3'
--Prueba Alta_Facilidades 'CCC', 'Facilidad 2'
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
		BEGIN TRANSACTION
			DELETE FROM Facilidades WHERE terminal = @codigo
			IF (@@ERROR <> 0)
				BEGIN
					ROLLBACK TRANSACTION
					RETURN -2
				END
				
			DELETE FROM Terminales WHERE codigo = @codigo
			IF (@@ERROR <> 0)
				BEGIN
					ROLLBACK TRANSACTION
					RETURN -2
				END
				
			ELSE
				BEGIN
					COMMIT TRANSACTION
					RETURN 1
				END
		END
END
GO

-- Prueba Eliminar_Terminal 'AAA'
-- Prueba Eliminar_Terminal 'GGG'
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA ELIMINAR FACILIDADES
CREATE PROCEDURE Eliminar_Facilidades
@codigo VARCHAR(9)
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM Terminales WHERE codigo = @codigo)
		RETURN -1
	
	DELETE FROM Facilidades WHERE terminal = @codigo
	IF (@@ERROR = 0)
		RETURN 1
	ELSE
		RETURN -2
END
GO
-- Prueba Eliminar_Facilidades 'AAA'
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
-- Prueba Modificar_Terminal 'GGG', 'Ciudad 7', 'Argentina'
-- Prueba Modificar_Terminal 'CCC', 'Ciudad 03', 'Uruguay'
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA LISTAR TERMINALES
CREATE PROCEDURE Listar_Terminales
AS
BEGIN
	Select * from Terminales where activo = 1
END
GO
-- Prueba Listar_Terminales
-- -----------------------------------------------------------------------------------------------














-- ***********************************************************************************************
-- -----------------------------------------------------------------------------------------------
-- ***********************************************************************************************
-- VIAJES
-- ***********************************************************************************************
-- -----------------------------------------------------------------------------------------------
-- ***********************************************************************************************

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA BÚSQUEDA DE VIAJE NACIONAL
CREATE PROCEDURE Buscar_ViajeNacional
@numero INT
AS
BEGIN
	SELECT Viajes.*, Nacionales.paradas FROM Viajes INNER JOIN Nacionales 
	ON Viajes.numero = Nacionales.numero WHERE Viajes.numero = @numero
END
GO
-- Prueba Buscar_ViajeNacional 1
-- Prueba Buscar_ViajeNacional 4
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA BÚSQUEDA DE VIAJE INTERNACIONAL
CREATE PROCEDURE Buscar_ViajeInternacional
@numero INT
AS
BEGIN
	SELECT Viajes.*, Internacionales.servicio, Internacionales.documentacion 
	FROM Viajes INNER JOIN Internacionales ON Viajes.numero = Internacionales.numero 
	WHERE Viajes.numero = @numero
END
GO
-- Prueba Buscar_ViajeInternacional 1
-- Prueba Buscar_ViajeInternacional 4
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA ALTA DE VIAJE NACIONAL
CREATE PROCEDURE Alta_ViajeNacional
@numero INT, 
@compania VARCHAR(50),
@destino VARCHAR(3),
@fecha_partida datetime,
@fecha_arribo datetime,
@asientos INT,
@empleado VARCHAR(9),
@paradas INT
AS
BEGIN
	IF EXISTS(SELECT * FROM Viajes WHERE numero = @numero)
		RETURN -1
	
	IF EXISTS(SELECT * FROM Viajes 
	WHERE (DATEDIFF(MINUTE,fecha_partida,@fecha_partida)<120 AND destino = @destino))
		RETURN -2
	
	IF NOT EXISTS(SELECT * FROM Companias WHERE nombre = @compania AND activo = 1)
		RETURN -3
		
	IF NOT EXISTS(SELECT * FROM Terminales WHERE codigo = @destino AND activo = 1)
		RETURN -4
	
	IF NOT EXISTS(SELECT * FROM Empleados WHERE cedula = @empleado AND activo = 1)
		RETURN -5
	
	BEGIN TRANSACTION
	INSERT INTO Viajes 
	VALUES (@numero, @compania, @destino, @fecha_partida, @fecha_arribo, @asientos, @empleado)
	IF (@@ERROR <> 0)
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -6
		END
			
	INSERT INTO Nacionales VALUES (@numero, @paradas)
	IF (@@ERROR <> 0)
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -7
		END
			
	ELSE
		BEGIN
			COMMIT TRANSACTION
			RETURN 1
		END
END
GO
-- Prueba Alta_ViajeNacional 9, 'Compania 3', 'BBB', '15/02/2019 16:00', '16/02/2019 01:00', 45, '33333333', 4
-- Prueba Alta_ViajeNacional 10, 'Compania 1', 'BBB', '15/02/2018 17:00', '16/02/2018 02:00', 45, '33333333', 4
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA ALTA DE VIAJE INTERNACIONAL
CREATE PROCEDURE Alta_ViajeInternacional
@numero INT, 
@compania VARCHAR(50),
@destino VARCHAR(3),
@fecha_partida datetime,
@fecha_arribo datetime,
@asientos INT,
@empleado VARCHAR(9),
@servicio BIT, 
@documentacion VARCHAR(200)
AS
BEGIN
	IF EXISTS(SELECT * FROM Viajes WHERE numero = @numero)
		RETURN -1
	
	IF EXISTS(SELECT * FROM Viajes 
	WHERE (DATEDIFF(MINUTE,fecha_partida,@fecha_partida)<120 AND destino = @destino))
		RETURN -2
		
	IF NOT EXISTS(SELECT * FROM Companias WHERE nombre = @compania AND activo = 1)
		RETURN -3
		
	IF NOT EXISTS(SELECT * FROM Terminales WHERE codigo = @destino AND activo = 1)
		RETURN -4
	
	IF NOT EXISTS(SELECT * FROM Empleados WHERE cedula = @empleado AND activo = 1)
		RETURN -5
	
	BEGIN TRANSACTION
	INSERT INTO Viajes 
	VALUES (@numero, @compania, @destino, @fecha_partida, @fecha_arribo, @asientos, @empleado)
	IF (@@ERROR <> 0)
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -6
		END
			
	INSERT INTO internacionales VALUES (@numero, @servicio, @documentacion)
	IF (@@ERROR <> 0)
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -7
		END
			
	ELSE
		BEGIN
			COMMIT TRANSACTION
			RETURN 1
		END
END
GO
-- Prueba Alta_ViajeInternacional 11, 'Compania 3', 'DDD', '15/02/2019 16:00', '16/02/2019 01:00', 45, '33333333', 1, 'Cedula'
-- Prueba Alta_ViajeInternacional 12, 'Compania 1', 'DDD', '15/02/2018 17:00', '16/02/2018 02:00', 45, '33333333', 0, 'Pasaporte'
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA ELIMINAR VIAJE NACIONAL
CREATE PROCEDURE Eliminar_ViajeNacional
@numero INT
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM Nacionales WHERE numero = @numero)
		RETURN -1
			
	ELSE
		BEGIN
		BEGIN TRANSACTION
			DELETE FROM Nacionales WHERE numero = @numero
			IF (@@ERROR <> 0)
				BEGIN
					ROLLBACK TRANSACTION
					RETURN -2
				END
				
			DELETE FROM Viajes WHERE numero = @numero
			IF (@@ERROR <> 0)
				BEGIN
					ROLLBACK TRANSACTION
					RETURN -3
				END
				
			ELSE
				BEGIN
					COMMIT TRANSACTION
					RETURN 1
				END
		END
END
GO

-- Prueba Eliminar_ViajeNacional 9
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA ELIMINAR VIAJE INTERNACIONAL
CREATE PROCEDURE Eliminar_ViajeInternacional
@numero INT
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM Internacionales WHERE numero = @numero)
		RETURN -1
			
	ELSE
		BEGIN
		BEGIN TRANSACTION
			DELETE FROM Internacionales WHERE numero = @numero
			IF (@@ERROR <> 0)
				BEGIN
					ROLLBACK TRANSACTION
					RETURN -2
				END
				
			DELETE FROM Viajes WHERE numero = @numero
			IF (@@ERROR <> 0)
				BEGIN
					ROLLBACK TRANSACTION
					RETURN -3
				END
				
			ELSE
				BEGIN
					COMMIT TRANSACTION
					RETURN 1
				END
		END
END
GO

-- Prueba Eliminar_ViajeInternacional 11
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA MODIFICAR VIAJE NACIONAL
CREATE PROCEDURE Modificar_ViajeNacional
@numero INT, 
@compania VARCHAR(50),
@destino VARCHAR(3),
@fecha_partida datetime,
@fecha_arribo datetime,
@asientos INT,
@empleado VARCHAR(9),
@paradas INT
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM Viajes WHERE numero = @numero)
		RETURN -1
	
	IF EXISTS(SELECT * FROM Viajes 
	WHERE (DATEDIFF(MINUTE,fecha_partida,@fecha_partida)<120 AND destino = @destino AND numero != @numero))
		RETURN -2
	
	IF NOT EXISTS(SELECT * FROM Companias WHERE nombre = @compania AND activo = 1)
		RETURN -3
		
	IF NOT EXISTS(SELECT * FROM Terminales WHERE codigo = @destino AND activo = 1)
		RETURN -4
	
	IF NOT EXISTS(SELECT * FROM Empleados WHERE cedula = @empleado AND activo = 1)
		RETURN -5
		
	BEGIN TRANSACTION
		UPDATE Viajes 
		SET compania = @compania, destino = @destino, fecha_partida = @fecha_partida, 
			fecha_arribo = @fecha_arribo, asientos = @asientos, empleado = @empleado
		WHERE numero = @numero
		IF (@@ERROR <> 0)
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -6
		END
		
		UPDATE Nacionales SET paradas = @paradas WHERE numero = @numero
		IF (@@ERROR <> 0)
			BEGIN
				ROLLBACK TRANSACTION
				RETURN -7
			END
			
		ELSE
		BEGIN
			COMMIT TRANSACTION
			RETURN 1
		END
END
GO
-- Prueba Modificar_ViajeNacional 9, 'Compania 3', 'CCC', '15/02/2018 16:00', '16/02/2018 01:00', 45, '33333333', 5
-- Prueba Modificar_ViajeNacional 9, 'Compania 3', 'CCC', '15/04/2017 15:00', '15/04/2017 22:00', 45, '33333333', 5
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA MODIFICAR VIAJE INTERNACIONAL
CREATE PROCEDURE Modificar_ViajeInternacional
@numero INT, 
@compania VARCHAR(50),
@destino VARCHAR(3),
@fecha_partida datetime,
@fecha_arribo datetime,
@asientos INT,
@empleado VARCHAR(9),
@servicio BIT, 
@documentacion VARCHAR(200)
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM Viajes WHERE numero = @numero)
		RETURN -1
	
	IF EXISTS(SELECT * FROM Viajes 
	WHERE (DATEDIFF(MINUTE,fecha_partida,@fecha_partida)<120 AND destino = @destino AND numero != @numero))
		RETURN -2
	
	IF NOT EXISTS(SELECT * FROM Companias WHERE nombre = @compania AND activo = 1)
		RETURN -3
		
	IF NOT EXISTS(SELECT * FROM Terminales WHERE codigo = @destino AND activo = 1)
		RETURN -4
	
	IF NOT EXISTS(SELECT * FROM Empleados WHERE cedula = @empleado AND activo = 1)
		RETURN -5
	
	BEGIN TRANSACTION
		UPDATE Viajes 
		SET compania = @compania, destino = @destino, fecha_partida = @fecha_partida, 
			fecha_arribo = @fecha_arribo, asientos = @asientos, empleado = @empleado
		WHERE numero = @numero
		IF (@@ERROR <> 0)
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -6
		END
		
		UPDATE internacionales SET servicio = @servicio, documentacion = @documentacion 
		WHERE numero = @numero
		IF (@@ERROR <> 0)
			BEGIN
				ROLLBACK TRANSACTION
				RETURN -7
			END
			
		ELSE
		BEGIN
			COMMIT TRANSACTION
			RETURN 1
		END
	END
GO


-- Prueba Modificar_ViajeInternacional 11, 'Compania 1', 'DDD', '15/02/2018 16:00', '16/02/2018 01:00', 45, '33333333', 0, 'Cedula y Vacunas'
-- Prueba Modificar_ViajeInternacional 11, 'Compania 3', 'CCC', '15/04/2017 15:00', '15/04/2017 22:00', 45, '33333333', 1, 'Cedula'
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA LISTAR VIAJES
CREATE PROCEDURE Listar_Viajes
AS
BEGIN
	Select * from Viajes
END
GO
-- Prueba Listar_Viajes




-- -----------------------------------------------------------------------------------------------
-- INSERCIÓN DE DATOS DE PRUEBA
-- -----------------------------------------------------------------------------------------------

Alta_Empleado '47879585', '111111', 'Empleado1'
GO
Alta_Empleado '41348194', '222222', 'Empleado2'
GO
Alta_Empleado '15080405', '333333', 'Empleado3'
GO

Alta_Compania 'Compania 1','Calle 1','099111111'
GO
Alta_Compania 'Compania 2','Calle 2','099222222'
GO
Alta_Compania 'Compania 3','Calle 3','099333333'
GO

Alta_Terminal 'AAA','Cuidad 1','Uruguay'
GO
Alta_Terminal 'BBB','Cuidad 2','Uruguay'
GO
Alta_Terminal 'CCC','Cuidad 3','Brasil'
GO
Alta_Terminal 'DDD','Cuidad 4','Brasil'
GO
Alta_Terminal 'EEE','Cuidad 5','Paraguay'
GO
Alta_Terminal 'FFF','Cuidad 6','Argentina'
GO

Alta_Facilidades 'AAA','Facilidad 1'
GO
Alta_Facilidades 'AAA','Facilidad 2'
GO
Alta_Facilidades 'AAA','Facilidad 3'
GO
Alta_Facilidades 'BBB','Facilidad 2'
GO
Alta_Facilidades 'CCC','Facilidad 1'
GO
Alta_Facilidades 'CCC','Facilidad 3'
GO
Alta_Facilidades 'DDD','Facilidad 1'
GO
Alta_Facilidades 'DDD','Facilidad 2'
GO
Alta_Facilidades 'EEE','Facilidad 3'
GO
Alta_Facilidades 'FFF','Facilidad 1'
GO
Alta_Facilidades 'FFF','Facilidad 2'
GO
Alta_Facilidades 'FFF','Facilidad 3'
GO

Alta_ViajeNacional 1,'Compania 1','AAA', '31/01/2017 12:00', '31/01/2017 16:30', 35, '47879585', 0
GO
Alta_ViajeNacional 2,'Compania 1','AAA', '05/01/2017 04:00', '05/01/2017 08:30', 35, '41348194', 2
GO
Alta_ViajeNacional 3,'Compania 2','AAA', '25/02/2017 23:00', '26/02/2017 03:30', 35, '47879585', 0
GO
Alta_ViajeNacional 5,'Compania 2','AAA', '15/06/2017 15:55', '15/06/2017 20:25', 35, '41348194', 3
GO
Alta_ViajeInternacional 4,'Compania 1','CCC', '03/03/2017 14:40', '03/03/2017 18:50', 35, '47879585', 0, 'Cedula'
GO
Alta_ViajeInternacional 6,'Compania 1','CCC', '15/04/2017 14:00', '15/04/2017 18:45', 35, '41348194', 1, ''
GO
Alta_ViajeInternacional 7,'Compania 2','CCC', '15/10/2017 17:25', '15/10/2017 23:55', 35, '47879585', 1, 'Pasaporte y vacunas'
GO
Alta_ViajeInternacional 8,'Compania 2','CCC', '25/09/2017 06:35', '25/09/2017 09:55', 35, '41348194', 0, ''
GO
