DECLARE @counter INT = 1;

WHILE @counter <= 50000
BEGIN
    INSERT INTO dbo.FEHLERKATEGORIE (Fehlerkategorie)
    VALUES ('Fehlerkategorie' + CAST(@counter AS NVARCHAR(10)));

    SET @counter = @counter + 1;
END;