USE [TradingGmbH]
GO

/****** Object:  UserDefinedFunction [dbo].[sf_GetLetztesDatum]    Script Date: 24.02.2023 13:51:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER          FUNCTION [dbo].[sf_GetLetztesDatum](@AktienID bigint)

RETURNS Date
AS
BEGIN
	DECLARE @LetztesDatum date;

		SELECT @LetztesDatum = MAX(Datum)
		FROM Aktienkurs
		WHERE AktienID =@AktienID

	RETURN @LetztesDatum

END;
GO


