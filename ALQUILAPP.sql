USE master
GO
CREATE DATABASE ALQUILAPP_DB
GO
USE ALQUILAPP_DB
GO
CREATE TABLE Usuarios(

    idUsuario INT IDENTITY(1,1) NOT NULL,
    Nombre NVARCHAR(50) NOT NULL,
    Apellido NVARCHAR(50) NOT NULL, 
    Email NVARCHAR(100) NOT NULL,
    Contraseña NVARCHAR(255) NOT NULL, 
    Telefono NVARCHAR(50) NULL, 
    FechaRegistro Date DEFAULT(GETDATE()),
    UltimoLogin DATETIME NULL, 
    Activo BIT DEFAULT(1),
    CONSTRAINT PK_Usuarios PRIMARY KEY (idUsuario)
)
GO
CREATE TABLE TiposUsuario(
    idTipoUsuario INT IDENTITY(1,1) NOT NULL,
    Descripcion NVARCHAR(20) NOT NULL,
    CONSTRAINT PK_TiposUsuario PRIMARY KEY (idTipoUsuario)
)
GO
CREATE TABLE RolesUsuario(
    idUsuario INT NOT NULL,
    idTipoUsuario INT NOT NULL,
    CONSTRAINT PK_RolesUsuario PRIMARY KEY (idUsuario, idTipoUsuario),
    CONSTRAINT FK_RolesUsuario_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario),
    CONSTRAINT FK_RolesUsuario_TipoUsuario FOREIGN KEY (idTipoUsuario) REFERENCES TiposUsuario(idTipoUsuario)
)
GO
CREATE TABLE Paises(
    idPais INT IDENTITY(1,1) NOT NULL,
    Nombre NVARCHAR(100) UNIQUE NOT NULL,
    CONSTRAINT PK_Paises PRIMARY KEY (idPais)
)
GO
CREATE TABLE Ciudades(
    idCiudad INT IDENTITY(1,1) NOT NULL, 
    idPais INT NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_Ciudades PRIMARY KEY (idCiudad),
    CONSTRAINT FK_Ciudades_Pais FOREIGN KEY (idPais) REFERENCES Paises(idPais)
)
GO
CREATE TABLE Propiedades(
idPropiedad INT IDENTITY(1,1) NOT NULL,
idAnfitrion INT NOT NULL,
idCiudad INT NOT NULL, 
Titulo NVARCHAR(100) NOT NULL, 
Descripcion NVARCHAR(500) NULL, 
PrecioNoche DECIMAL(10, 2) NOT NULL, 
Capacidad INT NOT NULL CHECK(Capacidad > 0), 
TipoPropiedad NVARCHAR(50) NOT NULL, 
Direccion NVARCHAR(100) NOT NULL, 
Activa BIT DEFAULT(1) NOT NULL, 
CONSTRAINT PK_Propiedades PRIMARY KEY (idPropiedad),
CONSTRAINT FK_Propiedades_idAnfitrion FOREIGN KEY(idAnfitrion) REFERENCES Usuarios(idUsuario),
CONSTRAINT FK_Propiedades_idCiudad FOREIGN KEY (idCiudad) REFERENCES Ciudades(idCiudad)

)
GO
CREATE TABLE Reservas(
    idReserva INT IDENTITY(1,1) NOT NULL, 
    idPropiedad INT NOT NULL,
    idHuesped INT NOT NULL,
    FechaInicio DATE NOT NULL, 
    FechaFin DATE NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    EstadoReserva NVARCHAR(20) NOT NULL, 
    FechaCreacion DATETIME NOT NULL, 
    FechaModificacion DATETIME NULL,
    CONSTRAINT PK_Reservas PRIMARY KEY (idReserva),
    CONSTRAINT FK_Reservas_idPropiedad FOREIGN KEY (idPropiedad) REFERENCES Propiedades(idPropiedad),
    CONSTRAINT FK_Reservas_idHuesped FOREIGN KEY (idHuesped) REFERENCES Usuarios(idUsuario),
    CONSTRAINT CK_FechaInicio_FechaFin CHECK (FechaFin > FechaInicio)
)
GO
CREATE TABLE FotosPropiedades(
    idFoto INT IDENTITY(1,1) NOT NULL, 
    idPropiedad INT NOT NULL, 
    Descripcion NVARCHAR(50) NULL, 
    URL NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_FotosPropiedades PRIMARY KEY (idFoto), 
    CONSTRAINT FK_FotosPropiedades_idPropiedad FOREIGN KEY (idPropiedad) REFERENCES Propiedades(idPropiedad)
)
GO
CREATE TABLE CompañiasPago(
    idCompañia INT IDENTITY(1,1) NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_CompañiasPago PRIMARY KEY (idCompañia)
)
GO
CREATE TABLE MediosPago(
    idMedioPago INT IDENTITY(1,1) NOT NULL,
    idCompañia INT NULL,
    Descripcion NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_MediosPago PRIMARY KEY (idMedioPago),
    CONSTRAINT FK_MediosPago_Compania FOREIGN KEY (idCompañia) REFERENCES CompañiasPago(idCompañia)
)
GO
CREATE TABLE Pagos(
    idPago INT IDENTITY(1,1) NOT NULL,
    idReserva INT NOT NULL,
    idMedioPago INT NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    FechaPago DATETIME NOT NULL DEFAULT(GETDATE()),
    EstadoPago NVARCHAR(20) NOT NULL,
    CONSTRAINT PK_Pagos PRIMARY KEY (idPago),
    CONSTRAINT FK_Pagos_Reserva FOREIGN KEY (idReserva) REFERENCES Reservas(idReserva),
    CONSTRAINT FK_Pagos_Medio FOREIGN KEY (idMedioPago)REFERENCES MediosPago(idMedioPago)
)
GO
CREATE TABLE Calificaciones(
    idCalificacion INT IDENTITY(1,1) NOT NULL,
    idReserva INT NOT NULL UNIQUE,
    Puntuacion INT NOT NULL CHECK (Puntuacion BETWEEN 1 AND 5),
    Comentario NVARCHAR(500) NULL,
    FechaCalificacion DATE NOT NULL DEFAULT(GETDATE()),
    CONSTRAINT PK_Calificaciones PRIMARY KEY (idCalificacion),
    CONSTRAINT FK_Calificaciones_Reserva FOREIGN KEY (idReserva) REFERENCES Reservas(idReserva)
);
GO

select * from Usuarios
select * from Propiedades
select * from FotosPropiedades
select * from Reservas
select * from RolesUsuario
select * from CompañiasPago
select * from Pagos
select  * from TiposUsuario
select * from Paises
select * from Ciudades
SELECT * from Calificaciones
select top 10 nombre, apellido, email from Usuarios