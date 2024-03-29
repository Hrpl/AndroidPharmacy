USE [master]
GO
/****** Object:  Database [Pharmacy]    Script Date: 20.03.2024 0:18:42 ******/
CREATE DATABASE [Pharmacy]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Pharmacy', FILENAME = N'C:\Users\Денис\Pharmacy.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Pharmacy_log', FILENAME = N'C:\Users\Денис\Pharmacy_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Pharmacy] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Pharmacy].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Pharmacy] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Pharmacy] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Pharmacy] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Pharmacy] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Pharmacy] SET ARITHABORT OFF 
GO
ALTER DATABASE [Pharmacy] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Pharmacy] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Pharmacy] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Pharmacy] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Pharmacy] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Pharmacy] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Pharmacy] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Pharmacy] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Pharmacy] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Pharmacy] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Pharmacy] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Pharmacy] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Pharmacy] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Pharmacy] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Pharmacy] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Pharmacy] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Pharmacy] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Pharmacy] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Pharmacy] SET  MULTI_USER 
GO
ALTER DATABASE [Pharmacy] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Pharmacy] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Pharmacy] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Pharmacy] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Pharmacy] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Pharmacy] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Pharmacy] SET QUERY_STORE = OFF
GO
USE [Pharmacy]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 20.03.2024 0:18:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoices]    Script Date: 20.03.2024 0:18:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoices](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DocumentDate] [datetime2](7) NOT NULL,
	[Provider] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Invoices] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Issues]    Script Date: 20.03.2024 0:18:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Issues](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[Purpose] [nvarchar](max) NULL,
	[Status] [nvarchar](max) NULL,
 CONSTRAINT [PK_Issues] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IssuesItems]    Script Date: 20.03.2024 0:18:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IssuesItems](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IssueId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[MedicineId] [int] NOT NULL,
 CONSTRAINT [PK_IssuesItems] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Medicines]    Script Date: 20.03.2024 0:18:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medicines](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Manufacturer] [nvarchar](max) NOT NULL,
	[Image] [nvarchar](max) NOT NULL,
	[Price] [int] NOT NULL,
	[StockQuantity] [int] NOT NULL,
	[OptimalQuantity] [int] NOT NULL,
	[WarehouseId] [int] NOT NULL,
	[ExpirationDate] [datetime2](7) NOT NULL,
	[InvoiceId] [int] NULL,
 CONSTRAINT [PK_Medicines] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Warehouses]    Script Date: 20.03.2024 0:18:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Warehouses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240319073411_1.0', N'8.0.3')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240319113340_1.1', N'8.0.3')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240319113711_1.2', N'8.0.3')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240319171606_2.0', N'8.0.3')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240319171745_2.1', N'8.0.3')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240319180232_2.2', N'8.0.3')
GO
SET IDENTITY_INSERT [dbo].[Invoices] ON 

INSERT [dbo].[Invoices] ([Id], [DocumentDate], [Provider]) VALUES (1, CAST(N'2023-09-11T00:00:00.0000000' AS DateTime2), N'У сороки боли')
SET IDENTITY_INSERT [dbo].[Invoices] OFF
GO
SET IDENTITY_INSERT [dbo].[Issues] ON 

INSERT [dbo].[Issues] ([Id], [CreatedTime], [Purpose], [Status]) VALUES (1, CAST(N'2023-09-21T13:16:42.0000000' AS DateTime2), N'Хирургическое отделение', N'Add')
INSERT [dbo].[Issues] ([Id], [CreatedTime], [Purpose], [Status]) VALUES (2, CAST(N'2023-09-21T13:16:43.0000000' AS DateTime2), N'Педиaтрическое отделение', N'Add')
INSERT [dbo].[Issues] ([Id], [CreatedTime], [Purpose], [Status]) VALUES (5, CAST(N'2023-09-21T13:16:43.0000000' AS DateTime2), N'Терaпевтическое отделение', N'Complete')
INSERT [dbo].[Issues] ([Id], [CreatedTime], [Purpose], [Status]) VALUES (6, CAST(N'2023-09-21T13:16:43.0000000' AS DateTime2), N'Травмпункт', N'Add')
SET IDENTITY_INSERT [dbo].[Issues] OFF
GO
SET IDENTITY_INSERT [dbo].[IssuesItems] ON 

INSERT [dbo].[IssuesItems] ([Id], [IssueId], [Quantity], [MedicineId]) VALUES (1, 1, 3, 1)
INSERT [dbo].[IssuesItems] ([Id], [IssueId], [Quantity], [MedicineId]) VALUES (2, 1, 5, 1)
INSERT [dbo].[IssuesItems] ([Id], [IssueId], [Quantity], [MedicineId]) VALUES (3, 1, 10, 2)
INSERT [dbo].[IssuesItems] ([Id], [IssueId], [Quantity], [MedicineId]) VALUES (4, 2, 1, 3)
INSERT [dbo].[IssuesItems] ([Id], [IssueId], [Quantity], [MedicineId]) VALUES (5, 2, 3, 4)
INSERT [dbo].[IssuesItems] ([Id], [IssueId], [Quantity], [MedicineId]) VALUES (6, 2, 11, 2)
SET IDENTITY_INSERT [dbo].[IssuesItems] OFF
GO
SET IDENTITY_INSERT [dbo].[Medicines] ON 

INSERT [dbo].[Medicines] ([Id], [Name], [Manufacturer], [Image], [Price], [StockQuantity], [OptimalQuantity], [WarehouseId], [ExpirationDate], [InvoiceId]) VALUES (1, N'Эвкалипт лист 75г', N'Красногорсклексредства', N'https://imgs.asna.ru/iblock/df7/df719d36294b0f0ef9cb60d4e3a85a55/EVKALIPT_75g_3D.jpg', 99, 14, 20, 1, CAST(N'2025-01-01T00:00:00.0000000' AS DateTime2), 1)
INSERT [dbo].[Medicines] ([Id], [Name], [Manufacturer], [Image], [Price], [StockQuantity], [OptimalQuantity], [WarehouseId], [ExpirationDate], [InvoiceId]) VALUES (2, N'Вольтарен 25мг/мл 3мл 5 шт. раствор для внутримышечного введения', N'Вольтарен', N'https://imgs.asna.ru/iblock/2d7/2d71cac199086932e4b68e6ae633eca8/100082.jpg', 79, 39, 20, 3, CAST(N'2026-01-01T00:00:00.0000000' AS DateTime2), 1)
INSERT [dbo].[Medicines] ([Id], [Name], [Manufacturer], [Image], [Price], [StockQuantity], [OptimalQuantity], [WarehouseId], [ExpirationDate], [InvoiceId]) VALUES (3, N'Кальцекс 500мг 10 шт. таблетки татхимфарм', N'Татхимфармпрепараты АО', N'https://imgs.asna.ru/iblock/177/177882ef988b42be05abd45dbb7d5fba/816f88b93afa5c096afbeec679ffd4c0.jpg', 42, 69, 30, 2, CAST(N'2024-06-01T00:00:00.0000000' AS DateTime2), 1)
INSERT [dbo].[Medicines] ([Id], [Name], [Manufacturer], [Image], [Price], [StockQuantity], [OptimalQuantity], [WarehouseId], [ExpirationDate], [InvoiceId]) VALUES (4, N'Мукалтин 50мг 10 шт. таблетки россия', N'Мукалтин', N'https://imgs.asna.ru/iblock/92e/92e31f17b43b697afd37fd8c96395172/babd684d2b732c4503dae861a790670b.jpg', 29, 1, 10, 3, CAST(N'2023-01-01T00:00:00.0000000' AS DateTime2), 1)
INSERT [dbo].[Medicines] ([Id], [Name], [Manufacturer], [Image], [Price], [StockQuantity], [OptimalQuantity], [WarehouseId], [ExpirationDate], [InvoiceId]) VALUES (6, N'Кальцекс 500мг 10 шт. таблетки татхимфарм', N'Татхимфармпрепараты АО', N'https://imgs.asna.ru/iblock/177/177882ef988b42be05abd45dbb7d5fba/816f88b93afa5c096afbeec679ffd4c0.jpg', 30, 22, 10, 1, CAST(N'2024-01-01T00:00:00.0000000' AS DateTime2), 1)
SET IDENTITY_INSERT [dbo].[Medicines] OFF
GO
SET IDENTITY_INSERT [dbo].[Warehouses] ON 

INSERT [dbo].[Warehouses] ([Id], [Name]) VALUES (1, N'Склад №1')
INSERT [dbo].[Warehouses] ([Id], [Name]) VALUES (2, N'Склад №2')
INSERT [dbo].[Warehouses] ([Id], [Name]) VALUES (3, N'Склад №3')
SET IDENTITY_INSERT [dbo].[Warehouses] OFF
GO
/****** Object:  Index [IX_IssuesItems_IssueId]    Script Date: 20.03.2024 0:18:43 ******/
CREATE NONCLUSTERED INDEX [IX_IssuesItems_IssueId] ON [dbo].[IssuesItems]
(
	[IssueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_IssuesItems_MedicineId]    Script Date: 20.03.2024 0:18:43 ******/
CREATE NONCLUSTERED INDEX [IX_IssuesItems_MedicineId] ON [dbo].[IssuesItems]
(
	[MedicineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Medicines_InvoiceId]    Script Date: 20.03.2024 0:18:43 ******/
CREATE NONCLUSTERED INDEX [IX_Medicines_InvoiceId] ON [dbo].[Medicines]
(
	[InvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Medicines_WarehouseId]    Script Date: 20.03.2024 0:18:43 ******/
CREATE NONCLUSTERED INDEX [IX_Medicines_WarehouseId] ON [dbo].[Medicines]
(
	[WarehouseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Medicines] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [ExpirationDate]
GO
ALTER TABLE [dbo].[IssuesItems]  WITH CHECK ADD  CONSTRAINT [FK_IssuesItems_Issues_IssueId] FOREIGN KEY([IssueId])
REFERENCES [dbo].[Issues] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IssuesItems] CHECK CONSTRAINT [FK_IssuesItems_Issues_IssueId]
GO
ALTER TABLE [dbo].[IssuesItems]  WITH CHECK ADD  CONSTRAINT [FK_IssuesItems_Medicines_MedicineId] FOREIGN KEY([MedicineId])
REFERENCES [dbo].[Medicines] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IssuesItems] CHECK CONSTRAINT [FK_IssuesItems_Medicines_MedicineId]
GO
ALTER TABLE [dbo].[Medicines]  WITH CHECK ADD  CONSTRAINT [FK_Medicines_Invoices_InvoiceId] FOREIGN KEY([InvoiceId])
REFERENCES [dbo].[Invoices] ([Id])
GO
ALTER TABLE [dbo].[Medicines] CHECK CONSTRAINT [FK_Medicines_Invoices_InvoiceId]
GO
ALTER TABLE [dbo].[Medicines]  WITH CHECK ADD  CONSTRAINT [FK_Medicines_Warehouses_WarehouseId] FOREIGN KEY([WarehouseId])
REFERENCES [dbo].[Warehouses] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Medicines] CHECK CONSTRAINT [FK_Medicines_Warehouses_WarehouseId]
GO
USE [master]
GO
ALTER DATABASE [Pharmacy] SET  READ_WRITE 
GO
