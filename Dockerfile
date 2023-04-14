FROM debian:11

ARG PODMAN_VERSION=4.4.5
ARG CONMON_VERSION=2.1.7
RUN apt update

RUN apt install wget btrfs-progs git iptables libassuan-dev libbtrfs-dev libc6-dev libdevmapper-dev libglib2.0-dev libgpgme-dev libgpg-error-dev libprotobuf-dev libprotobuf-c-dev  libseccomp-dev libselinux1-dev libsystemd-dev pkg-config runc uidmap make curl vim gcc -y

RUN wget https://storage.googleapis.com/golang/getgo/installer_linux
RUN chmod +x ./installer_linux
RUN SHELL=/bin/bash ./installer_linux

RUN wget https://github.com/containers/podman/archive/refs/tags/v${PODMAN_VERSION}.tar.gz && \
    tar xf v${PODMAN_VERSION}.tar.gz
RUN wget https://github.com/containers/conmon/archive/refs/tags/v${CONMON_VERSION}.tar.gz && \
    tar xf v${CONMON_VERSION}.tar.gz

RUN . /root/.bash_profile && cd podman-*/ && make BUILDTAGS="selinux seccomp systemd"

RUN . /root/.bash_profile && cd conmon-*/ && make
