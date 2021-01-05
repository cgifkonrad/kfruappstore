-- VIEW 9: Neueste Kommentare einsehen
CREATE OR REPLACE VIEW I_KOMMENTARE AS
SELECT
    "BEWERTUNG"."BEWERTUNGSTEXT",
    "BEWERTUNG"."BEWERTUNGSDATUM"
FROM
    "BEWERTUNG"
WHERE
    "BEWERTUNG"."BEWERTUNGSTEXT" IS NOT NULL
    AND 
        "BEWERTUNG"."BEWERTUNGSDATUM" >= add_months(trunc(sysdate), - 1)
    AND "BEWERTUNG"."RECHNUNGSPOSITIONSID" 
        IN
        (
        SELECT
            "RECHNUNGSPOSITION"."RECHNUNGSPOSITIONSID"
        FROM
            "RECHNUNGSPOSITION"
        WHERE
            "RECHNUNGSPOSITION"."APPID" = 524
        )
ORDER BY
    "BEWERTUNG"."BEWERTUNGSDATUM" DESC
;
COMMENT ON TABLE I_KOMMENTARE IS 'Diese Tabelle Beschreibt, welche Kommentare zur gewählten AppID in den letzten 30 Tagen beim Betreiber eingegangen sind.';