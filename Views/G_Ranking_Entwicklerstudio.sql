-- VIEW 7: Beliebteste Apps eines Entwicklerstudios darstellen
-- Der Wert wird gemessen in Downloads, Käufen und Sternebewertungen
-- Als Zeitraum für Downloads wurden die letzten 30 Tage gewählt, für die anderen Apps ist der Zeitraum unbegrenzt



-- Downloads in den letzten 30 Tagen
CREATE OR REPLACE VIEW G_RANKING_ENTW_DLDS AS
SELECT COUNT(Downloads.DownloadID) as Downloadzahl , App.AppID, App.ApplikationsName
FROM App
JOIN BetriebssystemKompabilität ON BetriebssystemKompabilität.AppID = App.AppID
JOIN Downloads ON Downloads.KOMPABILITÄTSID = BetriebssystemKompabilität.KompabilitätsID
WHERE 
    Downloads.DownloadDatum >=  add_months( trunc(sysdate), -1 )
AND
    App.EntwicklerStudio LIKE 'Felistella'
GROUP BY App.AppID, App.ApplikationsName
ORDER BY Downloadzahl DESC
FETCH FIRST 10 ROWS ONLY
;

-- Beste Bewertungen
CREATE OR REPLACE VIEW G_RANKING_ENTW_EVAL AS
SELECT AVG(Bewertung.BewertungsGrad) as Durchschnittsbewertung , App.AppID, App.ApplikationsName
FROM Bewertung
JOIN Rechnungsposition ON Bewertung.RechnungspositionsID = Rechnungsposition.RechnungspositionsID
JOIN App ON Rechnungsposition.AppID = App.AppID
WHERE 
    App.EntwicklerStudio LIKE 'Felistella'
GROUP BY App.AppID, App.ApplikationsName
ORDER BY Durchschnittsbewertung DESC
FETCH FIRST 10 ROWS ONLY
;

-- Menge an Verkäufen
CREATE OR REPLACE VIEW G_RANKING_ENTW_VERK AS
SELECT COUNT(Rechnungsposition.RechnungspositionsID) as Verkaufszahl , App.AppID, App.ApplikationsName
FROM App
JOIN Rechnungsposition ON Rechnungsposition.APPID = App.AppID
WHERE 
    App.EntwicklerStudio LIKE 'Felistella'
GROUP BY App.AppID, App.ApplikationsName
ORDER BY Verkaufszahl DESC
FETCH FIRST 10 ROWS ONLY
;

