FROM jamesm/redis-base:latest
EXPOSE 6379
VOLUME ["/data"]
RUN sysctl vm.overcommit_memory=1
ADD start-slave.sh start-slave.sh
ENTRYPOINT ["./start-slave.sh", "--dir", "/data"]
#
# build:  docker build -t jamesm/redis-slave .
# run:    docker run -d -P -name=redis0_slave -link=redis0:redis_master jamesm/redis-slave 
#
