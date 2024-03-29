USE [master]
GO
/****** Object:  Database [Forecast]    Script Date: 9/03/2024 12:34:08 a. m. ******/
CREATE DATABASE [Forecast]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Forecast', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Forecast.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Forecast_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Forecast_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Forecast] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Forecast].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Forecast] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Forecast] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Forecast] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Forecast] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Forecast] SET ARITHABORT OFF 
GO
ALTER DATABASE [Forecast] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Forecast] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Forecast] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Forecast] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Forecast] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Forecast] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Forecast] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Forecast] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Forecast] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Forecast] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Forecast] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Forecast] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Forecast] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Forecast] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Forecast] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Forecast] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Forecast] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Forecast] SET RECOVERY FULL 
GO
ALTER DATABASE [Forecast] SET  MULTI_USER 
GO
ALTER DATABASE [Forecast] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Forecast] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Forecast] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Forecast] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Forecast] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Forecast] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Forecast', N'ON'
GO
ALTER DATABASE [Forecast] SET QUERY_STORE = ON
GO
ALTER DATABASE [Forecast] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Forecast]
GO
/****** Object:  Table [dbo].[actual]    Script Date: 9/03/2024 12:34:08 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[actual](
	[id_actual] [int] IDENTITY(1,1) NOT NULL,
	[actual_value] [float] NULL,
	[fk_id_period] [int] NULL,
 CONSTRAINT [PK_actual] PRIMARY KEY CLUSTERED 
(
	[id_actual] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[forecast]    Script Date: 9/03/2024 12:34:08 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[forecast](
	[id_forecast] [int] IDENTITY(1,1) NOT NULL,
	[forecast_value] [float] NULL,
	[fk_periodo_id] [int] NULL,
	[open_period] [bit] NULL,
 CONSTRAINT [PK_forecast] PRIMARY KEY CLUSTERED 
(
	[id_forecast] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[forecast_actual]    Script Date: 9/03/2024 12:34:08 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[forecast_actual](
	[id_forecast_actual] [int] IDENTITY(1,1) NOT NULL,
	[fk_id_forecast] [int] NULL,
	[fk_id_actual] [int] NULL,
	[fk_id_forecast_snapshoot] [int] NULL,
 CONSTRAINT [PK_forecast_actual] PRIMARY KEY CLUSTERED 
(
	[id_forecast_actual] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[forecast_snapshoot]    Script Date: 9/03/2024 12:34:08 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[forecast_snapshoot](
	[id_forecast_snapshoot] [int] NOT NULL,
	[forecast_snapshoot] [varchar](50) NULL,
 CONSTRAINT [PK_forecast_snapshoot] PRIMARY KEY CLUSTERED 
(
	[id_forecast_snapshoot] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[period]    Script Date: 9/03/2024 12:34:08 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[period](
	[id_period] [int] NOT NULL,
	[period] [nvarchar](50) NULL,
	[period_month] [nvarchar](2) NULL,
	[period_year] [nvarchar](4) NULL,
	[period_quarter] [nvarchar](6) NULL,
 CONSTRAINT [PK_period] PRIMARY KEY CLUSTERED 
(
	[id_period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_actual]    Script Date: 9/03/2024 12:34:08 a. m. ******/
CREATE NONCLUSTERED INDEX [IX_actual] ON [dbo].[actual]
(
	[id_actual] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[actual]  WITH CHECK ADD  CONSTRAINT [FK_actual_period] FOREIGN KEY([fk_id_period])
REFERENCES [dbo].[period] ([id_period])
GO
ALTER TABLE [dbo].[actual] CHECK CONSTRAINT [FK_actual_period]
GO
ALTER TABLE [dbo].[forecast]  WITH CHECK ADD  CONSTRAINT [FK_forecast_period] FOREIGN KEY([fk_periodo_id])
REFERENCES [dbo].[period] ([id_period])
GO
ALTER TABLE [dbo].[forecast] CHECK CONSTRAINT [FK_forecast_period]
GO
ALTER TABLE [dbo].[forecast_actual]  WITH CHECK ADD  CONSTRAINT [FK_forecast_actual_actual] FOREIGN KEY([fk_id_actual])
REFERENCES [dbo].[actual] ([id_actual])
GO
ALTER TABLE [dbo].[forecast_actual] CHECK CONSTRAINT [FK_forecast_actual_actual]
GO
ALTER TABLE [dbo].[forecast_actual]  WITH CHECK ADD  CONSTRAINT [FK_forecast_actual_forecast] FOREIGN KEY([fk_id_forecast])
REFERENCES [dbo].[forecast] ([id_forecast])
GO
ALTER TABLE [dbo].[forecast_actual] CHECK CONSTRAINT [FK_forecast_actual_forecast]
GO
ALTER TABLE [dbo].[forecast_actual]  WITH CHECK ADD  CONSTRAINT [FK_forecast_actual_forecast_snapshoot] FOREIGN KEY([fk_id_forecast_snapshoot])
REFERENCES [dbo].[forecast_snapshoot] ([id_forecast_snapshoot])
GO
ALTER TABLE [dbo].[forecast_actual] CHECK CONSTRAINT [FK_forecast_actual_forecast_snapshoot]
GO
USE [master]
GO
ALTER DATABASE [Forecast] SET  READ_WRITE 
GO
