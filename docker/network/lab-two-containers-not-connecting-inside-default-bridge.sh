#!/bin/bash

SERVER=server
CLIENT=client
PUBLISH_PORT=12345

if [[ $(docker container ls --all --filter name=$SERVER --format '{{.Names}}' | grep -c $SERVER) -eq 1 ]]; then
    docker container rm --force $SERVER
fi

if [[ $(docker container ls --all --filter name=$CLIENT --format '{{.Names}}' | grep -c $CLIENT) -eq 1 ]]; then
    docker container rm --force $CLIENT
fi

docker container run --name $SERVER --rm --detach --publish $PUBLISH_PORT:80 nginx:latest

ipAddress=$(docker container inspect --format '{{.NetworkSettings.Networks.bridge.IPAddress}}' $SERVER)

docker container run --name $CLIENT --rm --detach curl:latest http://$ipAddress:80; curl -vvv http://$SERVER:80

trap "echo Ending server logs following" SIGINT

docker container logs --follow $SERVER

docker container stop $SERVER $CLIENT

## Testing the docker containers using the link statement
docker container run --name $SERVER --rm --detach --publish $PUBLISH_PORT:80 nginx:latest
## --link name-of-container:alias
docker container run --name $CLIENT --link $SERVER:serverAlias --rm --detach curl:latest http://serverAlias:80 
# cat /etc/hosts
# 172.17.0.2      serverAlias 5384fe5fd2a1 server
# 172.17.0.3      c5828e06cc0b

# docker container exec client bash -c env
# SERVERALIAS_PORT_80_TCP_PORT=80
# SERVERALIAS_PORT_80_TCP_PROTO=tcp
# SERVERALIAS_ENV_PKG_RELEASE=1~bullseye
# SERVERALIAS_PORT_80_TCP_ADDR=172.17.0.2
# SERVERALIAS_ENV_NGINX_VERSION=1.21.6
# SERVERALIAS_PORT_80_TCP=tcp://172.17.0.2:80
# SERVERALIAS_PORT=tcp://172.17.0.2:80
# SERVERALIAS_ENV_NJS_VERSION=0.7.2
# SERVERALIAS_NAME=/client/serverAlias

trap "echo Ending server logs following" SIGINT

docker container logs --follow $SERVER

docker container rm --force $SERVER $CLIENT