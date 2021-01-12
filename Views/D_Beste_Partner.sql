-- VIEW 4: Welche Entwicklerstudios sind die besten Partner des Unternehmens und zahlen die größte Provision

CREATE OR REPLACE VIEW D_BESTPARTNERS AS
SELECT
    Entwicklerstudio,
    SUM(APPUMSATZ) AS Gesamtumsatz,
    SUM(AppProvision) AS Gesamtprovsion,
    100 * SUM(AppProvision) / NULLIF ( SUM(APPUMSATZ),0 ) AS Durchschnittsprovision
FROM 
    (
    SELECT
        Rechnungsposition.AppID,
        COUNT ( Rechnungsposition.RechnungspositionsID) as Anzahlverkauft,
        SUM   ( Rechnungsposition.Rechnungspositionspreis) as Appumsatz,
        UMSATZKLASSE.UMSATZKLASSENPROVISION * SUM( Rechnungsposition.Rechnungspositionspreis) as AppProvision,
        Umsatzklasse.UmsatzklassenID,
        Umsatzklasse.Umsatzklassenbezeichner,
        UMSATZKLASSE.UMSATZKLASSENPROVISION,
        App.EntwicklerStudio as Entwicklerstudio
    FROM Rechnungsposition
    JOIN App On App.AppID = Rechnungsposition.AppID
    JOIN Rechnung ON Rechnungsposition.RechnungsID = Rechnung.RechnungsID
    JOIN Umsatzklasse ON App.UmsatzklassenID = Umsatzklasse.UmsatzklassenID
    JOIN EntwicklerStudios ON EntwicklerStudios.Entwicklerstudioname = App.EntwicklerStudio
    WHERE RECHNUNGSDATUM >= add_months( trunc(sysdate), -12 )
    GROUP BY Rechnungsposition.AppID, Umsatzklasse.UmsatzklassenProvision, Umsatzklasse.Umsatzklassenbezeichner, Umsatzklasse.UmsatzklassenID, App.EntwicklerStudio
    )
GROUP BY Entwicklerstudio
ORDER BY Gesamtprovsion DESC
;
COMMENT ON COLUMN D_BESTPARTNERS.Durchschnittsprovision IS 'Diese Spalte gibt an, welcher Anteil des Umsatzes über alle Apps des Studios hinweg dem Storebetreiber zufließt.';
EXIT; 
-- Skriptausführungen hier beenden. Der Rest dieses Dokuments existiert nur zu Test- und Entwicklungszwecken


-- Teilabfragen zu Testzwecken

-- Daten zu den einzelnen Apps erheben
    SELECT
        Rechnungsposition.AppID,
        COUNT ( Rechnungsposition.RechnungspositionsID) as Anzahlverkauft,
        SUM( Rechnungsposition.Rechnungspositionspreis) as Appumsatz,
        UMSATZKLASSE.UMSATZKLASSENPROVISION * SUM( Rechnungsposition.Rechnungspositionspreis) as AppProvision,
        
        
        
        Umsatzklasse.UmsatzklassenID,
        Umsatzklasse.Umsatzklassenbezeichner,
        UMSATZKLASSE.UMSATZKLASSENPROVISION,
        "App"."EntwicklerStudio"
    FROM Rechnungsposition
    JOIN "App" On "App"."AppID" = Rechnungsposition.AppID
    JOIN Rechnung ON Rechnungsposition.RechnungsID = Rechnung.RechnungsID
    JOIN Umsatzklasse ON "App".UmsatzklassenID = Umsatzklasse.UmsatzklassenID
    JOIN "EntwicklerStudios" ON "EntwicklerStudios"."Entwicklerstudioname" = "App"."EntwicklerStudio"
    WHERE RECHNUNGSDATUM >= add_months( trunc(sysdate), -12 )
    GROUP BY Rechnungsposition.AppID, Umsatzklasse.UmsatzklassenProvision, Umsatzklasse.UmsatzklassenID, Umsatzklasse.Umsatzklassenbezeichner, "App"."EntwicklerStudio";

-- Berechnung des Gesamtumsatzes je App in den letzten 12 Monaten
SELECT SUM( Rechnungsposition.Rechnungspositionspreis) as Appumsatz, COUNT ( Rechnungsposition.RechnungspositionsID) as Anzahlverkauft , Rechnungsposition.AppID
FROM Rechnungsposition
JOIN "App" On "App"."AppID" = Rechnungsposition.AppID
JOIN Rechnung ON Rechnungsposition.RechnungsID = Rechnung.RechnungsID
--WHERE RECHNUNGSDATUM >= TO_DATE  ( '01-JAN-2020 00:00:00' , 'DD-MON-YYYY HH24:MI:SS' )
WHERE RECHNUNGSDATUM >= add_months( trunc(sysdate), -12 )
GROUP BY Rechnungsposition.AppID 