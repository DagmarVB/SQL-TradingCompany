USE [TradingGmbH]
GO

/****** Object:  StoredProcedure [dbo].[sp_UpdateTrade]    Script Date: 24.02.2023 13:44:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author: MM
-- Create date: 21.02.2023
-- Description: Prozedur updated  Eintrag in Tabelle Trade.
-- Bei einem neuen Eintrag in der Aktienkurs Tabelle wird geprüft, ob es offene Trades zu dieser Aktie gibt.
-- Falls ja, werden die Trades an Hand des neuen Aktienkurses ausgewertet und der Erfolg ermittelt.
-- =============================================

CREATE OR ALTER         PROCEDURE [dbo].[sp_UpdateTrade]
	@TradeID bigint,
	@TradetypID bigint,
	@AktienkursID bigint,
	@Ergebnis decimal(6,2),
	@Erfolg bit,
	--------
	@Feedback VARCHAR(MAX) OUTPUT -- Fehlermeldungen etc.
AS
BEGIN

	SET NOCOUNT ON;

	BEGIN TRY
	-- Insert statements for procedure here
		UPDATE [dbo].[Trade]
		SET Erfolg = @Erfolg, Kursaenderung = @Ergebnis
			WHERE [AktienkursID]= @AktienkursID;
		SET @Feedback = 'Eintrag in Tabelle TRADE wurde geupdated.';
	END TRY

	BEGIN CATCH 
		SET @Feedback = CHAR(10) + 'Fehler beim Updaten eines neuen Eintrags in Tabelle TRADE! ' + ERROR_MESSAGE();
	END CATCH
END
GO


