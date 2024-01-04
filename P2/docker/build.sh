#!/bin/bash
pushd frrouting
    docker build -t frrouting:p2 .
popd

pushd host
    docker build -t host:p2 .
popd
