#!/bin/bash
#

NAME=pg-cli
PG_CONTAINER=pg0

# try to run it, if you can then try too attach to it
#
docker run -i -t --link=$PG_CONTAINER=pg0:pg --name=$NAME \
    jamesm/postgres-base /bin/bash

if [ $? -ne 0 ]; then 
    echo "Attempting to attach to $NAME, might need to hit enter a few times... "
    docker attach $NAME
fi