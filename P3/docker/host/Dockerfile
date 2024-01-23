FROM alpine:latest

RUN apk update && apk add iproute2

COPY ./scripts/host1.sh /host1.sh
COPY ./scripts/host2.sh /host2.sh
COPY ./scripts/host3.sh /host3.sh
