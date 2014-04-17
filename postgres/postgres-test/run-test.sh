#!/bin/bash
#

# check if data exists and is empty. If, initialize a db there
#
if [ ! -d /data ]; then
    echo "[run-test.sh] Cannot run without a /data volume. Please specify -v for docker run command.";
    exit 1;
fi

if [[ $EUID != 9876 ]]; then
    echo "[run-test.sh] must run as postgres user (9876)";
    exit 1;
fi

if [ "$(ls -A /data)" ]; then
    echo "[run-test.sh] /data has file, starting up database there.";
else
    echo "[run-test.sh] /data is empty; initdb on it.";
    # create a password file for initdb
    #
    touch /tmp/pg_passwdfile
    echo "test" >> /tmp/pg_passwdfile
    initdb -D /data -U pg-admin -E "UTF-8" --pwfile=/tmp/pg_passwdfile
    cp postgresql.conf /data/postgresql.conf
    cp pg_hba.conf /data/pg_hba.conf
fi

# exec postgres, so that docker stop signals will work
#
echo "[run-test.sh] starting postgres..."
exec postgres -D /data -d 1