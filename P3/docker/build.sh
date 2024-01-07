#!/bin/bash
pushd frrouting
    docker build -t frrouting:p3 .
popd

pushd host
    docker build -t host:p3 .
popd
