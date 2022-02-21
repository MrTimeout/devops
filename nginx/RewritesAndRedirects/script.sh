#!/bin/bash

mkdir --parent /sites/demo && cp -r resources /sites/demo

function curl_execute {
    local path=$1
    local expected=$2
    if [[ -z $path ]] || [[ -z $expected ]]; then
        echo "Path or expected value is null cannot be null"
        exit 1
    fi

    [[ $(curl -L --silent http://localhost:80/$path | grep -c "$expected") -eq 1 ]] || \
        { echo "Error calling the path $path"; exit 1; }
}

curl_execute "logo?local=yes" html && \
    curl_execute "user/somethingHere" "Hello world" && \
    curl_execute "user/jhon" "Hello Jhon" && echo "All right baby"