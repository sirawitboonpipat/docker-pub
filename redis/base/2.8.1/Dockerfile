FROM ubuntu:12.10
MAINTAINER James McKernan james@hvflabs.com
RUN apt-get update
RUN apt-get install -y build-essential
ADD redis-2.8.1.tar.gz redis-2.8.1.tar.gz
RUN tar xvfz redis-2.8.1.tar.gz
RUN cd redis-2.8.1 && make 
RUN cd redis-2.8.1 && make install 

#
# build:  docker build -rm -t jamesm/redis-base:2.8.1 .
# run:    docker run -rm -i -t jamesm/redis-base:2.8.1 /bin/bash 
#         docker run -rm -link=redis0:redis -i -t jamesm/redis-base /bin/bash 
#
