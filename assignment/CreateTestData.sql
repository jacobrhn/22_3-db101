USE [Technik_Center_DB];
GO

-- Set the seed for reproducibility
DECLARE @Seed INT = 1;
SET NOCOUNT ON;

-- Declare variables for loop
DECLARE @Counter INT = 1;

-- Loop to insert 25,000 test datasets
WHILE @Counter <= 25000
BEGIN
    INSERT INTO [dbo].[SUPPORT] (
        [ConfigID],
        [FehlerKategorieID],
        [ErfasserID],
        [TextID],
        [PersonalbereichID],
        [ZimmerID],
        [Falltitel],
        [Fallname],
        [Erfassungsdatum],
        [Problemschilderung],
        [PlandatumBearbeitung],
        [Plandauer],
        [Dauereinheit],
        [Bearbeitungsdatum],
        [Erledigt],
        [Weiterbearbeitungsdatum],
        [Istdauer],
        [Legende],
        [Ursache],
        [ZugErfasser]
    )
    VALUES (
        ABS(CHECKSUM(NEWID(), NEWID(), NEWID())) % 2 + 1,       -- ConfigID (random between 1 and 2)
        ABS(CHECKSUM(NEWID(), NEWID(), NEWID())) % 20 + 1,      -- FehlerKategorieID (random between 1 and 20)
        ABS(CHECKSUM(NEWID(), NEWID(), NEWID())) % 4 + 1004,    -- ErfasserID (random between 1001 and 1007)
        ABS(CHECKSUM(NEWID(), NEWID(), NEWID())) % 2 + 1,       -- TextID (random between 1 and 2)
        ABS(CASE WHEN ABS(CHECKSUM(NEWID(), NEWID(), NEWID())) % 3 = 0 THEN 1
             WHEN ABS(CHECKSUM(NEWID(), NEWID(), NEWID())) % 3 = 1 THEN 7
             ELSE 8
        END),      -- PersonalbereichID (random between 1, 7, or 8)
        ABS(CHECKSUM(NEWID(), NEWID(), NEWID())) % 7 + 1,       -- ZimmerID (random between 1 and 7)
        'Falltitel' + CAST(@Counter AS NVARCHAR(10)),           -- Falltitel
        'Fallname' + CAST(@Counter AS NVARCHAR(10)),            -- Fallname
        DATEADD(DAY, -ABS(CHECKSUM(NEWID(), NEWID(), NEWID())) % 365, GETDATE()),  -- Erfassungsdatum (random date within the last year)
        'Problemschilderung ' + CAST(@Counter AS NVARCHAR(10)),  -- Problemschilderung
        DATEADD(DAY, ABS(CHECKSUM(NEWID(), NEWID(), NEWID())) % 30, GETDATE()),   -- PlandatumBearbeitung (random date within the next 30 days)
        ABS(CHECKSUM(NEWID(), NEWID(), NEWID())) % 10 + 1,  -- Plandauer (random between 1 and 10)
        'Stunde(n)',                                        -- Dauereinheit
        DATEADD(DAY, ABS(CHECKSUM(NEWID(), NEWID(), NEWID())) % 365, GETDATE()),  -- Bearbeitungsdatum (random date within the next year)
        ABS(CHECKSUM(NEWID(), NEWID(), NEWID())) % 2,       -- Erledigt (0 or 1)
        DATEADD(DAY, ABS(CHECKSUM(NEWID(), NEWID(), NEWID())) % 30, GETDATE()),   -- Weiterbearbeitungsdatum (random date within the next 30 days)
        ABS(CHECKSUM(NEWID(), NEWID(), NEWID())) % 10,      -- Istdauer (random between 0 and 10)
        'Legende ' + CAST(@Counter AS NVARCHAR(10)),       -- Legende
        'Ursache ' + CAST(@Counter AS NVARCHAR(10)),       -- Ursache
        ABS(CHECKSUM(NEWID(), NEWID(), NEWID())) % 5 + 1   -- ZugErfasser (random between 1 and 5)
    );

    SET @Counter = @Counter + 1;
END;
