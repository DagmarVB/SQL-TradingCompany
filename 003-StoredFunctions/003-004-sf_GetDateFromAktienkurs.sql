USE [TradingGmbH]
GO

/****** Object:  UserDefinedFunction [dbo].[sf_GetDateFromAktienkurs]    Script Date: 24.02.2023 13:49:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER       FUNCTION [dbo].[sf_GetDateFromAktienkurs]
(
  @AktienkursID bigint
)
RETURNS date
AS
BEGIN
	DECLARE @Datum date;
	BEGIN
		SELECT @Datum = Aktienkurs.Datum
		FROM Aktienkurs
		WHERE AktienkursID=@AktienkursID;
	END
    IF @AktienkursID IS NOT NULL
    BEGIN
      RETURN @Datum
    END

  
  RETURN NULL
END
GO


