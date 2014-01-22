FROM jamesm/redis-base:latest
EXPOSE 6379
VOLUME ["/data"]
RUN sysctl vm.overcommit_memory=1
ENTRYPOINT ["/usr/local/bin/redis-server", "--dir", "/data"]

#
# build:  docker build -rm -t jamesm/redis-standalone .
# run:    docker run -d -P -v ~/data/redis0:/data -name=redis0 jamesm/redis-standalone
#
