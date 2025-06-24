USE [TradingGmbH]
GO

/****** Object:  UserDefinedFunction [dbo].[sf_GetTradetyp]    Script Date: 24.02.2023 13:51:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER       FUNCTION [dbo].[sf_GetTradetyp](@TradetypID int)

RETURNS bit
AS
BEGIN

	DECLARE @Kauf bit;
		SELECT @Kauf = Tradetyp.Kauf
		FROM Tradetyp 
		WHERE Tradetyp.TradetypID=@TradetypID 
	RETURN @Kauf;

END;
GO


