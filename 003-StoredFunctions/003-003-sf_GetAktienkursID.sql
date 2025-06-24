USE [TradingGmbH]
GO

/****** Object:  UserDefinedFunction [dbo].[sf_GetAktienKursID]    Script Date: 24.02.2023 13:49:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   FUNCTION [dbo].[sf_GetAktienKursID](@AktienID bigint, @TradeID bigint)
RETURNS bigint
AS
BEGIN

	DECLARE @AktienkursID bigint;
	SELECT @AktienkursID =  Aktienkurs.AktienkursID
		FROM dbo.Aktie INNER JOIN
			dbo.Aktienkurs ON dbo.Aktie.AktienID = dbo.Aktienkurs.AktienID INNER JOIN
			dbo.Trade ON dbo.Aktienkurs.AktienkursID = dbo.Trade.AktienkursID
		WHERE Aktie.AktienID = @AktienID AND Trade.TradeID = @TradeID
	RETURN @AktienkursID
END;
GO


