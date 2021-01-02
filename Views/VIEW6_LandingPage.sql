CREATE OR REPLACE VIEW F_USERLANDINGPAGE AS
Select COUNT(RECHNUNGSPOSITION.RECHNUNGSPOSITIONSID) as appkaufanzahl, "App"."AppID" , "App"."KATEGORIEID", "App"."EntwicklerStudio", kaufanzahl, kaufanzahl*COUNT(RECHNUNGSPOSITION.RECHNUNGSPOSITIONSID) as Scoring
FROM "App"
JOIN RECHNUNGSPOSITION ON RECHNUNGSPOSITION.APPID = "App"."AppID"
JOIN RECHNUNG ON RECHNUNGSPOSITION.RECHNUNGSID = RECHNUNG.RECHNUNGSID
JOIN
(
Select "App"."EntwicklerStudio" as entwst, null as kategorie , COUNT(Rechnungsposition.RechnungspositionsID) as kaufanzahl From Rechnungsposition
        JOIN Rechnung on Rechnungsposition.Rechnungsid = Rechnung.rechnungsid
        JOIN "Kunde" ON "Kunde"."KundenID" = Rechnung.KundenID
        JOIN "App" ON Rechnungsposition.Appid = "App"."AppID"
        WHERE Rechnung.Kundenid = 88
        GROUP BY "App"."EntwicklerStudio"
UNION
--    ORDER BY kaufanzahl desc
    Select null as entwst , "App"."KATEGORIEID" as kategorie , COUNT(Rechnungsposition.RechnungspositionsID) as kaufanzahl From Rechnungsposition
    JOIN Rechnung on Rechnungsposition.Rechnungsid = Rechnung.rechnungsid
    JOIN "Kunde" ON "Kunde"."KundenID" = Rechnung.KundenID
    JOIN "App" ON Rechnungsposition.Appid = "App"."AppID"
    WHERE Rechnung.Kundenid = 88
    GROUP BY "App"."KATEGORIEID"
--    ORDER BY kaufanzahl desc
UNION
    Select null as entwst, "Kategorien"."KategorieID" as kategorie ,
    COUNT(Rechnungsposition.RechnungspositionsID) as kaufanzahl
    From Rechnungsposition
    
    JOIN Rechnung on Rechnungsposition.Rechnungsid = Rechnung.rechnungsid
    JOIN "Kunde" ON "Kunde"."KundenID" = Rechnung.KundenID
    JOIN "App" ON "App"."AppID" = Rechnungsposition.Appid
    Right JOIN "Kategorien" ON "App"."KATEGORIEID" = "Kategorien"."KategorieID" -- "Kunde".LIEBLINGSKATEGORIEID = "Kategorien"."KategorieID"
    WHERE Rechnung.Kundenid = 88
        AND "Kunde".LIEBLINGSKATEGORIEID = "Kategorien"."KategorieID"
    GROUP BY "Kategorien"."KategorieID"
    
UNION
    select null as entwst, "Kategorien"."KategorieID" as kategorie , 5 as kaufanzahl from "Kunde"
    JOIN "Kategorien" on "Kunde".LIEBLINGSKATEGORIEID = "Kategorien"."KategorieID" 
    WHERE "Kunde"."KundenID" = 88
    ) ON entwst = "App"."EntwicklerStudio" OR "App"."KATEGORIEID" = kategorie

GROUP BY "App"."AppID", "App"."KATEGORIEID", "App"."EntwicklerStudio", kaufanzahl
ORDER BY scoring DESC
FETCH FIRST 10 ROWS ONLY;
COMMENT ON COLUMN "F_USERLANDINGPAGE"."APPKAUFANZAHL" IS 'Diese Spalte gibt an, wie häufig die Applikation insgesamt gekauft wurde.';
COMMENT ON COLUMN "F_USERLANDINGPAGE"."KAUFANZAHL" IS 'Diese Spalte beschreibt, wie viele Apps der User bereits in dieser Kategorie oder vom entsprechenden Entwicklerstudio gekauft hat.';
COMMENT ON COLUMN "F_USERLANDINGPAGE"."SCORING" IS 'Diese Spalte beinhaltet das Produkt aus Verkaufszahl der Applikation und der Anzahl der vom User besessenen Apps in dieser Kategorie. Nach diesem Modell werden die Kaufvorschläge priorisiert.';
