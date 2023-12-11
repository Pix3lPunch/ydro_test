FROM ubuntu:20.04
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y python${PYTHON_VER} python3-setuptools dh-python python3-pip
RUN apt-get install -y build-essential fakeroot devscripts debhelper dh-make
RUN mkdir -p /build/src
RUN mkdir -p /package
WORKDIR /build
COPY /scripts/build_deb.sh /build/build_deb.sh
COPY .env /build/.env
RUN chmod +x /build/build_deb.sh
ENTRYPOINT ./build_deb.sh
