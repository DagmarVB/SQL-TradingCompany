USE [TradingGmbH]
GO

/****** Object:  UserDefinedFunction [dbo].[sf_GetAktienIDFromAktienkurs]    Script Date: 24.02.2023 13:48:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER     FUNCTION [dbo].[sf_GetAktienIDFromAktienkurs]
(
  @AktienkursID bigint
)
RETURNS bigint
AS
BEGIN
	DECLARE @AktienID bigint;
	BEGIN
	SELECT @AktienID = Aktienkurs.AktienID FROM Aktienkurs WHERE AktienkursID=@AktienkursID;

	END
    IF @AktienkursID IS NOT NULL
    BEGIN
      RETURN @AktienID
    END

  
  RETURN NULL
END
GO


