USE [TradingGmbH]
GO

/****** Object:  View [dbo].[vw_Trader_und_Kunden_Zirkel]    Script Date: 24.02.2023 14:00:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER   VIEW [dbo].[vw_Trader_und_Kunden_Zirkel]
AS
SELECT        TOP (100) PERCENT dbo.Trader.TraderID AS [Trader ID (Trader)], dbo.Person.Vorname AS [Trader Vorname], dbo.Person.Name AS [Trader Name], dbo.Kunde.PersonID, dbo.Kunde.TraderID AS [Trader ID (Kunde)], 
                         Person_1.Vorname AS [Kunden Vorname], Person_1.Name AS [Kunden Name]
FROM            dbo.Trader INNER JOIN
                         dbo.Person ON dbo.Trader.PersonID = dbo.Person.PersonID INNER JOIN
                         dbo.Kunde ON dbo.Trader.TraderID = dbo.Kunde.TraderID INNER JOIN
                         dbo.Person AS Person_1 ON dbo.Kunde.PersonID = Person_1.PersonID
ORDER BY [Trader ID (Trader)]
GO


