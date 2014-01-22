#!/bin/bash
#
docker build -t jamesm/redis-base:2.6.16 base/2.6.16
docker build -t jamesm/redis-base:2.8.1 base/2.8.1
LATEST_VERS=2.8.1
# this image_id hockyness should be elliminated when this bug comes down in
# 0.8.0: https://github.com/dotcloud/docker/issues/2659
#
IMAGE_ID_LATEST_BASE=$(docker images jamesm/redis-base | grep $LATEST_VERS | awk '{print $3}')
docker tag $IMAGE_ID_LATEST_BASE jamesm/redis-base:latest

docker build -t jamesm/redis-standalone:2.8.1 standalone
docker build -t jamesm/redis-slave:2.8.1 slave
docker build -t jamesm/redis-standalone:2.6.16 standalone
docker build -t jamesm/redis-slave:2.6.16 slave

IMAGE_ID_LATEST_SDLONE=$(docker images jamesm/redis-standalone | grep $LATEST_VERS | awk '{print $3}')
docker tag $IMAGE_ID_LATEST_SDLONE jamesm/redis-standalone:latest
IMAGE_ID_LATEST_SLAVE=$(docker images jamesm/redis-slave | grep $LATEST_VERS | awk '{print $3}')
docker tag $IMAGE_ID_LATEST_SLAVE jamesm/redis-slave:latest
