#!/bin/bash

mkdir --parent /sites/demo && cp -r resources /sites/demo

# curl --headers/-I
curl http://127.0.0.1:80 && curl -I http://127.0.0.1:80/style.css | grep --silent text/css && echo "All right baby"
