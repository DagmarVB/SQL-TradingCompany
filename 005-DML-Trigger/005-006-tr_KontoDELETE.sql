USE [TradingGmbH]
GO

/****** Object:  Trigger [dbo].[tr_Konto_DELETE]    Script Date: 24.02.2023 13:35:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		BA
-- Create date: <Create Date,,>
-- Description:	Logge Kontobewegungen (in diesem Fall Löschungen) in der KontoLOG Tabelle
-- =============================================

CREATE OR ALTER      TRIGGER [dbo].[tr_Konto_DELETE] 
   ON [dbo].[Konto] 
   FOR DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
    

	SET NOCOUNT ON;

	

	 INSERT INTO dbo.KontoLog
			(KontoID, Art, Datum)
	SELECT  KontoID, 'D', getdate()

	FROM deleted;

	
	
	

    -- Insert statements for trigger here

END
GO

ALTER TABLE [dbo].[Konto] ENABLE TRIGGER [tr_Konto_DELETE]
GO


