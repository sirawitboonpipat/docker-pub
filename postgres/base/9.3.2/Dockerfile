FROM ubuntu:12.10
MAINTAINER James McKernan james@hvflabs.com
RUN apt-get update
# pre-packages
#
RUN apt-get install -y wget
RUN wget --quiet http://ftp.postgresql.org/pub/source/v9.3.2/postgresql-9.3.2.tar.gz && tar xzf postgresql-9.3.2.tar.gz
RUN apt-get install -y build-essential libreadline-dev zlib1g-dev

# user / group setup. NOTE that it is helpful
# for these to uid / gids to match what's created on the host
# system below
#
RUN groupadd -g 9876 postgres
RUN useradd -u 9876 -g 9876 -r postgres
# build it
#
RUN cd postgresql-9.3.2 && ./configure --bindir=/usr/local/bin
RUN cd postgresql-9.3.2 && make world
RUN cd postgresql-9.3.2 && make install
RUN cd postgresql-9.3.2/contrib && make install



ADD cli-env.sh cli-env.sh

# build: docker build -t jamesm/postgres-base:9.3.2 .
# run [initdb] 
#    groupadd -g 9876 postgres
#    useradd -u 9876 -g 9876 -r postgres
#    mkdir -p ~/data/pg-data
#    chown postgres:postgres ~/data/pg-data
#    docker run -i -t -v ~/data/pg-data:/data -u postgres jamesm/postgres-base initdb -D /data -U pgadmin -W
#
