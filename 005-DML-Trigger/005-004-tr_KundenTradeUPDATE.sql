USE [TradingGmbH]
GO

/****** Object:  Trigger [dbo].[tr_KundenGewinnUPDATE]    Script Date: 24.02.2023 13:37:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		BA
-- Create date: 23.02.2023
-- Description:	Wenn KundenTrade Eintr‰ge ge‰ndert werden
-- (das heiﬂt, ein Trade wurde abgeschlossen und ausgewertet),
-- dann aktualisiere die Kontost‰nde der teilnemhenden Kunden mit dem Gewinn oder Verlust aus dem Trade
-- =============================================

CREATE OR ALTER     TRIGGER [dbo].[tr_KundenTradeUPDATE] 
 ON  [dbo].[KundenTrade] 
   FOR UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @currentKontostand money;
	DECLARE @currentGewinnVerlust money;
	DECLARE @currentKundenID bigint;


	SELECT @currentGewinnVerlust= GewinnVerlust FROM inserted;
	SELECT @currentKundenID= KundenID FROM inserted;


	SELECT @currentKontostand = neu.Kontostand 
		FROM inserted AS alt INNER JOIN Konto AS neu ON alt.KundenID = neu.KundenID;



	SET @currentKontostand =  (@currentKontostand + @currentGewinnVerlust)



	UPDATE Konto 
		SET Kontostand = @currentKontostand
		WHERE KundenID= @currentKundenID;

			

END
GO

ALTER TABLE [dbo].[KundenTrade] ENABLE TRIGGER [tr_KundenGewinnUPDATE]
GO


