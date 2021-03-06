--------------------------------------------------------
--  DDL for Table UMSATZKLASSE
--------------------------------------------------------

  CREATE TABLE "PSE1"."UMSATZKLASSE" 
   (	"UMSATZKLASSENBEZEICHNER" VARCHAR2(50 BYTE), 
	"UMSATZKLASSENID" VARCHAR2(20 BYTE), 
	"UMSATZKLASSENPROVISION" NUMBER(2,2), 
	"UMSATZKLASSENBESTEUERUNGSSATZ" NUMBER(2,2)
   ) ;
REM INSERTING into PSE1.UMSATZKLASSE
SET DEFINE OFF;
Insert into PSE1.UMSATZKLASSE (UMSATZKLASSENBEZEICHNER,UMSATZKLASSENID,UMSATZKLASSENPROVISION,UMSATZKLASSENBESTEUERUNGSSATZ) values ('Gratis-App','0','0','0');
Insert into PSE1.UMSATZKLASSE (UMSATZKLASSENBEZEICHNER,UMSATZKLASSENID,UMSATZKLASSENPROVISION,UMSATZKLASSENBESTEUERUNGSSATZ) values ('Starter','1','0,05','0,01');
Insert into PSE1.UMSATZKLASSE (UMSATZKLASSENBEZEICHNER,UMSATZKLASSENID,UMSATZKLASSENPROVISION,UMSATZKLASSENBESTEUERUNGSSATZ) values ('Starter Premium','2','0,1','0,01');
Insert into PSE1.UMSATZKLASSE (UMSATZKLASSENBEZEICHNER,UMSATZKLASSENID,UMSATZKLASSENPROVISION,UMSATZKLASSENBESTEUERUNGSSATZ) values ('Starter Free','3','0','0,01');
Insert into PSE1.UMSATZKLASSE (UMSATZKLASSENBEZEICHNER,UMSATZKLASSENID,UMSATZKLASSENPROVISION,UMSATZKLASSENBESTEUERUNGSSATZ) values ('Mid Level','4','0,04','0,07');
Insert into PSE1.UMSATZKLASSE (UMSATZKLASSENBEZEICHNER,UMSATZKLASSENID,UMSATZKLASSENPROVISION,UMSATZKLASSENBESTEUERUNGSSATZ) values ('Mid Level Premium','5','0,08','0,07');
Insert into PSE1.UMSATZKLASSE (UMSATZKLASSENBEZEICHNER,UMSATZKLASSENID,UMSATZKLASSENPROVISION,UMSATZKLASSENBESTEUERUNGSSATZ) values ('Mid Level Free','6','0','0,07');
Insert into PSE1.UMSATZKLASSE (UMSATZKLASSENBEZEICHNER,UMSATZKLASSENID,UMSATZKLASSENPROVISION,UMSATZKLASSENBESTEUERUNGSSATZ) values ('High Level','7','0,03','0,06');
Insert into PSE1.UMSATZKLASSE (UMSATZKLASSENBEZEICHNER,UMSATZKLASSENID,UMSATZKLASSENPROVISION,UMSATZKLASSENBESTEUERUNGSSATZ) values ('High Level Premium','8','0,06','0,06');
Insert into PSE1.UMSATZKLASSE (UMSATZKLASSENBEZEICHNER,UMSATZKLASSENID,UMSATZKLASSENPROVISION,UMSATZKLASSENBESTEUERUNGSSATZ) values ('High Level Free','9','0','0,06');
Insert into PSE1.UMSATZKLASSE (UMSATZKLASSENBEZEICHNER,UMSATZKLASSENID,UMSATZKLASSENPROVISION,UMSATZKLASSENBESTEUERUNGSSATZ) values ('Partner Level','10','0,01','0,06');
Insert into PSE1.UMSATZKLASSE (UMSATZKLASSENBEZEICHNER,UMSATZKLASSENID,UMSATZKLASSENPROVISION,UMSATZKLASSENBESTEUERUNGSSATZ) values ('Starter No Tax','11','0,05','0');
Insert into PSE1.UMSATZKLASSE (UMSATZKLASSENBEZEICHNER,UMSATZKLASSENID,UMSATZKLASSENPROVISION,UMSATZKLASSENBESTEUERUNGSSATZ) values ('Mid Level No Tax','12','0,04','0');
Insert into PSE1.UMSATZKLASSE (UMSATZKLASSENBEZEICHNER,UMSATZKLASSENID,UMSATZKLASSENPROVISION,UMSATZKLASSENBESTEUERUNGSSATZ) values ('High Level No Tax','13','0,03','0');
Insert into PSE1.UMSATZKLASSE (UMSATZKLASSENBEZEICHNER,UMSATZKLASSENID,UMSATZKLASSENPROVISION,UMSATZKLASSENBESTEUERUNGSSATZ) values ('Partner Level No Tax','14','0,01','0');
--------------------------------------------------------
--  DDL for Index UMSATZKLASSE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PSE1"."UMSATZKLASSE_PK" ON "PSE1"."UMSATZKLASSE" ("UMSATZKLASSENID") 
  ;
--------------------------------------------------------
--  Constraints for Table UMSATZKLASSE
--------------------------------------------------------

  ALTER TABLE "PSE1"."UMSATZKLASSE" MODIFY ("UMSATZKLASSENBEZEICHNER" NOT NULL ENABLE);
  ALTER TABLE "PSE1"."UMSATZKLASSE" MODIFY ("UMSATZKLASSENID" NOT NULL ENABLE);
  ALTER TABLE "PSE1"."UMSATZKLASSE" ADD CONSTRAINT "UMSATZKLASSE_PK" PRIMARY KEY ("UMSATZKLASSENID")
  USING INDEX  ENABLE;
