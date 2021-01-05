-- VIEW 11: Downloadempfehlungen f�r den User in Abh�ngigkeit zu den drei von ihm bevorzugten App-Kategorien in seinem Downloadverlauf und dem bevorzugten Betriebssystem erstellen.
-- Diese Query wird f�r jede der drei favorisierten Kategorien getrennt ausgef�hrt. Die Ergebnisse werden �ber Union verbunden.

CREATE OR REPLACE VIEW K_DOWNLOADEMPFEHLUNGEN AS
-- erstes Select-Statement: die zwei h�ufigst heruntergeladenen Apps der ersten gefundenen Kategorie
SELECT downloadcount, kategorie, appid , appname FROM
    (
    SELECT COUNT (Downloads.DownloadID ) as downloadcount , App.KategorieID as kategorie , App.AppID as appid , App.ApplikationsName as appname
    FROM Downloads
    JOIN BetriebssystemKompabilit�t ON Downloads.kompabilit�tsid = BetriebssystemKompabilit�t.Kompabilit�tsID
    JOIN App ON BetriebssystemKompabilit�t.AppID = App.AppID
    WHERE BetriebssystemKompabilit�t.Betriebssystem =
        (
        SELECT  BetriebssystemKompabilit�t.Betriebssystem
        FROM BetriebssystemKompabilit�t
        JOIN Downloads ON Downloads.kompabilit�tsid = BetriebssystemKompabilit�t.Kompabilit�tsID
        WHERE Downloads.KundenID = 119
        GROUP BY BetriebssystemKompabilit�t.Betriebssystem
        ORDER BY COUNT(BetriebssystemKompabilit�t.Kompabilit�tsID) DESC
        FETCH FIRST ROW ONLY
        )
    AND App.KategorieID =
        (
        SELECT App.KategorieID
        FROM BetriebssystemKompabilit�t
        JOIN Downloads ON Downloads.kompabilit�tsid = BetriebssystemKompabilit�t.Kompabilit�tsID
        JOIN App ON BetriebssystemKompabilit�t.AppID = App.AppID
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
-- zweites Select-Statement: die zwei h�ufigst heruntergeladenen Apps der letzten gefundenen Kategorie
SELECT downloadcount, kategorie, appid , appname FROM
    (
    SELECT COUNT (Downloads.DownloadID ) as downloadcount , App.KategorieID as kategorie , App.AppID as appid , App.ApplikationsName as appname
    FROM Downloads
    JOIN BetriebssystemKompabilit�t ON Downloads.kompabilit�tsid = BetriebssystemKompabilit�t.Kompabilit�tsID
    JOIN App ON BetriebssystemKompabilit�t.AppID = App.AppID
    WHERE BetriebssystemKompabilit�t.Betriebssystem =
        (
        SELECT  BetriebssystemKompabilit�t.Betriebssystem
        FROM BetriebssystemKompabilit�t
        JOIN Downloads ON Downloads.kompabilit�tsid = BetriebssystemKompabilit�t.Kompabilit�tsID
        WHERE Downloads.KundenID = 119
        GROUP BY BetriebssystemKompabilit�t.Betriebssystem
        ORDER BY COUNT(BetriebssystemKompabilit�t.Kompabilit�tsID) DESC
        FETCH FIRST ROW ONLY
        )
    AND App.KategorieID =
        
            (
            SELECT App.KategorieID
            FROM BetriebssystemKompabilit�t
            JOIN Downloads ON Downloads.kompabilit�tsid = BetriebssystemKompabilit�t.Kompabilit�tsID
            JOIN App ON BetriebssystemKompabilit�t.AppID = App.AppID
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
-- drittes Select-Statement: die zwei h�ufigst heruntergeladenen Apps der mittleren gefundenen Kategorie
SELECT downloadcount, kategorie, appid , appname FROM
    (
    SELECT COUNT (Downloads.DownloadID ) as downloadcount , App.KategorieID as kategorie , App.AppID as appid , App.ApplikationsName as appname
    FROM Downloads
    JOIN BetriebssystemKompabilit�t ON Downloads.kompabilit�tsid = BetriebssystemKompabilit�t.Kompabilit�tsID
    JOIN App ON BetriebssystemKompabilit�t.AppID = App.AppID
    WHERE BetriebssystemKompabilit�t.Betriebssystem =
        (
        SELECT  BetriebssystemKompabilit�t.Betriebssystem
        FROM BetriebssystemKompabilit�t
        JOIN Downloads ON Downloads.kompabilit�tsid = BetriebssystemKompabilit�t.Kompabilit�tsID
        WHERE Downloads.KundenID = 119
        GROUP BY BetriebssystemKompabilit�t.Betriebssystem
        ORDER BY COUNT(BetriebssystemKompabilit�t.Kompabilit�tsID) DESC
        FETCH FIRST ROW ONLY
        )
    AND App.KategorieID =
        
            (
            SELECT App.KategorieID
            FROM BetriebssystemKompabilit�t
            JOIN Downloads ON Downloads.kompabilit�tsid = BetriebssystemKompabilit�t.Kompabilit�tsID
            JOIN App ON BetriebssystemKompabilit�t.AppID = App.AppID
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









-- Alle Apps in Lieblingskategorien, die im bevorzugten Betriebssystem verf�gbar sind anzeigen
SELECT *
-- SELECT
FROM "App"
JOIN "BetriebssystemKompabilit�t" ON "BetriebssystemKompabilit�t"."AppID" = "App"."AppID"
WHERE "BetriebssystemKompabilit�t"."Betriebssystem" =
    (
    SELECT  "BetriebssystemKompabilit�t"."Betriebssystem"
    FROM "BetriebssystemKompabilit�t"
    JOIN "Downloads" ON "Downloads".kompabilit�tsid = "BetriebssystemKompabilit�t"."Kompabilit�tsID"
    WHERE "Downloads"."KundenID" = 119
    GROUP BY "BetriebssystemKompabilit�t"."Betriebssystem"
    ORDER BY COUNT("BetriebssystemKompabilit�t"."Kompabilit�tsID") DESC
    FETCH FIRST ROW ONLY
    )
AND "App".KategorieID in
    (
    SELECT "App".KategorieID
    FROM "BetriebssystemKompabilit�t"
    JOIN "Downloads" ON "Downloads".kompabilit�tsid = "BetriebssystemKompabilit�t"."Kompabilit�tsID"
    JOIN "App" ON "BetriebssystemKompabilit�t"."AppID" = "App"."AppID"
    WHERE "Downloads"."KundenID" = 119
    GROUP BY "App".KategorieID
    ORDER BY Count( "Downloads"."DownloadID") DESC
    FETCH FIRST 3 ROWS ONLY
    )
;

-- Lieblingskategorien des Users bei App-Download
SELECT "App".KategorieID --, Count( "Downloads"."DownloadID")
FROM "BetriebssystemKompabilit�t"
JOIN "Downloads" ON "Downloads".kompabilit�tsid = "BetriebssystemKompabilit�t"."Kompabilit�tsID"
JOIN "App" ON "BetriebssystemKompabilit�t"."AppID" = "App"."AppID"
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
    INNER JOIN "BetriebssystemKompabilit�t" ON "Downloads".kompabilit�tsid = "BetriebssystemKompabilit�t"."Kompabilit�tsID"
    INNER JOIN "App" ON "BetriebssystemKompabilit�t"."AppID" = "App"."AppID"
WHERE "BetriebssystemKompabilit�t"."Betriebssystem" =
    (
    SELECT  "BetriebssystemKompabilit�t"."Betriebssystem"
    FROM "BetriebssystemKompabilit�t"
    JOIN "Downloads" ON "Downloads".kompabilit�tsid = "BetriebssystemKompabilit�t"."Kompabilit�tsID"
    WHERE "Downloads"."KundenID" = 119
    GROUP BY "BetriebssystemKompabilit�t"."Betriebssystem"
    ORDER BY COUNT("BetriebssystemKompabilit�t"."Kompabilit�tsID") DESC
    FETCH FIRST ROW ONLY
    )
    
;



-- Bevorzugtes Betriebssystem des Users
SELECT  "BetriebssystemKompabilit�t"."Betriebssystem" -- ,COUNT("BetriebssystemKompabilit�t"."Kompabilit�tsID")
FROM "BetriebssystemKompabilit�t"
JOIN "Downloads" ON "Downloads".kompabilit�tsid = "BetriebssystemKompabilit�t"."Kompabilit�tsID"
WHERE "Downloads"."KundenID" = 119
GROUP BY "BetriebssystemKompabilit�t"."Betriebssystem"
ORDER BY COUNT("BetriebssystemKompabilit�t"."Kompabilit�tsID") DESC
FETCH FIRST ROW ONLY
;

-- Alle Heruntergeladenen App-IDs eines Kunden auflisten
SELECT *
--SELECT "BetriebssystemKompabilit�t"."Betriebssystem"
FROM "BetriebssystemKompabilit�t"
JOIN "Downloads" ON "Downloads".kompabilit�tsid = "BetriebssystemKompabilit�t"."Kompabilit�tsID"
WHERE "Downloads"."KundenID" = 119
;
