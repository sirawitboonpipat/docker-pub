FROM jamesm/postgres-base:latest
MAINTAINER James McKernan james@hvflabs.com
# NOTE this runtime configuration assumes some stuff:
#   - a postgres user has been created on the host with
#     a uid / gid of 9876 so that it matches up with the
#     user / group created in the postgres-base image
#   - the directory we map into the data volume /data
#     is owned by this user and has initdb run on it.
#
VOLUME ["/data"]
EXPOSE 5432
USER postgres 

# build: docker build -t jamesm/postgres-test .
# run:   docker run -d -name=pg-test -v /tmp/postgres_test:/data -u postgres -P jamesm/postgres-test
