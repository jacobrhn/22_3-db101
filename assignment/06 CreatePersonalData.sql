Declare @counter INT;
SET @counter = 1;

WHILE @counter <= 50000
BEGIN
    INSERT INTO dbo.PERSONALBEREICH (Personalbereich)
    VALUES ('Personalbereich' + CAST(@counter AS NVARCHAR(10)));

    SET @counter = @counter + 1;
END;