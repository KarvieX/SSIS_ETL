--Create
----Create dimDate

IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'dimDate')
BEGIN
	DROP TABLE dbo.dimDate;
END
GO

CREATE TABLE dbo.dimDate
(
dimDateID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_dimDate PRIMARY KEY,
FullDate [date] NOT NULL,
DayNumberOfWeek [tinyint] NOT NULL,
DayNameOfWeek [varchar] (9) NOT NULL,
DayNumberOfMonth [tinyint] NOT NULL,
DayNumberOfYear [int] NOT NULL,
WeekdayFlag [int] NOT NULL,
WeekNumberOfYear [tinyint] NOT NULL,
[MonthName] [varchar](9) NOT NULL,
MonthNumberOfYear [tinyint] NOT NULL,
CalendarQuarter [tinyint] NOT NULL,
CalendarYear [int] NOT NULL,
CalendarSemester [tinyint] NOT NULL,
CreatedDate DATETIME NOT NULL,
CreatedBy NVARCHAR(255) NOT NULL,
ModifiedDate DATETIME NULL,
ModifiedBy NVARCHAR(255) NULL
);
GO

----Create dimLocation
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'dimLocation')
BEGIN
	DROP TABLE dbo.dimLocation;
END
GO

CREATE TABLE dbo.dimLocation(
 [dimLocationID] [int] IDENTITY(1,1) NOT NULL CONSTRAINT PK_dimLocation PRIMARY KEY,
 [Address] [nvarchar](255) NOT NULL,
 [City] [nvarchar](255) NOT NULL,
 [StateProvince] [nvarchar](255) NOT NULL,
 [Country] [nvarchar](255) NOT NULL,
 [PostalCode] [nvarchar](255) NOT NULL,
 [CreatedDate] [datetime] NOT NULL,
 [CreatedBy] [nvarchar](255) NOT NULL,
 [ModifiedDate] [datetime] NULL,
 [ModifiedBy] [nvarchar](255) NULL,
 )

----Create dimCustomer
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'dimCustomer')
BEGIN
	DROP TABLE dbo.dimCustomer;
END
GO

CREATE TABLE dbo.dimCustomer(
 [dimCustomerKey] [int] IDENTITY(1,1) CONSTRAINT PK_dimCustomer PRIMARY KEY NOT NULL,
 [CustomerID] [uniqueidentifier] NOT NULL,
 [FirstName] [nvarchar](255) NOT NULL,
 [LastName] [nvarchar](255) NOT NULL,
 [Gender] [nvarchar](1) NOT NULL,
 [EmailAddress] [nvarchar](255) NOT NULL,
 [PhoneNumber] [nvarchar](20) NOT NULL,
 [LocationID] [int] NOT NULL,
 [CreatedDate] [datetime] NOT NULL,
 [CreatedBy] [nvarchar](255) NOT NULL,
 [ModifiedDate] [datetime] NULL,
 [ModifiedBy] [nvarchar](255) NULL,
 CONSTRAINT FK_dimCustomer_LocationID FOREIGN KEY (LocationID) REFERENCES dimLocation(dimLocationID), 
)

----Create dimStore
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'dimStore')
BEGIN
	DROP TABLE dbo.dimStore;
END
GO

CREATE TABLE dbo.dimStore(
 [dimStoreKey] [int] IDENTITY(1,1) CONSTRAINT PK_dimStore PRIMARY KEY NOT NULL,
 [StoreID] [int] NOT NULL,
 [StoreNumber] [int] NOT NULL,
 [StoreName] [nvarchar](255) NOT NULL,
 [StoreManager] [nvarchar](255) NOT NULL,
 [PhoneNumber] [nvarchar](20) NOT NULL,
 [LocationID] [int] NOT NULL,
 [CreatedDate] [datetime] NOT NULL,
 [CreatedBy] [nvarchar](255) NOT NULL,
 [ModifiedDate] [datetime] NULL,
 [ModifiedBy] [nvarchar](255) NULL,
 CONSTRAINT FK_dimStore_LocationID FOREIGN KEY (LocationID) REFERENCES dimLocation(dimLocationID)
 )

----Create dimChannel
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'dimChannel')
BEGIN
	DROP TABLE dbo.dimChannel;
END
GO

CREATE TABLE dbo.dimChannel(
 [dimChannelKey] [int] IDENTITY(1,1) CONSTRAINT PK_dimChannel PRIMARY KEY NOT NULL,
 [ChannelID] [int] NOT NULL,
 [ChannelCategoryID] [int] NOT NULL,
 [ChannelName] [nvarchar](50) NOT NULL,
 [ChannelCategory] [nvarchar](50) NOT NULL,
 [CreatedDate] [datetime] NOT NULL,
 [CreatedBy] [nvarchar](255) NOT NULL,
 [ModifiedDate] [datetime] NULL,
 [ModifiedBy] [nvarchar](255) NULL,
 )


----Create dimReseller
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'dimReseller')
BEGIN
	DROP TABLE dbo.dimReseller;
END
GO

CREATE TABLE dbo.dimReseller(
 [dimResellerKey] [int] IDENTITY(1,1) CONSTRAINT PK_dimReseller PRIMARY KEY NOT NULL,
 [ResellerID] [uniqueidentifier] NOT NULL,
 [ResellerName] [nvarchar](255) NOT NULL, 
 [Contact] [nvarchar](255) NOT NULL,
 [EmailAddress] [nvarchar](255) NOT NULL,
 [LocationID] [int] NOT NULL,
 [PhoneNumber] [nvarchar](20) NOT NULL,
 [CreatedDate] [datetime] NOT NULL,
 [CreatedBy] [nvarchar](255) NOT NULL,
 [ModifiedDate] [datetime] NULL,
 [ModifiedBy] [nvarchar](255) NULL,
 CONSTRAINT FK_dimReseller_LocationID FOREIGN KEY (LocationID) REFERENCES dimLocation(dimLocationID),
)

----Create dimProduct
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'dimProduct')
BEGIN
	DROP TABLE dbo.dimProduct;
END
GO

CREATE TABLE dbo.dimProduct (
    [dimProductKey] [int] IDENTITY(1,1) CONSTRAINT PK_dimProduct PRIMARY KEY NOT NULL,
    [ProductID] [int] NOT NULL,
    [Product] [nvarchar](50) NOT NULL,
    [ProductTypeID] [int] NOT NULL,
    [ProductType] [nvarchar](50) NOT NULL,
    [ProductCategoryID] [int] NOT NULL,
    [ProductCategory] [nvarchar](50) NOT NULL,
    [Color] [nvarchar](50) NULL,
    [Style] [nvarchar](50) NULL,
    [Weight] [decimal](18,6) NOT NULL,
    [Price] [decimal](18,6) NOT NULL,
    [Cost] [decimal](18,6) NOT NULL,
    [WholesalePrice] [decimal](18,6) NOT NULL,
    [CreatedDate] [datetime] NOT NULL,
    [CreatedBy] [nvarchar](255) NOT NULL,
    [ModifiedDate] [datetime] NULL,
    [ModifiedBy] [nvarchar](255) NULL,
)

--Create factTargetChannel
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'factTargetChannel')
BEGIN
	DROP TABLE dbo.factTargetChannel;
END
GO

CREATE TABLE factTargetChannel(
 [TargetChannelID] [int] IDENTITY(1,1) CONSTRAINT [PK_factTargetChannel] PRIMARY KEY CLUSTERED NOT NULL,
 [dimDateID] [int] NOT NULL,
 [TargetChannelYear] [nvarchar](50) NOT NULL,
 [dimChannelKey] [int] NOT NULL,
 [dimStoreKey] [int],
 [dimResellerKey] [int],
 [TargetSalesAmount] [decimal](18, 6) NOT NULL,
 CONSTRAINT FK_factTargetChannel_dimChannelKey FOREIGN KEY (dimChannelKey) REFERENCES dimChannel(dimChannelKey),
 CONSTRAINT FK_factTargetChannel_dimStoreKey FOREIGN KEY (dimStoreKey) REFERENCES dimStore(dimStoreKey),
 CONSTRAINT FK_factTargetChannel_dimResellerKey FOREIGN KEY (dimResellerKey) REFERENCES dimReseller(dimResellerKey), 
 CONSTRAINT FK_factTargetChannel_dimDateID FOREIGN KEY (dimDateID) REFERENCES dimDate(dimDateID)
) 



--Create factTargetProduct
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'factTargetProduct')
BEGIN
	DROP TABLE dbo.factTargetProduct;
END
GO

CREATE TABLE dbo.factTargetProduct(
 [TargetProductID] [int] IDENTITY(1,1) CONSTRAINT [PK_factTargetProduct] PRIMARY KEY NOT NULL,
 [dimDateID] [int] NOT NULL,
 [TargetProductYear] [nvarchar](10) NOT NULL,
 [dimProductKey] [int] NOT NULL,
 [SalesQuantityTarget ] [decimal](18,6) NOT NULL,
 CONSTRAINT FK_factTargetProduct_dimProductKey FOREIGN KEY (dimProductKey) REFERENCES dimProduct(dimProductKey),
 CONSTRAINT FK_factTargetProduct_dimDateID FOREIGN KEY (dimDateID) REFERENCES dimDate(dimDateID)
) 

--Create factSalesDetail
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'factSalesDetail')
BEGIN
	DROP TABLE dbo.factSalesDetail;
END
GO

CREATE TABLE dbo.factSalesDetail(
 [SalesDetailID] [int] IDENTITY(1,1) CONSTRAINT [PK_factSalesDetail] PRIMARY KEY CLUSTERED NOT NULL,
 [dimDateID] [int] NOT NULL,
 [SalesQuantity] [int] NOT NULL,
 [SalesAmount] [decimal](18, 6) NOT NULL,
 [dimProductKey] [int] NOT NULL,
 [Cost] [decimal](18,6) NOT NULL,
 [Profit] [decimal](18,6) NOT NULL,
 [dimChannelKey] [int] NOT NULL,
 [dimStoreKey] [int] NULL,
 [dimCustomerKey] [int] NULL,
 [dimResellerKey] [int] NULL,
 [LocationID] [int] NOT NULL,
 [CreatedDate] [datetime] NOT NULL,
 [CreatedBy] [nvarchar](255) NOT NULL,
 [ModifiedDate] [datetime] NULL,
 [ModifiedBy] [nvarchar](255) NULL,

 CONSTRAINT FK_factSalesDetial_dimChannelKey FOREIGN KEY (dimChannelKey) REFERENCES dimChannel(dimChannelKey),
 CONSTRAINT FK_factSalesDetail_dimStoreKey FOREIGN KEY (dimStoreKey) REFERENCES dimStore(dimStoreKey),
 CONSTRAINT FK_factSalesDetail_dimCustomerKey FOREIGN KEY (dimCustomerKey) REFERENCES dimCustomer(dimCustomerKey),
 CONSTRAINT FK_factSalesDetail_dimResellerKey FOREIGN KEY (dimResellerKey) REFERENCES dimReseller(dimResellerKey),
 CONSTRAINT FK_factSalesDetail_dimProductKey FOREIGN KEY (dimProductKey) REFERENCES dimProduct(dimProductKey),
CONSTRAINT FK_factSalesDetail_LocationID FOREIGN KEY (LocationID) REFERENCES dimLocation(dimLocationID),
CONSTRAINT FK_factSalesDetail_dimDateID FOREIGN KEY (dimDateID) REFERENCES dimDate(dimDateID)         
 )


--Delete
DELETE FROM dbo.factSalesDetail;
DELETE FROM dbo.factTargetChannel;
DELETE FROM dbo.factTargetProduct;

DELETE FROM dbo.dimProduct;
DELETE FROM dbo.dimChannel;

DELETE FROM dbo.dimCustomer;
DELETE FROM dbo.dimReseller;
DELETE FROM dbo.dimStore;

DELETE FROM dbo.dimLocation;
DELETE FROM dbo.dimDate;

DELETE FROM dimLocation;
--Load
--Load dimLocation
DBCC CHECKIDENT ('dbo.dimLocation', RESEED, 1);
GO
SET IDENTITY_INSERT dbo.dimLocation ON
INSERT INTO dbo.dimLocation(
 dimLocationID,
 Address,
 City,
 StateProvince,
 Country,
 PostalCode,
 CreatedDate,
 CreatedBy,
 ModifiedDate,
 ModifiedBy
)
VALUES(
-1,
'Unknown',
'Unknown',
'Unknown',
'Unknown',
'Unknown',
0,
'Unknown',
0,
'Unknown'
);
SET IDENTITY_INSERT dbo.dimLocation OFF

INSERT INTO dbo.dimLocation(
	Address,
	City,
	StateProvince,
	Country,
	PostalCode,
	CreatedDate,
	CreatedBy,
	ModifiedDate,
	ModifiedBy
)
SELECT S.Address,S.City,S.StateProvince,S.Country,S.PostalCode,S.CreatedDate,S.CreatedBy,S.ModifiedDate,S.ModifiedBy
FROM dbo.StageStore S

INSERT INTO dbo.dimLocation(
	Address,
	City,
	StateProvince,
	Country,
	PostalCode,
	CreatedDate,
	CreatedBy,
	ModifiedDate,
	ModifiedBy
)
SELECT 
C.Address,C.City,C.StateProvince,C.Country,C.PostalCode,C.CreatedDate,C.CreatedBy,C.ModifiedDate,C.ModifiedBy
FROM dbo.StageCustomer C

INSERT INTO dbo.dimLocation(
	Address,
	City,
	StateProvince,
	Country,
	PostalCode,
	CreatedDate,
	CreatedBy,
	ModifiedDate,
	ModifiedBy
)
SELECT 
R.Address,R.City,R.StateProvince,R.Country,R.PostalCode,R.CreatedDate,R.CreatedBy,R.ModifiedDate,R.ModifiedBy
FROM dbo.StageReseller R

--Load dimProduct
DBCC CHECKIDENT ('dbo.dimProduct', RESEED, 0);
GO

SET IDENTITY_INSERT dbo.dimProduct ON
INSERT INTO dbo.dimProduct(
 dimProductKey,
 ProductID,
 Product,
 ProductTypeID,
 ProductType,
 ProductCategoryID,
 ProductCategory,
 Color,
 Style,
 Weight,
 Price,
 Cost,
 WholesalePrice,
 CreatedDate,
 CreatedBy,
 ModifiedDate,
 ModifiedBy
)
VALUES(
-1,
0,
'Unknown',
0,
'Unknown',
0,
'Unknown',
'Unknown',
'Unknown',
0,
0,
0,
0,
0,
'Unknown',
0,
'Unknown'
);
SET IDENTITY_INSERT dbo.dimProduct OFF

INSERT INTO dbo.dimProduct(
 ProductID,
 Product,
 ProductTypeID,
 ProductType,
 ProductCategoryID,
 ProductCategory,
 Color,
 Style,
 Weight,
 Price,
 Cost,
 WholesalePrice,
 CreatedDate,
 CreatedBy,
 ModifiedDate,
 ModifiedBy
)
SELECT P.ProductID,
 P.Product,
 PT.ProductTypeID,
 PT.ProductType,
 PC.ProductCategoryID,
 PC.ProductCategory,
 P.Color,
 P.Style,
 P.Weight,
 P.Price,
 P.Cost,
 P.WholesalePrice,
 P.CreatedDate,
 P.CreatedBy,
 P.ModifiedDate,
 P.ModifiedBy
FROM dbo.StageProduct P
JOIN dbo.StageProductType PT ON PT.ProductTypeID = P.ProductTypeID
JOIN dbo.StageProductCategory PC ON PT.ProductCategoryID = PC.ProductCategoryID

SELECT * FROM dimProduct;

--Load dimReseller
DBCC CHECKIDENT ('dbo.dimReseller', RESEED, 1);
GO
SET IDENTITY_INSERT dbo.dimReseller ON
INSERT INTO dbo.dimReseller(
 dimResellerKey,
 ResellerID,
 ResellerName,
 Contact,
 EmailAddress,
 LocationID,
 PhoneNumber,
 CreatedDate,
 CreatedBy,
 ModifiedDate,
 ModifiedBy
)
VALUES(
-1,
NEWID(),
'Unknown',
'Unknown',
'Unknown',
-1,
'Unknown',
0,
'Unknown',
0,
'Unknown'
);
SET IDENTITY_INSERT dbo.dimReseller OFF

INSERT INTO dbo.dimReseller(
 ResellerID,
 ResellerName,
 Contact,
 EmailAddress,
 LocationID,
 PhoneNumber,
 CreatedDate,
 CreatedBy,
 ModifiedDate,
 ModifiedBy
)
SELECT  R.ResellerID,
 R.ResellerName,
 R.Contact,
 R.EmailAddress,
 L.dimLocationID,
 R.PhoneNumber,
 R.CreatedDate,
 R.CreatedBy,
 R.ModifiedDate,
 R.ModifiedBy
FROM dbo.StageReseller R
JOIN dbo.dimLocation L ON L.Address = R.Address


--Load dimChannel
DBCC CHECKIDENT ('dbo.dimChannel', RESEED, 1);
GO
SET IDENTITY_INSERT dbo.dimChannel ON
INSERT INTO dbo.dimChannel(
	dimChannelKey,
	ChannelID,
	ChannelName,
	ChannelCategoryID,
	ChannelCategory,
	CreatedDate,
	CreatedBy,
	ModifiedDate,
	ModifiedBy
)
VALUES(
-1,
0,
'Unknown',
0,
'Unknown',
0,
'Unknown',
0,
'Unknown'
);
SET IDENTITY_INSERT dbo.dimChannel OFF

INSERT INTO dbo.dimChannel(
	ChannelID,
	ChannelName,
	ChannelCategoryID,
	ChannelCategory,
	CreatedDate,
	CreatedBy,
	ModifiedDate,
	ModifiedBy
)
SELECT CH.ChannelID,CH.Channel,CHC.ChannelCategoryID,CHC.ChannelCategory,CH.CreatedDate,CH.CreatedBy,CH.ModifiedDate,CH.ModifiedBy
FROM dbo.StageChannel CH
JOIN dbo.StageChannelCategory CHC ON CH.ChannelCategoryID = CHC.ChannelCategoryID


--Load dimStore
DBCC CHECKIDENT ('dbo.dimStore', RESEED, 1);
GO
SET IDENTITY_INSERT dbo.dimStore ON
INSERT INTO dbo.dimStore(
 dimStoreKey,
 StoreID,
 StoreNumber,
 StoreName,
 StoreManager,
 PhoneNumber,
 LocationID,
 CreatedDate,
 CreatedBy,
 ModifiedDate,
 ModifiedBy
)
VALUES(
-1,
0,
0,
'Unknown',
'Unknown',
'Unknown',
-1,
0,
'Unknown',
0,
'Unknown'
);
SET IDENTITY_INSERT dbo.dimStore OFF

INSERT INTO dbo.dimStore(
 StoreID,
 StoreNumber,
 StoreName,
 StoreManager,
 PhoneNumber,
 LocationID,
 CreatedDate,
 CreatedBy,
 ModifiedDate,
 ModifiedBy
)
SELECT S.StoreID,
 S.StoreNumber,
 'Store Number '+LTRIM(STR(S.StoreNumber)),
 S.StoreManager,
 S.PhoneNumber,
 L.dimLocationID,
 S.CreatedDate,
 S.CreatedBy,
 S.ModifiedDate,
 S.ModifiedBy
FROM dbo.StageStore S
JOIN dbo.dimLocation L ON L.Address = S.Address


--Load dimCustomer

SET IDENTITY_INSERT dbo.dimCustomer ON
INSERT INTO dbo.dimCustomer(
 dimCustomerKey,
 CustomerID,
 FirstName,
 LastName,
 Gender,
 EmailAddress,
 PhoneNumber,
 LocationID,
 CreatedDate,
 CreatedBy,
 ModifiedDate,
 ModifiedBy
)
VALUES(
-1,
'00000000-0000-0000-0000-000000000000',
'Unknown',
'Unknown',
'N',
'Unknown',
'Unknown',
-1,
0,
'Unknown',
0,
'Unknown'
);
SET IDENTITY_INSERT dbo.dimCustomer OFF

DBCC CHECKIDENT ('dbo.dimCustomer', RESEED, 0);
GO

INSERT INTO dbo.dimCustomer(
 CustomerID,
 FirstName,
 LastName,
 Gender,
 EmailAddress,
 PhoneNumber,
 LocationID,
 CreatedDate,
 CreatedBy,
 ModifiedDate,
 ModifiedBy
)
SELECT C.CustomerID,
	C.FirstName,
	C.LastName,
	C.Gender,
	C.EmailAddress,
	C.PhoneNumber,
	L.dimLocationID,
	C.CreatedDate,
	C.CreatedBy,
	C.ModifiedDate,
	C.ModifiedBy
FROM dbo.StageCustomer C
JOIN dimLocation L ON L.Address = C.Address

DELETE FROM dimDate
--Load yearly dates
DBCC CHECKIDENT ('dbo.dimDate', RESEED, 0);
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'InsDimDateYearly')
BEGIN
	DROP PROCEDURE dbo.InsDimDateYearly;
END
GO

CREATE PROC [dbo].[InsDimDateYearly]
( 
	@Year INT=NULL
)
AS
SET NOCOUNT ON;

DECLARE @Date DATE, @FirstDate Date, @LastDate Date;

SELECT @Year=COALESCE(@Year,YEAR(DATEADD(d,1,MAX(DimDateID)))) FROM dbo.DimDate;

SET @FirstDate=DATEFROMPARTS(COALESCE(@Year,YEAR(GETDATE())-1), 01, 01); -- First Day of the Year
SET @LastDate=DATEFROMPARTS(COALESCE(@Year,YEAR(GETDATE())-1), 12, 31); -- Last Day of the Year

SET @Date=@FirstDate;
-- create CTE with all dates needed for load
;WITH DateCTE AS
(
SELECT @FirstDate AS StartDate -- earliest date to load in table
UNION ALL
SELECT DATEADD(day, 1, StartDate)
FROM DateCTE -- recursively select the date + 1 over and over
WHERE DATEADD(day, 1, StartDate) <= @LastDate -- last date to load in table
)

-- load date dimension table with all dates
INSERT INTO dbo.DimDate 
	(
	FullDate 
	,DayNumberOfWeek 
	,DayNameOfWeek 
	,DayNumberOfMonth 
	,DayNumberOfYear 
	,WeekdayFlag
	,WeekNumberOfYear 
	,[MonthName] 
	,MonthNumberOfYear 
	,CalendarQuarter 
	,CalendarYear 
	,CalendarSemester
	,CreatedDate
	,CreatedBy
	,ModifiedDate
	,ModifiedBy 
	)
SELECT 
	 CAST(StartDate AS DATE) AS FullDate
	,DATEPART(dw, StartDate) AS DayNumberOfWeek
	,DATENAME(dw, StartDate) AS DayNameOfWeek
	,DAY(StartDate) AS DayNumberOfMonth
	,DATEPART(dy, StartDate) AS DayNumberOfYear
	,CASE DATENAME(dw, StartDate) WHEN 'Saturday' THEN 0 WHEN 'Sunday' THEN 0 ELSE 1 END AS WeekdayFlag
	,DATEPART(wk, StartDate) AS WeekNumberOfYear
	,DATENAME(mm, StartDate) AS [MonthName]
	,MONTH(StartDate) AS MonthNumberOfYear
	,DATEPART(qq, StartDate) AS CalendarQuarter
	,YEAR(StartDate) AS CalendarYear
	,(CASE WHEN MONTH(StartDate)>=1 AND MONTH(StartDate) <=6 THEN 1 ELSE 2 END) AS CalendarSemester
	,DATEADD(dd,DATEDIFF(dd,GETDATE(), '2013-01-01'),GETDATE()) AS CreatedDate
	,'company\SQLServerServiceAccount' AS CreatedBy
	,NULL AS ModifiedDate
	,NULL AS ModifiedBy
FROM DateCTE
OPTION (MAXRECURSION 0);-- prevents infinate loop from running more than once
GO

-- ========================================================================
-- Execute the procedure for 2013 and 2014 (those are the years you need)
-- ========================================================================
EXEC InsDimDateYearly 2013

EXEC InsDimDateYearly 2014
SELECT * FROM dimDate;
DELETE FROM factTargetProduct;
--Load factTargetProduct
DBCC CHECKIDENT ('dbo.factTargetProduct', RESEED, 0);
GO

INSERT INTO dbo.factTargetProduct(
 dimDateID,
 TargetProductYear,
 dimProductKey,
 [SalesQuantityTarget ]
)
SELECT D.dimDateID,TP.Year,P.dimProductKey,(CAST(TP.[ SalesQuantityTarget ] AS DECIMAL(18,6))/365)
FROM StageProductTarget TP
JOIN dimDate D ON D.CalendarYear = TP.Year
JOIN dimProduct P ON TP.ProductID = P.ProductID
SELECT * FROM factTargetProduct;


DELETE FROM factTargetChannel;
--Load factTargetChannel
DBCC CHECKIDENT ('dbo.factTargetChannel', RESEED, 0);
GO

INSERT INTO factTargetChannel(
 dimDateID,
 TargetChannelYear,
 dimChannelKey,
 dimStoreKey,
 dimResellerKey,
 TargetSalesAmount
)
SELECT 
D.dimDateID,
TC.Year,
ISNULL(CH.dimChannelKey,-1),
ISNULL(S.dimStoreKey,-1),
ISNULL(R.dimResellerKey,-1),
(CAST(TC.[ TargetSalesAmount ] AS DECIMAL(18,6))/365)
FROM StageChannelTarget TC
JOIN dimDate D ON D.CalendarYear = TC.Year
LEFT JOIN dimChannel CH ON '%'+RIGHT(TC.ChannelName,4)+'%' LIKE '%'+RIGHT(CH.ChannelName,4)+'%'
LEFT JOIN dimStore S ON '%'+RIGHT(TC.TargetName,2)+'%' LIKE '%'+RIGHT(S.StoreName,2)+'%'
LEFT JOIN dimReseller R ON '%'+RIGHT(R.ResellerName,8)+'%' LIKE '%'+RIGHT(TC.TargetName,8)+'%'

select * FROM factTargetChannel;

--Load factSalesDetail
/* Insert default values
then reseed 0 
then insert normal values
*/
	DBCC CHECKIDENT ('dbo.factSalesDetail', RESEED, 0);
	GO
	
	INSERT INTO dbo.factSalesDetail(
	 dimDateID,
	 SalesQuantity,
	 SalesAmount,
	 dimProductKey,
	 Cost,
	 Profit,
	 dimChannelKey,
	 dimStoreKey,
	 dimCustomerKey,
	 dimResellerKey,
	 LocationID,
	 CreatedDate,
	 CreatedBy,
	 ModifiedDate,
	 ModifiedBy
	)
	SELECT D.dimDateID,SD.SalesQuantity,SD.SalesAmount,
	 P.dimProductKey,
	 P.Cost,
	 (SD.SalesAmount - P.Cost*SD.SalesQuantity),
	 CH.dimChannelKey,
	 ISNULL(S.dimStoreKey,-1),
	 ISNULL(C.dimCustomerKey,-1),
	 ISNULL(R.dimResellerKey,-1),
	 L.dimLocationID,
	 SD.CreatedDate,
	 SD.CreatedBy,
	 SD.ModifiedDate,
	 SD.ModifiedBy
	FROM StageSalesHeader SH
	JOIN dimDate D ON D.FullDate = SH.Date
	JOIN StageSalesDetail SD ON SD.SalesHeaderID = SH.SalesHeaderID
	JOIN dimProduct P ON SD.ProductID = P.ProductID
	JOIN dimChannel CH ON CH.ChannelID = SH.ChannelID
	FULL OUTER JOIN dimStore S ON S.StoreID = SH.StoreID
	FULL OUTER JOIN dimCustomer C ON C.CustomerID = SH.CustomerID
	FULL OUTER JOIN dimReseller R ON R.ResellerID = SH.ResellerID
	FULL OUTER JOIN dimLocation L ON L.dimLocationID = R.LocationID OR L.dimLocationID = S.LocationID OR L.dimLocationID = C.LocationID
	WHERE SH.ResellerID IS NOT NULL OR SH.StoreID IS NOT NULL OR SH.CustomerID IS NOT NULL

	SELECT * FROM dimDate;


	--Create Views

IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'dimChannelView')
BEGIN
 DROP VIEW dimChannelView;
END
GO

IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'dimCustomerView')
BEGIN
 DROP VIEW dimCustomerView;
END
GO

IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'dimDateView')
BEGIN
 DROP VIEW dimDateView;
END
GO

IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'dimLocationView')
BEGIN
 DROP VIEW dimLocationView;
END
GO

IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'dimProductView')
BEGIN
 DROP VIEW dimProductView;
END
GO

IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'dimResellerView')
BEGIN
 DROP VIEW dimResellerView;
END
GO

IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'dimStoreView')
BEGIN
 DROP VIEW dimStoreView;
END
GO

IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'factSalesDetailView')
BEGIN
 DROP VIEW factSalesDetailView;
END
GO

IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'vfactTargetChannel')
BEGIN
 DROP VIEW vfactTargetChannel;
END
GO

IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'vfactTargetProduct')
BEGIN
 DROP VIEW vfactTargetProduct;
END
GO

CREATE VIEW vdimChannel AS
SELECT [dimChannelKey]
      ,[ChannelID]
      ,[ChannelCategoryID]
      ,[ChannelName]
      ,[ChannelCategory]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy]
  FROM [dbo].[dimChannel]
GO



CREATE VIEW vdimCustomer AS
SELECT [dimCustomerKey]
      ,[CustomerID]
      ,[FirstName]
      ,[LastName]
      ,[Gender]
      ,[EmailAddress]
      ,[PhoneNumber]
      ,[LocationID]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy]
  FROM [dbo].[dimCustomer]
GO

CREATE VIEW vdimDate AS
SELECT [dimDateID]
      ,[FullDate]
      ,[DayNumberOfWeek]
      ,[DayNameOfWeek]
      ,[DayNumberOfMonth]
      ,[DayNumberOfYear]
      ,[WeekdayFlag]
      ,[WeekNumberOfYear]
      ,[MonthName]
      ,[MonthNumberOfYear]
      ,[CalendarQuarter]
      ,[CalendarYear]
      ,[CalendarSemester]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy]
  FROM [dbo].[dimDate]
GO

CREATE VIEW vdimLocation AS
SELECT [dimLocationID]
      ,[Address]
      ,[City]
      ,[StateProvince]
      ,[Country]
      ,[PostalCode]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy]
  FROM [dbo].[dimLocation]
GO


CREATE VIEW vdimProduct AS
SELECT [dimProductKey]
      ,[ProductID]
      ,[Product]
      ,[ProductTypeID]
      ,[ProductType]
      ,[ProductCategoryID]
      ,[ProductCategory]
      ,[Color]
      ,[Style]
      ,[Weight]
      ,[Price]
      ,[Cost]
      ,[WholesalePrice]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy]
  FROM [dbo].[dimProduct]
GO

CREATE VIEW vdimReseller AS
SELECT [dimResellerKey]
      ,[ResellerID]
      ,[ResellerName]
      ,[Contact]
      ,[EmailAddress]
      ,[LocationID]
      ,[PhoneNumber]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy]
  FROM [dbo].[dimReseller]
GO

CREATE VIEW vdimStore AS 
SELECT [dimStoreKey]
      ,[StoreID]
      ,[StoreNumber]
      ,[StoreName]
      ,[StoreManager]
      ,[PhoneNumber]
      ,[LocationID]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy]
  FROM [dbo].[dimStore]
GO

CREATE VIEW vfactSalesDetail AS
SELECT [SalesDetailID]
      ,[dimDateID]
      ,[SalesQuantity]
      ,[SalesAmount]
      ,[dimProductKey]
      ,[Cost]
      ,[Profit]
      ,[dimChannelKey]
      ,[dimStoreKey]
      ,[dimCustomerKey]
      ,[dimResellerKey]
      ,[LocationID]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy]
  FROM [dbo].[factSalesDetail]
GO



CREATE VIEW vfactTargetChannel AS
SELECT [TargetChannelID]
      ,[dimDateID]
      ,[TargetChannelYear]
      ,[dimChannelKey]
      ,[dimStoreKey]
      ,[dimResellerKey]
      ,[TargetSalesAmount]
  FROM [dbo].[factTargetChannel]
GO



CREATE VIEW vfactTargetProduct AS
SELECT [TargetProductID]
      ,[dimDateID]
      ,[TargetProductYear]
      ,[dimProductKey]
      ,[SalesQuantityTarget ]
  FROM [dbo].[factTargetProduct]
GO


SELECT * FROM vfactTargetProduct

SELECT * FROM vfactTargetChannel

SELECT * FROM vfactSalesDetail