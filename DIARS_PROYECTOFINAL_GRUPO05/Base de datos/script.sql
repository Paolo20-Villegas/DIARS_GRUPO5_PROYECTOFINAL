USE [master]
GO
/****** Object:  Database [dbDiars]    Script Date: 19/04/2023 9:59:33 ******/
CREATE DATABASE [dbDiars]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbDiars', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\dbDiars.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dbDiars_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\dbDiars_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [dbDiars] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbDiars].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbDiars] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbDiars] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbDiars] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbDiars] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbDiars] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbDiars] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dbDiars] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbDiars] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbDiars] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbDiars] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbDiars] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbDiars] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbDiars] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbDiars] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbDiars] SET  ENABLE_BROKER 
GO
ALTER DATABASE [dbDiars] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbDiars] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbDiars] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbDiars] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbDiars] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbDiars] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbDiars] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbDiars] SET RECOVERY FULL 
GO
ALTER DATABASE [dbDiars] SET  MULTI_USER 
GO
ALTER DATABASE [dbDiars] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbDiars] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbDiars] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbDiars] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dbDiars] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [dbDiars] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'dbDiars', N'ON'
GO
ALTER DATABASE [dbDiars] SET QUERY_STORE = OFF
GO
USE [dbDiars]
GO
/****** Object:  Table [dbo].[cliente]    Script Date: 19/04/2023 9:59:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cliente](
	[clienteId] [smallint] IDENTITY(1,1) NOT NULL,
	[dni] [char](8) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[correo] [varchar](50) NOT NULL,
	[telefono] [char](9) NOT NULL,
	[edad] [smallint] NOT NULL,
	[estado] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[clienteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [unq_dni] UNIQUE NONCLUSTERED 
(
	[dni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cliente]  WITH CHECK ADD  CONSTRAINT [chk_correo] CHECK  (([correo] like '%_@__%.__%'))
GO
ALTER TABLE [dbo].[cliente] CHECK CONSTRAINT [chk_correo]
GO
ALTER TABLE [dbo].[cliente]  WITH CHECK ADD  CONSTRAINT [chk_dni] CHECK  (([dni] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[cliente] CHECK CONSTRAINT [chk_dni]
GO
ALTER TABLE [dbo].[cliente]  WITH CHECK ADD  CONSTRAINT [chk_telefono] CHECK  (([telefono] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[cliente] CHECK CONSTRAINT [chk_telefono]
GO
/****** Object:  StoredProcedure [dbo].[spDeshabilitaCliente]    Script Date: 19/04/2023 9:59:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* uwu*/

CREATE PROCEDURE [dbo].[spDeshabilitaCliente]
(
	@clienteId smallint
)
AS
BEGIN
	update cliente set 
		estado = 0 
	where clienteId = @clienteId;
END
GO
/****** Object:  StoredProcedure [dbo].[spEditaCliente]    Script Date: 19/04/2023 9:59:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* uwu*/

CREATE PROCEDURE [dbo].[spEditaCliente]
(
	@clienteId smallint,
	@dni char(8),
	@nombre varchar(50),
	@correo varchar(50),
	@telefono char(9),
	@edad smallint
)
AS
BEGIN
	update  cliente set 
	dni = @dni,
	nombre = @nombre,
	correo = @correo,
	telefono = @telefono,
	edad = @edad
	where clienteId = @clienteId;
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertaCliente]    Script Date: 19/04/2023 9:59:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* uwu*/

CREATE PROCEDURE [dbo].[spInsertaCliente]
(
	@dni char(8),
	@nombre varchar(50),
	@correo varchar(50),
	@telefono char(9),
	@edad smallint
)
AS
BEGIN 
	insert into cliente(dni, nombre, correo, telefono, edad, estado)
	values(@dni, @nombre, @correo, @telefono, @edad, 1);
END
GO
/****** Object:  StoredProcedure [dbo].[spListaCliente]    Script Date: 19/04/2023 9:59:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* Procesos cliente*/
CREATE PROCEDURE [dbo].[spListaCliente]
AS
	SELECT c.clienteId as id,
	c.dni as dni,
	c.nombre as nombre,
	c.correo as correo,
	c.telefono as telefono,
	c.edad as edad
	FROM cliente as c where c.estado = 1;
GO
USE [master]
GO
ALTER DATABASE [dbDiars] SET  READ_WRITE 
GO
