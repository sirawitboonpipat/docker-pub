#!/bin/bash
#
docker build -t jamesm/redis-base:2.6.16 base/2.6.16
docker build -t jamesm/redis-base:2.8.1 base/2.8.1
# this image_id hockyness should be elliminated when this bug comes down in
# 0.8.0: https://github.com/dotcloud/docker/issues/2659
#
IMAGE_ID_2_6_16=$(docker images jamesm/redis-base | grep 2.6.16 | awk '{print $3}')
IMAGE_ID_2_8_1=$(docker images jamesm/redis-base | grep 2.8.1 | awk '{print $3}')
docker tag $IMAGE_ID_2_8_1 jamesm/redis-base:latest
docker build -t jamesm/redis-standalone:2.8.1 standalone
docker build -t jamesm/redis-slave:2.8.1 slave
docker tag $IMAGE_ID_2_6_16 jamesm/redis-base:latest
docker build -t jamesm/redis-standalone:2.6.16 standalone
docker build -t jamesm/redis-slave:2.6.16 slave
