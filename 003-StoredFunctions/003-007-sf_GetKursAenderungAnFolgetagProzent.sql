USE [TradingGmbH]
GO

/****** Object:  UserDefinedFunction [dbo].[sf_GetKursAenderungAmFolgetagProzent]    Script Date: 24.02.2023 13:50:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER     FUNCTION [dbo].[sf_GetKursAenderungAmFolgetagProzent](@AktienID int, @Datum date)

RETURNS decimal(6,2)
AS
BEGIN
    DECLARE @KursAenderung decimal(6,2);
    DECLARE @Folgetag date;

    -- Suche nach dem nächsten Eintrag
    SELECT TOP 1 @Folgetag = Datum
    FROM Aktienkurs
    WHERE AktienID = @AktienID AND Datum > @Datum
    ORDER BY Datum ASC;

    -- Wenn kein Eintrag gefunden wurde, nimm den letzten vorhandenen Eintrag
    IF @Folgetag IS NULL
    BEGIN
        SELECT TOP 1 @Folgetag = Datum
        FROM Aktienkurs
        WHERE AktienID = @AktienID AND Datum < @Datum
        ORDER BY Datum DESC;
    END;

    -- Berechne die Kursänderung
    IF @Folgetag IS NOT NULL
    BEGIN
        SELECT @KursAenderung = ((Folgetag.Kurs - Aktuell.Kurs) / Aktuell.Kurs) * 100
        FROM Aktienkurs Aktuell
        LEFT JOIN Aktienkurs Folgetag ON Folgetag.Datum = @Folgetag
        WHERE Aktuell.Datum = @Datum AND Aktuell.AktienID = @AktienID AND Folgetag.AktienID = @AktienID
        ORDER BY Folgetag.Datum;
    END;

    RETURN ROUND(@KursAenderung, 2);

END;
GO


