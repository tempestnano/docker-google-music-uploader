FROM alpine AS builder

#Download QEMU, see https://github.com/docker/hub-feedback/issues/1261
#ENV QEMU_URL https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-arm.tar.gz
ENV QEMU_URL https://github.com/balena-io/qemu/releases/download/v4.0.0-balena/qemu-4.0.0-balena-arm.tar.gz
RUN apk add curl && curl -L ${QEMU_URL} | tar zxvf - -C . --strip-components 1

FROM arm32v7/python:alpine

# Add QEMU
COPY --from=builder qemu-arm-static /usr/bin

ARG VERSION=1.5.7


LABEL version=${VERSION}

ENV REMOVE=0
ENV ONESHOT=0
ENV UPLOADER_ID=false
ENV DEDUP_API=

RUN apk update && \
    apk add gcc g++ linux-headers libxml2-dev libxslt-dev --no-cache --virtual .build-deps && \
    apk add ffmpeg --no-cache && mkdir /root/oauth/ && \
    pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir google-music-manager-uploader && \
    apk del gcc --purge .build-deps

COPY ./daemon.sh /root/daemon
COPY ./auth.sh /root/auth

VOLUME /media/library
VOLUME /root/oauth

WORKDIR /root
ENV PATH="/root:${PATH}"
CMD ["daemon"]
