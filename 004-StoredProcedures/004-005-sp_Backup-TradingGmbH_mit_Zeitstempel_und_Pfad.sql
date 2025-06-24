USE [TradingGmbH]
GO

/****** Object:  StoredProcedure [dbo].[sp_Backup_TradingGmbH_mit_Zeitstempel_und_Param_OutputUndFehlermeldung]    Script Date: 24.02.2023 13:43:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- =============================================================
-- Author:		AD 
-- Create date: 21.02.2023
-- Description:	Diese Prozedur erstellt ein Backup 
--              der Datenbank TradingGmbH.
-- Parameter:
--  @Pfad:    Ein Pfad für das Backup wird von der exec-Prozedur
--            geliefert. Z.B.: 'C:\SQL-Kurs\040-Abschlussprojekt'.
--            Ist der Pfad nicht vorhanden, wird er erstellt.
--            Das Laufwerk muss vorhanden sein.
-- @Feedback: Liefert eine Nachricht an die exec-Prozedur zurück.
-- ==============================================================

CREATE OR ALTER           PROCEDURE [dbo].[sp_Backup_TradingGmbH_mit_Zeitstempel_und_Param_OutputUndFehlermeldung]
	@Pfad nvarchar(256),  -- Parameter 1, @Pfad kann so aussehen: 'C:\SQL-Kurs\040-Abschlussprojekt' 
	@Feedback nvarchar(MAX) OUTPUT -- Parameter 2

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY

	-------------------------------------------------------------------------------
		DECLARE @t TABLE (FileExists int, FileIsDir int, ParentDirExists int);
		INSERT INTO @t EXEC master.dbo.xp_fileexist @Pfad;
		
		IF ((SELECT FileIsDir FROM @t) = 0) AND ((SELECT FileExists FROM @t) = 0)
		BEGIN
		-- Ordner existiert nicht, ist keine Datei 
			PRINT 'Pfad existiert nicht';
			-- TODO testen ob die Festplatte existiert
		
			---- Ordner erstellen, wenn nicht existiert ---------------------------------------------------------------
			EXEC master.sys.xp_create_subdir @Pfad;-- Ordner erstellen
			-- TODO: TRY-CATCH 
			-- (z.B. wir haben keine Berechtigungen, Festplatte existiert nicht etc.)
		END
		ELSE IF (SELECT FileExists FROM @t) = 1 -- Das ist eine Datei
		BEGIN 
			PRINT 'Das ist eine Datei';
			--TODO: Fehler, Abbruch
		END
		ELSE
			PRINT 'Pfad existiert';

		DECLARE @backupFile NVARCHAR(MAX); -- file name
		SET @backupFile = @Pfad + 
						  'TradingGmbH-' + [dbo].[sf_Zeitstempel]() + '.bak'; 
	
		BACKUP DATABASE [TradingGmbH] TO DISK = @backupFile;
		SET @Feedback =  CHAR(10) + 'Alles OK!';
	END TRY
	-------------------------------------------------------------------------------

	BEGIN CATCH	
		SET @Feedback =  CHAR(10) + 'Fehler!';
	END CATCH
	
END
GO


