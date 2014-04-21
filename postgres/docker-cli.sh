#!/bin/bash
#

if [ $# != 1 ]; then
    echo "usage: docker-cli.sh {pg container to link to}";
    exit 1
fi

PG_CONTAINER=$1
NAME=$1-cli

C_STATE=$(docker inspect -f '{{.State.Running}}' $NAME)
if [ $? -ne 0 ]; then
    echo "Seems lik container never created. Doing so now....";
    # try to run it, if you can then try too attach to it
    #
    docker run -d -i -t --link=$PG_CONTAINER:pg --name=$NAME \
        jamesm/postgres-base:latest /bin/bash
    if [ $? -ne 0 ]; then
        echo "Unable to create $NAME. Exiting... ";
        exit 1;
    else 
        C_STATE=$(docker inspect -f '{{.State.Running}}' $NAME)
    fi

fi
if [ $C_STATE == "false" ]; then
    echo "$NAME stopped, starting... ";
    docker start $NAME
    if [ $? -ne 0 ]; then 
        echo "Unable to start $NAME, exiting... ";
        exit 1;
    fi
    C_STATE=$(docker inspect -f '{{.State.Running}}' $NAME)
fi
echo "$NAME running: $C_STATE"
echo "Attaching... (may have to hit enter a few times to see prompt... "
docker attach $NAME