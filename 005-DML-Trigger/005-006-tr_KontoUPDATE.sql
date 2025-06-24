USE [TradingGmbH]
GO

/****** Object:  Trigger [dbo].[tr_Konto_UPDATE]    Script Date: 24.02.2023 13:36:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		BA
-- Create date: <Create Date,,>
-- Description:	Logge Kontobewegungen (in diesem Fall Updates) in der KontoLOG Tabelle
-- =============================================

CREATE OR ALTER     TRIGGER [dbo].[tr_Konto_UPDATE] 
   ON [dbo].[Konto] 
   FOR UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
    

	SET NOCOUNT ON;

	 INSERT INTO dbo.KontoLog

			(KontoID, Art, Datum, KontostandAlt, KontostandNeu)
			


	SELECT  KontoID, 'U',  
		
			(SELECT getdate() FROM inserted),
			(SELECT Kontostand FROM deleted), -- Wert alt
			(SELECT Kontostand FROM inserted) -- Wert neu
	FROM deleted;

    -- Insert statements for trigger here

END
GO

ALTER TABLE [dbo].[Konto] ENABLE TRIGGER [tr_Konto_UPDATE]
GO


