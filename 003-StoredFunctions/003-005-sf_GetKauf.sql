USE [TradingGmbH]
GO

/****** Object:  UserDefinedFunction [dbo].[sf_GetKauf]    Script Date: 24.02.2023 13:49:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   FUNCTION [dbo].[sf_GetKauf](@TradeID int)

RETURNS bit
AS
	BEGIN
	DECLARE @Kauf bit;

		SELECT @Kauf= dbo.Tradetyp.Kauf
		FROM dbo.Trade INNER JOIN
			 dbo.Aktienkurs ON dbo.Trade.AktienkursID = dbo.Aktienkurs.AktienkursID INNER JOIN
			 dbo.Tradetyp ON dbo.Trade.TradetypID = dbo.Tradetyp.TradetypID
		WHERE (dbo.Trade.TradeID = @TradeID)

	RETURN @Kauf;
	END;
GO


