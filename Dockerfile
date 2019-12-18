FROM python:alpine as builder

FROM builder

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
