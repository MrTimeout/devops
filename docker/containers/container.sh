#!/bin/bash

# The last part of the script from image latest to -T is the command line entry point
docker container run --name server --publish 12345:80 --detach nginx:latest nginx -T

# It shows the process top of a container running
docker container top server