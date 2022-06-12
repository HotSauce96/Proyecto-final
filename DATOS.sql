USE DBCARRITO
select * from USUARIO

INSERT INTO USUARIO(Nombres,Apellidos,Correo,Clave)VALUES('JUANE ','TORRES','JT@GMAIL.com','5994471ABB01112AFCC18159F6CC74B4F511B99806DA59B3CAF5A9C173CACFC5')

SELECT * FROM CATEGORIA

INSERT INTO CATEGORIA(Descripcion) VALUES
('Celulares'),
('Computadoras'),
('Consolas'),
('PC'),
('Portátiles'),
('Periféricos'),
('VideosJuegos')

SELECT * FROM MARCA

INSERT INTO MARCA(Descripcion) VALUES 
('NVIDIA'),
('SONY'),
('XBOX'),
('NINTENDO'),
('ASUS'),
('LENOVO'),
('SAMSUNG'),
('IPHONE')

 
 go

create proc sp_RegistrarUsuario(
@Nombres varchar(100),
@Apellidos varchar(100),
@Correo varchar(100),
@Clave varchar(100),
@Activo bit,
@Mensaje varchar (500) output,
@Resultado int output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM USUARIO WHERE Correo = @Correo)
	begin
		INSERT INTO USUARIO(Nombres,Apellidos,Correo,Clave,Activo)VALUES
			(@Nombres,@Apellidos,@Correo,@Clave,@Activo)
			SET @Resultado = SCOPE_IDENTITY()
			end
			else
				set @Mensaje = 'El correo del usuario ya existe'
				end
go

create proc sp_EditarUsuario(
@IdUsuario int,
@Nombres varchar(100),
@Apellidos varchar(100),
@Correo varchar(100),
@Activo bit,
@Mensaje varchar(500) output,
@Resultado bit output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM USUARIO WHERE Correo = @Correo and IdUsuario != @IdUsuario)
	begin
		update top (1) USUARIO SET
		Nombres = @Nombres,
		Apellidos = @Apellidos,
		Correo = @Correo,
		Activo = @Activo
		where IdUsuario = @IdUsuario

		SET @Resultado = 1
		end 
			else 
			set @Mensaje = 'El correo del usuario ya existe'
	end
	
create proc sp_RegistrarCategoria(
@Descripcion varchar(100),
@Activo bit,
@Mensaje varchar(500) output,
@Resultado int output
)
as
begin
	SET @Resultado = 0

	IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion)
	begin
		insert into CATEGORIA(Descripcion,Activo) values 
		(@Descripcion,@Activo)
		SET @Resultado = SCOPE_IDENTITY()
		end
		else
		SET @Mensaje = 'La categoria ya existe'
end
create proc sp_EditarCategoria(
@IdCategoria int,
@Descripcion varchar(100),
@Activo bit,
@Mensaje varchar(500) output,
@Resultado bit output
)
as 
	begin
	set @Resultado = 0
		IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion AND @IdCategoria != @IdCategoria)
		begin
			update top(1) CATEGORIA set
			Descripcion = @Activo
			WHERE IdCategoria = @IdCategoria
			
			SET @Resultado = 1
			end
			else
			set @Resultado = 'La categoria ya existe'
			end

			select * from CATEGORIA

create proc sp_EliminarCategoria(
@IdCategoria int,
@Mensaje varchar(500) output,
@Resultado bit output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (select * from PRODUCTO p
	inner join CATEGORIA c on c.IdCategoria = p.IdCategoria
	where p.IdCategoria = @IdCategoria)
	begin
		delete top (1) from CARRITO where @IdCategoria = @IdCategoria
		SET @Resultado = 1
		end
		else
			set @Mensaje = 'La categoria se encuentra relacionada a un un producto'
			end 


create proc sp_RegistrarMarca(
@Descripcion varchar(100),
@Activo bit,
@Mensaje varchar(500) output,
@Resultado int output
)
as
begin
	SET @Resultado = 0
	if NOT EXISTS (SELECT * FROM MARCA WHERE Descripcion = @Descripcion)
	begin
		insert into MARCA(Descripcion,Activo) values
		(@Descripcion,@Activo)
		set @Resultado = SCOPE_IDENTITY()
	end
	else
	 set @Mensaje= 'La marca ya existe'
end

create proc sp_EditarMarca(
@IdMarca int,
@Descripcion varchar(100),
@Activo bit,
@Mensaje varchar(500) output,
@Resultado bit output)
as
begin
	set @Resultado = 0
	IF NOT EXISTS (SELECT * FROM MARCA WHERE Descripcion = @Descripcion AND IdMarca != @IdMarca)
	BEGIN
		update top (1) Marca set
		Descripcion = @Descripcion,
		Activo = @Activo
		WHERE IdMarca = @IdMarca

		SET @Resultado =1
		end
		else
			set
			@Mensaje = 'La marca ya exite'
	end

create proc sp_EliminarMarca(
@IdMarca int,
@Mensaje varchar(500) output,
@Resultado bit output
)as
begin
	set @Resultado = 0
	IF NOT EXISTS (select * from PRODUCTO p inner join MARCA m ON m.IdMarca = p.IdMarca where p.IdMarca = @IdMarca)
	begin
		delete top(1) from MARCA where IdMarca = @IdMarca
		set @Resultado = 1
		end 
		else
		set @Mensaje = 'La marca se enecuntra realcionada a un producto'
end

select * from MARCA

create proc sp_RegistrarProducto(
@Nombre varchar(100),
@Descripcion varchar(500),
@IdMarca varchar(100),
@IdCategoria varchar(100),
@Precio decimal(10,2),
@Stock int,
@Activo bit,
@Mensaje varchar(500),
@Resultado int output)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE Nombre = @Nombre)
	begin
		insert into PRODUCTO(Nombre,Descripcion,IdMarca,IdCategoria,Precio,Stock,Activo) values
		(@Nombre,@Descripcion,@IdMarca,@IdCategoria,@Precio,@Stock,@Activo)
		
		SET @Resultado = SCOPE_IDENTITY()
		end
		else
		set @Mensaje = 'el producto ya existe'
end

create proc sp_EditarProducto(
@IdProducto int,
@Nombre varchar(100),
@Descripcion varchar(100),
@IdMarca varchar(100),
@IdCategoria varchar(100),
@Precio decimal(10,2),
@Stock int,
@Activo bit,
@Mensaje varchar(500) output,
@Resultado bit output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE Nombre = @Nombre AND IdProducto != @IdProducto)
	begin

	update PRODUCTO set
	Nombre = @Nombre,
	Descripcion = @Descripcion,
	IdMarca = @IdMarca,
	IdCategoria = IdCategoria,
	Precio = @Precio,
	Stock = @Stock,
	Activo = @Activo
	where IdProducto = @IdProducto
	SET @Resultado = 1
	end
	else
	set @Mensaje = 'El producto ya exite'
end

create proc sp_EliminarProducto(
@IdProducto int,
@Mensaje varchar(500) output,
@Resultado bit output
)
as
begin
	SET @resultado = 0
	IF NOT EXISTS (SELECT * FROM DETALLE_VENTA dv
	inner join PRODUCTO p on p.IdProducto = dv.IdProducto where P.IdProducto = @IdProducto)
	BEGIN
		delete top(1) from PRODUCTO where IdProducto = @IdProducto
		set @Resultado = 1
		END
		ELSE
		SET @Mensaje = 'El producto se encuntra ralcionado a una ventan'
		end 
