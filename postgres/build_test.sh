#!/bin/bash
#

DATADIR=/tmp/postgres_test
PASSWD_TMP=/tmp/postgres_passwd_tmp
PASSWD_TMP_FILE=$PASSWD_TMP/badpassword.txt
PG_SUPERUSER=pg_tester
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

# STEP 3 - init the datadir with the initdb. we create a password file for 
# reference during initdb
#
mkdir -p $PASSWD_TMP
echo "test" > $PASSWD_TMP_FILE 
sudo chown postgres:postgres $PASSWD_TMP_FILE
docker run -i -t -v $DATADIR:/data -v /tmp:/tmp -u postgres jamesm/postgres-base initdb -D /data -U $PG_SUPERUSER --pwfile=$PASSWD_TMP_FILE
sudo echo -e "host    all             all             0.0.0.0/0               md5\n" >> $DATADIR/pg_hbf.conf
sudo echo -e "listen_addresses='*'\n" >> $DATADIR/postgres.conf

# STEP 4 - build the runtime image in postgres
#
docker build -t jamesm/postgres-testdb:$VERSION postgres
IMAGE_ID=$(docker images jamesm/postgres-testdb | grep $VERSION | awk '{print $3}')
echo "runtime image id is $IMAGE_ID";
docker tag $IMAGE_ID jamesm/postgres-testdb:latest

