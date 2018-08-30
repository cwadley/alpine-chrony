# Chrony NTP server based on Alpine Linux


## Getting The Image
### Docker Hub
`docker pull cwadley/alpine-chrony`


### Build
`git pull https://github.com/cwadley/alpine-chrony.git`
`docker build --tag cwadley/alpine-chrony .`

## Usage
### Default Config
```
docker run -d                       \
            --name chrony           \
            -p 123:123/udp          \
            --cap-add SYS_NICE      \
            --cap-add SYS_TIME      \
            --cap-add SYS_RESOURCE  \
            cwadley/alpine-chrony
```

### Custom Config
```
docker run -d                                                       \
            --name chrony                                           \
            -p 123:123/udp                                          \
            --cap-add SYS_NICE                                      \
            --cap-add SYS_TIME                                      \
            --cap-add SYS_RESOURCE                                  \
            -v <path_to_chrony.conf>:/etc/chrony/chrony.conf:ro     \
            cwadley/alpine-chrony
```

## Logs
Chrony runs in un-detached mode in this image, which means that it does not send its logs to a file in the container, but to stdout. To view chrony logs, use `docker logs chrony`.

## Testing
ntpdate can be used to query the running container for the time:
### If you have mapped port 123 to the host:
`ntpdate -q localhost`
### From another container on the same Docker network:
`ntpdate -q <chrony_ip>`