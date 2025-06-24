USE [TradingGmbH]
GO

/****** Object:  Trigger [dbo].[tr_Konto_INSERT]    Script Date: 24.02.2023 13:36:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER    TRIGGER [dbo].[tr_Konto_INSERT] 
   ON [dbo].[Konto] 
   FOR INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
    

	SET NOCOUNT ON;

	 INSERT INTO dbo.KontoLog
			(KontoID, Art, Datum)
	SELECT  KontoID, 'I', getdate()

	FROM inserted;
	 
	

    -- Insert statements for trigger here

END
GO

ALTER TABLE [dbo].[Konto] ENABLE TRIGGER [tr_Konto_INSERT]
GO


