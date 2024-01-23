FROM quay.io/frrouting/frr:9.0.2

RUN apk update && \
    apk add iproute2 && \
    echo "/sbin/ip" > /usr/local/bin/ip2 && \
    chmod +x /usr/local/bin/ip2
RUN rm -rf /etc/frr/daemons

COPY ./config/daemons /etc/frr/daemons
COPY ./config/vtysh.conf /etc/frr/vtysh.conf
