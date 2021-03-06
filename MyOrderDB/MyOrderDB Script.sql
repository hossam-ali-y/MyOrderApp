USE [master]
GO
/****** Object:  Database [MyOrderDB]    Script Date: 12/16/2021 4:31:06 AM ******/
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
/****** Object:  Table [dbo].[CartItems]    Script Date: 12/16/2021 4:31:06 AM ******/
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
/****** Object:  Table [dbo].[Categories]    Script Date: 12/16/2021 4:31:06 AM ******/
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
/****** Object:  Table [dbo].[Companies]    Script Date: 12/16/2021 4:31:06 AM ******/
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
/****** Object:  Table [dbo].[Orders]    Script Date: 12/16/2021 4:31:06 AM ******/
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
/****** Object:  Table [dbo].[Pictures]    Script Date: 12/16/2021 4:31:06 AM ******/
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
/****** Object:  Table [dbo].[Products]    Script Date: 12/16/2021 4:31:06 AM ******/
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
	[ShortDetails] [nvarchar](250) NULL,
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

INSERT [dbo].[CartItems] ([Id], [ProductId], [OrderId], [Quantity], [UnitPrice]) VALUES (1, 24, 4, 7, 0.0000)
INSERT [dbo].[CartItems] ([Id], [ProductId], [OrderId], [Quantity], [UnitPrice]) VALUES (2, 5, 4, 3, 290.0000)
INSERT [dbo].[CartItems] ([Id], [ProductId], [OrderId], [Quantity], [UnitPrice]) VALUES (3, 1, 4, 1, 0.0000)
INSERT [dbo].[CartItems] ([Id], [ProductId], [OrderId], [Quantity], [UnitPrice]) VALUES (4, 2, 4, 1, 0.0000)
INSERT [dbo].[CartItems] ([Id], [ProductId], [OrderId], [Quantity], [UnitPrice]) VALUES (5, 3, 4, 3, 200.0000)
INSERT [dbo].[CartItems] ([Id], [ProductId], [OrderId], [Quantity], [UnitPrice]) VALUES (6, 20, 4, 1, 0.0000)
INSERT [dbo].[CartItems] ([Id], [ProductId], [OrderId], [Quantity], [UnitPrice]) VALUES (7, 6, 4, 2, 0.0000)
INSERT [dbo].[CartItems] ([Id], [ProductId], [OrderId], [Quantity], [UnitPrice]) VALUES (8, 4, 4, 3, 300.0000)
INSERT [dbo].[CartItems] ([Id], [ProductId], [OrderId], [Quantity], [UnitPrice]) VALUES (9, 25, 5, 2, 35.0000)
INSERT [dbo].[CartItems] ([Id], [ProductId], [OrderId], [Quantity], [UnitPrice]) VALUES (10, 18, 6, 1, 500.0000)
INSERT [dbo].[CartItems] ([Id], [ProductId], [OrderId], [Quantity], [UnitPrice]) VALUES (11, 2, 6, 1, 10.0000)
INSERT [dbo].[CartItems] ([Id], [ProductId], [OrderId], [Quantity], [UnitPrice]) VALUES (12, 3, 6, 2, 200.0000)
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

INSERT [dbo].[Orders] ([Id], [CustomerName], [CustomerLastName], [CustomerEmail], [CustomerPhone], [CustomerCompanyName], [CustomerAddress], [Country], [City], [ZipCode], [Status], [Note], [CreatedDate], [ShippedDate], [DeliveredDate], [TotalPrice]) VALUES (1, N'حسام علي اليعري', NULL, N'hosamali.9.bh@gmail.com', N'772982855', NULL, NULL, NULL, NULL, NULL, 0, N'نرجو سرعة التوصيل', NULL, NULL, NULL, 10630.0000)
INSERT [dbo].[Orders] ([Id], [CustomerName], [CustomerLastName], [CustomerEmail], [CustomerPhone], [CustomerCompanyName], [CustomerAddress], [Country], [City], [ZipCode], [Status], [Note], [CreatedDate], [ShippedDate], [DeliveredDate], [TotalPrice]) VALUES (2, N'sss', NULL, N'ssssjsnjhs', N'77725272', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 10630.0000)
INSERT [dbo].[Orders] ([Id], [CustomerName], [CustomerLastName], [CustomerEmail], [CustomerPhone], [CustomerCompanyName], [CustomerAddress], [Country], [City], [ZipCode], [Status], [Note], [CreatedDate], [ShippedDate], [DeliveredDate], [TotalPrice]) VALUES (3, N'ssguugs', NULL, N'ssguugsshihiis', N'727627', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 10630.0000)
INSERT [dbo].[Orders] ([Id], [CustomerName], [CustomerLastName], [CustomerEmail], [CustomerPhone], [CustomerCompanyName], [CustomerAddress], [Country], [City], [ZipCode], [Status], [Note], [CreatedDate], [ShippedDate], [DeliveredDate], [TotalPrice]) VALUES (4, N'eeeeeeeee', NULL, N'hghsgshhs', N'', NULL, NULL, NULL, NULL, NULL, 0, N'dddddddddddd', NULL, NULL, NULL, 10630.0000)
INSERT [dbo].[Orders] ([Id], [CustomerName], [CustomerLastName], [CustomerEmail], [CustomerPhone], [CustomerCompanyName], [CustomerAddress], [Country], [City], [ZipCode], [Status], [Note], [CreatedDate], [ShippedDate], [DeliveredDate], [TotalPrice]) VALUES (5, N'حسام', N'اليعري', N'hosamali.9.bh@gmail.com', N'772982855', N'سينك تكنولوجي', N'اليمن - صنعاء - الستين الغربي', N'اليمن', N'أمانة العاصمة', N'0020339', 0, N'الرجاء سرعة توصيل الطلب', NULL, NULL, NULL, 70.0000)
INSERT [dbo].[Orders] ([Id], [CustomerName], [CustomerLastName], [CustomerEmail], [CustomerPhone], [CustomerCompanyName], [CustomerAddress], [Country], [City], [ZipCode], [Status], [Note], [CreatedDate], [ShippedDate], [DeliveredDate], [TotalPrice]) VALUES (6, N'hossam alyaari', N'alyaari', N'alfatehschools@gmail.co', N'+967772982855', N'سينك تكنولوجي', N'sanaa', N'اليمن - صنعاء', N'صنعاء', N'5000', 0, NULL, NULL, NULL, NULL, 910.0000)
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[Pictures] ON 

INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (1, 1, N'assets/images/product/laptop.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (2, 2, N'assets/images/product/headphone1 (2).png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (3, 3, N'assets/images/product/phone1.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (5, 4, N'assets/images/product/phone2.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (6, 5, N'assets/images/product/phone3.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (7, 6, N'assets/images/product/phone4.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (8, 8, N'assets/images/product/headphone1.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (9, 9, N'assets/images/product/headphone2.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (10, 10, N'assets/images/product/headphone3.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (11, 11, N'assets/images/product/headphone4.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (12, 12, N'assets/images/product/headphone5.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (13, 13, N'assets/images/product/headphone2.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (14, 14, N'assets/images/product/laptop1.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (15, 15, N'assets/images/product/laptop2.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (16, 16, N'assets/images/product/laptop3.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (17, 17, N'assets/images/product/laptop4.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (18, 18, N'assets/images/product/laptop5.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (19, 19, N'assets/images/product/tv1.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (20, 20, N'assets/images/product/tv2.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (21, 21, N'assets/images/product/tv3.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (22, 22, N'assets/images/product/tv4.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (23, 23, N'assets/images/product/Smartwatch1.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (24, 24, N'assets/images/product/Smartwatch2.png', N'assets/images/product/Smartwatch21.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (25, 25, N'assets/images/product/Smartwatch3.png', NULL, NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (31, 24, NULL, N'assets/images/product/Smartwatch22.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (32, 24, NULL, N'assets/images/product/Smartwatch23.png', NULL)
INSERT [dbo].[Pictures] ([Id], [ProductId], [Big], [Small], [Note]) VALUES (33, 24, NULL, N'assets/images/product/Smartwatch24.png', NULL)
SET IDENTITY_INSERT [dbo].[Pictures] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (1, N'لابتوب هواوي ميت بك إكس برو', 1750.0000, 1800.0000, 3.0000, NULL, NULL, 10, NULL, NULL, NULL, NULL, 1, 8)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (2, N'سماعة إستريو', 10.0000, 15.0000, 30.0000, NULL, NULL, 2, NULL, NULL, NULL, NULL, 5, 8)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (3, N'نوت10', 200.0000, 250.0000, 20.0000, NULL, NULL, 3, NULL, NULL, NULL, NULL, 2, 6)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (4, N'نوت9', 300.0000, 330.0000, 9.0000, NULL, NULL, 5, NULL, NULL, NULL, NULL, 2, 6)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (5, N'هواوي', 290.0000, 320.0000, 9.0000, NULL, NULL, 20, NULL, NULL, NULL, NULL, 2, 8)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (6, N'ستايل 4', 120.0000, 140.0000, 7.0000, NULL, NULL, 26, NULL, NULL, NULL, NULL, 2, 7)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (8, N'سماعة موندو لاسلكية', 12.0000, 15.0000, 20.0000, NULL, NULL, 70, NULL, NULL, NULL, NULL, 5, 8)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (9, N'سماعة اذن سلكية', 20.0000, 25.0000, 20.0000, NULL, NULL, 100, NULL, NULL, NULL, NULL, 5, 6)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (10, N'سماعة Dono Purple', 30.0000, 35.0000, 7.0000, NULL, NULL, 120, NULL, NULL, NULL, NULL, 5, 4)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (11, N'سماعة ونتك', 49.0000, 60.0000, 6.0000, NULL, NULL, 30, NULL, NULL, NULL, NULL, 5, 5)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (12, N'سماعة بيرو', 33.0000, 40.0000, 22.0000, NULL, NULL, 50, NULL, NULL, NULL, NULL, 5, 5)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (13, N'سماعة اذن سلكية', 30.0000, 35.0000, 7.0000, NULL, NULL, 22, NULL, NULL, NULL, NULL, 5, 6)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (14, N'لابتوب Dell', 1200.0000, 1250.0000, 4.0000, NULL, NULL, 13, NULL, NULL, NULL, NULL, 1, 3)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (15, N'لابتوب HP', 1000.0000, 130.0000, NULL, NULL, NULL, 12, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (16, N'لابتوب توشيبا', 800.0000, 850.0000, 3.0000, NULL, NULL, 17, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (17, N'لابتوب اسوس', 1400.0000, 1480.0000, 7.0000, NULL, NULL, 9, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (18, N'لابتوب لينوفو', 500.0000, 520.0000, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, 1, 2)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (19, N'شاشة تلفزيون', 300.0000, 320.0000, NULL, NULL, NULL, 8, NULL, NULL, NULL, NULL, 3, 3)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (20, N'شاشة أندرويد', 450.0000, 460.0000, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, 3, 4)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (21, N'شاشة ذكية', 250.0000, 280.0000, NULL, NULL, NULL, 20, NULL, NULL, NULL, NULL, 3, 4)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (22, N'تلفزيون متكامل', 280.0000, 300.0000, NULL, NULL, NULL, 38, NULL, NULL, NULL, NULL, 3, 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (23, N'ساعة قوقل', 50.0000, 55.0000, 9.0000, NULL, NULL, 14, NULL, NULL, NULL, NULL, 4, 4)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (24, N'ساعة أبل', 80.0000, 90.0000, 9.0000, NULL, NULL, 20, NULL, NULL, NULL, NULL, 4, 5)
INSERT [dbo].[Products] ([Id], [Name], [Price], [SalePrice], [Discount], [ShortDetails], [Description], [Stock], [Brand], [Sale], [Tags], [Colors], [CategoryId], [CompanyId]) VALUES (25, N'ساعة سوني', 35.0000, 40.0000, 8.0000, NULL, NULL, 9, NULL, NULL, NULL, NULL, 4, 1)
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
