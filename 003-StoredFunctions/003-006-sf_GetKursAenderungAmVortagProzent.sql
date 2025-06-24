USE [TradingGmbH]
GO

/****** Object:  UserDefinedFunction [dbo].[sf_GetKursAenderungAmVortagProzent]    Script Date: 24.02.2023 13:50:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER     FUNCTION [dbo].[sf_GetKursAenderungAmVortagProzent]

(
  @AktienID int,
  @Datum date
)

RETURNS float
AS
BEGIN
  DECLARE @VortagKurs decimal(6,2)
  
	  SELECT TOP 1 @VortagKurs = Kurs
	  FROM Aktienkurs
	  WHERE AktienID = @AktienID AND Datum < @Datum
	  ORDER BY Datum DESC
  
  IF @VortagKurs IS NOT NULL
  BEGIN
    DECLARE @Kurs decimal(6,2)
  
		SELECT TOP 1 @Kurs = Kurs
		FROM Aktienkurs
		WHERE AktienID = @AktienID AND Datum = @Datum
  
    IF @Kurs IS NOT NULL
    BEGIN
      RETURN ROUND(((@Kurs - @VortagKurs) / @VortagKurs) * 100, 2)
    END
  END
  
  RETURN NULL
END
GO


