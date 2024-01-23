FROM quay.io/frrouting/frr:9.1.0

RUN apk update && \
    apk upgrade busybox && \
    apk add util-linux iproute2 bridge-utils
    
RUN rm -rf /etc/frr/daemons

COPY ./config/daemons /etc/frr/daemons
COPY ./config/vtysh.conf /etc/frr/vtysh.conf
