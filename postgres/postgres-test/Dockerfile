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
ADD run-test.sh run-test.sh
ADD pg_hba.conf pg_hba.conf
RUN chmod 0655 pg_hba.conf
ADD postgresql.conf postgresql.conf
RUN chmod 0655 postgresql.conf
ENTRYPOINT ["/bin/bash", "/run-test.sh"]

# build: docker build -t jamesm/postgres-test .
# run:   docker run -d -P -v /tmp/pg0/:/data -u postgres --name pg-test jamesm/postgres-test:9.3.2
