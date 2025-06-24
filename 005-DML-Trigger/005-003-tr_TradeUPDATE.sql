USE [TradingGmbH]
GO

/****** Object:  Trigger [dbo].[tr_Trade_Update]    Script Date: 24.02.2023 13:39:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		DVB
-- Create date: 22.02.2023
-- Description:	Wenn in Tabelle Trade ein Eintrag aktualisiert wird (update 'Erfolg', 'Kursaenderung'),
-- soll Prozedur sp_UpdateKundenTrade aufgerufen werden,
-- die in der Tabelle KundenTrade die Spalte GewinnVerlust füllt.
-- =============================================

CREATE OR ALTER        TRIGGER [dbo].[tr_Trade_Update]
   ON  [dbo].[Trade]
   FOR UPDATE
AS 
BEGIN
	
	SET NOCOUNT ON;

	DECLARE	@TradeID bigint;

	SELECT @TradeID = TradeID FROM inserted;

	EXEC [dbo].[sp_UpdateKundenTrade] @TradeID

END
GO

ALTER TABLE [dbo].[Trade] ENABLE TRIGGER [tr_Trade_Update]
GO


