FROM python:alpine3.6 as builder

COPY qemu-*-static /usr/bin/

FROM builder

ARG VERSION=1.2.1

LABEL maintainer="Jay MOULIN <jaymoulin@gmail.com> <https://twitter.com/MoulinJay>"
LABEL version=${VERSION}

ENV REMOVE=0
ENV ONESHOT=0
ENV UPLOADER_ID=false

RUN apk update && \
    apk add gcc g++ linux-headers libxml2-dev libxslt-dev --no-cache --virtual .build-deps && \
    apk add ffmpeg && mkdir /root/oauth/ && \
    pip3 install --upgrade pip && \
    pip3 install google-music-manager-uploader && \
    apk del gcc --purge .build-deps

COPY ./daemon.sh /root/daemon
COPY ./auth.sh /root/auth

VOLUME /media/library
VOLUME /root/oauth

WORKDIR /root
ENV PATH="/root:${PATH}"
CMD ["daemon"]
