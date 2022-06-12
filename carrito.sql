CREATE DATABASE DBCARRITO
GO
USE DBCARRITO
GO
CREATE TABLE CATEGORIA(
IdCategoria int primary key identity,
Descripcion varchar(100),
Activo bit default 1,
FechaRegistro datetime default getdate()
)
GO
CREATE TABLE MARCA(
IdMarca int primary key identity,
Descripcion varchar(100),
Activo bit default 1,
FechaRegistro datetime default getdate() 
)
GO
CREATE TABLE PRODUCTO(
IdProducto int primary key identity,
Nombre varchar(100),
Descripcion varchar(500),
IdMarca int references MARCA(IdMarca),
IdCategoria int references CATEGORIA(IdCategoria),
Precio decimal (10,2) default 0,
Stock int,
RutaImagen varchar(100),
NombreImagen Varchar(100),
Activo bit default 1,
FechaRegistro datetime default getdate()
)

GO
CREATE TABLE CLIENTE(
IdCliente int primary key identity,
Nombres varchar(100),
Apellidos varchar(100),
Correo varchar(100),
Clave varchar(100),
Reestablecer bit default 0,
FechaRegistro datetime default getdate()
)
go
CREATE TABLE CARRITO(
IdCarrito int primary key identity,
IdCliente int references CLIENTE(Idcliente),
IdProducto int references PRODUCTO(IdProducto),
Cantida int)
GO
CREATE TABLE VENTA(
IdVenta int primary key identity,
IdCliente int references CLIENTE(IdCliente),
TotalProducto int,
MontoTotal decimal(10,2),
Contacto varchar(50),
IdMunicipio varchar(10),
Telefono varchar(50),
Direccion varchar(500),
IdTrasacion varchar(50),
FechaVenta datetime default getdate()
)
GO
CREATE TABLE DETALLE_VENTA(
IdDetalleVenta int primary key identity,
IdVenta int references Venta(IdVenta),
IdProducto int references Producto(Idproducto),
Cantidad int,
Total decimal(10,2)
)
GO
CREATE TABLE USUARIO(
IdUsuario int primary key identity,
Nombres varchar(100),
Apellidos Varchar(100),
Correo varchar(100),
Clave varchar(100),
Reestablecer bit default 1,
Activo bit default 1,
FechaRegistro datetime default getdate(),
)
GO
CREATE TABLE DEPARTAMENTO(
IdDerpatamento varchar(2) NOT NULL,
Descripcion varchar(45)
)
GO
Create Table MUNICIPIOS(
IdMunicipio varchar(4) NOT NULL,
Descripcion varchar(45) NOT NULL,
IdDepartamento varchar(2) NOT NULL,
)

create table DIRECCION(
IdDepartamento varchar (10),
IdMunicipio varchar(10),
Descripcion varchar(50)
)
