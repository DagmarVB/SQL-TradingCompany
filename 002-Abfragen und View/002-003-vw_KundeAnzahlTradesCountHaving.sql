USE [TradingGmbH]
GO

/****** Object:  View [dbo].[vw_Kunde_Anzahl_Trades_Count_Having]    Script Date: 24.02.2023 13:57:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER     VIEW [dbo].[vw_Kunde_Anzahl_Trades_Count_Having]
AS
SELECT        TOP (100) PERCENT dbo.Person.Name AS [Kunden-Name], dbo.Person.Vorname AS [Kunden-Vorname], COUNT(dbo.KundenTrade.KundenID) AS [Anzahl Trades]
FROM            dbo.Person INNER JOIN
                         dbo.Kunde ON dbo.Person.PersonID = dbo.Kunde.PersonID INNER JOIN
                         dbo.KundenTrade ON dbo.Kunde.KundenID = dbo.KundenTrade.KundenID
GROUP BY dbo.Person.Name, dbo.Person.Vorname
HAVING        (COUNT(dbo.KundenTrade.KundenID) > 1)
ORDER BY [Kunden-Name], [Kunden-Vorname]
GO


