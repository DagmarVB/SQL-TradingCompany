USE [TradingGmbH]
GO

/****** Object:  View [dbo].[vw_Kunde_hat_diese_Aktien_gehandelt]    Script Date: 24.02.2023 13:58:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER   VIEW [dbo].[vw_Kunde_hat_diese_Aktien_gehandelt]
AS
SELECT        TOP (100) PERCENT dbo.Kunde.KundenID AS [Kunde.KundenID], dbo.Person.Vorname AS [Person.Vorname], dbo.Person.Name AS [Person.Name], dbo.Aktie.Bezeichnung AS Aktie
FROM            dbo.Kunde INNER JOIN
                         dbo.KundenTrade ON dbo.Kunde.KundenID = dbo.KundenTrade.KundenID INNER JOIN
                         dbo.Trade ON dbo.KundenTrade.TradeID = dbo.Trade.TradeID INNER JOIN
                         dbo.Aktienkurs ON dbo.Trade.AktienkursID = dbo.Aktienkurs.AktienkursID INNER JOIN
                         dbo.Aktie ON dbo.Aktienkurs.AktienID = dbo.Aktie.AktienID INNER JOIN
                         dbo.Person ON dbo.Kunde.PersonID = dbo.Person.PersonID
WHERE        (dbo.Aktie.Ticker = N'TSLA')
GROUP BY dbo.Kunde.KundenID, dbo.Person.Vorname, dbo.Person.Name, dbo.Aktie.Bezeichnung
ORDER BY [Kunde.KundenID]
GO


