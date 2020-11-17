#!/bin/bash
# Sample run script.  Primarly used in build / testing

docker rm pz-server
docker run -it -p 16261:16261/udp -p 16262:16272/tcp -v /app/docker/temp-vol:/app \
-e SERVERNAME="t3stn3t" \
-e PASSWORD="passsword123" \
--name pz-server \
antimodes201/pz-server:build
