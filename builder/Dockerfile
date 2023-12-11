FROM ubuntu:20.04
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y python3 python3-setuptools dh-python python3-pip
RUN apt-get install -y build-essential fakeroot devscripts debhelper dh-make
RUN mkdir -p /build/src
WORKDIR /build
COPY /scripts/make_deb.sh /build/make_deb.sh
RUN chmod +x /build/make_deb.sh
ENTRYPOINT ./build_deb.sh
