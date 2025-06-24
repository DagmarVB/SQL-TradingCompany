USE [TradingGmbH]
GO

/****** Object:  Trigger [dbo].[tr_AktienkursINSERT]    Script Date: 24.02.2023 13:34:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		MM
-- Create date: <Create Date,,>
-- Description:	Wenn ein neuer Aktienkurs in die Tabelle kommt, wird geprüft,
--	ob die Kursbewegung relevant genug ist, um einen Trade darauf einzugehen.
--  Falls ja, wird der Tradetyp ermittelt und ein neuer Eintrag in der Trade Tabelle erstellt.
-- =============================================

CREATE OR ALTER TRIGGER [dbo].[tr_AktienkursINSERT]
   ON [dbo].[Aktienkurs] 
   FOR INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @AktienID bigint;
	DECLARE @Datum date;
	DECLARE @TradetypID bigint;
	DECLARE @TradeID bigint;
	--DECLARE @TradeID_LAST bigint;

	DECLARE @AktienkursID bigint;
	DECLARE @AktienkursID_update bigint;
	DECLARE @Feedback VARCHAR(MAX);
	DECLARE @KursAenderung_VOR decimal(6,2);
	DECLARE @KursAenderung_FOLGE decimal(6,2);
	DECLARE @Erfolg bit;
	DECLARE @Kauf bit;
	SELECT @Datum = Datum from inserted;
	SELECT @AktienID = AktienID from inserted;
	SELECT @AktienkursID = AktienkursID from inserted;
	SET @TradeID = [dbo].[sf_GetTradeID](@AktienID);
	IF @TradeID IS NOT NULL
		BEGIN
		-- Kursaenderung fuer Update und ADD Trade
		SET @Kursaenderung_VOR = dbo.sf_GetKursAenderungAmVortagProzent(@AktienID, @Datum);
		-- UPDATE TRADE
		SET @Kauf = [dbo].[sf_GetKauf](@TradeID);
			
		SET @Erfolg = 0;
		IF @Kursaenderung_VOR > 0 AND @Kauf = 1
			SET @Erfolg = 1;
		IF @Kursaenderung_VOR < 0 AND @Kauf = 0
			SET @Erfolg = 1;

		SET @AktienkursID_update = [dbo].[sf_GetAktienKursID](@AktienID, @TradeID);
		EXEC [dbo].[sp_UpdateTrade] @TradeID, @TradetypID, @AktienkursID_update, @KursAenderung_VOR ,@Erfolg, @Feedback OUTPUT
		--- ADD TRADE
		--SET @Kursaenderung_VOR = dbo.sf_GetKursAenderungAmVortagProzent(@AktienID, @Datum);
		IF @KursAenderung_VOR = 0
			BEGIN
				RETURN
			END
			ELSE
			BEGIN
				IF @KursAenderung_VOR >= 1 AND @KursAenderung_VOR < 2
				BEGIN
					SET @TradetypID = 1;
					SET @Kauf = [dbo].[sf_GetTradetyp](@TradetypID);
				END
				IF @KursAenderung_VOR >= 2
				BEGIN
					SET @TradetypID = 2;
					SET @Kauf = [dbo].[sf_GetTradetyp](@TradetypID);
				END
				IF @KursAenderung_VOR < 0 AND @KursAenderung_VOR > -2
				BEGIN
					SET @TradetypID = 3;
					SET @Kauf = [dbo].[sf_GetTradetyp](@TradetypID);
				END
				IF @KursAenderung_VOR <= -2
				BEGIN
					SET @TradetypID = 4;
					SET @Kauf = [dbo].[sf_GetTradetyp](@TradetypID);
				END
				SELECT @AktienkursID = AktienkursID from inserted;
			IF @TradetypID IS NOT NULL
			EXEC [dbo].[sp_AddTrade] @TradetypID, @AktienkursID, @Feedback OUTPUT
			ELSE
			RETURN
			END
		END
		ELSE
		BEGIN
			SET @Kursaenderung_VOR = dbo.sf_GetKursAenderungAmVortagProzent(@AktienID, @Datum);
			IF @KursAenderung_VOR = 0
			BEGIN
				RETURN
			END
			ELSE
			BEGIN
				IF @KursAenderung_VOR >= 1 AND @KursAenderung_VOR < 2
				BEGIN
					SET @TradetypID = 1;
					SET @Kauf = [dbo].[sf_GetTradetyp](@TradetypID);
				END
				IF @KursAenderung_VOR >= 2
				BEGIN
					SET @TradetypID = 2;
					SET @Kauf = [dbo].[sf_GetTradetyp](@TradetypID);
				END
				IF @KursAenderung_VOR < 0 AND @KursAenderung_VOR > -2
				BEGIN
					SET @TradetypID = 3;
					SET @Kauf = [dbo].[sf_GetTradetyp](@TradetypID);
				END
				IF @KursAenderung_VOR <= -2
				BEGIN
					SET @TradetypID = 4;
					SET @Kauf = [dbo].[sf_GetTradetyp](@TradetypID);
			END
			-- BEENDE BEI 0
			    -- Überprüfen, ob der Wert von @AktienkursID NULL ist
			  IF @AktienkursID IS NULL
			  BEGIN
				  RAISERROR('AktienkursID darf nicht NULL sein.', 16, 1);
				  RETURN;
			  END

			  IF EXISTS (SELECT @AktienID FROM inserted)
			  BEGIN
				DECLARE @MinAktienKursID INT
				SELECT @MinAktienKursID = MIN(AktienKursID) FROM Aktienkurs

				IF @AktienkursID = @MinAktienKursID
				BEGIN
				  SELECT 1 -- AktienKursID ist die erste in der Tabelle, nichts tun!
				END
				ELSE
				BEGIN
					IF @TradetypID IS NOT NULL
						EXEC [dbo].[sp_AddTrade] @TradetypID, @AktienkursID, @Feedback OUTPUT
					ELSE
					RETURN
				END
			END
			
			
			END
		END

--SELECT @Feedback AS 'Rückgabemeldung';
--RETURN
END

GO

ALTER TABLE [dbo].[Aktienkurs] ENABLE TRIGGER [tr_AktienkursINSERT]
GO


