#!/bin/bash
pushd frrouting
    docker build -t frrouting:p1 .
popd

pushd host
    docker build -t host:p1 .
popd
