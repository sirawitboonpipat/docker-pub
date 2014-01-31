FROM ubuntu:12.10
MAINTAINER James McKernan james@hvflabs.com
RUN apt-get update
RUN apt-get install -y build-essential
ADD redis-2.6.16.tar.gz redis-2.6.16.tar.gz
RUN tar xvfz redis-2.6.16.tar.gz
RUN cd redis-2.6.16 && make 
RUN cd redis-2.6.16 && make install 

#
# build:  docker build -t jamesm/redis-base:2.6.16 .
# run:    docker run -i -t jamesm/redis-base:2.6.16 /bin/bash 
#  (cli)  docker run -link=redis0:redis -i -t -name=redis-cli jamesm/redis-base /bin/bash 
#
