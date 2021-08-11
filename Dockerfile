FROM alpine:3.14 AS builder
ARG NTP_VERSION=ntp-4.2.8p15
RUN apk add --no-cache build-base linux-headers && \
    wget http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/$NTP_VERSION.tar.gz && \
    tar -xzf $NTP_VERSION.tar.gz && \
    cd $NTP_VERSION && \
    ./configure && \
    make && \
    mkdir /ntp-bin && \
    cp ntpdate/ntpdate /ntp-bin && \
    cp sntp/sntp /ntp-bin

FROM alpine:3.14
COPY --from=builder /ntp-bin /usr/sbin
RUN apk add --no-cache chrony

EXPOSE 123/udp

ENTRYPOINT [ "/usr/sbin/chronyd", "-d", "-s"]
