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
# STEP 1 - create postgres user on host that
#   will mirror the user in the container.
#
sudo groupadd -g 9876 postgres
sudo useradd -u 9876 -g 9876 -r postgres
sudo mkdir -p $DATADIR 
sudo chown postgres:postgres $DATADIR

# STEP 2 - build the base image with the base/
docker build -t jamesm/postgres-base:$VERSION base/$VERSION
IMAGE_ID=$(docker images jamesm/postgres-base | grep $VERSION | awk '{print $3}')
echo "base image id is $IMAGE_ID";
docker tag $IMAGE_ID jamesm/postgres-base:latest

# STEP 3 - init the datadir with the initdb 
#
docker run -i -t -v $DATADIR:/data -u postgres jamesm/postgres-base initdb -D /data -U $PG_SUPERUSER -W

echo "
db in $DATADIR initialized. Please configure it before building
the runtime image with buid_runtime.sh

the primary config files are 
  $DATADIR/pg_hba.conf
  $DATADIR/postgresql.conf
  $DATADIR/pg_ident.conf

and a sample dev config simply adds something like:

host    all             all             0.0.0.0/0               md5

to pg_hbf.conf for password auth on all interfaces, and 

listen_addresses='*'

to postgresql.conf, to listen on all interfaces.
"


