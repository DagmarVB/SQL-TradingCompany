USE [TradingGmbH]
GO

/****** Object:  UserDefinedFunction [dbo].[tf_Kunden_fuer_Trade]    Script Date: 24.02.2023 13:47:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		DVB
-- Create date: 21.02.2023
-- Description:	GET alle Kunden, die ausreichend Kontostand haben, um zu traden
-- Die Funktion tf_Kunden_fuer_Trade bekommt als Eingabeparameter einen €-Wert Mindestguthaben und eine TraderID
-- und soll als Ergebnis alle Kunden liefern, deren Kontostand >= Mindestguthaben ist und die der TraderID zugeordnet sind
-- =============================================

CREATE OR ALTER         FUNCTION [dbo].[tf_Kunden_fuer_Trade] 
(
	@TraderID bigint,
	@Mindestguthaben money
)

RETURNS TABLE
AS
RETURN

(
	SELECT Konto.KundenID
		FROM Konto INNER JOIN Kunde ON Konto.KundenID=Kunde.KundenID
		WHERE Kontostand>=@Mindestguthaben AND TraderID=@TraderID
);

GO


