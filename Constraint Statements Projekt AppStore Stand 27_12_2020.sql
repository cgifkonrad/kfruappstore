-- Weiterhin fehlende Referenzen:
--      App referenziert ID des Entwicklerstudios

-- noch nicht erfolgreich durchgeführte Referenzauflösungen
-- lock Table "PSE1"."RECHNUNG" in EXCLUSIVE mode;
-- alter table "PSE1"."RECHNUNG" add constraint Rechnung_KundenID_FK foreign key("KUNDENID") references "Kunde"("KundenID");
lock table "PSE1"."Warenkorb" in EXCLUSIVE mode;
alter table "PSE1"."Warenkorb" add constraint Warenkorb_KundenID_FK foreign key("KundenID") references "Kunde"("KundenID");

--Diese Befehle haben bereits funktioniert
-- alter table "PSE1"."BEWERTUNG" add CONSTRAINT "RECHNUNGSPOSITIONSID_FK" FOREIGN KEY ("RECHNUNGSPOSITIONSID") REFERENCES "PSE1"."RECHNUNGSPOSITION" ("RECHNUNGSPOSITIONSID")
-- alter table "PSE1"."RECHNUNGSPOSITION" add constraint RechnungsID_FK foreign key("RECHNUNGSID") references "RECHNUNG"("RECHNUNGSID")
-- alter table "PSE1"."RECHNUNGSPOSITION" add CONSTRAINT "RECHNUNGSPOSITION_APPID_FK" FOREIGN KEY ("APPID") REFERENCES "PSE1"."App" ("AppID")
-- alter table "PSE1"."App" add constraint UmsatzklassenID_FK foreign key("UMSATZKLASSENID") references "UMSATZKLASSE"("UMSATZKLASSENID")
-- alter table "PSE1"."WarenkorbPosition" add constraint AppID_FK foreign key("AppID") references "App"("AppID")
-- alter table "PSE1"."WarenkorbPosition" add constraint WarenkorbID_FK foreign key("WarenkorbID") references "Warenkorb"("ID")
