CREATE FUNCTION dbo.GetSupportByPersonalbereichID
(
    @PersonalbereichID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        dbo.SUPPORT.SupportID,
        dbo.CONFIG.HausPflichtAktiv,
        dbo.ERFASSER.Erfasser,
        dbo.ERFASSER.DomUser,
        dbo.TEXT.Text,
        dbo.TEXT.Bemerkung,
        dbo.PERSONALBEREICH.Personalbereich,
        dbo.PERSONALBEREICH.PersBereichID,
        dbo.ZIMMER.Zimmer,
        dbo.ETAGE.EtagenName,
        dbo.OBJEKT.ObjektName,
        dbo.FEHLERKATEGORIE.Fehlerkategorie
    FROM
        dbo.SUPPORT
    INNER JOIN dbo.CONFIG ON dbo.SUPPORT.ConfigID = dbo.CONFIG.ID
    INNER JOIN dbo.FEHLERKATEGORIE ON dbo.SUPPORT.FehlerKategorieID = dbo.FEHLERKATEGORIE.FehlerKategorieID
    INNER JOIN dbo.ERFASSER ON dbo.SUPPORT.ErfasserID = dbo.ERFASSER.ErfasserID
    INNER JOIN dbo.TEXT ON dbo.SUPPORT.TextID = dbo.TEXT.TextID
    INNER JOIN dbo.PERSONALBEREICH ON dbo.SUPPORT.PersonalbereichID = dbo.PERSONALBEREICH.PersBereichID
    INNER JOIN dbo.ZIMMER ON dbo.SUPPORT.ZimmerID = dbo.ZIMMER.ZimmerID
    INNER JOIN dbo.ETAGE ON dbo.ZIMMER.EtagenID = dbo.ETAGE.EtagenID
    INNER JOIN dbo.OBJEKT ON dbo.ETAGE.ObjektID = dbo.OBJEKT.ObjektID
    WHERE dbo.PERSONALBEREICH.PersBereichID = @PersonalbereichID
);
