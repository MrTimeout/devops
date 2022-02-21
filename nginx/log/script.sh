#!/bin/bash

# Starting with all the log files without any character
echo '' > /var/log/nginx/secure_access.log
echo '' > /var/log/nginx/other_access.log
echo '' > /var/log/nginx/access.log

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

function access_grep {
    local word=$1
    local path=$2

    if [[ -z $word ]] || [[ -z $path ]]; then
        echo "word or path are empty or null";
    fi

    [[ $(grep -c "$word" $path) -eq 1 ]] || { echo "Error looking for $path and grep the word $word"; exit 1; }
}

secure_endpoint="Hello from the secure endpoint"
other_endpoint="Hello from the other endpoint"

curl_execute secure $secure_endpoint && access_grep "secure" /var/log/nginx/secure_access.log && access_grep "secure" /var/log/nginx/access.log && echo "secure endpoint success"
# It should work, but it fails at third step
curl_execute other $other_endpoint && access_grep "other" /var/log/nginx/other_access.log && access_grep "other" /var/log/nginx/access.log && echo "other endpoint success"