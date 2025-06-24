USE [master]
GO

--Erstelle User, der nur Leseberechtigung hat
CREATE LOGIN [UserLeserechte] 
WITH PASSWORD=N'123', 
DEFAULT_DATABASE=[Master], 
CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

CREATE USER [UserLeserechte] FOR LOGIN [UserLeserechte]
GO

use [TradingGmbH]
GO
GRANT SELECT TO [UserLeserechte]
GO

--Erstelle User, der Lese- und Schreibrechte hat


CREATE LOGIN [UserEXECRechte] 
WITH PASSWORD=N'1234', DEFAULT_DATABASE=[master], 
CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

--

CREATE USER [UserEXECRechte] FOR LOGIN [UserEXECRechte]
GO
use [TradingGmbH]
GO

GRANT SELECT TO [UserEXECRechte]
GO
GRANT UPDATE TO [UserEXECRechte]
GO


GRANT EXECUTE ON [dbo].[sp_AddTrade] TO [UserEXECRechte]
GO
GRANT EXECUTE ON [dbo].[sp_UpdateTrade] TO [UserEXECRechte]
GO
GRANT EXECUTE ON [dbo].[sp_AddKundenTrade] TO [UserEXECRechte]
GO
GRANT EXECUTE ON [dbo].[sp_UpdateKundenTrade] TO [UserEXECRechte]
GO
GRANT EXECUTE ON [dbo].[sp_Backup_TradingGmbH_mit_Zeitstempel_und_Param_OutputUndFehlermeldung] TO [UserEXECRechte]
GO
