#!/bin/bash

count=0
mkdir --parent /sites/demo && cp -r resources /sites/demo

function curl_execute {
    local path=$1
    local expected=$2
    if [[ -z $path ]] || [[ -z $expected ]]; then
        echo "Path or expected value is null cannot be null"
        exit 1
    fi

    ((count+=1))
    [[ $(curl --silent -X GET http://localhost:80/$path | grep -c "$expected") -eq 1 ]] || \
        { echo "Error calling the path $path"; exit 1; }
}

function for_curl_execute {
    local path=$1
    local expected=$2
    local from=$3
    local to=$4
    if [[ -z $path ]] || [[ -z $expected ]] || [[ -z $from ]] || [[ -z $to ]] || [[ $from -ge $to ]]; then
        echo "Path, expected, from, to are null or from is greater/equal than to"
        exit 1
    fi

    for number in $(seq $from $to); do
        curl_execute $path$number $expected
    done
}

# curl --headers/-I
curl_execute "greet" "exact" && \
    curl_execute "greeting" "Hello" && \
    curl_execute "greet/more" "Hello" && \
    for_curl_execute "greet" "regex" 0 9 && \
    for_curl_execute "GREET" "regex case insensitive" 0 9 && \
    curl_execute "greet10" "preferential match" && \
    for_curl_execute "greet" "regex special" 11 20 && \
    echo "Greet endpoint working as expected"; cat /var/log/nginx/access.log | tail -n $count