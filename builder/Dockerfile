FROM ubuntu:20.04
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y python3 python3-setuptools dh-python python3-pip
RUN apt-get install -y build-essential fakeroot devscripts debhelper dh-make
ADD ./scripts /scripts
ENTRYPOINT ./scripts/build_deb.sh