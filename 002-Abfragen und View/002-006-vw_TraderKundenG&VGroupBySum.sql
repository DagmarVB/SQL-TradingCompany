USE [TradingGmbH]
GO

/****** Object:  View [dbo].[vw_Trader_Kunden_G&V_GroupBy_Sum]    Script Date: 24.02.2023 13:59:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER   VIEW [dbo].[vw_Trader_Kunden_G&V_GroupBy_Sum]
AS
SELECT        TOP (100) PERCENT dbo.Trader.TraderID AS [Trader-TraderID], dbo.Trader.PersonID AS [Trader-PersonID], Person_1.Vorname AS [Trader-Vorname], Person_1.Name AS [Trader-Nachname], 
                         dbo.Kunde.TraderID AS [Kunde-TraderID], dbo.Kunde.PersonID AS [Kunde-PersonID], dbo.Kunde.KundenID AS [Kunde-KundenID], dbo.Person.Vorname AS [Kunde-Vorname], dbo.Person.Name AS [Kunde-Nachname], 
                         SUM(dbo.KundenTrade.GewinnVerlust) AS [Gewinn/ Verlust]
FROM            dbo.Kunde INNER JOIN
                         dbo.KundenTrade ON dbo.Kunde.KundenID = dbo.KundenTrade.KundenID INNER JOIN
                         dbo.Person ON dbo.Kunde.PersonID = dbo.Person.PersonID INNER JOIN
                         dbo.Trader ON dbo.Kunde.TraderID = dbo.Trader.TraderID INNER JOIN
                         dbo.Person AS Person_1 ON dbo.Trader.PersonID = Person_1.PersonID
GROUP BY dbo.Trader.TraderID, dbo.Trader.PersonID, Person_1.Vorname, Person_1.Name, dbo.Kunde.TraderID, dbo.Kunde.PersonID, dbo.Kunde.KundenID, dbo.Person.Vorname, dbo.Person.Name
ORDER BY [Trader-Nachname], [Kunde-Nachname]
GO


