USE [TradingGmbH]
GO

/****** Object:  StoredProcedure [dbo].[sp_UpdateKundenTrade]    Script Date: 24.02.2023 13:44:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		DVB
-- Create date: 22.02.2023
-- Description:	Prozedur, die Eintr�ge in Tabelle KundenTrade aktualisiert.
-- Wenn ein Trade abgeschlossen und ausgewertet wird, berechnen wir f�r alle zugeh�rigen KundenTrades den Gewinn oder Verlust.
-- =============================================

CREATE OR ALTER              PROCEDURE [dbo].[sp_UpdateKundenTrade]
	@TradeID bigint

AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @KundenID bigint 
	DECLARE @GewinnVerlust money	-- F�r UPDATE KundenTrade nach Abwicklung des Trades
	DECLARE @Kauf bit				-- f�r Aufruf von sf_GetKauf
	DECLARE @Multiplikator int		-- um GewinnVerlust positiv oder negativ zu setzen
	DECLARE @Kursaenderung decimal(6,2)-- um zu pr�fen, ob Kurs�nderung positiv oder negativ ist
	---------------------------------------------------------------------------------

	DECLARE Cursor_Kunde CURSOR
		FOR
		SELECT dbo.KundenTrade.KundenID
		FROM dbo.KundenTrade
		WHERE dbo.KundenTrade.TradeID=@TradeID

		OPEN Cursor_Kunde;

		PRINT ' --------Anfang UPDATE----------';
			FETCH NEXT FROM Cursor_Kunde INTO @KundenID;
			WHILE @@FETCH_STATUS = 0
			BEGIN
						-- Pr�fe, ob der Kunde einen Gewinn oder einen Verlust gemacht hat und setzte Multiplikator entsprechend
						SET @Kauf = [dbo].[sf_GetKauf](@TradeID);
						SET @Kursaenderung = (SELECT dbo.Trade.Kursaenderung
												FROM dbo.Trade
												WHERE dbo.Trade.TradeID = @TradeID)

						-- wenn Kurs�nderung < 0 UND  Kauf = 0, dann Gewinn * (+1) (wir hatten beim Verkauf auf steigende Kurse gesetzt, der Kurs ist aber gestiegen.
						--		Somit hatte unser Trade keinen Erfolg und wir haben unseren Einsatz verloren
						-- wenn Kurs�nderung > 0 und Kauf = 1, dann Gewinn * (+1)
						-- wenn Kurs�nderung < 0 UND  Kauf = 1, dann Gewinn * (-1)
						-- wenn Kurs�nderung > 0 und Kauf = 0, dann Gewinn * (-1)
						IF (@Kursaenderung > 0 AND @Kauf = 1)
							SET @Multiplikator=1
						ELSE IF (@Kursaenderung < 0 AND @Kauf = 0)
							SET @Multiplikator=-1
						ELSE IF (@Kursaenderung > 0 AND @Kauf = 0)
							SET @Multiplikator=-1
						ELSE IF (@Kursaenderung < 0 AND @Kauf = 1)
							SET @Multiplikator=1
						ELSE SET @Multiplikator=0

						---Ermittle GewinnVerlust f�r @KundenID und @TradeID und aktualisiere entsprechenden Eintrag in KundenTrade Tabelle
						SET @GewinnVerlust = (SELECT dbo.Trade.Kursaenderung*dbo.KundenTrade.Positionsgroesse*@Multiplikator
												FROM dbo.Trade INNER JOIN
													dbo.KundenTrade ON dbo.Trade.TradeID = dbo.KundenTrade.TradeID
												WHERE dbo.KundenTrade.KundenID=@KundenID AND dbo.KundenTrade.TradeID=@TradeID
													) 
				
						Print CONCAT_WS(' ', @KundenID, @GewinnVerlust)
						UPDATE KundenTrade
							SET GewinnVerlust=@GewinnVerlust
							WHERE KundenID=@KundenID

						

				FETCH NEXT FROM Cursor_Kunde INTO @KundenID;
			END
		PRINT ' --------Ende UPDATE------------';
		CLOSE Cursor_Kunde;
		DEALLOCATE Cursor_Kunde; --Arbeitsspeicher freigeben
END
GO


