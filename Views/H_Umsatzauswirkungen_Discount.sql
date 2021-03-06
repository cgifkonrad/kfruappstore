-- VIEW 8: Auswirkungen einer Rabattaktion auf dem Umsatz. Über die Zeitspanne der Rabattaktion hinweg werden die Umsätze gemessen. Diese werden anschließend mit den Umsatzen in der vorausliegenden Zeitspanne verglichen.


-- Gesamtansicht
CREATE OR REPLACE VIEW H_UMSATZAUSWIRKUNGENDISCOUNT AS
SELECT summe2 as "Umsatz_im_Vorzeitraum", summe1 as "Umsatz_im_Rabattzeitraum" , ((summe1/summe2)-1)*100 as "Umsatzänderung_in_%" , rabattid1 as "RabattID" FROM
    (
    SELECT SUM(RECHNUNGSPOSITION.RECHNUNGSPOSITIONSPREIS) AS SUMME1, RECHNUNGSPOSITION.APPID as appid1 , Rabatt.RabattID as rabattid1 FROM Rabatt
        JOIN RECHNUNGSPOSITION ON  RECHNUNGSPOSITION.APPID = Rabatt.AppID
        JOIN RECHNUNG ON RECHNUNG.RECHNUNGSID = RECHNUNGSPOSITION.RECHNUNGSID
        WHERE RECHNUNG.RECHNUNGSDATUM BETWEEN Rabatt.DiscountStart AND Rabatt.DiscountEnd

        Group by RECHNUNGSPOSITION.APPID , Rabatt.RabattID
    ) 
JOIN
    (
    SELECT SUM(RECHNUNGSPOSITION.RECHNUNGSPOSITIONSPREIS) as SUMME2 , RECHNUNGSPOSITION.APPID as appid2, Rabatt.RabattID as rabattid2 FROM Rabatt
    JOIN RECHNUNGSPOSITION ON  RECHNUNGSPOSITION.APPID = Rabatt.AppID
    JOIN RECHNUNG ON RECHNUNG.RECHNUNGSID = RECHNUNGSPOSITION.RECHNUNGSID
    WHERE RECHNUNG.RECHNUNGSDATUM BETWEEN Rabatt.DiscountStart- (Rabatt.DiscountEnd - Rabatt.DiscountStart ) AND Rabatt.DiscountStart

    Group by RECHNUNGSPOSITION.APPID , Rabatt.RabattID
    ) 
    ON appid1 = appid2
;
COMMENT ON TABLE H_UMSATZAUSWIRKUNGENDISCOUNT IS 'Dieser View beschreibt die Auswirkungen aller Rabattaktionen auf die entsprechenden Produktumsätze, hierbei vergleichend zwischen dem Zeitraum vor der Rabattaktion und während der Rabattaktion';


-- Gefilterte Ansicht
CREATE OR REPLACE VIEW H_UMSATZAUSWIRKUNGENGEFILTERT AS
SELECT summe2 as "Umsatz_im_Vorzeitraum", summe1 as "Umsatz_im_Rabattzeitraum" , ((summe1/summe2)-1)*100 as "Umsatzänderung_in_%" , rabattid1 as "RabattID" FROM

    SELECT SUM(RECHNUNGSPOSITION.RECHNUNGSPOSITIONSPREIS) AS SUMME1, RECHNUNGSPOSITION.APPID as appid1 , Rabatt.RabattID as rabattid1 FROM Rabatt
        JOIN RECHNUNGSPOSITION ON  RECHNUNGSPOSITION.APPID = Rabatt.AppID
        JOIN RECHNUNG ON RECHNUNG.RECHNUNGSID = RECHNUNGSPOSITION.RECHNUNGSID
        WHERE RECHNUNG.RECHNUNGSDATUM BETWEEN Rabatt.DiscountStart AND Rabatt.DiscountEnd

        Group by RECHNUNGSPOSITION.APPID , Rabatt.RabattID
    ) 
JOIN
    (
    SELECT SUM(RECHNUNGSPOSITION.RECHNUNGSPOSITIONSPREIS) as SUMME2 , RECHNUNGSPOSITION.APPID as appid2, Rabatt.RabattID as rabattid2 FROM Rabatt
    JOIN RECHNUNGSPOSITION ON  RECHNUNGSPOSITION.APPID = Rabatt.AppID
    JOIN RECHNUNG ON RECHNUNG.RECHNUNGSID = RECHNUNGSPOSITION.RECHNUNGSID
    WHERE RECHNUNG.RECHNUNGSDATUM BETWEEN Rabatt.DiscountStart- (Rabatt.DiscountEnd - Rabatt.DiscountStart ) AND Rabatt.DiscountStart

    Group by RECHNUNGSPOSITION.APPID , Rabatt.RabattID
    ) 
    ON appid1 = appid2
    WHERE rabattid1 = 202
;
COMMENT ON TABLE H_UMSATZAUSWIRKUNGENGEFILTERT IS 'Dieser View beschreibt die Auswirkungen einer spezifischen Rabattaktionen auf die entsprechenden Produktumsätze, hierbei vergleichend zwischen dem Zeitraum vor der Rabattaktion und während der Rabattaktion';
EXIT;

SELECT SUM(RECHNUNGSPOSITION.RECHNUNGSPOSITIONSPREIS) AS SUMME1, RECHNUNGSPOSITION.APPID as appid1 , Rabatt.RabattID as rabattid1 FROM Rabatt
        JOIN RECHNUNGSPOSITION ON  RECHNUNGSPOSITION.APPID = Rabatt.AppID
        JOIN RECHNUNG ON RECHNUNG.RECHNUNGSID = RECHNUNGSPOSITION.RECHNUNGSID
        WHERE RECHNUNG.RECHNUNGSDATUM BETWEEN Rabatt.DiscountStart AND Rabatt.DiscountEnd

        Group by RECHNUNGSPOSITION.APPID , Rabatt.RabattID;
        
SELECT SUM(RECHNUNGSPOSITION.RECHNUNGSPOSITIONSPREIS) as SUMME2 , RECHNUNGSPOSITION.APPID as appid2, Rabatt.RabattID as rabattid2 FROM Rabatt
    JOIN RECHNUNGSPOSITION ON  RECHNUNGSPOSITION.APPID = Rabatt.AppID
    JOIN RECHNUNG ON RECHNUNG.RECHNUNGSID = RECHNUNGSPOSITION.RECHNUNGSID
    WHERE RECHNUNG.RECHNUNGSDATUM BETWEEN Rabatt.DiscountStart- (Rabatt.DiscountEnd - Rabatt.DiscountStart ) AND Rabatt.DiscountStart

    Group by RECHNUNGSPOSITION.APPID , Rabatt.RabattID;
    WHERE rabattid1 = 202
;
COMMENT ON TABLE H_UMSATZAUSWIRKUNGENGEFILTERT IS 'Dieser View beschreibt die Auswirkungen einer spezifischen Rabattaktionen auf die entsprechenden Produktumsätze, hierbei vergleichend zwischen dem Zeitraum vor der Rabattaktion und während der Rabattaktion';
