USE [TradingGmbH]
GO

/****** Object:  StoredProcedure [dbo].[sp_AddKundenTrade]    Script Date: 24.02.2023 13:42:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		DVB
-- Create date: 22.02.2023
-- Description:	Prozedur, die neue Eintr�ge in Tabelle KundenTrade schreibt.
-- Bei jedem neuen Eintrag in Trade Tabelle wird gepr�ft, welche Kunden am Trade teilnehmen k�nnen.
-- Ihr Trader muss die Aktie handeln und sie m�ssen ausreichend Guthaben auf dem Konto haben.
-- F�r alle Teilnehmenden Kunden wird dann ein Eintrag in KundenTrade erstellt.
-- =============================================
CREATE OR ALTER           PROCEDURE [dbo].[sp_AddKundenTrade]
	@TradeID bigint,
	@Mindestguthaben money

AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @TraderID bigint	-- um Kundenauswahl auf relevanten Trader zu beschr�nken
    DECLARE @KundenID bigint	-- F�r INSERT INTO KundenTrade
	DECLARE @Positionsgroesse money -- F�r INSERT INTO KundenTrade
	DECLARE @GewinnVerlust money	-- F�r INSERT INTO KundenTrade
	---------------------------------------------------------------------------------

	-- Ermittle relevante Trader IDs, d.h. diejenigen Trader, die die Aktie handeln, f�r die ein Trade erstellt wurde
	DECLARE Cursor_Trader CURSOR
		FOR
		SELECT dbo.AktieTrader.TraderID
		FROM dbo.AktieTrader INNER JOIN
             dbo.Trade INNER JOIN
             dbo.Aktienkurs ON dbo.Trade.AktienkursID = dbo.Aktienkurs.AktienkursID INNER JOIN
             dbo.Aktie ON dbo.Aktienkurs.AktienID = dbo.Aktie.AktienID ON dbo.AktieTrader.AktienID = dbo.Aktie.AktienID
		WHERE dbo.Trade.TradeID=@TradeID

		OPEN Cursor_Trader;

		PRINT ' --------Anfang TRADER----------';
			FETCH NEXT FROM Cursor_Trader INTO @TraderID;
			WHILE @@FETCH_STATUS = 0
			BEGIN

				-- F�r alle Kunden von @TraderID, die �ber ausreichend Guthaben verf�gen, soll ein Eintrag in der KundenTrade Tabelle erstellt werden
				DECLARE Cursor_Kunde CURSOR 
					FOR
					SELECT *
					FROM [dbo].[tf_Kunden_fuer_Trade](@TraderID,@Mindestguthaben)

				OPEN Cursor_Kunde;

				PRINT ' --------Anfang KUNDE----------';
					FETCH NEXT FROM Cursor_Kunde INTO @KundenID;
					WHILE @@FETCH_STATUS = 0
					BEGIN
						---Ermittle Positionsgr��e f�r @KundenID und @TradeID und erstelle neuen Eintrag in KundenTrade Tabelle
						SET @Positionsgroesse = (SELECT dbo.Konto.Kontostand * dbo.Tradetyp.Einsatz
													FROM dbo.Trader INNER JOIN
													 dbo.Konto INNER JOIN
													 dbo.Kunde ON dbo.Konto.KundenID = dbo.Kunde.KundenID ON dbo.Trader.TraderID = dbo.Kunde.TraderID INNER JOIN
													 dbo.AktieTrader ON dbo.Trader.TraderID = dbo.AktieTrader.TraderID INNER JOIN
													 dbo.Trade INNER JOIN
													 dbo.Tradetyp ON dbo.Trade.TradetypID = dbo.Tradetyp.TradetypID INNER JOIN
													 dbo.Aktienkurs ON dbo.Trade.AktienkursID = dbo.Aktienkurs.AktienkursID INNER JOIN
													 dbo.Aktie ON dbo.Aktienkurs.AktienID = dbo.Aktie.AktienID ON dbo.AktieTrader.AktienID = dbo.Aktie.AktienID
													WHERE dbo.Konto.KundenID=@KundenID AND dbo.Trade.TradeID=@TradeID
													) 

						Print CONCAT_WS(' ', @KundenID, @TradeID, @Positionsgroesse)
						INSERT INTO KundenTrade (KundenID, TradeID, Positionsgroesse)
							VALUES (@KundenID, @TradeID, @Positionsgroesse)

						FETCH NEXT FROM Cursor_Kunde INTO @KundenID;
					END
				PRINT ' --------Ende KUNDE------------';
				CLOSE Cursor_Kunde;
				DEALLOCATE Cursor_Kunde; --Arbeitsspeicher freigeben

				FETCH NEXT FROM Cursor_Trader INTO @TraderID;
			END
		PRINT ' --------Ende TRADER------------';
		CLOSE Cursor_Trader;
		DEALLOCATE Cursor_Trader; --Arbeitsspeicher freigeben
END
GO


