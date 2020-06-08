FROM golang:alpine as builder
RUN mkdir /build
ADD . /build/
WORKDIR /build
RUN go build .

FROM alpine:3.7
RUN apk add --update ca-certificates
RUN apk add --no-cache --virtual .build-deps ca-certificates wget \
  && apk del .build-deps
COPY --from=builder /build/gcsproxy /usr/local/bin/gcsproxy
ENTRYPOINT /usr/local/bin/gcsproxy
