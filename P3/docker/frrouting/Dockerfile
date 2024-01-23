FROM quay.io/frrouting/frr:9.0.2

RUN apk update && \
    apk add iproute2 && \
    echo "/sbin/ip" > /usr/local/bin/ip2 && \
    chmod +x /usr/local/bin/ip2

RUN rm -rf /etc/frr/daemons

COPY ./config/daemons /etc/frr/daemons
COPY ./config/vtysh.conf /etc/frr/vtysh.conf

COPY ./scripts/routerRR.sh /routerRR.sh
COPY ./scripts/router2.sh /router1.sh
COPY ./scripts/router3.sh /router2.sh
COPY ./scripts/router4.sh /router3.sh