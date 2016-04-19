#!/usr/bin/bash

db_name=$1
db_user=$2

psql -d $db_name -U $db_user -f myldb.sql
psql -d $db_name -U $db_user -c "\COPY modes (mode_name,mode_id) FROM './ref-data/modes.csv' WITH CSV HEADER"
ogr2ogr -overwrite -f "PostgreSQL" -lco GEOMETRY_NAME=the_geom -lco FID=pid PG:"host=localhost user=$db_user dbname=$db_name" places.vrt -nln places
