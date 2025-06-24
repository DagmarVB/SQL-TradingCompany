USE [TradingGmbH]
GO

/****** Object:  View [dbo].[vw_Kunden_Trades_Outer_Join]    Script Date: 24.02.2023 13:58:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER   VIEW [dbo].[vw_Kunden_Trades_Outer_Join]
AS
SELECT        TOP (100) PERCENT dbo.Kunde.KundenID, dbo.Person.Name, dbo.Person.Vorname, dbo.KundenTrade.TradeID AS KundenTradeID, dbo.Aktienkurs.AktienkursID, dbo.Aktienkurs.Datum AS [Aktienkurs-Datum], 
                         dbo.Trade.Kursaenderung
FROM            dbo.Kunde INNER JOIN
                         dbo.Person ON dbo.Kunde.PersonID = dbo.Person.PersonID LEFT OUTER JOIN
                         dbo.KundenTrade ON dbo.Kunde.KundenID = dbo.KundenTrade.KundenID LEFT OUTER JOIN
                         dbo.Trade ON dbo.KundenTrade.TradeID = dbo.Trade.TradeID LEFT OUTER JOIN
                         dbo.Aktienkurs ON dbo.Trade.AktienkursID = dbo.Aktienkurs.AktienkursID
ORDER BY dbo.Kunde.KundenID
GO


