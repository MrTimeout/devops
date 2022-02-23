#!/bin/bash

CONTAINER_NAME=server
PUBLISH_PORT=12345

# docker container rm -f $CONTAINER_NAME # We can use this command to stop and remove the container
if [[ $(docker container ls --all --filter "name=$CONTAINER_NAME" --format "{{.ID}}:{{.Status}}" | grep -c "Up") -eq 1 ]]; then 
    docker container stop $CONTAINER_NAME 
fi

if [[ $(docker container ls --all --filter "name=$CONTAINER_NAME" --format "{{.ID}}:{{.Status}}" | grep -c "Exit") -eq 1 ]]; then
    docker container rm $CONTAINER_NAME 
fi

docker container run --detach --name server --publish 12345:80 nginx:latest 

docker container ls --all --filter="name=$CONTAINER_NAME" --format="{{.ID}} {{.Names}} {{.Ports}}"