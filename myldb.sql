ALTER TABLE "mobileprofiles" DROP CONSTRAINT "fk_mobileprofiles_users_1";
ALTER TABLE "mobileprofiles" DROP CONSTRAINT "fk_mobileprofiles_transportmodes_1";
ALTER TABLE "lifelines" DROP CONSTRAINT "fk_lifelines_users_1";
ALTER TABLE "participants" DROP CONSTRAINT "fk_participants_users_1";
ALTER TABLE "participants" DROP CONSTRAINT "fk_participants_events_1";
ALTER TABLE "events" DROP CONSTRAINT "fk_events_spatialinfo_1";
ALTER TABLE "spatialinfo" DROP CONSTRAINT "fk_spatialinfo_places_1";
ALTER TABLE "tracks" DROP CONSTRAINT "fk_tracks_spatialinfo_1";
ALTER TABLE "transportmodes" DROP CONSTRAINT "fk_transportmodes_modes_1";
ALTER TABLE "transportmodes" DROP CONSTRAINT "fk_transportmodes_transportinfo_1";
ALTER TABLE "transportinfo" DROP CONSTRAINT "fk_transportinfo_events_1";

DROP TABLE "users";
DROP TABLE "events";
DROP TABLE "places";
DROP TABLE "lifelines";
DROP TABLE "tracks";
DROP TABLE "modes";
DROP TABLE "participants";
DROP TABLE "spatialinfo";
DROP TABLE "mobileprofiles";
DROP TABLE "transportinfo";
DROP TABLE "transportmodes";

CREATE TABLE "users" (
"uid" int8 NOT NULL,
"gender" varchar(255),
"email" varchar(255) NOT NULL,
"birthday" date,
"deathday" date,
"education" varchar(255),
"name" varchar(255),
"disabled" varchar(255),
PRIMARY KEY ("uid") 
)
WITHOUT OIDS;

CREATE TABLE "events" (
"eid" int8 NOT NULL,
"space_id" int8 NOT NULL,
"started_at" timestamptz(0) NOT NULL,
"duration" interval(0) NOT NULL,
"description" varchar(255),
PRIMARY KEY ("eid") 
)
WITHOUT OIDS;

CREATE TABLE "places" (
"pid" int8 NOT NULL,
"name" varchar(255) NOT NULL,
"geometry" point NOT NULL,
PRIMARY KEY ("pid") 
)
WITHOUT OIDS;

CREATE TABLE "lifelines" (
"lid" int8 NOT NULL,
"user_id" int8 NOT NULL,
PRIMARY KEY ("lid") 
)
WITHOUT OIDS;

CREATE TABLE "tracks" (
"tid" int8 NOT NULL,
"geometry" line NOT NULL,
"description" varchar(255),
"space_id" int8,
PRIMARY KEY ("tid") 
)
WITHOUT OIDS;

CREATE TABLE "modes" (
"mid" int8 NOT NULL,
"name" varchar(255) NOT NULL,
"avg_speed" float4 NOT NULL,
PRIMARY KEY ("mid") 
)
WITHOUT OIDS;

CREATE TABLE "participants" (
"pid" int8 NOT NULL,
"user_id" int8 NOT NULL,
"event_id" int8 NOT NULL,
PRIMARY KEY ("pid") 
)
WITHOUT OIDS;

CREATE TABLE "spatialinfo" (
"sid" int8 NOT NULL,
"place_id" int8 NOT NULL,
"description" varchar(255),
PRIMARY KEY ("sid") 
)
WITHOUT OIDS;

CREATE TABLE "mobileprofiles" (
"mpid" int8 NOT NULL,
"user_id" int8 NOT NULL,
"mode_id" int8 NOT NULL,
"priority" int4 NOT NULL DEFAULT 1,
PRIMARY KEY ("mpid") 
)
WITHOUT OIDS;

CREATE TABLE "transportinfo" (
"tid" int8 NOT NULL,
"cost" float8,
"duration" interval(0),
"distance" float8,
"description" varchar(255),
"event_id" int8,
PRIMARY KEY ("tid") 
)
WITHOUT OIDS;

CREATE TABLE "transportmodes" (
"tmid" int8 NOT NULL,
"mode_id" int8 NOT NULL,
"transinfo_id" int8 NOT NULL,
PRIMARY KEY ("tmid") 
)
WITHOUT OIDS;


ALTER TABLE "mobileprofiles" ADD CONSTRAINT "fk_mobileprofiles_users_1" FOREIGN KEY ("user_id") REFERENCES "users" ("uid") ON DELETE CASCADE;
ALTER TABLE "mobileprofiles" ADD CONSTRAINT "fk_mobileprofiles_transportmodes_1" FOREIGN KEY ("mode_id") REFERENCES "modes" ("mid");
ALTER TABLE "lifelines" ADD CONSTRAINT "fk_lifelines_users_1" FOREIGN KEY ("user_id") REFERENCES "users" ("uid");
ALTER TABLE "participants" ADD CONSTRAINT "fk_participants_users_1" FOREIGN KEY ("user_id") REFERENCES "users" ("uid");
ALTER TABLE "participants" ADD CONSTRAINT "fk_participants_events_1" FOREIGN KEY ("event_id") REFERENCES "events" ("eid");
ALTER TABLE "events" ADD CONSTRAINT "fk_events_spatialinfo_1" FOREIGN KEY ("space_id") REFERENCES "spatialinfo" ("sid");
ALTER TABLE "spatialinfo" ADD CONSTRAINT "fk_spatialinfo_places_1" FOREIGN KEY ("place_id") REFERENCES "places" ("pid");
ALTER TABLE "tracks" ADD CONSTRAINT "fk_tracks_spatialinfo_1" FOREIGN KEY ("space_id") REFERENCES "spatialinfo" ("sid");
ALTER TABLE "transportmodes" ADD CONSTRAINT "fk_transportmodes_modes_1" FOREIGN KEY ("mode_id") REFERENCES "modes" ("mid");
ALTER TABLE "transportmodes" ADD CONSTRAINT "fk_transportmodes_transportinfo_1" FOREIGN KEY ("transinfo_id") REFERENCES "transportinfo" ("tid");
ALTER TABLE "transportinfo" ADD CONSTRAINT "fk_transportinfo_events_1" FOREIGN KEY ("event_id") REFERENCES "events" ("eid");

