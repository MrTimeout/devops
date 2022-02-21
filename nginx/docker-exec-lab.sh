#!/bin/bash

lab_name=$1
if [[ -z $lab_name ]]; then
    echo "Parameter cannot be null or empty"
    exit 1
fi

if [[ $(ls $PWD | grep -c $(basename $0)) -eq 0 ]]; then
    echo "You must execute the script inside the folder nginx/"
    exit 1
fi

# We must create the folder before copying anything into it
docker container exec server bash -c "mkdir --parent /nginx/$lab_name"

docker cp $1/ server:/nginx/

docker container exec --interactive --workdir /nginx/$lab_name server bash -c "cp nginx.conf /etc/nginx/nginx.conf && nginx -t && nginx -s reload && ./script.sh"