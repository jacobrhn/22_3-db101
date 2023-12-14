ALTER TRIGGER CheckErfasserPermission
ON dbo.SUPPORT
INSTEAD OF INSERT
AS
BEGIN
    -- Check if Erfasser has permission for the specified PersonalbereichID
    IF NOT EXISTS (
        SELECT 1
        FROM dbo.PERSONALBEREICH_ERFASSER
        WHERE ErfassserID IN (SELECT ErfasserID FROM inserted)
        AND PersBereichID IN (SELECT PersonalbereichID FROM inserted)
    )
    BEGIN
        -- Get the ErfasserID causing the permission denial
        DECLARE @DeniedErfasserID INT;
        SELECT TOP 1 @DeniedErfasserID = ErfasserID
        FROM inserted;

        DECLARE @DeniedPersonalbereichID INT;
        SELECT TOP 1 @DeniedPersonalbereichID = PersonalbereichID
        FROM inserted;

        -- Cancel the INSERT operation and raise an error with the ErfasserID
        DECLARE @ErrorMessage NVARCHAR(100);
        SET @ErrorMessage = 'Permission denied for Erfasser ' + CAST(@DeniedErfasserID AS NVARCHAR(10)) + ' to insert ticket for ' + CAST(@DeniedPersonalbereichID AS NVARCHAR(50));
        THROW 50000, @ErrorMessage, 1;
    END
    ELSE
    BEGIN
        -- Insert all columns from the inserted table into the SUPPORT table excluding the identity column
        INSERT INTO dbo.SUPPORT (
            ConfigID,
            FehlerKategorieID,
            ErfasserID,
            TextID,
            PersonalbereichID,
            ZimmerID,
            Falltitel,
            Fallname,
            Erfassungsdatum,
            Problemschilderung,
            PlandatumBearbeitung,
            Plandauer,
            Dauereinheit,
            Bearbeitungsdatum,
            Erledigt,
            Weiterbearbeitungsdatum,
            Istdauer,
            Legende,
            Ursache,
            ZugErfasser)
        SELECT
            ConfigID,
            FehlerKategorieID,
            ErfasserID,
            TextID,
            PersonalbereichID,
            ZimmerID,
            Falltitel,
            Fallname,
            Erfassungsdatum,
            Problemschilderung,
            PlandatumBearbeitung,
            Plandauer,
            Dauereinheit,
            Bearbeitungsdatum,
            Erledigt,
            Weiterbearbeitungsdatum,
            Istdauer,
            Legende,
            Ursache,
            ZugErfasser 
        FROM inserted;
    END;
END;
