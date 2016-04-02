ALTER TABLE "public"."mobileprofiles" DROP CONSTRAINT "fk_mobileprofiles_users_1";
ALTER TABLE "public"."mobileprofiles" DROP CONSTRAINT "fk_mobileprofiles_transportmodes_1";
ALTER TABLE "public"."lifelines" DROP CONSTRAINT "fk_lifelines_users_1";
ALTER TABLE "public"."participants" DROP CONSTRAINT "fk_participants_users_1";
ALTER TABLE "public"."participants" DROP CONSTRAINT "fk_participants_events_1";
ALTER TABLE "public"."events" DROP CONSTRAINT "fk_events_spatialinfo_1";
ALTER TABLE "public"."spatialinfo" DROP CONSTRAINT "fk_spatialinfo_places_1";
ALTER TABLE "public"."events" DROP CONSTRAINT "fk_events_transportinfo_1";
ALTER TABLE "public"."tracks" DROP CONSTRAINT "fk_tracks_spatialinfo_1";
ALTER TABLE "public"."transportmodes" DROP CONSTRAINT "fk_transportmodes_modes_1";
ALTER TABLE "public"."transportmodes" DROP CONSTRAINT "fk_transportmodes_transportinfo_1";

ALTER TABLE "public"."users" DROP CONSTRAINT "";
ALTER TABLE "public"."events" DROP CONSTRAINT "";
ALTER TABLE "public"."places" DROP CONSTRAINT "";
ALTER TABLE "public"."tracks" DROP CONSTRAINT "";
ALTER TABLE "public"."modes" DROP CONSTRAINT "";
ALTER TABLE "public"."participants" DROP CONSTRAINT "";
ALTER TABLE "public"."spatialinfo" DROP CONSTRAINT "";
ALTER TABLE "public"."mobileprofiles" DROP CONSTRAINT "";

DROP TABLE "public"."users";
DROP TABLE "public"."events";
DROP TABLE "public"."places";
DROP TABLE "public"."lifelines";
DROP TABLE "public"."tracks";
DROP TABLE "public"."modes";
DROP TABLE "public"."participants";
DROP TABLE "public"."spatialinfo";
DROP TABLE "public"."mobileprofiles";
DROP TABLE "public"."transportinfo";
DROP TABLE "public"."transportmodes";

CREATE TABLE "public"."users" (
"uid" int8 NOT NULL,
"gender" int2,
"email" varchar(255) NOT NULL,
"birthday" date,
"education" varchar(255),
"name" varchar(255),
"disabled" varchar(255),
PRIMARY KEY ("uid") ,
UNIQUE ("uid")
)
WITHOUT OIDS;

CREATE TABLE "public"."events" (
"eid" int8 NOT NULL,
"space_id" int8 NOT NULL,
"transport_id" int8 NOT NULL,
"started_at" timestamp(0) NOT NULL,
"duration" interval(0) NOT NULL,
"description" varchar(255),
PRIMARY KEY ("eid") ,
UNIQUE ("eid")
)
WITHOUT OIDS;

CREATE TABLE "public"."places" (
"pid" int8 NOT NULL,
"name" varchar(255) NOT NULL,
"geometry" point NOT NULL,
PRIMARY KEY ("pid") ,
UNIQUE ("pid")
)
WITHOUT OIDS;

CREATE TABLE "public"."lifelines" (
"user_id" int8 NOT NULL,
PRIMARY KEY ("user_id") 
)
WITHOUT OIDS;

CREATE TABLE "public"."tracks" (
"tid" int8 NOT NULL,
"geometry" line NOT NULL,
"description" varchar(255),
"space_id" int8,
PRIMARY KEY ("tid") ,
UNIQUE ("tid")
)
WITHOUT OIDS;

CREATE TABLE "public"."modes" (
"mid" int8 NOT NULL,
"avg_speed" float4 NOT NULL,
"name" varchar(255) NOT NULL,
PRIMARY KEY ("mid") ,
UNIQUE ("mid")
)
WITHOUT OIDS;

CREATE TABLE "public"."participants" (
"pid" int8 NOT NULL,
"user_id" int8 NOT NULL,
"event_id" int8 NOT NULL,
PRIMARY KEY ("pid") ,
UNIQUE ("pid")
)
WITHOUT OIDS;

CREATE TABLE "public"."spatialinfo" (
"sid" int8 NOT NULL,
"place_id" int8 NOT NULL,
"description" varchar(255),
PRIMARY KEY ("sid") ,
UNIQUE ("sid")
)
WITHOUT OIDS;

CREATE TABLE "public"."mobileprofiles" (
"mpid" int8 NOT NULL,
"user_id" int8 NOT NULL,
"mode_id" int8 NOT NULL,
"priority" int4 NOT NULL DEFAULT 1,
PRIMARY KEY ("mpid") ,
UNIQUE ("mpid")
)
WITHOUT OIDS;

CREATE TABLE "public"."transportinfo" (
"tid" int8 NOT NULL,
"cost" float8,
"duration" interval(0),
"distance" float8,
"description" varchar(255),
PRIMARY KEY ("tid") 
)
WITHOUT OIDS;

CREATE TABLE "public"."transportmodes" (
"tmid" int8 NOT NULL,
"mode_id" int8 NOT NULL,
"transinfo_id" int8 NOT NULL,
PRIMARY KEY ("tmid") 
)
WITHOUT OIDS;


ALTER TABLE "public"."mobileprofiles" ADD CONSTRAINT "fk_mobileprofiles_users_1" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("uid") ON DELETE CASCADE;
ALTER TABLE "public"."mobileprofiles" ADD CONSTRAINT "fk_mobileprofiles_transportmodes_1" FOREIGN KEY ("mode_id") REFERENCES "public"."modes" ("mid");
ALTER TABLE "public"."lifelines" ADD CONSTRAINT "fk_lifelines_users_1" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("uid");
ALTER TABLE "public"."participants" ADD CONSTRAINT "fk_participants_users_1" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("uid");
ALTER TABLE "public"."participants" ADD CONSTRAINT "fk_participants_events_1" FOREIGN KEY ("event_id") REFERENCES "public"."events" ("eid");
ALTER TABLE "public"."events" ADD CONSTRAINT "fk_events_spatialinfo_1" FOREIGN KEY ("space_id") REFERENCES "public"."spatialinfo" ("sid");
ALTER TABLE "public"."spatialinfo" ADD CONSTRAINT "fk_spatialinfo_places_1" FOREIGN KEY ("place_id") REFERENCES "public"."places" ("pid");
ALTER TABLE "public"."events" ADD CONSTRAINT "fk_events_transportinfo_1" FOREIGN KEY ("transport_id") REFERENCES "public"."transportinfo" ("tid");
ALTER TABLE "public"."tracks" ADD CONSTRAINT "fk_tracks_spatialinfo_1" FOREIGN KEY ("space_id") REFERENCES "public"."spatialinfo" ("sid");
ALTER TABLE "public"."transportmodes" ADD CONSTRAINT "fk_transportmodes_modes_1" FOREIGN KEY ("mode_id") REFERENCES "public"."modes" ("mid");
ALTER TABLE "public"."transportmodes" ADD CONSTRAINT "fk_transportmodes_transportinfo_1" FOREIGN KEY ("transinfo_id") REFERENCES "public"."transportinfo" ("tid");

