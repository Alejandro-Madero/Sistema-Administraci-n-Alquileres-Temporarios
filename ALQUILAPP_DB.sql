USE master
GO
CREATE DATABASE ALQUILAPP_DB
COLLATE Latin1_General_CI_AI
GO
USE ALQUILAPP_DB
GO
CREATE TABLE Usuarios
(

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
CREATE TABLE TiposUsuario
(
    idTipoUsuario INT IDENTITY(1,1) NOT NULL,
    Descripcion NVARCHAR(20) NOT NULL,
    CONSTRAINT PK_TiposUsuario PRIMARY KEY (idTipoUsuario)
)
GO
CREATE TABLE RolesUsuario
(
    idUsuario INT NOT NULL,
    idTipoUsuario INT NOT NULL,
    CONSTRAINT PK_RolesUsuario PRIMARY KEY (idUsuario, idTipoUsuario),
    CONSTRAINT FK_RolesUsuario_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario),
    CONSTRAINT FK_RolesUsuario_TipoUsuario FOREIGN KEY (idTipoUsuario) REFERENCES TiposUsuario(idTipoUsuario)
)
GO
CREATE TABLE Paises
(
    idPais INT IDENTITY(1,1) NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_Paises PRIMARY KEY (idPais)
)
GO
CREATE TABLE Ciudades
(
    idCiudad INT IDENTITY(1,1) NOT NULL,
    idPais INT NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_Ciudades PRIMARY KEY (idCiudad),
    CONSTRAINT FK_Ciudades_Pais FOREIGN KEY (idPais) REFERENCES Paises(idPais)
)
GO
CREATE TABLE Propiedades
(
    idPropiedad INT IDENTITY(1,1) NOT NULL,
    idAnfitrion INT NOT NULL,
    idCiudad INT NOT NULL,
    Titulo NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(500) NULL,
    PrecioNoche DECIMAL(10, 2) NOT NULL,
    Capacidad INT NOT NULL CHECK(Capacidad > 0),
    TipoPropiedad NVARCHAR(50) NOT NULL,
    Direccion NVARCHAR(100) NOT NULL,
    CalificacionPromedio DECIMAL(3,2) NULL,
    Activa BIT DEFAULT(1) NOT NULL,
    FechaAltaPublicacion DATETIME NOT NULL DEFAULT(GETDATE()),
    FechaBajaPublicacion DATETIME NULL,
    CONSTRAINT PK_Propiedades PRIMARY KEY (idPropiedad),
    CONSTRAINT FK_Propiedades_idAnfitrion FOREIGN KEY(idAnfitrion) REFERENCES Usuarios(idUsuario),
    CONSTRAINT FK_Propiedades_idCiudad FOREIGN KEY (idCiudad) REFERENCES Ciudades(idCiudad)

)
GO
CREATE TABLE Reservas
(
    idReserva INT IDENTITY(1,1) NOT NULL,
    idPropiedad INT NOT NULL,
    idHuesped INT NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    CantidadHuespedes INT NOT NULL, 
    EstadoReserva NVARCHAR(20) NOT NULL CHECK (EstadoReserva IN ('Pendiente', 'Confirmada', 'Finalizada', 'Cancelada')),
    ReservaConfirmada BIT NOT NULL DEFAULT 0, 
    FechaCreacion DATETIME NOT NULL,
    FechaModificacion DATETIME NULL,
    CONSTRAINT PK_Reservas PRIMARY KEY (idReserva),
    CONSTRAINT FK_Reservas_idPropiedad FOREIGN KEY (idPropiedad) REFERENCES Propiedades(idPropiedad),
    CONSTRAINT FK_Reservas_idHuesped FOREIGN KEY (idHuesped) REFERENCES Usuarios(idUsuario),
    CONSTRAINT CK_FechaInicio_FechaFin CHECK (FechaFin > FechaInicio)
)
GO
CREATE TABLE FotosPropiedades
(
    idFoto INT IDENTITY(1,1) NOT NULL,
    idPropiedad INT NOT NULL,
    Descripcion NVARCHAR(50) NULL,
    URL NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_FotosPropiedades PRIMARY KEY (idFoto),
    CONSTRAINT FK_FotosPropiedades_idPropiedad FOREIGN KEY (idPropiedad) REFERENCES Propiedades(idPropiedad)
)
GO
CREATE TABLE CompañiasPago
(
    idCompañia INT IDENTITY(1,1) NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_CompañiasPago PRIMARY KEY (idCompañia)
)
GO
CREATE TABLE MediosPago
(
    idMedioPago INT IDENTITY(1,1) NOT NULL,
    idCompañia INT NULL,
    Descripcion NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_MediosPago PRIMARY KEY (idMedioPago),
    CONSTRAINT FK_MediosPago_Compania FOREIGN KEY (idCompañia) REFERENCES CompañiasPago(idCompañia)
)
GO
CREATE TABLE Pagos
(
    idPago INT IDENTITY(1,1) NOT NULL,
    idReserva INT NOT NULL,
    idMedioPago INT NOT NULL,
    idCompañia INT NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    FechaPago DATETIME NOT NULL DEFAULT(GETDATE()),
    EstadoPago NVARCHAR(20) NOT NULL,
    NFactura NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Pagos PRIMARY KEY (idPago),
    CONSTRAINT FK_Pagos_Reserva FOREIGN KEY (idReserva) REFERENCES Reservas(idReserva),
    CONSTRAINT FK_Pagos_Medio FOREIGN KEY (idMedioPago)REFERENCES MediosPago(idMedioPago),
    CONSTRAINT FK_Pagos_Compañias FOREIGN KEY(idCompañia) REFERENCES CompañiasPago(idCompañia)
)
GO
CREATE TABLE Calificaciones
(
    idCalificacion INT IDENTITY(1,1) NOT NULL,
    idReserva INT NOT NULL UNIQUE,
    Puntuacion TINYINT NOT NULL CHECK (Puntuacion BETWEEN 1 AND 5),
    Comentario NVARCHAR(500) NULL,
    FechaCalificacion DATE NOT NULL DEFAULT(GETDATE()),
    CONSTRAINT PK_Calificaciones PRIMARY KEY (idCalificacion),
    CONSTRAINT FK_Calificaciones_Reserva FOREIGN KEY (idReserva) REFERENCES Reservas(idReserva)
);
GO

--VIEW 1
CREATE VIEW vw_reservasPorCiudad AS
SELECT 
C.Nombre as Ciudad, 
PA.Nombre as Pais,
SUM(CASE WHEN R.EstadoReserva NOT IN ('Cancelada') THEN R.Monto ELSE 0 END) AS IngresosGenerados,
 count(r.idPropiedad) AS CantidadPropiedades, 
 SUM(CASE WHEN R.EstadoReserva = 'Finalizada' THEN 1 ELSE 0 END) as EstadiasFinalizadas,
 SUM(CASE WHEN R.EstadoReserva = 'Cancelada' THEN 1 ELSE 0 END) AS ReservasCanceladas,
 SUM(CASE WHEN R.EstadoReserva = 'Confirmada' THEN 1 ELSE 0 END) AS ReservasConfirmadas,
 ROUND(AVG(CA.Puntuacion * 1.0), 2) AS CalificacionPromedio,
 ROUND(AVG(DATEDIFF(DAY,R.FechaInicio, R.FechaFin) * 1.0), 2) PromedioNochesEstadia
FROM reservas R
INNER join Propiedades p on r.idPropiedad = P.idPropiedad
INNER JOIN ciudades C on p.idCiudad = C.idCiudad
INNER join paises PA on pa.idPais = C.idPais
LEFT JOIN Calificaciones CA on R.idReserva = ca.idReserva
GROUP BY C.Nombre, PA.Nombre
GO


-- VIEW 2: 
CREATE VIEW vw_ReservasPendientesPorPropiedad AS
SELECT 
P.idPropiedad, 
U.Nombre + ' ' + U.Apellido AS NombreAnfitrion,
u.Email AS EmailAnfitrion,
C.Nombre AS Ciudad,
SUM(R.Monto) AS MontoPendiente,
COUNT(R.idReserva) AS ReservasPendientesPago
FROM Reservas R
INNER JOIN Propiedades P on R.idPropiedad = P.idPropiedad
INNER JOIN Ciudades C ON C.idCiudad = P.idCiudad
INNER JOIN Usuarios U ON U.idUsuario = P.idAnfitrion
where EstadoReserva = 'Pendiente'
GROUP BY P.idPropiedad, 
U.Nombre + ' ' + U.Apellido,
U.Email,
C.Nombre
GO



-- VIEW 3: 
CREATE VIEW vw_ingresosPorAnfitrion AS
SELECT 
u.idUsuario,
U.Nombre + ' ' + U.Apellido AS NombreApellido,
SUM(R.Monto) AS RecaudacionTotal,
SUM(r.Monto) / COUNT(r.idReserva) AS RecaudacionPromEstadia,
COUNT(DISTINCT P.idPropiedad) AS CantidadPropiedadesListadas,
COUNT(distinct r.idReserva) AS CantidadEstadias,
AVG(DATEDIFF(day, r.FechaInicio, r.FechaFin) * 1.0) as NochesPromEstadia
FROM Propiedades P
INNER JOIN Reservas R ON P.idPropiedad = R.idPropiedad AND R.ReservaConfirmada = 1
INNER JOIN USUARIOS U ON U.idUsuario = P.idAnfitrion
GROUP BY
U.idUsuario,
U.Nombre + ' ' + U.Apellido
GO


--SP 1, LISTAR PROPIEDADES DISPONIBLES
CREATE PROCEDURE sp_ListarPropiedadesDisponibles(
    @Ciudad NVARCHAR(100),
    @Capacidad INT,
    @FechaInicio DATE,
    @FechaFin DATE
)
AS
BEGIN

    IF (@FechaFin <= @FechaInicio)
BEGIN
        RAISERROR('La fecha de fin debe ser posterior a la fecha de inicio.', 16, 1);
        RETURN;
    END
    SELECT
        P.idPropiedad,
        U.idUsuario,
        U.Nombre,
        U.Apellido,
        P.Titulo,
        p.TipoPropiedad,
        P.PrecioNoche,
        DATEDIFF(DAY, @FechaInicio, @FechaFin) AS Noches,
        P.Capacidad,
        p.direccion,
        p.Descripcion,
        p.CalificacionPromedio,
        c.idCiudad AS idCiudad,
        C.Nombre AS Ciudad
    FROM Propiedades P
        INNER JOIN Ciudades C ON P.idCiudad = C.idCiudad
        INNER JOIN Usuarios U ON P.idAnfitrion = U.idUsuario
    WHERE C.Nombre LIKE @Ciudad
        AND P.Capacidad >= @Capacidad
        AND P.Activa = 1
        AND P.idPropiedad NOT IN (
        SELECT P.idPropiedad
        FROM Reservas R
        WHERE R.idPropiedad = P.idPropiedad
            AND (R.Fechainicio < @FechaFin)
            AND (R.FechaFin > @FechaInicio)         
      )
END
GO



-- SP 2: Obtener detalles propiedad
CREATE PROCEDURE sp_ObtenerDetallePropiedad(
    @idPropiedad INT
)
AS
BEGIN
    SELECT
        P.idPropiedad,
        U.idUsuario,
        U.Nombre,
        U.Apellido,
        P.Titulo,
        p.TipoPropiedad,
        P.PrecioNoche,
        P.Capacidad,
        p.direccion,
        p.Descripcion,
        p.CalificacionPromedio,
        C.idCiudad AS idCiudad,
        C.Nombre AS Ciudad
    FROM Propiedades P
        INNER JOIN Ciudades C ON P.idCiudad = C.idCiudad
        INNER JOIN Usuarios U ON P.idAnfitrion = U.idUsuario
    WHERE P.idPropiedad = @idPropiedad
END;
GO

-- SP 3: Listar fotos propiedad
CREATE PROCEDURE sp_ObtenerFotosPropiedad(
    @idPropiedad INT
)
AS
BEGIN
    SELECT *
    FROM FotosPropiedades FP
    WHERE FP.idPropiedad = @idPropiedad
END
GO

--SP 4: Desactivar cuenta de un usuario
CREATE PROCEDURE sp_desactivarCuenta(
    @idUsuario INT
)
AS
BEGIN
    UPDATE Usuarios  
SET Activo = 0
WHERE idUsuario = @idUsuario
END
GO

-- SP 5: RESERVAR PROPIEDAD

CREATE PROCEDURE sp_realizarReserva (
    @idPropiedad INT,
    @FechaInicio DATETIME,
    @FechaFin DATETIME,
    @CantidadHuespedes INT,
    @idHuesped INT
)
AS
BEGIN
BEGIN TRY
DECLARE @CantidadNoches INT =  DATEDIFF(DAY,@Fechainicio, @FechaFin)
DECLARE @PrecioNoche DECIMAL(10,2) 
SELECT @PrecioNoche = PrecioNoche from Propiedades where idPropiedad = @idPropiedad; 
DECLARE @Monto DECIMAL(10,2) = @CantidadNoches * @PrecioNoche
INSERT INTO Reservas(idPropiedad, idHuesped, FechaInicio, FechaFin, Monto, EstadoReserva, FechaCreacion, ReservaConfirmada, CantidadHuespedes)
VALUES(@idPropiedad, @idHuesped, @FechaInicio, @FechaFin, @Monto, 'Pendiente', GETDATE(), 0, @CantidadHuespedes)

END TRY
BEGIN CATCH
RAISERROR('No se pudo reservar la propiedad seleccionada', 16, 1);
END CATCH
END
GO


-- SP 6: Registrar un pago

create PROCEDURE sp_registrarPago(  
    @idReserva INT,
    @Monto DECIMAL(10,2),
    @idMedioPago INT,
    @idCompañia INT
)
AS
BEGIN
BEGIN TRY
BEGIN TRANSACTION
DECLARE @MontoReserva DECIMAL(10,2)
DECLARE @EstadoReserva NVARCHAR(20)
DECLARE @ReservaConfirmada BIT
DECLARE @Factura NVARCHAR(50)

SELECT  
@EstadoReserva = R.EstadoReserva, 
@ReservaConfirmada = R.ReservaConfirmada,
@MontoReserva = R.Monto 
FROM Reservas R 
WHERE R.idReserva = @idReserva 

IF @MontoReserva IS NULL
BEGIN
    RAISERROR('La reserva no existe.', 16, 1);
    RETURN
END

IF @ReservaConfirmada = 1
AND @EstadoReserva = 'Confirmada'
BEGIN
RAISERROR('La reserva ya fue abonada', 16, 1)
RETURN
END

IF @Monto <> @MontoReserva
BEGIN
RAISERROR('El monto no coincide con el valor de la reserva', 16, 1)
RETURN
END
SET @Factura = 'FAC-' + FORMAT(GETDATE(),'yyyyMMddHHmmssfff');

INSERT INTO Pagos(idReserva, idMedioPago, idCompañia, Monto, FechaPago, EstadoPago, NFactura)
VALUES(@idReserva, @idMedioPago,@idCompañia, @Monto, GETDATE(), 'Aprobado', @Factura)

UPDATE Reservas
SET EstadoReserva = 'Confirmada',
ReservaConfirmada = 1,
FechaModificacion = GETDATE()
WHERE idReserva = @idReserva;

COMMIT TRANSACTION
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
DECLARE @ERROR NVARCHAR(1000) = ERROR_MESSAGE();
RAISERROR(@ERROR,16,1);
END CATCH 
END
GO


--SP7: Calificar reserva

CREATE PROCEDURE sp_calificarEstadia(
    @idReserva INT,
    @Comentario NVARCHAR(500),
    @Puntaje INT
)
AS 
BEGIN
BEGIN TRY
BEGIN TRANSACTION
DECLARE @FechaActual DATETIME = GETDATE()
DECLARE @FechaFinalizacionEstadia DATETIME

SELECT @FechaFinalizacionEstadia = R.FechaFin 
FROM Reservas R
WHERE R.idReserva = @idReserva

IF @FechaFinalizacionEstadia > @FechaActual
BEGIN
RAISERROR('La estadia no finalizo todavia, no es posible calificarla', 16, 1)
RETURN
END

IF EXISTS(SELECT 1 FROM Calificaciones WHERE idReserva=@idReserva)
RAISERROR('La reserva ya fue calificada.',16,1);

INSERT INTO Calificaciones(idReserva, Puntuacion, Comentario, FechaCalificacion)
VALUES(@idReserva, @Puntaje, @Comentario,GETDATE())

UPDATE Reservas
SET EstadoReserva = 'Finalizada',
FechaModificacion = GETDATE()
WHERE idReserva = @idReserva

COMMIT TRANSACTION
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
DECLARE @ERROR NVARCHAR(1000) = ERROR_MESSAGE();

RAISERROR(@ERROR, 16, 1)
END CATCH
END
GO

--TRIGGER 1: 

CREATE TRIGGER tr_desactivarPropiedades on Usuarios
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Activo)
 BEGIN
        DECLARE @idUsuario INT;
        Declare @Activo INT;
        SELECT @idUsuario = idUsuario, @Activo = Activo
        FROM inserted;

        IF(@Activo = 0)
          BEGIN
          
            UPDATE Propiedades 
            SET Activa = 0,
            FechaBajaPublicacion = GETDATE()
            WHERE idAnfitrion = @idUsuario;
        END;

        IF(@Activo = 1)
          BEGIN
            UPDATE Propiedades
          SET Activa = 1,
          FechaAltaPublicacion = GETDATE(),
          FechaBajaPublicacion = NULL
          where idAnfitrion = @idUsuario
        END;
    
    END
END
GO

-- TRIGGER 2: 
CREATE TRIGGER tr_PrevenirReservasSuperpuestas ON Reservas
AFTER INSERT 
AS
BEGIN
DECLARE @FechaInicio DATETIME 
DECLARE @FechaFin DATETIME
DECLARE @idPropiedad INT
DECLARE @idReserva INT

SELECT @FechaInicio = FechaInicio, @FechaFin = FechaFin, @idPropiedad = idPropiedad, @idReserva = idReserva FROM inserted

IF EXISTS (
    SELECT  TOP 1 R.idReserva FROM Reservas R     
    WHERE R.idPropiedad = @idPropiedad
    AND R.idReserva <> @idReserva
    AND (R.FechaInicio < @FechaFin)
    AND (R.FechaFin > @FechaInicio)
    AND R.EstadoReserva NOT IN ('Cancelada')
)
BEGIN
RAISERROR('Las fechas elegidas ya no estan disponibles', 16, 1)
ROLLBACK TRANSACTION
END
END
GO



--TRIGGER 3: 
CREATE TRIGGER tr_actualizarPuntajePromedio ON Calificaciones
AFTER INSERT 
AS
BEGIN
BEGIN TRY
BEGIN TRANSACTION

DECLARE @idReserva INT 
DECLARE @idPropiedad INT
DECLARE @NuevoPuntaje DECIMAL(3,2)

SELECT @idReserva = I.idReserva, @idPropiedad = r.idPropiedad from inserted I
INNER JOIN Reservas R on i.idReserva = R.idReserva

select @NuevoPuntaje = AVG(C.Puntuacion * 1.0) from Calificaciones C
INNER JOIN Reservas R ON R.idReserva = C.idReserva
WHERE R.idPropiedad = @idPropiedad


UPDATE Propiedades
SET CalificacionPromedio = @NuevoPuntaje
WHERE idPropiedad = @idPropiedad

COMMIT TRANSACTION
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0 ROLLBACK;
DECLARE @ERROR NVARCHAR(1000) = ERROR_MESSAGE();
RAISERROR(@ERROR, 16, 1)
END CATCH
END
GO



-- DATASET




-- ===========================
-- PAISES
-- ===========================
INSERT INTO Paises (Nombre) VALUES
('Argentina'),
('Brasil'),
('Chile');
GO

-- ===========================
-- CIUDADES
-- ===========================
INSERT INTO Ciudades (idPais, Nombre) VALUES
(1, 'Buenos Aires'),
(1, 'Bariloche'),
(1, 'Mendoza'),
(1, 'Córdoba'),
(1, 'Salta'),
(1, 'Rosario'),
(1, 'Ushuaia'),
(1, 'Mar del Plata'),
(1, 'San Martín de los Andes'),
(1, 'El Calafate'),
(2, 'Florianópolis'),
(3, 'Santiago de Chile');
GO

-- ===========================
-- TIPOS DE USUARIO
-- ===========================
INSERT INTO TiposUsuario (Descripcion) VALUES
('Anfitrión'),
('Huésped');
GO

-- ===========================
-- USUARIOS
-- ===========================
INSERT INTO Usuarios (Nombre, Apellido, Email, Contraseña, Telefono)
VALUES
('Alejandro', 'Madero', 'alejandro@example.com', '1234', '294-5123456'),
('Lucía', 'Fernández', 'luciaf@example.com', '1234', '294-4234234'),
('Pedro', 'Gómez', 'pedrog@example.com', '1234', '351-4234567'),
('Ana', 'Rodríguez', 'anar@example.com', '1234', '261-4123123'),
('Tomás', 'Silva', 'tomas@example.com', '1234', '387-4556677'),
('María', 'Pérez', 'mariap@example.com', '1234', '11-45566789'),
('Sofía', 'Lopez', 'sofia@example.com', '1234', '299-4112233'),
('Ignacio', 'Ruiz', 'ignacio@example.com', '1234', '11-49998877'),
('Verónica', 'Blanco', 'vero@example.com', '1234', '223-4556677'),
('Camila', 'Costa', 'camila@example.com', '1234', '223-4222211');
GO

-- ===========================
-- ROLES USUARIO
-- ===========================
-- Primeros 5 anfitriones
INSERT INTO RolesUsuario (idUsuario, idTipoUsuario)
SELECT idUsuario, 1 FROM Usuarios WHERE idUsuario <= 5;
-- Todos los usuarios son también huéspedes
INSERT INTO RolesUsuario (idUsuario, idTipoUsuario)
SELECT idUsuario, 2 FROM Usuarios;
GO

-- ===========================
-- PROPIEDADES
-- ===========================
INSERT INTO Propiedades (idAnfitrion, idCiudad, Titulo, Descripcion, PrecioNoche, Capacidad, TipoPropiedad, Direccion, CalificacionPromedio)
VALUES
(1, 2, 'Cabaña con vista al lago', 'Cabaña cálida con vista al Nahuel Huapi.', 85.00, 4, 'Cabaña', 'Av. Bustillo 2345', 4.8),
(2, 4, 'Departamento en Nueva Córdoba', 'Ideal para estudiantes o parejas.', 75.00, 2, 'Departamento', 'Bv. Illia 950', 4.5),
(3, 1, 'Loft moderno en Palermo', 'Decoración minimalista y gran ubicación.', 110.00, 3, 'Loft', 'Thames 1777', 4.7),
(4, 5, 'Casa colonial salteña', 'Cerca del teleférico, muy espaciosa.', 95.00, 5, 'Casa', 'Balcarce 654', 4.6),
(5, 10, 'Casa frente al glaciar', 'Vista espectacular al Lago Argentino.', 200.00, 6, 'Casa', 'Av. del Libertador 2100', NULL),
(1, 8, 'Departamento frente al mar', 'Vista al mar y cochera.', 150.00, 4, 'Departamento', 'Av. Peralta Ramos 3300', 4.9),
(2, 9, 'Cabaña en bosque andino', 'Ideal para escapadas románticas.', 95.00, 2, 'Cabaña', 'Ruta 40 km 50', 5.0),
(3, 11, 'Casa en la playa', 'Ubicada en la arena en Florianópolis.', 220.00, 5, 'Casa', 'Rua das Gaivotas 310', 4.7);
GO

-- ===========================
-- COMPAÑÍAS DE PAGO
-- ===========================
INSERT INTO CompañiasPago (Nombre) VALUES
('Visa'), ('MasterCard'), ('Mercado Pago'), ('PayPal'), ('American Express');
GO

-- ===========================
-- MEDIOS DE PAGO
-- ===========================
INSERT INTO MediosPago (idCompañia, Descripcion) VALUES
(1, 'Tarjeta de crédito Visa'),
(2, 'Tarjeta de crédito MasterCard'),
(3, 'Transferencia Mercado Pago'),
(4, 'Cuenta PayPal'),
(5, 'Tarjeta American Express'),
(NULL, 'Efectivo');
GO

-- ===========================
-- RESERVAS
-- ===========================
INSERT INTO Reservas (idPropiedad, idHuesped, FechaInicio, FechaFin, Monto, EstadoReserva, FechaCreacion)
VALUES
(1, 6, '2025-11-15', '2025-11-20', 425.00, 'Finalizada', GETDATE()),
(2, 7, '2025-12-01', '2025-12-05', 300.00, 'Confirmada', GETDATE()),
(3, 8, '2025-12-10', '2025-12-15', 550.00, 'Pendiente', GETDATE()),
(4, 9, '2025-11-28', '2025-12-02', 380.00, 'Finalizada', GETDATE()),
(5, 10, '2025-12-20', '2025-12-25', 1000.00, 'Confirmada', GETDATE()),
(6, 7, '2025-12-28', '2026-01-03', 900.00, 'Pendiente', GETDATE()),
(7, 8, '2025-11-05', '2025-11-10', 475.00, 'Finalizada', GETDATE()),
(8, 9, '2025-12-12', '2025-12-18', 1320.00, 'Cancelada', GETDATE());
GO

-- ===========================
-- PAGOS
-- ===========================
INSERT INTO Pagos (idReserva, idMedioPago, Monto, EstadoPago, NFactura)
VALUES
(1, 1, 425.00, 'Aprobado', 'FAC-0001'),
(2, 2, 300.00, 'Aprobado', 'FAC-0002'),
(4, 3, 380.00, 'Aprobado', 'FAC-0003'),
(5, 4, 1000.00, 'Pendiente', 'FAC-0004'),
(7, 1, 475.00, 'Aprobado', 'FAC-0005');
GO

-- ===========================
-- CALIFICACIONES
-- ===========================
INSERT INTO Calificaciones (idReserva, Puntuacion, Comentario)
VALUES
(1, 5, 'Hermosa vista y excelente atención.'),
(4, 4, 'Todo muy limpio, aunque algo de ruido.'),
(7, 5, 'Cabaña perfecta, rodeada de naturaleza.');
GO

-- ===========================
-- FOTOS DE PROPIEDADES
-- ===========================
INSERT INTO FotosPropiedades (idPropiedad, Descripcion, URL)
VALUES
(1, 'Vista al lago', 'https://a0.muscache.com/im/pictures/miso/Hosting-1318152355929165462/original/1c084b8c-7ebc-45b8-bef5-79e5806691f8.jpeg?im_w=1440'),
(2, 'Balcón de Nueva Córdoba', 'https://a0.muscache.com/im/pictures/dffe9f6f-00d1-450d-bc41-006f417645ab.jpg?im_w=1440'),
(3, 'Loft moderno', 'https://a0.muscache.com/im/pictures/miso/Hosting-52472958/original/f48315f4-b4bc-4432-bbed-2ad5ec60fcf0.jpeg?im_w=1440'),
(4, 'Casa colonial', 'https://a0.muscache.com/im/pictures/hosting/Hosting-1092572812810804004/original/cd4a3bc9-2b32-49ef-9f78-c50bb29b5de4.jpeg?im_w=1440'),
(6, 'Vista al mar', 'https://a0.muscache.com/im/pictures/prohost-api/Hosting-1480383357425078524/original/43b82ac5-9414-48b0-8299-486e5498e39d.jpeg?im_w=1200'),
(7, 'Bosque andino', 'https://a0.muscache.com/im/pictures/hosting/Hosting-1142214113866089160/original/c6161c84-b2c4-42ce-8f40-db6da4d2ca71.jpeg?im_w=1440'),
(7, 'Bosque andino', 'https://a0.muscache.com/im/pictures/dffe9f6f-00d1-450d-bc41-006f417645ab.jpg?im_w=1440'),
(7, 'Bosque andino', 'https://a0.muscache.com/im/pictures/c35c8310-cac0-4520-aa0c-3604e65527ec.jpg?im_w=1440'),
(7, 'Bosque andino', 'https://a0.muscache.com/im/pictures/2b6e4a7b-f847-4745-a687-56260882ce38.jpg?im_w=1440'),
(8, 'Casa en la playa', 'https://a0.muscache.com/im/pictures/hosting/Hosting-U3RheVN1cHBseUxpc3Rpbmc6MTE5NDYxNTI2NTM4MjU4MTMwOQ%3D%3D/original/468e3fad-ebc5-4a16-b236-b71100703c69.jpeg?im_w=1440');
GO

