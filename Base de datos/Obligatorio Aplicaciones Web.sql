use master
go

if exists(select * from sysdatabases where name = 'Terminal')
begin
	alter database Terminal set single_user with rollback immediate
	drop database Terminal
end
go

--Se crea la base de datos
create database Terminal
go


--Se selecciona la base de datos
use Terminal
go

-- ------------------------------------------------------------------------------------------------
-- CREACIÓN DE TABLAS 
-- ------------------------------------------------------------------------------------------------

--Se crea la tabla de Empleados
create table Empleados(
cedula varchar(9) not null primary key,
pass varchar(6) not null,
nombre varchar(100)
)
go

-- Se crea la tabla de Compañías
create table Companias(
nombre varchar(50) not null primary key,
direccion varchar(100) not null,
telefono varchar(20) not null
)
go

--Se crea la tabla de Terminales
create table Terminales(
codigo varchar(3) not null primary key,
ciudad varchar(50) not null,
pais varchar (50)
)
go

--Se crea la tabla de Facilidades
create table Facilidades(
nombre varchar(50) not null,
terminal varchar(3) not null foreign key references Terminales(codigo),
constraint PK_Facilidades primary key (terminal, nombre)
)
go

--Se crea la tabla de viajes
create table Viajes(
numero int not null primary key, 
compania varchar(50) not null foreign key references Companias(nombre),
destino varchar(3) not null foreign key references Terminales(codigo),
fecha_partida datetime not null,
fecha_arribo datetime not null,
asientos int not null,
empleado varchar(9) not null foreign key references Empleados(cedula)
)
go

--Se crea la tabla de Viajes Nacionales
create table Nacionales(
numero int not null primary key,
paradas int not null
constraint FK_Nacionales foreign key (numero) references Viajes(numero)
)
go

--Se crea la tabla de Viajes Internacionales
create table Internacionales(
numero int not null primary key, 
servicio bit not null, 
documentacion varchar(200) not null,
constraint FK_Internacionales foreign key (numero) references Viajes(numero)
)
go
