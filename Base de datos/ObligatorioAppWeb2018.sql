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

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA LISTAR COMPANIAS
CREATE PROCEDURE Listar_Todos_Companias
AS
BEGIN
	Select * from Companias
END
GO
-- Prueba Listar_Todos_Companias
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
-- SE CREA PROCEDIMIENTO PARA BÚSQUEDA DE TERMINAL
CREATE PROCEDURE BuscarTodos_Terminal
@codigo VARCHAR(3)
AS
BEGIN
	SELECT * FROM Terminales WHERE codigo = @codigo
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
-- Prueba Buscar_ViajeInternacional 1005
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
	WHERE (ABS(DATEDIFF(MINUTE,fecha_partida,@fecha_partida))<120 AND destino = @destino))
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
	WHERE (ABS(DATEDIFF(MINUTE,fecha_partida,@fecha_partida))<120 AND destino = @destino))
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
	WHERE (ABS(DATEDIFF(MINUTE,fecha_partida,@fecha_partida))<120 AND destino = @destino AND numero <> @numero))
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
	WHERE (ABS(DATEDIFF(MINUTE,fecha_partida,@fecha_partida))<120 AND destino = @destino AND numero != @numero))
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
-- SE CREA PROCEDIMIENTO PARA LISTAR VIAJES NACIONALES
CREATE PROCEDURE Listar_Viajes_Nacionales
AS
BEGIN
	SELECT Viajes.*, Nacionales.paradas FROM Viajes INNER JOIN Nacionales 
	ON Viajes.numero = Nacionales.numero
END
GO
-- Prueba Listar_ViajesNacionales
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- SE CREA PROCEDIMIENTO PARA LISTAR VIAJES INTERNACIONALES
CREATE PROCEDURE Listar_Viajes_Internacionales
AS
BEGIN
	SELECT Viajes.*, Internacionales.servicio, Internacionales.documentacion 
	FROM Viajes INNER JOIN Internacionales ON Viajes.numero = Internacionales.numero 
END
GO
-- Prueba Listar_ViajesInternacionales
-- -----------------------------------------------------------------------------------------------






-- -----------------------------------------------------------------------------------------------
-- INSERCIÓN DE DATOS DE PRUEBA
-- -----------------------------------------------------------------------------------------------

Alta_Empleado '47879585', '123456', 'Juan'
GO
Alta_Empleado '41348194', '123456', 'Pedro'
GO
Alta_Empleado '15080405', '123456', 'Maria'
GO
Alta_Empleado '16066363', '123456', 'Carlos'
GO
Alta_Empleado '44142650', '123456', 'Paola'
GO
Alta_Empleado '43593913', '123456', 'Daniela'
GO

Alta_Compania 'Agencia Central','Bulevar Artigas 3516','26185475'
GO
Alta_Compania 'Buquebus','Garibaldi 1523','24845736'
GO
Alta_Compania 'Chadre','General Flores 6548','29241536'
GO
Alta_Compania 'Cita','Ocho de octubre 3883','26008452'
GO
Alta_Compania 'Colonia Express','San Jose 1563','26284578'
GO
Alta_Compania 'Copsa','18 de Julio 956','27106598'
GO
Alta_Compania 'Cot','Avenida Italia 2345','24086536'
GO
Alta_Compania 'Cynsa','Bolivia 1536','22045863'
GO
Alta_Compania 'Ega','Gral. Rivera 3125','25114536'
GO
Alta_Compania 'Nossar','Rbla República de Chile 1523','23584536'
GO

Alta_Terminal 'SAL','Salto','Uruguay'
GO
Alta_Terminal 'RIV','Rivera','Uruguay'
GO
Alta_Terminal 'MAL','Maldonado','Uruguay'
GO
Alta_Terminal 'RDJ','Rio de Janeiro','Brasil'
GO
Alta_Terminal 'SAP','Sao Paulo','Brasil'
GO
Alta_Terminal 'REC','Recife','Brasil'
GO
Alta_Terminal 'BSA','Buenos Aires','Argentina'
GO
Alta_Terminal 'COR','Cordoba','Argentina'
GO
Alta_Terminal 'ENR','Entre Rios','Argentina'
GO
Alta_Terminal 'ASU','Asunción','Paraguay'
GO
Alta_Terminal 'DUR','Durazno','Uruguay'
GO
Alta_Terminal 'CUR','Curitiba','Brasil'
GO
Alta_Terminal 'COL','Colonia','Brasil'
GO

Alta_Facilidades 'SAL','Correo'
GO
Alta_Facilidades 'SAL','Telefonía'
GO
Alta_Facilidades 'SAL','Cambio de moneda'
GO
Alta_Facilidades 'RIV','Telefonía'
GO
Alta_Facilidades 'MAL','Correo'
GO
Alta_Facilidades 'MAL','Plaza de comidas'
GO
Alta_Facilidades 'RDJ','Plaza de comidas'
GO
Alta_Facilidades 'RDJ','Correo'
GO
Alta_Facilidades 'RDJ','Baños públicos'
GO
Alta_Facilidades 'RDJ','Telefonía'
GO
Alta_Facilidades 'REC','Baños públicos'
GO
Alta_Facilidades 'BSA','Correo'
GO
Alta_Facilidades 'BSA','Cambio de moneda'
GO
Alta_Facilidades 'BSA','Baños públicos'
GO
Alta_Facilidades 'COR','Correo'
GO
Alta_Facilidades 'COR','Cambio de moneda'
GO
Alta_Facilidades 'ASU','Baños públicos'
GO
Alta_Facilidades 'CUR','Plaza de comidas'
GO
Alta_Facilidades 'CUR','Cambio de moneda'
GO
Alta_Facilidades 'COL','Correo'
GO
Alta_Facilidades 'COL','Plaza de comidas'
GO

Alta_ViajeNacional 291, 'Ega', 'SAL', '06/02/2017 0:8', '06/02/2017 19:5', 45, '43593913', 1
GO
Alta_ViajeNacional 751, 'Buquebus', 'MAL', '25/11/2017 20:6', '27/11/2017 2:43', 47, '47879585', 2
GO
Alta_ViajeNacional 443, 'Cita', 'MAL', '15/06/2017 22:39', '17/06/2017 9:21', 51, '15080405', 2
GO
Alta_ViajeNacional 801, 'Ega', 'RIV', '23/12/2017 3:41', '24/12/2017 1:24', 27, '44142650', 3
GO
Alta_ViajeNacional 360, 'Ega', 'RIV', '17/03/2018 9:55', '17/03/2018 15:8', 51, '15080405', 3
GO
Alta_ViajeNacional 127, 'Cot', 'RIV', '29/11/2017 12:4', '01/12/2017 14:3', 19, '47879585', 4
GO
Alta_ViajeNacional 68, 'Copsa', 'DUR', '05/05/2019 17:8', '07/05/2019 8:28', 19, '47879585', 6
GO
Alta_ViajeNacional 54, 'Agencia Central', 'DUR', '11/06/2020 19:58', '11/06/2020 23:12', 25, '44142650', 6
GO
Alta_ViajeNacional 412, 'Cynsa', 'SAL', '16/06/2019 20:32', '16/06/2019 23:10', 59, '47879585', 6
GO
Alta_ViajeNacional 761, 'Copsa', 'COL', '16/08/2019 23:28', '18/08/2019 5:4', 34, '47879585', 7
GO
Alta_ViajeNacional 484, 'Agencia Central', 'COL', '07/09/2018 0:45', '09/09/2018 13:40', 18, '43593913', 7
GO
Alta_ViajeNacional 421, 'Buquebus', 'COL', '29/11/2018 20:49', '29/11/2018 23:39', 47, '43593913', 7
GO
Alta_ViajeNacional 932, 'Nossar', 'DUR', '01/02/2020 11:1', '02/02/2020 21:13', 32, '16066363', 8
GO
Alta_ViajeNacional 976, 'Agencia Central', 'SAL', '18/06/2017 0:13', '20/06/2017 17:48', 11, '41348194', 8
GO
Alta_ViajeNacional 144, 'Ega', 'DUR', '11/01/2018 17:5', '12/01/2018 7:44', 21, '43593913', 9
GO
Alta_ViajeNacional 977, 'Ega', 'SAL', '14/04/2017 21:56', '15/04/2017 20:44', 48, '16066363', 10
GO
Alta_ViajeNacional 252, 'Cynsa', 'COL', '21/03/2017 12:14', '21/03/2017 16:53', 41, '15080405', 10
GO
Alta_ViajeNacional 1005, 'Nossar', 'RIV', '19/08/2018 20:28', '20/08/2018 20:13', 20, '16066363', 10
GO
Alta_ViajeNacional 700, 'Copsa', 'DUR', '12/04/2019 14:46', '12/04/2019 15:52', 35, '44142650', 11
GO
Alta_ViajeNacional 960, 'Copsa', 'MAL', '21/08/2019 4:23', '21/08/2019 8:55', 52, '15080405', 11
GO
Alta_ViajeNacional 935, 'Agencia Central', 'SAL', '02/01/2019 1:18', '04/01/2019 8:18', 55, '16066363', 11
GO
Alta_ViajeNacional 386, 'Cita', 'SAL', '31/03/2018 0:41', '01/04/2018 4:42', 44, '47879585', 12
GO
Alta_ViajeNacional 620, 'Cot', 'MAL', '18/03/2018 10:20', '19/03/2018 22:21', 34, '16066363', 12
GO
Alta_ViajeNacional 614, 'Buquebus', 'DUR', '31/03/2017 13:19', '02/04/2017 4:31', 46, '15080405', 13
GO
Alta_ViajeNacional 480, 'Colonia Express', 'DUR', '22/03/2017 12:20', '24/03/2017 14:19', 42, '16066363', 13
GO
Alta_ViajeNacional 799, 'Cynsa', 'MAL', '20/10/2019 10:19', '21/10/2019 21:44', 46, '47879585', 13
GO
Alta_ViajeNacional 609, 'Agencia Central', 'SAL', '01/07/2018 4:13', '03/07/2018 10:8', 24, '44142650', 13
GO
Alta_ViajeNacional 841, 'Agencia Central', 'RIV', '22/05/2018 19:57', '23/05/2018 16:14', 17, '16066363', 14
GO
Alta_ViajeNacional 998, 'Nossar', 'SAL', '02/11/2018 15:2', '02/11/2018 19:16', 36, '47879585', 14
GO
Alta_ViajeNacional 999, 'Cita', 'COL', '13/03/2019 15:43', '15/03/2019 7:45', 48, '41348194', 14
GO
Alta_ViajeNacional 795, 'Agencia Central', 'DUR', '29/01/2018 10:22', '29/01/2018 11:21', 18, '15080405', 14
GO
Alta_ViajeNacional 606, 'Cita', 'RIV', '22/11/2018 9:10', '22/11/2018 10:35', 27, '41348194', 14
GO
Alta_ViajeNacional 678, 'Agencia Central', 'SAL', '24/08/2017 7:36', '25/08/2017 6:54', 25, '15080405', 14
GO
Alta_ViajeInternacional 878, 'Agencia Central', 'SAP', '13/03/2017 3:41', '14/03/2017 8:19', 23, '16066363', 0, 'Pasaporte'
GO
Alta_ViajeInternacional 891, 'Chadre', 'SAP', '25/09/2017 19:47', '26/09/2017 5:11', 41, '41348194', 1, ''
GO
Alta_ViajeInternacional 819, 'Copsa', 'BSA', '03/10/2017 3:28', '04/10/2017 9:18', 18, '16066363', 1, ''
GO
Alta_ViajeInternacional 844, 'Cot', 'BSA', '01/02/2019 3:28', '03/02/2019 2:56', 29, '16066363', 0, ''
GO
Alta_ViajeInternacional 117, 'Cynsa', 'BSA', '08/10/2017 18:42', '10/10/2017 14:26', 25, '47879585', 0, 'Vacunas'
GO
Alta_ViajeInternacional 653, 'Buquebus', 'ASU', '26/01/2018 13:6', '28/01/2018 4:6', 45, '16066363', 1, ''
GO
Alta_ViajeInternacional 925, 'Buquebus', 'ENR', '26/04/2018 0:32', '27/04/2018 7:46', 23, '15080405', 1, ''
GO
Alta_ViajeInternacional 253, 'Cynsa', 'RDJ', '25/01/2018 10:19', '26/01/2018 19:3', 53, '43593913', 1, 'Pasaporte'
GO
Alta_ViajeInternacional 153, 'Agencia Central', 'REC', '02/12/2018 5:33', '02/12/2018 18:8', 39, '15080405', 0, ''
GO
Alta_ViajeInternacional 249, 'Agencia Central', 'ASU', '12/09/2018 1:33', '13/09/2018 6:3', 54, '43593913', 0, ''
GO
Alta_ViajeInternacional 459, 'Colonia Express', 'CUR', '16/03/2017 21:36', '17/03/2017 15:15', 45, '43593913', 1, 'Cedula y Vacunas'
GO
Alta_ViajeInternacional 248, 'Buquebus', 'ASU', '23/09/2019 19:30', '23/09/2019 23:4', 31, '44142650', 1, 'Pasaporte'
GO
Alta_ViajeInternacional 780, 'Copsa', 'COR', '14/12/2017 23:50', '15/12/2017 15:11', 36, '41348194', 0, ''
GO
Alta_ViajeInternacional 21, 'Copsa', 'ASU', '02/08/2017 15:33', '02/08/2017 18:46', 21, '43593913', 1, ''
GO
Alta_ViajeInternacional 6, 'Cot', 'ASU', '21/09/2017 8:44', '21/09/2017 17:41', 30, '16066363', 0, ''
GO
Alta_ViajeInternacional 800, 'Buquebus', 'RDJ', '26/04/2017 3:32', '28/04/2017 10:50', 11, '16066363', 1, ''
GO
Alta_ViajeInternacional 556, 'Colonia Express', 'SAP', '07/03/2019 15:59', '09/03/2019 13:4', 20, '15080405', 0, ''
GO
Alta_ViajeInternacional 378, 'Agencia Central', 'COR', '09/05/2017 21:19', '11/05/2017 6:26', 45, '44142650', 0, ''
GO
Alta_ViajeInternacional 796, 'Colonia Express', 'SAP', '27/09/2017 15:11', '27/09/2017 16:30', 34, '15080405', 1, ''
GO
Alta_ViajeInternacional 195, 'Nossar', 'ASU', '15/05/2017 6:39', '17/05/2017 20:31', 56, '47879585', 1, 'Pasaporte y Vacunas'
GO
Alta_ViajeInternacional 368, 'Chadre', 'CUR', '02/05/2017 5:5', '04/05/2017 10:16', 16, '41348194', 1, 'Cedula y Pasaporte'
GO
Alta_ViajeInternacional 168, 'Buquebus', 'ASU', '08/01/2017 10:38', '08/01/2017 12:7', 52, '44142650', 1, ''
GO
Alta_ViajeInternacional 301, 'Ega', 'ASU', '21/01/2017 22:47', '21/01/2017 23:11', 51, '43593913', 1, ''
GO
Alta_ViajeInternacional 726, 'Cita', 'ASU', '10/04/2017 14:4', '11/04/2017 19:15', 47, '15080405', 0, ''
GO
Alta_ViajeInternacional 15, 'Agencia Central', 'ASU', '22/11/2017 2:12', '22/11/2017 16:25', 55, '44142650', 1, ''
GO
Alta_ViajeInternacional 682, 'Colonia Express', 'ASU', '02/07/2018 12:14', '04/07/2018 16:33', 17, '15080405', 1, 'Cedula y Vacunas'
GO
Alta_ViajeInternacional 79, 'Cot', 'ASU', '03/09/2018 20:8', '03/09/2018 23:30', 36, '16066363', 0, 'Pasaporte'
GO
Alta_ViajeInternacional 159, 'Cot', 'ASU', '23/05/2019 20:52', '25/05/2019 22:10', 26, '47879585', 0, ''
GO
Alta_ViajeInternacional 267, 'Agencia Central', 'BSA', '06/11/2017 20:30', '06/11/2017 23:54', 37, '47879585', 1, ''
GO
Alta_ViajeInternacional 978, 'Copsa', 'BSA', '14/03/2018 16:48', '16/03/2018 3:51', 43, '47879585', 1, 'Cedula y Pasaporte'
GO
Alta_ViajeInternacional 721, 'Colonia Express', 'BSA', '26/03/2018 14:54', '27/03/2018 2:19', 35, '15080405', 0, ''
GO
Alta_ViajeInternacional 124, 'Ega', 'BSA', '08/06/2018 8:13', '10/06/2018 0:29', 36, '44142650', 1, ''
GO
Alta_ViajeInternacional 353, 'Chadre', 'BSA', '13/08/2019 5:10', '13/08/2019 13:37', 27, '15080405', 0, 'Cedula y Vacunas'
GO
Alta_ViajeInternacional 732, 'Chadre', 'COR', '03/04/2017 20:18', '05/04/2017 22:24', 10, '16066363', 1, ''
GO
Alta_ViajeInternacional 173, 'Ega', 'COR', '04/06/2017 19:19', '05/06/2017 22:3', 57, '41348194', 1, 'Vacunas'
GO
Alta_ViajeInternacional 611, 'Copsa', 'COR', '23/09/2017 6:56', '23/09/2017 15:38', 16, '41348194', 0, 'Cedula'
GO
Alta_ViajeInternacional 521, 'Cot', 'COR', '20/01/2018 13:46', '21/01/2018 13:58', 58, '44142650', 1, 'Pasaporte'
GO
Alta_ViajeInternacional 790, 'Nossar', 'COR', '28/01/2018 7:18', '28/01/2018 8:42', 45, '15080405', 1, ''
GO
Alta_ViajeInternacional 183, 'Agencia Central', 'COR', '02/04/2018 8:18', '02/04/2018 10:25', 35, '41348194', 1, 'Pasaporte'
GO
Alta_ViajeInternacional 659, 'Agencia Central', 'COR', '15/08/2018 6:24', '17/08/2018 19:4', 52, '44142650', 1, 'Cedula y Pasaporte'
GO
Alta_ViajeInternacional 749, 'Copsa', 'COR', '23/11/2018 17:27', '24/11/2018 13:16', 20, '16066363', 0, ''
GO
Alta_ViajeInternacional 499, 'Buquebus', 'COR', '17/02/2019 22:45', '18/02/2019 11:33', 33, '47879585', 1, ''
GO
Alta_ViajeInternacional 430, 'Colonia Express', 'COR', '06/03/2019 8:35', '08/03/2019 1:30', 37, '43593913', 1, ''
GO
Alta_ViajeInternacional 1000, 'Cot', 'COR', '24/07/2019 1:9', '25/07/2019 7:46', 54, '15080405', 1, 'Cedula y Vacunas'
GO
Alta_ViajeInternacional 628, 'Agencia Central', 'CUR', '29/01/2017 21:8', '30/01/2017 23:50', 19, '43593913', 0, 'Pasaporte'
GO
Alta_ViajeInternacional 25, 'Chadre', 'CUR', '06/04/2018 4:43', '06/04/2018 7:5', 25, '15080405', 1, ''
GO
Alta_ViajeInternacional 966, 'Cynsa', 'CUR', '20/06/2018 11:55', '20/06/2018 13:25', 31, '47879585', 0, 'Cedula'
GO
Alta_ViajeInternacional 383, 'Copsa', 'CUR', '13/09/2018 16:47', '15/09/2018 9:20', 20, '16066363', 0, 'Cedula'
GO
Alta_ViajeInternacional 864, 'Cot', 'CUR', '17/03/2019 20:1', '18/03/2019 19:40', 47, '16066363', 1, 'Vacunas'
GO
Alta_ViajeInternacional 615, 'Cynsa', 'CUR', '15/04/2019 16:25', '15/04/2019 17:24', 24, '43593913', 0, ''
GO
Alta_ViajeInternacional 854, 'Nossar', 'CUR', '20/05/2019 19:51', '22/05/2019 17:57', 52, '43593913', 0, ''
GO
Alta_ViajeInternacional 391, 'Nossar', 'ENR', '19/03/2018 10:49', '21/03/2018 19:49', 33, '47879585', 0, ''
GO
Alta_ViajeInternacional 55, 'Cynsa', 'ENR', '12/05/2018 15:53', '12/05/2018 16:17', 23, '16066363', 1, 'Vacunas'
GO
Alta_ViajeInternacional 342, 'Cynsa', 'ENR', '14/07/2019 8:18', '14/07/2019 13:19', 40, '47879585', 1, 'Pasaporte'
GO
Alta_ViajeInternacional 1032, 'Colonia Express', 'ENR', '12/09/2019 12:54', '14/09/2019 7:32', 42, '47879585', 0, ''
GO
Alta_ViajeInternacional 898, 'Cita', 'RDJ', '31/08/2018 9:23', '31/08/2018 11:57', 30, '41348194', 0, ''
GO
Alta_ViajeInternacional 565, 'Ega', 'REC', '07/02/2017 21:3', '08/02/2017 0:55', 18, '44142650', 0, 'Vacunas'
GO
Alta_ViajeInternacional 654, 'Agencia Central', 'REC', '05/03/2018 2:56', '07/03/2018 1:22', 40, '47879585', 0, 'Vacunas'
GO
Alta_ViajeInternacional 517, 'Buquebus', 'REC', '10/05/2018 22:36', '10/05/2018 23:24', 35, '41348194', 1, ''
GO
Alta_ViajeInternacional 150, 'Cot', 'REC', '09/08/2019 12:9', '09/08/2019 20:12', 51, '16066363', 0, 'Cedula'
GO
Alta_ViajeInternacional 741, 'Colonia Express', 'REC', '12/08/2020 9:8', '13/08/2020 16:22', 10, '43593913', 1, 'Pasaporte'
GO
Alta_ViajeInternacional 465, 'Cynsa', 'SAP', '23/05/2017 2:43', '24/05/2017 5:34', 37, '41348194', 0, 'Vacunas'
GO
Alta_ViajeInternacional 911, 'Colonia Express', 'SAP', '30/07/2017 17:37', '01/08/2017 3:24', 21, '41348194', 0, ''
GO
Alta_ViajeInternacional 939, 'Colonia Express', 'SAP', '01/08/2017 22:18', '03/08/2017 20:33', 14, '47879585', 0, ''
GO
Alta_ViajeInternacional 118, 'Colonia Express', 'SAP', '31/05/2018 3:3', '02/06/2018 17:51', 35, '47879585', 0, 'Pasaporte y Vacunas'
GO
Alta_ViajeInternacional 460, 'Copsa', 'SAP', '20/07/2019 10:53', '21/07/2019 10:42', 38, '15080405', 1, 'Vacunas'
GO
Alta_ViajeInternacional 728, 'Nossar', 'SAP', '12/09/2019 16:55', '13/09/2019 5:23', 52, '43593913', 1, 'Cedula y Pasaporte'
GO



