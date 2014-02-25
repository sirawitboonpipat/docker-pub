FROM ubuntu:12.10
MAINTAINER James McKernan james@hvflabs.com
RUN apt-get update
RUN apt-get install -y curl git mercurial bzr
RUN curl -O https://go.googlecode.com/files/go1.2.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.2.linux-amd64.tar.gz
# "install" go commands
RUN cd /usr/local/go/bin && for i in *; do ln -s /usr/local/go/bin/$i /usr/local/bin/$i; done;
VOLUME ["/gocode/src"]
ENV GOROOT /usr/local/go
ENV GOPATH /gocode
ENV PATH /gocode/bin:$PATH
#
# build:  docker build -t jamesm/golang-base:1.2 .
# run:    docker run -i -t -v $GOPATH:/gocode/src -name go1.2 jamesm/golang-base:1.2 /bin/bash
#
