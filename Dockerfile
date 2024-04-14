ARG DEBIAN=11
FROM debian:${DEBIAN}

ARG PODMAN_VERSION=4.9.0
ARG CONMON_VERSION=2.1.10
RUN apt update

RUN apt install wget btrfs-progs git iptables libassuan-dev libbtrfs-dev libc6-dev libdevmapper-dev libglib2.0-dev libgpgme-dev libgpg-error-dev libprotobuf-dev libprotobuf-c-dev  libseccomp-dev libselinux1-dev libsystemd-dev pkg-config runc uidmap make curl vim gcc -y

RUN curl -L https://dl.google.com/go/go1.22.0.linux-amd64.tar.gz | tar -xz -C /usr/local

RUN wget https://github.com/containers/podman/archive/refs/tags/v${PODMAN_VERSION}.tar.gz && \
    tar xf v${PODMAN_VERSION}.tar.gz
RUN wget https://github.com/containers/conmon/archive/refs/tags/v${CONMON_VERSION}.tar.gz && \
    tar xf v${CONMON_VERSION}.tar.gz

RUN cd podman-*/ && PATH=$PATH:/usr/local/go/bin make BUILDTAGS="selinux seccomp systemd"

RUN cd conmon-*/ && PATH=$PATH:/usr/local/go/bin make
