ALTER TABLE "users" DROP CONSTRAINT "fk_users_lifelines_1";
ALTER TABLE "transportmodes" DROP CONSTRAINT "fk_transportmodes_events_1";
ALTER TABLE "users" DROP CONSTRAINT "fk_users_participants_1";
ALTER TABLE "events" DROP CONSTRAINT "fk_events_participants_1";
ALTER TABLE "tracks" DROP CONSTRAINT "fk_tracks_spatialinfo_1";
ALTER TABLE "places" DROP CONSTRAINT "fk_places_spatialinfo_1";
ALTER TABLE "spatialinfo" DROP CONSTRAINT "fk_spatialinfo_events_1";

DROP TABLE "users";
DROP TABLE "events";
DROP TABLE "places";
DROP TABLE "lifelines";
DROP TABLE "tracks";
DROP TABLE "transportmodes";
DROP TABLE "participants";
DROP TABLE "spatialinfo";

CREATE TABLE "users" (
"uid" int8 NOT NULL,
"gender" int2,
"email" varchar(255),
"birthday" date,
"education" varchar(255),
"can_drive" varchar(255),
"name" varchar(255),
"disabled" varchar(255),
"can_ride_bicycle" varchar(255),
"can_ship" varchar(255),
"can_fly" varchar(255),
PRIMARY KEY ("uid") 
)
WITHOUT OIDS;

CREATE TABLE "events" (
"eid" int8 NOT NULL,
"space_id" int8,
"mode_id" int8 NOT NULL,
"started_at" timestamp(255) NOT NULL,
"duration" interval(255) NOT NULL,
"description" varchar(255),
PRIMARY KEY ("eid") 
)
WITHOUT OIDS;

CREATE TABLE "places" (
"pid" int8 NOT NULL,
"name" varchar(255),
"geometry" point NOT NULL,
PRIMARY KEY ("pid") 
)
WITHOUT OIDS;

CREATE TABLE "lifelines" (
"uid" int8 NOT NULL,
PRIMARY KEY ("uid") 
)
WITHOUT OIDS;

CREATE TABLE "tracks" (
"tid" int8 NOT NULL,
"geometry" line NOT NULL,
"description" varchar(255),
PRIMARY KEY ("tid") 
)
WITHOUT OIDS;

CREATE TABLE "transportmodes" (
"mid" int8 NOT NULL,
"average_speed" float4,
"name" varchar(255),
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
"track_id" int8,
"description" varchar(255),
PRIMARY KEY ("sid") 
)
WITHOUT OIDS;


ALTER TABLE "users" ADD CONSTRAINT "fk_users_lifelines_1" FOREIGN KEY ("uid") REFERENCES "lifelines" ("uid");
ALTER TABLE "transportmodes" ADD CONSTRAINT "fk_transportmodes_events_1" FOREIGN KEY ("mid") REFERENCES "events" ("mode_id");
ALTER TABLE "users" ADD CONSTRAINT "fk_users_participants_1" FOREIGN KEY ("uid") REFERENCES "participants" ("user_id");
ALTER TABLE "events" ADD CONSTRAINT "fk_events_participants_1" FOREIGN KEY ("eid") REFERENCES "participants" ("event_id");
ALTER TABLE "tracks" ADD CONSTRAINT "fk_tracks_spatialinfo_1" FOREIGN KEY ("tid") REFERENCES "spatialinfo" ("track_id");
ALTER TABLE "places" ADD CONSTRAINT "fk_places_spatialinfo_1" FOREIGN KEY ("pid") REFERENCES "spatialinfo" ("place_id");
ALTER TABLE "spatialinfo" ADD CONSTRAINT "fk_spatialinfo_events_1" FOREIGN KEY ("sid") REFERENCES "events" ("space_id");

