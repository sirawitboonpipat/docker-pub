#!/bin/bash
#

# pull in some params
#
if [ $# -ne 2 ]; then
    echo "Invalid input. usage:";
    echo "  build.sh {datadir} {postgres superuser name}";
    exit 1;
fi
DATADIR=$1
PG_SUPERUSER=$2
VERSION=9.3.2

# STEP 4 - build the runtime image in postgres
#
docker build -t jamesm/postgres:$VERSION postgres
IMAGE_ID=$(docker images jamesm/postgres | grep $VERSION | awk '{print $3}')
echo "runtime image id is $IMAGE_ID";
docker tag $IMAGE_ID jamesm/postgres:latest
echo "
GREAT SUCCESS!! 
TO RUN, try something like: 

  docker run -d --name=pg0 -v $DATADIR:/data -u postgres -P jamesm/postgres

and then connect to and create a db with:

  docker run -i -t --link=pg0:pg --name=pg-cli jamesm/postgres-base /bin/bash
  > createdb -h \$PG_PORT_5432_TCP_ADDR -p \$PG_PORT_5432_TCP_PORT -U $PG_SUPERUSER -W test
  > psql -h \$PG_PORT_5432_TCP_ADDR -p \$PG_PORT_5432_TCP_PORT -U $PG_SUPERUSER -W test

";

