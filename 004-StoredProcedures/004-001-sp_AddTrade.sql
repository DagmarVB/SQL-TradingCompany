USE [TradingGmbH]
GO

/****** Object:  StoredProcedure [dbo].[sp_AddTrade]    Script Date: 24.02.2023 13:43:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author: DVB
-- Create date: 21.02.2023
-- Description: Prozedur erstellt neuen Eintrag in Tabelle Trade
-- =============================================

CREATE OR ALTER       PROCEDURE [dbo].[sp_AddTrade]

	@TradetypID bigint,
	@AktienkursID bigint,


	--------
	@Feedback VARCHAR(MAX) OUTPUT -- Fehlermeldungen etc.
	AS
	BEGIN

	SET NOCOUNT ON;

	BEGIN TRY

	INSERT INTO [dbo].[Trade]
			([TradetypID], [AktienkursID])
		VALUES (@TradetypID, @AktienkursID);
	SET @Feedback = 'Neuer Eintrag in Tabelle TRADE wurde erstellt.';
	END TRY

	BEGIN CATCH 
	SET @Feedback = CHAR(10) + 'Fehler beim Erstellen eines neuen Eintrags in Tabelle TRADE! ' + ERROR_MESSAGE();
	END CATCH
END
GO


