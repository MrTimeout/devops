#!/bin/bash

mkdir --parent /sites/demo && cp -r resources /sites/demo

function curl_execute {
    local path=$1
    local expected=$2
    if [[ -z $path ]] || [[ -z $expected ]]; then
        echo "Path or expected value is null cannot be null"
        exit 1
    fi

    [[ $(curl --silent http://localhost:80/$path | grep -c "$expected") -ge 1 ]] || \
        { echo "Error calling the path $path"; exit 1; }
}

curl_execute index.html "NGINX Fundamentals" && \
    curl_execute style.css "Helvetica Neue" && \
    curl_execute greet "Hello world" && \
    curl_execute uri_not_found "resource not found" && echo "all right baby";