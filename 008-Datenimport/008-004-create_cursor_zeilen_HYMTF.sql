DECLARE @Zeilennummer INT, @Datum DATE, @Kurs DECIMAL(10,2), @AktienID INT

DECLARE cursor_zeilen CURSOR FOR
SELECT ROW_NUMBER() OVER (ORDER BY Datum) as Zeilennummer, Datum, Kurs, AktienID
FROM [dbo].[Aktienkurs_Import_vw]
WHERE datum > '2022-12-31'

OPEN cursor_zeilen
FETCH NEXT FROM cursor_zeilen INTO @Zeilennummer, @Datum, @Kurs, @AktienID

WHILE @@FETCH_STATUS = 0
BEGIN
   INSERT INTO Aktienkurs (Datum, Kurs, AktienID)
   VALUES (@Datum, @Kurs, @AktienID)
   
   FETCH NEXT FROM cursor_zeilen INTO @Zeilennummer, @Datum, @Kurs, @AktienID
END

CLOSE cursor_zeilen
DEALLOCATE cursor_zeilen
