-- VIEW 11: Downloadempfehlungen für den User in Abhängigkeit zu den drei von ihm bevorzugten App-Kategorien in seinem Downloadverlauf und dem bevorzugten Betriebssystem erstellen.
-- Diese Query wird für jede der drei favorisierten Kategorien getrennt ausgeführt. Die Ergebnisse werden über Union verbunden.

CREATE OR REPLACE VIEW K_DOWNLOADEMPFEHLUNGEN AS
-- erstes Select-Statement: die zwei häufigst heruntergeladenen Apps der ersten gefundenen Kategorie
SELECT downloadcount, kategorie, appid , appname FROM
    (
    SELECT COUNT (Downloads.DownloadID ) as downloadcount , App.KategorieID as kategorie , App.AppID as appid , App.ApplikationsName as appname
    FROM Downloads
    JOIN BetriebssystemKompabilität ON Downloads.kompabilitätsid = BetriebssystemKompabilität.KompabilitätsID
    JOIN App ON BetriebssystemKompabilität.AppID = App.AppID
    WHERE BetriebssystemKompabilität.Betriebssystem =
        (
        SELECT  BetriebssystemKompabilität.Betriebssystem
        FROM BetriebssystemKompabilität
        JOIN Downloads ON Downloads.kompabilitätsid = BetriebssystemKompabilität.KompabilitätsID
        WHERE Downloads.KundenID = 119
        GROUP BY BetriebssystemKompabilität.Betriebssystem
        ORDER BY COUNT(BetriebssystemKompabilität.KompabilitätsID) DESC
        FETCH FIRST ROW ONLY
        )
    AND App.KategorieID =
        (
        SELECT App.KategorieID
        FROM BetriebssystemKompabilität
        JOIN Downloads ON Downloads.kompabilitätsid = BetriebssystemKompabilität.KompabilitätsID
        JOIN App ON BetriebssystemKompabilität.AppID = App.AppID
        WHERE Downloads.KundenID = 119
        GROUP BY App.KategorieID
        ORDER BY App.KategorieID ASC
        FETCH FIRST ROW ONLY
        )
    GROUP BY App.AppID, App.KategorieID, App.ApplikationsName
    ORDER BY COUNT (Downloads.DownloadID ) DESC
    FETCH FIRST 2 ROWS ONLY
    )
UNION
-- zweites Select-Statement: die zwei häufigst heruntergeladenen Apps der letzten gefundenen Kategorie
SELECT downloadcount, kategorie, appid , appname FROM
    (
    SELECT COUNT (Downloads.DownloadID ) as downloadcount , App.KategorieID as kategorie , App.AppID as appid , App.ApplikationsName as appname
    FROM Downloads
    JOIN BetriebssystemKompabilität ON Downloads.kompabilitätsid = BetriebssystemKompabilität.KompabilitätsID
    JOIN App ON BetriebssystemKompabilität.AppID = App.AppID
    WHERE BetriebssystemKompabilität.Betriebssystem =
        (
        SELECT  BetriebssystemKompabilität.Betriebssystem
        FROM BetriebssystemKompabilität
        JOIN Downloads ON Downloads.kompabilitätsid = BetriebssystemKompabilität.KompabilitätsID
        WHERE Downloads.KundenID = 119
        GROUP BY BetriebssystemKompabilität.Betriebssystem
        ORDER BY COUNT(BetriebssystemKompabilität.KompabilitätsID) DESC
        FETCH FIRST ROW ONLY
        )
    AND App.KategorieID =
        
            (
            SELECT App.KategorieID
            FROM BetriebssystemKompabilität
            JOIN Downloads ON Downloads.kompabilitätsid = BetriebssystemKompabilität.KompabilitätsID
            JOIN App ON BetriebssystemKompabilität.AppID = App.AppID
            WHERE Downloads.KundenID = 119
            GROUP BY App.KategorieID
            ORDER BY App.KategorieID DESC
            FETCH FIRST ROW ONLY
            )
    GROUP BY App.AppID, App.KategorieID , App.ApplikationsName
    ORDER BY COUNT (Downloads.DownloadID ) DESC
    FETCH FIRST 2 ROWS ONLY
    )

UNION
-- drittes Select-Statement: die zwei häufigst heruntergeladenen Apps der mittleren gefundenen Kategorie
SELECT downloadcount, kategorie, appid , appname FROM
    (
    SELECT COUNT (Downloads.DownloadID ) as downloadcount , App.KategorieID as kategorie , App.AppID as appid , App.ApplikationsName as appname
    FROM Downloads
    JOIN BetriebssystemKompabilität ON Downloads.kompabilitätsid = BetriebssystemKompabilität.KompabilitätsID
    JOIN App ON BetriebssystemKompabilität.AppID = App.AppID
    WHERE BetriebssystemKompabilität.Betriebssystem =
        (
        SELECT  BetriebssystemKompabilität.Betriebssystem
        FROM BetriebssystemKompabilität
        JOIN Downloads ON Downloads.kompabilitätsid = BetriebssystemKompabilität.KompabilitätsID
        WHERE Downloads.KundenID = 119
        GROUP BY BetriebssystemKompabilität.Betriebssystem
        ORDER BY COUNT(BetriebssystemKompabilität.KompabilitätsID) DESC
        FETCH FIRST ROW ONLY
        )
    AND App.KategorieID =
        
            (
            SELECT App.KategorieID
            FROM BetriebssystemKompabilität
            JOIN Downloads ON Downloads.kompabilitätsid = BetriebssystemKompabilität.KompabilitätsID
            JOIN App ON BetriebssystemKompabilität.AppID = App.AppID
            WHERE Downloads.KundenID = 119
            GROUP BY App.KategorieID
            ORDER BY App.KategorieID DESC
            OFFSET 1 ROWS
            FETCH NEXT ROW ONLY
            )
    GROUP BY App.AppID, App.KategorieID , App.ApplikationsName
    ORDER BY COUNT (Downloads.DownloadID ) DESC
    FETCH FIRST 2 ROWS ONLY
    )
ORDER BY downloadcount DESC
;
EXIT;









-- Alle Apps in Lieblingskategorien, die im bevorzugten Betriebssystem verfügbar sind anzeigen
SELECT *
-- SELECT
FROM "App"
JOIN "BetriebssystemKompabilität" ON "BetriebssystemKompabilität"."AppID" = "App"."AppID"
WHERE "BetriebssystemKompabilität"."Betriebssystem" =
    (
    SELECT  "BetriebssystemKompabilität"."Betriebssystem"
    FROM "BetriebssystemKompabilität"
    JOIN "Downloads" ON "Downloads".kompabilitätsid = "BetriebssystemKompabilität"."KompabilitätsID"
    WHERE "Downloads"."KundenID" = 119
    GROUP BY "BetriebssystemKompabilität"."Betriebssystem"
    ORDER BY COUNT("BetriebssystemKompabilität"."KompabilitätsID") DESC
    FETCH FIRST ROW ONLY
    )
AND "App".KategorieID in
    (
    SELECT "App".KategorieID
    FROM "BetriebssystemKompabilität"
    JOIN "Downloads" ON "Downloads".kompabilitätsid = "BetriebssystemKompabilität"."KompabilitätsID"
    JOIN "App" ON "BetriebssystemKompabilität"."AppID" = "App"."AppID"
    WHERE "Downloads"."KundenID" = 119
    GROUP BY "App".KategorieID
    ORDER BY Count( "Downloads"."DownloadID") DESC
    FETCH FIRST 3 ROWS ONLY
    )
;

-- Lieblingskategorien des Users bei App-Download
SELECT "App".KategorieID --, Count( "Downloads"."DownloadID")
FROM "BetriebssystemKompabilität"
JOIN "Downloads" ON "Downloads".kompabilitätsid = "BetriebssystemKompabilität"."KompabilitätsID"
JOIN "App" ON "BetriebssystemKompabilität"."AppID" = "App"."AppID"
WHERE "Downloads"."KundenID" = 119
GROUP BY "App".KategorieID
ORDER BY Count( "Downloads"."DownloadID") DESC
FETCH FIRST 3 ROWS ONLY
;

-- Alle Apps auf dem bevorzugten Betriebssystem des Users
SELECT  *
-- SELECT "App"."AppID", "App"."ApplikationsName"
FROM
         "Downloads"
    INNER JOIN "BetriebssystemKompabilität" ON "Downloads".kompabilitätsid = "BetriebssystemKompabilität"."KompabilitätsID"
    INNER JOIN "App" ON "BetriebssystemKompabilität"."AppID" = "App"."AppID"
WHERE "BetriebssystemKompabilität"."Betriebssystem" =
    (
    SELECT  "BetriebssystemKompabilität"."Betriebssystem"
    FROM "BetriebssystemKompabilität"
    JOIN "Downloads" ON "Downloads".kompabilitätsid = "BetriebssystemKompabilität"."KompabilitätsID"
    WHERE "Downloads"."KundenID" = 119
    GROUP BY "BetriebssystemKompabilität"."Betriebssystem"
    ORDER BY COUNT("BetriebssystemKompabilität"."KompabilitätsID") DESC
    FETCH FIRST ROW ONLY
    )
    
;



-- Bevorzugtes Betriebssystem des Users
SELECT  "BetriebssystemKompabilität"."Betriebssystem" -- ,COUNT("BetriebssystemKompabilität"."KompabilitätsID")
FROM "BetriebssystemKompabilität"
JOIN "Downloads" ON "Downloads".kompabilitätsid = "BetriebssystemKompabilität"."KompabilitätsID"
WHERE "Downloads"."KundenID" = 119
GROUP BY "BetriebssystemKompabilität"."Betriebssystem"
ORDER BY COUNT("BetriebssystemKompabilität"."KompabilitätsID") DESC
FETCH FIRST ROW ONLY
;

-- Alle Heruntergeladenen App-IDs eines Kunden auflisten
SELECT *
--SELECT "BetriebssystemKompabilität"."Betriebssystem"
FROM "BetriebssystemKompabilität"
JOIN "Downloads" ON "Downloads".kompabilitätsid = "BetriebssystemKompabilität"."KompabilitätsID"
WHERE "Downloads"."KundenID" = 119
;
