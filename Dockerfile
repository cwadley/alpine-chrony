FROM alpine:latest

RUN apk add --no-cache chrony

EXPOSE 123/udp

ENTRYPOINT [ "/usr/sbin/chronyd", "-d", "-s"]