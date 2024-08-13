#!/bin/bash

mkdir out/

docker build -t debug-payroll-system .
docker run \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ./out:/app/out \
    debug-payroll-system