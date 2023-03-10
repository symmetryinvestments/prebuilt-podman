FROM debian:11

ARG PODMAN_VERSION=4.4.2
RUN apt update

RUN apt install wget btrfs-progs git iptables libassuan-dev libbtrfs-dev libc6-dev libdevmapper-dev libglib2.0-dev libgpgme-dev libgpg-error-dev libprotobuf-dev libprotobuf-c-dev  libseccomp-dev libselinux1-dev libsystemd-dev pkg-config runc uidmap make curl vim gcc -y

RUN wget https://storage.googleapis.com/golang/getgo/installer_linux
RUN chmod +x ./installer_linux
RUN SHELL=/bin/bash ./installer_linux

RUN wget https://github.com/containers/podman/archive/refs/tags/v${PODMAN_VERSION}.tar.gz && \
    tar xvf v${PODMAN_VERSION}.tar.gz

RUN . /root/.bash_profile && cd podman-*/ && make BUILDTAGS="selinux seccomp systemd"
