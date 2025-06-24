USE [TradingGmbH]
GO

/****** Object:  Trigger [dbo].[tr_Trade_Insert]    Script Date: 24.02.2023 13:39:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		DVB
-- Create date: 22.02.2023
-- Description:	Wenn in Tabelle Trade ein neuer Eintrag erstellt wird,
-- soll Prozedur sp_AddKundenTrade aufgerufen werden,
-- die neue Einträge in Tabelle KundenTrade erstellt
-- =============================================

CREATE OR ALTER   TRIGGER [dbo].[tr_Trade_Insert]
   ON  [dbo].[Trade]
   AFTER INSERT
AS 
BEGIN
	
	SET NOCOUNT ON;

	DECLARE	@TradeID bigint
	DECLARE @Mindestguthaben money

	SELECT @TradeID = TradeID FROM inserted
	SELECT @Mindestguthaben = dbo.Tradetyp.Mindestguthaben
		FROM dbo.Trade INNER JOIN
           dbo.Tradetyp ON dbo.Trade.TradetypID = dbo.Tradetyp.TradetypID
		WHERE dbo.Tradetyp.TradetypID = (SELECT TradetypID FROM inserted)

	EXEC [dbo].[sp_AddKundenTrade] @TradeID,@Mindestguthaben

END
GO

ALTER TABLE [dbo].[Trade] ENABLE TRIGGER [tr_Trade_Insert]
GO


