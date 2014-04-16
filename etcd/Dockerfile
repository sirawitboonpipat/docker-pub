# This dockerfile is basically exactly the same as https://github.com/coreos/etcd/Dockerfile
# except it pulls a specific release version from github and uses that.
#

FROM ubuntu:12.04
# Let's install go just like Docker (from source).
RUN apt-get update -q
RUN apt-get install -qy build-essential curl git
RUN curl -s https://go.googlecode.com/files/go1.2.src.tar.gz | tar -v -C /usr/local -xz
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1
ENV PATH /usr/local/go/bin:$PATH
RUN cd /opt/ && curl -L https://github.com/coreos/etcd/archive/v0.3.0.tar.gz -o etcd-0.3.0.tar.gz
RUN cd /opt/ && tar zxf etcd-0.3.0.tar.gz && mv etcd-0.3.0 etcd
RUN cd /opt/etcd && ./build
EXPOSE 4001 7001
ENTRYPOINT ["/opt/etcd/bin/etcd"]

#
# build:  docker build -t jamesm/etcd:0.3.0 .
# run:    docker run -d -P -v /data --name=etcd-dev jamesm/etcd:0.3.0 -name etcd-dev0 -data-dir /data -v
#
