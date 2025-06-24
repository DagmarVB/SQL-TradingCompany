USE [TradingGmbH]
GO

/****** Object:  UserDefinedFunction [dbo].[sf_GetTradeID]    Script Date: 24.02.2023 13:51:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER        FUNCTION [dbo].[sf_GetTradeID](@AktienID bigint)

RETURNS bigint

AS
BEGIN
	DECLARE @TradeID bigint;

		SELECT @TradeID = Trade.TradeID
		FROM dbo.Aktie INNER JOIN
			 dbo.Aktienkurs ON dbo.Aktie.AktienID = dbo.Aktienkurs.AktienID INNER JOIN
			 dbo.Trade ON dbo.Aktienkurs.AktienkursID = dbo.Trade.AktienkursID
		WHERE Trade.Kursaenderung IS NULL AND Aktie.AktienID = @AktienID 

	RETURN @TradeID
END;
GO


