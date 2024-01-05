FROM quay.io/frrouting/frr:9.0.2

RUN rm -rf /etc/frr/daemons

COPY ./config/daemons /etc/frr/daemons
COPY ./config/vtysh.conf /etc/frr/vtysh.conf
COPY ./scripts/router1.sh /router1.sh
COPY ./scripts/router2.sh /router2.sh
