#!/bin/bash

db_name=$1
db_user=$2

# Create database schema
echo Creating database schema...
psql -d $db_name -U $db_user -f myldb.sql
echo done!
# Import modes table
echo Importing modes...
psql -d $db_name -U $db_user -c "\COPY modes (mid,name,avg_speed) FROM './ref-data/modes.csv' WITH CSV HEADER"
echo done!
# Import users table
echo Importing users...
psql -d $db_name -U $db_user -c "\COPY users (uid,gender,email,birthday,deathday,education,name,disabled) FROM './ref-data/users.csv' WITH CSV HEADER"
echo done!
# Import mobileprofiles table
echo Importing mobileprofiles...
psql -d $db_name -U $db_user -c "\COPY mobileprofiles (mpid,user_id,mode_id,priority) FROM './ref-data/mobileprofiles.csv' WITH CSV HEADER"
echo done!
# Import places table which has spatial info with GDAL ogr2ogr
echo Importing places with ogr2ogr...
ogr2ogr -overwrite -f "PostgreSQL" -lco GEOMETRY_NAME=the_geom -lco FID=pid PG:"host=localhost user=$db_user dbname=$db_name" ./ref-data/places.vrt -nln places
echo done!
# Add a foreign key to spatialinfo referening places table
echo Adding foregin key...
psql -d $db_name -U $db_user -c "ALTER TABLE \"spatialinfo\" ADD CONSTRAINT \"fk_spatialinfo_places_1\" FOREIGN KEY (\"place_id\") REFERENCES \"places\" (\"pid\");"
echo done!
# Import spatialinfo table
echo Importing spatialinfo...
psql -d $db_name -U $db_user -c "\COPY spatialinfo (sid,place_id,description) FROM './ref-data/spatialinfo.csv' WITH CSV HEADER"
echo done!
# Import events table
echo Importing events...
psql -d $db_name -U $db_user -c "\COPY events (eid,space_id,started_at,duration,description) FROM './ref-data/events.csv' WITH CSV HEADER"
echo done!
# Import participants table
echo Importing participants...
psql -d $db_name -U $db_user -c "\COPY participants (pid,user_id,event_id) FROM './ref-data/participants.csv' WITH CSV HEADER"
echo done!
# Import transportinfo table
echo Importing transportinfo...
psql -d $db_name -U $db_user -c "\COPY transportinfo (tid,cost,duration,distance,description,event_id) FROM './ref-data/transportinfo.csv' WITH CSV HEADER"
echo done!
# Import transportmodes table
echo Importing transportmodes...
psql -d $db_name -U $db_user -c "\COPY transportmodes (tmid,mode_id,transinfo_id) FROM './ref-data/transportmodes.csv' WITH CSV HEADER"
echo done!
# TODO: It is also necessary to import some tracks from external dataset like GPX, 
# and then create a foreign key relation between the tracks and spatialinfo tables
