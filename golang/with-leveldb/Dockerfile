FROM jamesm/golang-base:1.2
ADD ctl ctl
RUN apt-get install --yes build-essential subversion git
RUN sh /ctl/setup
ENV CGO_CFLAGS -I/leveldb/include
ENV CGO_LDFLAGS -L/leveldb
ENV LD_LIBRARY_PATH /leveldb

#
# build:  docker build -t jamesm/golang:with-leveldb .
# run:    docker run -i -t -v $GOPATH:/gocode/src -name go-lvldb jamesm/golang:with-leveldb /bin/bash
#