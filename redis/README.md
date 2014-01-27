Redis On Docker
==========
Building redis for use with docker. We break things up into 3 logical kinds of
containers:

Base: used to install the version of redis we want. Versions are 2.6.16 and
2.8.1. NOTE that each of these Dockerfile ADD the a tarball of the form
redis-{version}.tar.gz so those must be in the appropriate directory. They can
be dowloaded from: http://download.redis.io/releases/

Standalone: uses base as a, well, base, and adds directives like EXPOSE and
VOLUME and ENTRYPOINT. Call a "runtime container."

Slave: adds more runtime directives as Standalone, but also add a
start-slave.sh script. This script which uses the env vars created with running
the container with -link.

To build these images, a build script is included. Execute ./build.sh to build
all image types and then docker images to inspect them.


