USE TradingGmbH;
GO

DECLARE @Rueckgabe nvarchar(MAX); -- ist notwendig

---- Pfad existiert
EXEC [dbo].[sp_Backup_TradingGmbH_mit_Zeitstempel_und_Param_OutputUndFehlermeldung] 
	'C:\SQL-Kurs\040-Abschlussprojekt',
	@Rueckgabe OUTPUT;


PRINT @Rueckgabe