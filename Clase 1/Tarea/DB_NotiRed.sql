--Crear base de datos
CREATE DATABASE DB_NotiRed
GO
USE DB_NotiRed
------------------------------------------------------------------------
GO
--Crear tablas
CREATE TABLE Persona(
	IdPersona INT IDENTITY(1,1) PRIMARY KEY,
	Nombre VARCHAR(100),
	Apellido VARCHAR(100),
	Estado BIT
)
GO
CREATE TABLE Imagen(
	IdImagen INT IDENTITY(1,1) PRIMARY KEY,
	Imagen Image,
	Estado BIT
)
GO
CREATE TABLE Usuario(
	IdUsuario INT IDENTITY(1,1) PRIMARY KEY,
	IdPersona INT FOREIGN KEY REFERENCES Persona(IdPersona),
	IdImagen INT FOREIGN KEY REFERENCES Imagen(IdImagen),
	Correo VARCHAR(50),
	Usuario VARCHAR(20),
	Contrasenia	VARCHAR(250),
	Estado BIT
)
GO
CREATE TABLE PerfilUsuario(
	IdPerfilUsuario INT IDENTITY(1,1) PRIMARY KEY,
	IdUsuario INT FOREIGN KEY REFERENCES Usuario(IdUsuario),
	Portada INT FOREIGN KEY REFERENCES  Imagen(IdImagen),
	NoTelefono VARCHAR(12),
	Descripcion VARCHAR(200),
	FechaNacimiento DATE,
	Linked VARCHAR(100),
	Facebook VARCHAR(100),
	Twitter VARCHAR(100),
	Estatus BIT
)

GO
CREATE TABLE Noticia(
	IdNoticia INT IDENTITY(1,1) PRIMARY KEY,
	IdUsuario INT FOREIGN KEY REFERENCES Usuario(IdUsuario),
	Portada INT FOREIGN KEY REFERENCES Imagen(IdImagen),
	Titulo VARCHAR(200),
	Descripcion VARCHAR(500),
	Enlace VARCHAR(200),
	Visible BIT,
	Fecha DATETIME,
	Estatus BIT
)
GO
CREATE TABLE Etiqueta(
	IdEtiquetas INT IDENTITY(1,1) PRIMARY KEY,
	IdNoticia INT FOREIGN KEY REFERENCES Noticia(IdNoticia),
	IdUsuario INT FOREIGN KEY REFERENCES Usuario(IdUsuario),
	Estatus BIT
)
GO
CREATE TABLE ImagenNoticia(
	IdImagenNoticia INT IDENTITY(1,1) PRIMARY KEY,
	IdNoticia INT FOREIGN KEY REFERENCES Noticia(IdNoticia),
	IdImagen INT FOREIGN KEY REFERENCES Imagen(IdImagen),
	Estatus BIT
)
GO

CREATE TABLE Comentario(
	IdComentario INT IDENTITY(1,1) PRIMARY KEY,
	IdNoticia INT FOREIGN KEY REFERENCES Noticia(IdNoticia),
	IdUsuario INT FOREIGN KEY REFERENCES Usuario(IdUsuario),
	Descripcion VARCHAR(500),
	Fecha DATETIME,
	Estatus BIT
)
GO
CREATE TABLE Respuesta(
	IdRespuesta INT IDENTITY(1,1) PRIMARY KEY,
	IdComentario INT FOREIGN KEY REFERENCES Comentario(IdComentario),
	IdUsuario INT FOREIGN KEY REFERENCES Usuario(IdUsuario),
	Descripcion VARCHAR(500),
	Fecha DATETIME,
	Estatus BIT
)
GO
CREATE TABLE ReaccionNoticia(
	IdReaccionNoticia INT IDENTITY(1,1) PRIMARY KEY,
	IdNoticia INT FOREIGN KEY REFERENCES Noticia(IdNoticia),
	IdUsuario INT FOREIGN KEY REFERENCES Usuario(IdUsuario),
	Reaccion VARCHAR(20),
	Estatus BIT
)
------------------------------------------------------------------------
GO
--- Procedimientos Insertar
CREATE PROCEDURE spInsertarPersona(
	@Nombre VARCHAR(100),
	@Apellido VARCHAR(100)
)
AS BEGIN
INSERT INTO Persona VALUES (@Nombre,@Apellido,1)
END
GO

--- Procedimientos Editar
CREATE PROCEDURE spEditarPersona(
	@IdPersona INT,
	@Nombre VARCHAR(100),
	@Apellido VARCHAR(100)
)
AS BEGIN
UPDATE Persona SET Nombre = @Nombre, Apellido = @Apellido WHERE IdPersona = @IdPersona 
END
GO

--- Procedimientos Eliminar
CREATE PROCEDURE spEliminarPersona(
	@IdPersona INT
)
AS BEGIN
UPDATE Persona SET Estado = 0 WHERE IdPersona = @IdPersona 
END
GO

--- Procedimientos Listar
CREATE PROCEDURE spObtenerPersona
AS BEGIN
SELECT * FROM Persona WHERE Estado = 1
END
GO


-----------------------------------------------------------------------