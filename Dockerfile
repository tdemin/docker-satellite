FROM golang:1.18-alpine AS builder

ENV CGO_ENABLED=0
RUN apk add git

ARG SATELLITE_VERSION=v1.0.0
RUN \
    GOBIN=/tmp go install -v \
        git.sr.ht/~gsthnz/satellite@${SATELLITE_VERSION}

FROM alpine:3.15 AS worker

LABEL maintainer "Timur Demin <me@tdem.in>"
WORKDIR /app
VOLUME /config
VOLUME /data

RUN adduser -D -u 1000 satellite && \
    mkdir -p /config && chown satellite /config && chmod 700 /config && \
    mkdir -p /data && chown satellite /data && chmod 700 /data

COPY --from=builder /tmp/satellite /app/satellite

USER satellite
CMD ["/app/satellite", "-c", "/config/config.toml"]
