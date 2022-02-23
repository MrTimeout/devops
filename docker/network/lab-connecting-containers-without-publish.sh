#!/bin/bash

NETWORK_NAME="test_private"
PORT=12345

if [[ $(docker network ls | grep -c $NETWORK_NAME) -eq 1 ]]; then
    docker container rm --force $(docker network inspect $NETWORK_NAME --format '{{range $k, $v := .Containers}}{{$k}}{{end}}')
    docker network rm $NETWORK_NAME
fi

docker network create $NETWORK_NAME

docker container rm --force server client

docker container run --detach --name server --network $NETWORK_NAME --publish $PORT:80 nginx:latest

IP_ADDRESS=$(docker container inspect server --format '{{.NetworkSettings.Networks.test_private.IPAddress}}')

docker container run --interactive --tty --name client --network $NETWORK_NAME debian:latest apt-get update && apt-get install --yes curl && curl -vvv http://$IP_ADDRESS:80

docker container rm --force server client
docker network rm $NETWORK_NAME