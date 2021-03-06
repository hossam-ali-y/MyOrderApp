USE [master]
GO
/****** Object:  Database [MyOrderDB]    Script Date: 12/17/2021 9:02:23 PM ******/
CREATE DATABASE [MyOrderDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StoreDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER1\MSSQL\DATA\StoreDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'StoreDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER1\MSSQL\DATA\StoreDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [MyOrderDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MyOrderDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MyOrderDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MyOrderDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MyOrderDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MyOrderDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MyOrderDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [MyOrderDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MyOrderDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MyOrderDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MyOrderDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MyOrderDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MyOrderDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MyOrderDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MyOrderDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MyOrderDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MyOrderDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MyOrderDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MyOrderDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MyOrderDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MyOrderDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MyOrderDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MyOrderDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MyOrderDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MyOrderDB] SET RECOVERY FULL 
GO
ALTER DATABASE [MyOrderDB] SET  MULTI_USER 
GO
ALTER DATABASE [MyOrderDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MyOrderDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MyOrderDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MyOrderDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MyOrderDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'MyOrderDB', N'ON'
GO
ALTER DATABASE [MyOrderDB] SET QUERY_STORE = OFF
GO
USE [MyOrderDB]
GO
/****** Object:  Table [dbo].[CartItems]    Script Date: 12/17/2021 9:02:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartItems](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[OrderId] [int] NOT NULL,
	[Quantity] [int] NULL,
	[UnitPrice] [money] NULL,
 CONSTRAINT [PK_CartItems] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 12/17/2021 9:02:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Companies]    Script Date: 12/17/2021 9:02:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Companies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](max) NULL,
	[Owner] [nvarchar](100) NULL,
	[Manager] [nvarchar](100) NULL,
	[OwnerPhone] [nvarchar](50) NULL,
	[ManagerPhone] [nvarchar](50) NULL,
	[Logo] [nvarchar](250) NULL,
	[OpeningDate] [datetime] NULL,
	[ClosingDate] [datetime] NULL,
 CONSTRAINT [PK_Companies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 12/17/2021 9:02:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](100) NOT NULL,
	[CustomerLastName] [nvarchar](100) NULL,
	[CustomerEmail] [nvarchar](50) NULL,
	[CustomerPhone] [nvarchar](50) NULL,
	[CustomerCompanyName] [nvarchar](100) NULL,
	[CustomerAddress] [nvarchar](100) NULL,
	[Country] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[ZipCode] [nvarchar](50) NULL,
	[Status] [int] NOT NULL,
	[Note] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[DeliveredDate] [datetime] NULL,
	[TotalPrice] [money] NOT NULL,
 CONSTRAINT [PK_Tickets] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pictures]    Script Date: 12/17/2021 9:02:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pictures](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[Big] [nvarchar](max) NULL,
	[Small] [nvarchar](max) NULL,
	[Note] [nvarchar](max) NULL,
 CONSTRAINT [PK_Pictures] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 12/17/2021 9:02:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Price] [money] NOT NULL,
	[SalePrice] [money] NULL,
	[Discount] [money] NULL,
	[ShortDetails] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[Stock] [int] NULL,
	[Brand] [nvarchar](250) NULL,
	[Sale] [bit] NULL,
	[Tags] [nvarchar](max) NULL,
	[Colors] [nvarchar](max) NULL,
	[CategoryId] [int] NULL,
	[CompanyId] [int] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CartItems] ON 

INSERT [dbo].[CartItems] ([Id], [ProductId], [OrderId], [Quantity], [UnitPrice]) VALUES (37, 2, 10, 1, 10.0000)
INSERT [dbo].[CartItems] ([Id], [ProductId], [OrderId], [Quantity], [UnitPrice]) VALUES (38, 3, 10, 1, 200.0000)
INSERT [dbo].[CartItems] ([Id], [ProductId], [OrderId], [Quantity], [UnitPrice]) VALUES (39, 1, 10, 1, 1750.0000)
INSERT [dbo].[CartItems] ([Id], [ProductId], [OrderId], [Quantity], [UnitPrice]) VALUES (50, 2, 19, 1, 10.0000)
SET IDENTITY_INSERT [dbo].[CartItems] OFF
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [CategoryName], [Description]) VALUES (1, N'لابتوبات', NULL)
INSERT [dbo].[Categories] ([Id], [CategoryName], [Description]) VALUES (2, N'هواتف ذكية', NULL)
INSERT [dbo].[Categories] ([Id], [CategoryName], [Description]) VALUES (3, N'شاشات ذكية', NULL)
INSERT [dbo].[Categories] ([Id], [CategoryName], [Description]) VALUES (4, N'ساعات ذكية', NULL)
INSERT [dbo].[Categories] ([Id], [CategoryName], [Description]) VALUES (5, N'سماعات', NULL)
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[Companies] ON 

INSERT [dbo].[Companies] ([Id], [CompanyName], [Address], [Owner], [Manager], [OwnerPhone], [ManagerPhone], [Logo], [OpeningDate], [ClosingDate]) VALUES (1, N'سوني', N'صنعاء-الستين الغربي', N'حسام اليعري', N'حساام اليعري', N'01534435', N'772982855', NULL, NULL, NULL)
INSERT [dbo].[Companies] ([Id], [CompanyName], [Address], [Owner], [Manager], [OwnerPhone], [ManagerPhone], [Logo], [OpeningDate], [ClosingDate]) VALUES (2, N'لينوفو', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Companies] ([Id], [CompanyName], [Address], [Owner], [Manager], [OwnerPhone], [ManagerPhone], [Logo], [OpeningDate], [ClosingDate]) VALUES (3, N'Dell', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Companies] ([Id], [CompanyName], [Address], [Owner], [Manager], [OwnerPhone], [ManagerPhone], [Logo], [OpeningDate], [ClosingDate]) VALUES (4, N'Google', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Companies] ([Id], [CompanyName], [Address], [Owner], [Manager], [OwnerPhone], [ManagerPhone], [Logo], [OpeningDate], [ClosingDate]) VALUES (5, N'أبل', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Companies] ([Id], [CompanyName], [Address], [Owner], [Manager], [OwnerPhone], [ManagerPhone], [Logo], [OpeningDate], [ClosingDate]) VALUES (6, N'سامسونج', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Companies] ([Id], [CompanyName], [Address], [Owner], [Manager], [OwnerPhone], [ManagerPhone], [Logo], [OpeningDate], [ClosingDate]) VALUES (7, N'LG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Companies] ([Id], [CompanyName], [Address], [Owner], [Manager], [OwnerPhone], [ManagerPhone], [Logo], [OpeningDate], [ClosingDate]) VALUES (8, N'هواوي', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Companies] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [CustomerName], [CustomerLastName], [CustomerEmail], [CustomerPhone], [CustomerCompanyName], [CustomerAddress], [Country], [City], [ZipCode], [Status], [Note], [CreatedDate], [ShippedDate], [DeliveredDate], [TotalPrice]) VALUES (10, N'حسام علي', N'اليعري', N'hosamali.9.bh@gmail.com', N'+967772982855', N'hvhvhvh', N'hgfugfuf', N'اليمن - صنعاء', N'صنعاء', NULL, 2, NULL, CAST(N'2021-12-17T16:14:38.287' AS DateTime), NULL, NULL, 1960.0000)
INSERT [dbo].[Orders] ([Id], [CustomerName], [CustomerLastName], [CustomerEmail], [CustomerPhone], [CustomerCompanyName], [CustomerAddress], [Country], [City], [ZipCode], [Status], [Note], [CreatedDate], [ShippedDate], [DeliveredDate], [TotalPrice]) VALUES (19, N'حسام', N'اليعري', N'hosamali.9.bh@gmail.com', N'+967772982855', NULL, N'صنعاء - الستين الغربي', N'اليمن - صنعاء', N'صنعاء', NULL, 1, N'يرجى سرعة التوصيل', CAST(N'2021-12-17T19:55:49.927' AS DateTime), NULL, NULL, 10.0000)
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[Pictures] ON 

INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (1, 1, N'assets/images/product/laptop.png', N'assets/images/product/laptop66.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (2, 2, N'assets/images/product/headphone1.png', N'assets/images/product/headphone11.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (3, 3, N'assets/images/product/phone1.png', N'assets/images/product/phone11.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (5, 4, N'assets/images/product/phone2.png', N'assets/images/product/phone22.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (6, 5, N'assets/images/product/phone3.png', N'assets/images/product/phone33.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (7, 6, N'assets/images/product/phone4.png', N'assets/images/product/phone44.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (8, 8, N'assets/images/product/headphone1.png', N'assets/images/product/headphone11.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (9, 9, N'assets/images/product/headphone2.png', N'assets/images/product/headphone22.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (10, 10, N'assets/images/product/headphone3.png', N'assets/images/product/headphone33.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (11, 11, N'assets/images/product/headphone4.png', N'assets/images/product/headphone44.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (12, 12, N'assets/images/product/headphone5.png', N'assets/images/product/headphone44.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (13, 13, N'assets/images/product/headphone2.png', N'assets/images/product/headphone22.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (14, 14, N'assets/images/product/laptop1.png', N'assets/images/product/laptop11.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (15, 15, N'assets/images/product/laptop2.png', N'assets/images/product/laptop22.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (16, 16, N'assets/images/product/laptop3.png', N'assets/images/product/laptop33.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (17, 17, N'assets/images/product/laptop4.png', N'assets/images/product/laptop44.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (18, 18, N'assets/images/product/laptop5.png', N'assets/images/product/laptop55.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (19, 19, N'assets/images/product/tv1.png', N'assets/images/product/tv11.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (20, 20, N'assets/images/product/tv2.png', N'assets/images/product/tv22.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (21, 21, N'assets/images/product/tv3.png', N'assets/images/product/tv33.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (22, 22, N'assets/images/product/tv4.png', N'assets/images/product/tv44.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (23, 23, N'assets/images/product/Smartwatch1.png', N'assets/images/product/Smartwatch11.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (24, 24, N'assets/images/product/Smartwatch2.png', N'assets/images/product/Smartwatch22.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (25, 25, N'assets/images/product/Smartwatch3.png', N'assets/images/product/Smartwatch33.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (31, 24, NULL, N'assets/images/product/Smartwatch22.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (32, 24, NULL, N'assets/images/product/Smartwatch23.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (34, 1, NULL, N'assets/images/product/laptop11.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (35, 1, NULL, N'assets/images/product/laptop22.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (36, 1, NULL, N'assets/images/product/laptop33.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (37, 1, NULL, N'assets/images/product/laptop44.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (38, 1, NULL, N'assets/images/product/laptop55.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (39, 2, NULL, N'assets/images/product/headphone22.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (40, 2, NULL, N'assets/images/product/headphone33.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (41, 2, NULL, N'assets/images/product/headphone44.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (42, 3, NULL, N'assets/images/product/phone22.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (43, 3, NULL, N'assets/images/product/phone33.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (44, 4, NULL, N'assets/images/product/phone11.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (45, 4, NULL, N'assets/images/product/phone33.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (46, 5, NULL, N'assets/images/product/phone11.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (47, 5, NULL, N'assets/images/product/phone44.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (48, 5, NULL, N'assets/images/product/phone22.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (49, 14, NULL, N'assets/images/product/laptop22.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (50, 14, NULL, N'assets/images/product/laptop33.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (51, 14, NULL, N'assets/images/product/laptop44.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (52, 14, NULL, N'assets/images/product/laptop55.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (53, 15, NULL, N'assets/images/product/laptop1.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (54, 15, NULL, N'assets/images/product/laptop33.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (55, 15, NULL, N'assets/images/product/laptop44.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (56, 15, NULL, N'assets/images/product/laptop55.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (57, 16, NULL, N'assets/images/product/laptop1.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (58, 16, NULL, N'assets/images/product/laptop2.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (59, 16, NULL, N'assets/images/product/laptop55.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (60, 19, NULL, N'assets/images/product/tv22.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (61, 19, NULL, N'assets/images/product/tv33.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (62, 19, NULL, N'assets/images/product/tv44.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (63, 20, NULL, N'assets/images/product/tv11.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (64, 20, NULL, N'assets/images/product/tv33.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (65, 20, NULL, N'assets/images/product/tv44.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (67, 20, NULL, N'assets/images/product/tv55.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (68, 21, NULL, N'assets/images/product/tv11.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (69, 21, NULL, N'assets/images/product/tv22.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (70, 21, NULL, N'assets/images/product/tv44.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (71, 23, NULL, N'assets/images/product/Smartwatch22.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (72, 23, NULL, N'assets/images/product/Smartwatch33.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (73, 24, NULL, N'assets/images/product/Smartwatch44.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (74, 24, NULL, N'assets/images/product/Smartwatch21.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (75, 25, NULL, N'assets/images/product/Smartwatch11.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (76, 25, NULL, N'assets/images/product/Smartwatch22.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (77, 24, NULL, N'assets/images/product/Smartwatch55.png', NULL)
SET IDENTITY_INSERT [dbo].[Pictures] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (1, N'لابتوب هواوي ميت بك إكس برو', 1750.0000, 1800.0000, 3.0000, N'لابتوبات جديدة من شركة هواوي بمعالجات حديثة من شركة إنتل ', N'يتميز اللابتوب الجديد من هواوي، ميت بوك اكس برو 2021 بشاشة كاملة مقاس 13.9 إنش، مع إطار ضعيف من الجوانب، نسبة الشاشة إلى هيكل الجهاز تصل إلى 91%، ودقة عرض الشاشة تصل إلى 2000×3000 بكسل.

كما يدعم الجهاز إمكانية إلتقاط صورة شاشة بثلاث أصابع من خلال التمرير السريع لأسفل، ومن خلال إيماءات الشاشة التي تعمل باللمس يمكن التقاط أي منطقة في الشاشة والتعرف تلقائيًا على النص الموجودة.

الجهاز مصنوع من سبائك الألومنيوم، ويبلغ سُمكه 14.6 ملم، ووزنه 1.33 كجم فقط، وهو متوفر بأربعة ألوان، الفضي، الرامي، الأخضر الزمردي، والذهبي الوردي.

يأتي الجهاز مزودًا بشاحن بقوة 65 واط، حيث إن شحن اللابتوب لمدة نصف ساعة، ستمكن المستخدم من استخدامه 4 ساعات متواصلة، كما أن الشاحن يدعم الشحن السريع لبعض هواتف هواوي.

يستخدم الجهاز 4 مكبرات صوتية، مع 4 أوضاع صوتية للموسيقى والألعاب والأفلام والمكالمات.

سعر ميت بوك اكس برو 2021

نسخة معالج i5-1135G7 – رام 16 جيجابايت – ذاكرة تخزين 512 جيجابايت = 1388 دولار

نسخة معالج i7-1165G7 – رام 16 جيجابايت – ذاكرة تخزين 512 جيجابايت = 1543 دولار

نسخة معالج i7-1165G7 – رام 16 جيجابايت – ذاكرة تخزين 1 تيرابايت = 1851 دولار

هل جربت أجهزة لابتوب من هواوي من قبل ؟ شاركونا في التعليقات..', 10, NULL, NULL, NULL, NULL, 1, 8)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (2, N'سماعة إستريو', 10.0000, 15.0000, 30.0000, N'هواوي فري بادز 3 سيليكون سماعة بلوتوث لاسلكية حالة صندوق تخزين مع هوك - احمر', N'سماعات اذن لاسلكية بتقنية بلوتوث 5.0 تي دبليو اس وخاصية حجب الضوضاء وتصميم صغير مضاد للتعرق سماعات من كيو سي واي، موديل T1C
3.4 من 5 نجوم 12
جنيه‎315.‎00‏
احصل عليه غداً، 18 ديسمبر
تشحن من أمازون - شحن مجاني', 2, NULL, NULL, NULL, NULL, 5, 8)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (3, N'نوت10', 200.0000, 250.0000, 20.0000, N'سامسونج جلاكسي A72 أسود', N'لا تفوِّت اللقطة المثالية مرةً أخرى. تعرَّف على هاتفي Galaxy S21 5G وS21+ 5G. لقد صُمما لإحداث ثورة في عالم الفيديو والتصوير بدقة 8K - على نحو يتجاوز دقة التصوير السينمائي - حتى تتمكن من الحصول على صور خيالية مباشرةً من مقطع الفيديو. يتوفر ذلك بحجمين، بالإضافة إلى دقة 64 ميجابكسل، وأسرع شريحة لدينا، وبطارية ضخمة لا ينفد شحنها طوال اليوم. استعد لإثارة أكبر مع هذين الهاتفين.1', 3, NULL, NULL, NULL, NULL, 2, 6)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (4, N'Galaxy S21 | S21+ 5G', 300.0000, 330.0000, 9.0000, N'سامسونج جلاكسي A72 أسود', N'لا تفوِّت اللقطة المثالية مرةً أخرى. تعرَّف على هاتفي Galaxy S21 5G وS21+ 5G. لقد صُمما لإحداث ثورة في عالم الفيديو والتصوير بدقة 8K - على نحو يتجاوز دقة التصوير السينمائي - حتى تتمكن من الحصول على صور خيالية مباشرةً من مقطع الفيديو. يتوفر ذلك بحجمين، بالإضافة إلى دقة 64 ميجابكسل، وأسرع شريحة لدينا، وبطارية ضخمة لا ينفد شحنها طوال اليوم. استعد لإثارة أكبر مع هذين الهاتفين.1', 5, NULL, NULL, NULL, NULL, 2, 6)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (5, N'شياومي ردمي note 10 أسود', 290.0000, 320.0000, 9.0000, N'سماعات بلوتوث لاسلكية، سماعات أذن i11 TWS بلوتوث 5.0 ستيريو ميني ثلاثي الأبعاد للحد من الضوضاء مضادة للانزلاق للرياضة واللياقة', N'يأتي الهاتف بأبعاد 151×71.8×7.9 ملم مع وزن 168 جرام .
متانة وجودة التصنيع المستخدمة في الهاتف تأتي من الزجاج مع إطار من معدن ستانلس ستيل مع حماية جوريلا الجيل السادس .
الهاتف يأتي بشريحتين إتصال من نوع Nano Sim كما يدعم شبكات الاتصال الجيل الثاني الـ 2G والجيل الثالث الـ 3G والجيل الرابع الـ 4G .
أما عن القلم الـ S Pen فيأتي بأبعاد 105.08×5.8×4.35 ملم مع وزن 3.04 جرام والقلم يقوم بالعمل حتى عن بعد 10 متر عن الهاتف كما يدعم العمل عن طريق البلوتوث ولكن الجديد أنه أصبح يدعم مستشعرات الجيروسكوب والتسارع لعمل بعض الحركات والاوامر بالقلم من بعيد مثل التغيير في اوضاع التصوير في الكاميرا بدون لمس الشاشة وصرحت الشركة بأن القلم كافي للعمل لمدة 10 ساعات من البعد بداية من خروج القلم من جسم الهاتف ويمكنك شحنه فقط خلال 6 دقائق .
الهاتف والقلم كلاهما مقاوم للماء والغبار بشهادة IP68 حتى متر ونصف لمدة نصف ساعة كما يدعم الإتصال قريب المدى الـ NFC بالإضافة إلى دعمه لـ Samsung Pay والـ Samsung DeX .
أما عن الشاشة فتأتي لأول مرة بشكل الثقب في منتصف اعلى الشاشة على حرف الـ O في سلسلة النوت من سامسونج وتأتي الشاشة من نوع Dynamic AMOLED بمساحة 6.3 إنش بجودة الـ FHD+ بدقة 1080×2280 بكسل بمعدل كثافة بكسلات 401 بكسل لكل إنش وتدعم الشاشة خاصية الـ HDR10+ والـ Always on Display كما ستجدها منحنية من الأطراف بالإضافة إلى وجود طبقة حماية من نوع Corning Gorilla Glass الجيل السادس .
الكاميرا الأمامية تأتي بدقة 10 ميجا بكسل بفتحة عدسة F/2.2 وتدعم خاصية الـ Dual Pixel .
الكاميرا الخلفية تأتي بكاميرا ثلاثية حيث تأتي الكاميرا الأولى تأتي بدقة 16 ميجا بكسل بفتحة عدسة F/2.2 للتصوير الـ Ultra Wide والكاميرا الثانية هي الرئيسية تأتي بدقة 16 ميجا بكسل بفتحة عدسة متغيرة من F/1.5 إلى F/2.4 للتصوير الـ Wide Angle والكاميرا الثالثة تأتي بدقة 12 ميجا بكسل بفتحة عدسة F/2.1 للتصوير الـزوم Telephoto مع فلاش أحادي من نوع ليد .
الكاميرات تدعم المثبت البصري الـ OIS كما تدعم التقريب البصري حتى مرتين بدون فقدان في تفاصيل أو جودة الصورة بالإضافة إلى دعمها لخاصية الـ AR Emoji وتدعم العزل وعمل البورتريه بصورة مباشرة حتى أثناء تصوير الفيديوهات .', 20, NULL, NULL, NULL, NULL, 2, 8)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (6, N'ستايل 4', 120.0000, 140.0000, 7.0000, N'لابتوبات جديدة من شركة هواوي بمعالجات حديثة من شركة إنتل ', N'سعر ومواصفات إل جى lg Q Stylo 4 : تقدم شركة إل جى موبايل إل جى lg Q Stylo 4 و الذي يأتي مع مميزات رائعة وامكانيات قوية وبمواصفات عالية الجودة فى الشرق الاوسط تتمثل فى شاشة من نوع IPS LCD كابستيف تدعم اللمس ، 16 مليون لون حجم الشاشة 6.2 بوصة وكثافة شاشة جهاز إل جى هى 1080 × 2160 بكسل ، نسبة 18:9 ، 390 بكسل في البوصة بالاضافة الى معالج رئيسى من نوع Qualcomm SDM450 Snapdragon 450 المعالج الرسومى الخاص بجوال إل جى lg Q Stylo 4 معالج رسومى من نوع Adreno 506.
انواع التنبية بموبايل إل جى lg Q Stylo 4 أهتزاز ، نغمات MP3, WAV اما عن وضع وحالة كاميرا الجهاز الخلفية اى الكاميرا الاساسية لموبايل lg Q Stylo 4 فيحتوى الجهاز على كاميرا 13 ميجابكسل ، فتحة عدسة f/2.4 ، كشف تلقائي لضبط بؤرة العدسة ، فلاش LED ويعمل جوال lg Q Stylo 4 على نظام تشغيل أندرويد إصدار 8.1 ( أوريو )', 26, NULL, NULL, NULL, NULL, 2, 7)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (8, N'سماعة موندو لاسلكية', 12.0000, 15.0000, 20.0000, N'يتيح لك معالج إلغاء التشويش عالي الوضوح QN1 الاستماع بدون تشتيت الانتباه
صوت لاسلكي عالي الجودة مع تقنية Bluetooth®‎ وLDAC
تقنية الاستماع الذكي لتحسين الاستماع', N'يتيح لك معالج إلغاء التشويش عالي الوضوح QN1 الاستماع بدون تشتيت الانتباه
صوت لاسلكي عالي الجودة مع تقنية Bluetooth®‎ وLDAC
تقنية الاستماع الذكي لتحسين الاستماع', 70, NULL, NULL, NULL, NULL, 5, 8)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (9, N'سماعة اذن سلكية', 20.0000, 25.0000, 20.0000, N'هواوي فري بادز 3 سيليكون سماعة بلوتوث لاسلكية حالة صندوق تخزين مع هوك - احمر', N'EXTRA BASS™‎ لصوت عميق وقوي وإلغاء التشويش
صوت لاسلكي عالي الجودة مع تقنية Bluetooth®‎
عمر بطارية يصل إلى 30 ساعة والشحن السريع
مكالمات دون استخدام اليدين لراحتك', 100, NULL, NULL, NULL, NULL, 5, 6)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (10, N'سماعة Dono Purple', 30.0000, 35.0000, 7.0000, N'صوت يمكنك الثقة به
يحقق مضخم صوت مدمج متكامل في معالج إلغاء التشويش عالي الوضوح QN1 أفضل نسبة إشارة إلى تشويش في فئته وتشوه منخفض للأجهزة المحمولة، ويوفر جودة صوت استثنائية. وتجعل مضخمات صوت قوية مقاس 40 مم، مع أغشية من البوليمر البلوري السائل (LCP)، سماعات الرأس مثالية للتعامل مع الإيقاعات الثقيلة وتستطيع إعادة إنتاج نطاق كامل من الترددات حتى 40 كيلو هرتز.', N'سماعات اذن لاسلكية بتقنية بلوتوث 5.0 تي دبليو اس وخاصية حجب الضوضاء وتصميم صغير مضاد للتعرق سماعات من كيو سي واي، موديل T1C
3.4 من 5 نجوم 12
جنيه‎315.‎00‏
احصل عليه غداً، 18 ديسمبر
تشحن من أمازون - شحن مجاني', 120, NULL, NULL, NULL, NULL, 5, 4)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (11, N'سماعة ونتك', 49.0000, 60.0000, 6.0000, N'هواوي فري بادز 3 سيليكون سماعة بلوتوث لاسلكية حالة صندوق تخزين مع هوك - احمر', N'EXTRA BASS™‎ لصوت عميق وقوي وإلغاء التشويش
صوت لاسلكي عالي الجودة مع تقنية Bluetooth®‎
عمر بطارية يصل إلى 30 ساعة والشحن السريع
مكالمات دون استخدام اليدين لراحتك', 30, NULL, NULL, NULL, NULL, 5, 5)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (12, N'سماعات اذن ستيريو بلوتوث رياضية', 33.0000, 40.0000, 22.0000, N'هواوي فري بادز 3 سيليكون سماعة بلوتوث لاسلكية حالة صندوق تخزين مع هوك - احمر', N'سماعات اذن لاسلكية بتقنية بلوتوث 5.0 تي دبليو اس وخاصية حجب الضوضاء وتصميم صغير مضاد للتعرق سماعات من كيو سي واي، موديل T1C
3.4 من 5 نجوم 12
جنيه‎315.‎00‏
احصل عليه غداً، 18 ديسمبر
تشحن من أمازون - شحن مجاني', 50, NULL, NULL, NULL, NULL, 5, 5)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (13, N'سماعات اذن ستيريو مغناطيسية للموبايل', 30.0000, 35.0000, 7.0000, N'هواوي فري بادز 3 سيليكون سماعة بلوتوث لاسلكية حالة صندوق تخزين مع هوك - احمر', N'سماعات بلوتوث لاسلكية، سماعات أذن i11 TWS بلوتوث 5.0 ستيريو ميني ثلاثي الأبعاد للحد من الضوضاء مضادة للانزلاق للرياضة واللياقة', 22, NULL, NULL, NULL, NULL, 5, 6)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (14, N'لابتوب Dell', 1200.0000, 1250.0000, 4.0000, N' لاب توب Dell XPS 13 9310 أفضل مواصفات لاب توب من ديل في 2021', N'اذا كنت تريد الحصول على جهاز لابتوب خيالي ويمتلك عرض فائق الدقة بالاضافة الى هيكل جذاب ونحيف وبوزن خفيف ليسهل عليك حمله من مكان لاخر فإليك هذا الجهاز الرائع Dell XPS 13 والذي يعد أفضل جهاز لابتوب على الاطلاق حيث يجمع بين القوة في الاداء والتصميم الانيق والجذاب بالاضافة الى عرض فائق الدقة وهذا ما ساعد الجهاز على ان ينافس اقوى اجهزة اللابتوب في الاسواق ، وكما نعلم انه يأتي هذا الجهاز الرائع بوزن خفيف للغاية كما انه نحيف جدا وبالتالي يمكنك وضعه في حقيبة ظهرك وحمله دون معاناة ، واذا تحدثنا عن لوحة المفاتيح سوف تجد انها تأتي بتصميم مريح للغاية كما ان لوحة اللمس مميزة جدا ومريحة ، اما بالنسبة لشاشة الجهاز فيمكنها عرض الرسومات ومقاطع الفيديو بدقة 1080 بكسل كما تأتي بحجم 13 بوصة ، واذا كنت من الاشخاص الذين يرغبون في مشاهدة مقاطع الفيديو او الافلام على جهاز اللابتوب الخاصة بك فهذا الجهاز سوف يوفر لك صوت وصورة بوضوح ونقاء شديد .

اما بالنسبة لمنافذ الجهاز فهو يحتوي على منفذين من Thunderbolt 3 ومنفذ microSD بالاضافة الى مدخل لسماعة الرأس ، واذا تحدثنا عن اداء الجهاز فهو يأتي بمعالج قوي من الجيل العاشر لشركة انتل ويمكنه انجاز العديد من المهام بشكل جيد ، اما اذا كنت ترغب في فتح العديد من علامات التبويب في وقت واحد فلن تلاحظ بط ء في تشغيلها ، كما انه لن تلاحظ اي سخونة تصل للوحة المفاتيح او لوحة اللمس اثناء العمل ولكن قد تجد السخونة اسفل الجهاز وبالتحديد اسفل لوحة اللمس ، وبالنسبة لبطارية الجهاز فهى رائعة للغاية حيث يأتي الجهاز ببطارية ذات عمر طويل وبالتالي يمكنك العمل على الجهاز لفترات طويلة دون القلق بشأن نفاذ شحن البطارية او حمل الشاحن معك في كل مكان حيث يمكن للبطارية الصمود حتى أكثر من 12 ساعات عمل متواصله .', 13, NULL, NULL, NULL, NULL, 1, 3)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (15, N'لابتوب HP', 1000.0000, 130.0000, 30.0000, N'يتيح لك معالج إلغاء التشويش عالي الوضوح QN1 الاستماع بدون تشتيت الانتباه
صوت لاسلكي عالي الجودة مع تقنية Bluetooth®‎ وLDAC
تقنية الاستماع الذكي لتحسين الاستماع', N'لاب توب اتش بي 15-dw3042، انتل كور i5-1135G7، شاشة 15.6 بوصة، 1 تيرا، 8 جيجا رام، كارت شاشة نفيديا جي فورس MX350، سعة 2 جيجا، ويندوز 10 - اسود - لابتوب - لاب توب و كمبيوتر
12,244', 12, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (16, N'لابتوب توشيبا', 800.0000, 850.0000, 3.0000, N'لينوفو V15 (انتل® كور™ I3-8130U - رامات 4 جيجا بايت - هارد 1 تيرا بايت - IntelHD Graphics - شاشة 15.6بوصة HD) اسود', N'البروسيسور: الجيل الثامن انتل® كور™ I3-8130U 4M Cache, up to 3.40 GHz
الرامات : 4 جيجا بايت 
هارد ديسك : 1 تيرا بايت
الجرافيك : IntelHD Graphics
اللون : اسود ', 17, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (17, N'لابتوب اسوس', 1400.0000, 1480.0000, 7.0000, N'لينوفو V15 (انتل® كور™ I3-8130U - رامات 4 جيجا بايت - هارد 1 تيرا بايت - IntelHD Graphics - شاشة 15.6بوصة HD) اسود', N'لينوفو V15 (انتل® كور™ I3-8130U - رامات 4 جيجا بايت - هارد 1 تيرا بايت - IntelHD Graphics - شاشة 15.6بوصة HD) اسود', 9, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (18, N'لابتوب لينوفو', 500.0000, 520.0000, 5.0000, N'لينوفو V15 (انتل® كور™ I3-8130U - رامات 4 جيجا بايت - هارد 1 تيرا بايت - IntelHD Graphics - شاشة 15.6بوصة HD) اسود', N'البروسيسور: الجيل الثامن انتل® كور™ I3-8130U 4M Cache, up to 3.40 GHz
الرامات : 4 جيجا بايت 
هارد ديسك : 1 تيرا بايت
الجرافيك : IntelHD Graphics
اللون : اسود ', 5, NULL, NULL, NULL, NULL, 1, 2)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (19, N'شاشة تلفزيون', 300.0000, 320.0000, 10.0000, N'يتيح لك معالج إلغاء التشويش عالي الوضوح QN1 الاستماع بدون تشتيت الانتباه
صوت لاسلكي عالي الجودة مع تقنية Bluetooth®‎ وLDAC
تقنية الاستماع الذكي لتحسين الاستماع', N'يأتي الهاتف بأبعاد 151×71.8×7.9 ملم مع وزن 168 جرام .
متانة وجودة التصنيع المستخدمة في الهاتف تأتي من الزجاج مع إطار من معدن ستانلس ستيل مع حماية جوريلا الجيل السادس .
الهاتف يأتي بشريحتين إتصال من نوع Nano Sim كما يدعم شبكات الاتصال الجيل الثاني الـ 2G والجيل الثالث الـ 3G والجيل الرابع الـ 4G .
أما عن القلم الـ S Pen فيأتي بأبعاد 105.08×5.8×4.35 ملم مع وزن 3.04 جرام والقلم يقوم بالعمل حتى عن بعد 10 متر عن الهاتف كما يدعم العمل عن طريق البلوتوث ولكن الجديد أنه أصبح يدعم مستشعرات الجيروسكوب والتسارع لعمل بعض الحركات والاوامر بالقلم من بعيد مثل التغيير في اوضاع التصوير في الكاميرا بدون لمس الشاشة وصرحت الشركة بأن القلم كافي للعمل لمدة 10 ساعات من البعد بداية من خروج القلم من جسم الهاتف ويمكنك شحنه فقط خلال 6 دقائق .
الهاتف والقلم كلاهما مقاوم للماء والغبار بشهادة IP68 حتى متر ونصف لمدة نصف ساعة كما يدعم الإتصال قريب المدى الـ NFC بالإضافة إلى دعمه لـ Samsung Pay والـ Samsung DeX .
أما عن الشاشة فتأتي لأول مرة بشكل الثقب في منتصف اعلى الشاشة على حرف الـ O في سلسلة النوت من سامسونج وتأتي الشاشة من نوع Dynamic AMOLED بمساحة 6.3 إنش بجودة الـ FHD+ بدقة 1080×2280 بكسل بمعدل كثافة بكسلات 401 بكسل لكل إنش وتدعم الشاشة خاصية الـ HDR10+ والـ Always on Display كما ستجدها منحنية من الأطراف بالإضافة إلى وجود طبقة حماية من نوع Corning Gorilla Glass الجيل السادس .
الكاميرا الأمامية تأتي بدقة 10 ميجا بكسل بفتحة عدسة F/2.2 وتدعم خاصية الـ Dual Pixel .
الكاميرا الخلفية تأتي بكاميرا ثلاثية حيث تأتي الكاميرا الأولى تأتي بدقة 16 ميجا بكسل بفتحة عدسة F/2.2 للتصوير الـ Ultra Wide والكاميرا الثانية هي الرئيسية تأتي بدقة 16 ميجا بكسل بفتحة عدسة متغيرة من F/1.5 إلى F/2.4 للتصوير الـ Wide Angle والكاميرا الثالثة تأتي بدقة 12 ميجا بكسل بفتحة عدسة F/2.1 للتصوير الـزوم Telephoto مع فلاش أحادي من نوع ليد .
الكاميرات تدعم المثبت البصري الـ OIS كما تدعم التقريب البصري حتى مرتين بدون فقدان في تفاصيل أو جودة الصورة بالإضافة إلى دعمها لخاصية الـ AR Emoji وتدعم العزل وعمل البورتريه بصورة مباشرة حتى أثناء تصوير الفيديوهات .', 8, NULL, NULL, NULL, NULL, 3, 3)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (20, N'شاشة أندرويد', 450.0000, 460.0000, 30.0000, N'إل جي 75" 4K UHD السلسلة 75, معالج رباعي النواة, HDR, ريموت سحري, ذكاء إصطناعي عربي.', N'تلفزيون فائق الوضوح (UHD) من إل جي بدقة 4K مقاس 75 بوصة من السلسلة 75، معالج رباعي النواة، HDR (النطاق الديناميكي العالي) النشط، الريموت السحري والذكاء الاصطناعي بالعربية
75UP7550PVC
تجربة مشاهدة مبهرة مع دقة 4K Ultra HD بجودة صورة مفعمة بالحيوية
معالج سريع رباعي النواة 4K
تقنية HDR لتجربة مشاهدة غامرة للأعمال السينمائية والرياضية والألعاب
تقنية إل جي الذكية، AI ThinQ من إل جي
تلفزيون webOS الذكي مع جهاز التحكم السحري عن بعد سحري يتميز بإمكانية التحكم عبر العجلة والتأشير', 4, NULL, NULL, NULL, NULL, 3, 4)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (21, N'إل جي 75 بوصه السلسلة 75', 250.0000, 280.0000, 5.0000, N'إل جي 75" 4K UHD السلسلة 75, معالج رباعي النواة, HDR, ريموت سحري, ذكاء إصطناعي عربي.', N'تلفزيون فائق الوضوح (UHD) من إل جي بدقة 4K مقاس 75 بوصة من السلسلة 75، معالج رباعي النواة، HDR (النطاق الديناميكي العالي) النشط، الريموت السحري والذكاء الاصطناعي بالعربية
75UP7550PVC
تجربة مشاهدة مبهرة مع دقة 4K Ultra HD بجودة صورة مفعمة بالحيوية
معالج سريع رباعي النواة 4K
تقنية HDR لتجربة مشاهدة غامرة للأعمال السينمائية والرياضية والألعاب
تقنية إل جي الذكية، AI ThinQ من إل جي
تلفزيون webOS الذكي مع جهاز التحكم السحري عن بعد سحري يتميز بإمكانية التحكم عبر العجلة والتأشير', 20, NULL, NULL, NULL, NULL, 3, 4)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (22, N'تلفزيون متكامل', 280.0000, 300.0000, 6.0000, N'شياومي ردمي note 10 أسود', N'• وحدة معالجة مركزية ( بروسيسور ) من نوع : Intel Core i7-1165G7 من الجيل الحادي عشر .
• كارت شاشة من نوع : Intel Iris Xe Graphics .
• ذاكرة وصول عشوائي ( رامات ) بحجم : 16 جيجا بايت .
• سعة تخزين داخلية تصل الي : 512 جيجا بايت M.2 NVMe من نوع  SSD .
• شاشة بمقياس : 13.4 بوصة وبتقنية 1080 بكسل .
• ابعاد الجهاز : 11.6 × 7.8 × 0.6 انش .
• وزن الجهاز يصل الى : 2.8 باوند .
• هيكل جذاب ومتميز .
• خفيف الوزن .
• عمر بطارية ممتاز .
• اداء عام قوي .
العيوب :
• لا يمتلك عدد كبير من المنافذ .
سعر اللاب توب :
يبلغ سعر الجهاز : يبدأ من 1000 دولار امريكي .', 38, NULL, NULL, NULL, NULL, 3, 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (23, N'ساعة قوقل', 50.0000, 55.0000, 9.0000, N'هواوي فري بادز 3 سيليكون سماعة بلوتوث لاسلكية حالة صندوق تخزين مع هوك - احمر', N'البروسيسور: الجيل الثامن انتل® كور™ I3-8130U 4M Cache, up to 3.40 GHz
الرامات : 4 جيجا بايت 
هارد ديسك : 1 تيرا بايت
الجرافيك : IntelHD Graphics
اللون : اسود ', 14, NULL, NULL, NULL, NULL, 4, 4)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (24, N'ساعة أبل', 80.0000, 90.0000, 9.0000, N'هواوي فري بادز 3 سيليكون سماعة بلوتوث لاسلكية حالة صندوق تخزين مع هوك - احمر', N'تلفزيون فائق الوضوح (UHD) من إل جي بدقة 4K مقاس 75 بوصة من السلسلة 75، معالج رباعي النواة، HDR (النطاق الديناميكي العالي) النشط، الريموت السحري والذكاء الاصطناعي بالعربية
75UP7550PVC
تجربة مشاهدة مبهرة مع دقة 4K Ultra HD بجودة صورة مفعمة بالحيوية
معالج سريع رباعي النواة 4K
تقنية HDR لتجربة مشاهدة غامرة للأعمال السينمائية والرياضية والألعاب
تقنية إل جي الذكية، AI ThinQ من إل جي
تلفزيون webOS الذكي مع جهاز التحكم السحري عن بعد سحري يتميز بإمكانية التحكم عبر العجلة والتأشير', 20, NULL, NULL, NULL, NULL, 4, 5)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (25, N'ساعة سوني', 35.0000, 40.0000, 8.0000, N'لابتوبات جديدة من شركة هواوي بمعالجات حديثة من شركة إنتل ', N'EXTRA BASS™‎ لصوت عميق وقوي وإلغاء التشويش
صوت لاسلكي عالي الجودة مع تقنية Bluetooth®‎
عمر بطارية يصل إلى 30 ساعة والشحن السريع
مكالمات دون استخدام اليدين لراحتك', 9, NULL, NULL, NULL, NULL, 4, 1)
SET IDENTITY_INSERT [dbo].[Products] OFF
ALTER TABLE [dbo].[CartItems] ADD  CONSTRAINT [DF_CartItems_UnitPrice]  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Tickets_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_TotalPrice]  DEFAULT ((0)) FOR [TotalPrice]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_Price]  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_SalePrice]  DEFAULT ((0)) FOR [SalePrice]
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK_CartItems_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK_CartItems_Orders]
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK_CartItems_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK_CartItems_Products]
GO
ALTER TABLE [dbo].[Pictures]  WITH CHECK ADD  CONSTRAINT [FK_Pictures_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Pictures] CHECK CONSTRAINT [FK_Pictures_Products]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Companies] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Companies] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Companies]
GO
USE [master]
GO
ALTER DATABASE [MyOrderDB] SET  READ_WRITE 
GO
