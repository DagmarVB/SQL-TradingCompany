USE [TradingGmbH]
GO

/****** Object:  UserDefinedFunction [dbo].[sf_Zeitstempel]    Script Date: 24.02.2023 13:52:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		AD
-- Create date: 22.02.2023
-- Description:	Die Funktion generiert so was: 20210105-105151150
-- =============================================
CREATE OR ALTER       FUNCTION [dbo].[sf_Zeitstempel] 
(
)
RETURNS char(18)
AS
BEGIN
	

	RETURN FORMAT(GETDATE(), 'yyyyMMdd-HHmmssfff');

END
GO


