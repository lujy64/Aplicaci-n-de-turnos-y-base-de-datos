USE [master]
GO
/****** Object:  Database [python]    Script Date: 17/8/2024 22:18:04 ******/
CREATE DATABASE [python]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Pyton', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Pyton.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Pyton_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Pyton_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [python] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [python].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [python] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [python] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [python] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [python] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [python] SET ARITHABORT OFF 
GO
ALTER DATABASE [python] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [python] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [python] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [python] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [python] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [python] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [python] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [python] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [python] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [python] SET  ENABLE_BROKER 
GO
ALTER DATABASE [python] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [python] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [python] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [python] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [python] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [python] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [python] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [python] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [python] SET  MULTI_USER 
GO
ALTER DATABASE [python] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [python] SET DB_CHAINING OFF 
GO
ALTER DATABASE [python] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [python] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [python] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [python] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [python] SET QUERY_STORE = ON
GO
ALTER DATABASE [python] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [python]
GO
/****** Object:  Table [dbo].[clientes]    Script Date: 17/8/2024 22:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clientes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](max) NULL,
	[email] [varchar](max) NULL,
	[telefono] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[turnos]    Script Date: 17/8/2024 22:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[turnos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [date] NULL,
	[tipo] [varchar](max) NULL,
	[cliente_id] [int] NULL,
	[vehículo_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vehiculos]    Script Date: 17/8/2024 22:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vehiculos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[marca] [varchar](max) NULL,
	[modelo] [varchar](max) NULL,
	[año] [int] NULL,
	[precio] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[clientes] ON 

INSERT [dbo].[clientes] ([id], [nombre], [email], [telefono]) VALUES (1, N'Juan Pérez', N'juan@example.com', N'123456789')
SET IDENTITY_INSERT [dbo].[clientes] OFF
GO
SET IDENTITY_INSERT [dbo].[turnos] ON 

INSERT [dbo].[turnos] ([id], [fecha], [tipo], [cliente_id], [vehículo_id]) VALUES (1, CAST(N'2024-08-17' AS Date), N'compra', 1, 1)
SET IDENTITY_INSERT [dbo].[turnos] OFF
GO
SET IDENTITY_INSERT [dbo].[vehiculos] ON 

INSERT [dbo].[vehiculos] ([id], [marca], [modelo], [año], [precio]) VALUES (1, N'Toyota', N'Corolla', 2020, 20000)
SET IDENTITY_INSERT [dbo].[vehiculos] OFF
GO
ALTER TABLE [dbo].[turnos]  WITH CHECK ADD FOREIGN KEY([cliente_id])
REFERENCES [dbo].[clientes] ([id])
GO
ALTER TABLE [dbo].[turnos]  WITH CHECK ADD FOREIGN KEY([vehículo_id])
REFERENCES [dbo].[vehiculos] ([id])
GO
USE [master]
GO
ALTER DATABASE [python] SET  READ_WRITE 
GO
