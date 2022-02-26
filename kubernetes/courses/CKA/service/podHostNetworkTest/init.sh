#!/bin/bash

kubectl delete pod port.host.network
kubectl create -f ./pod-definition.yaml

kubectl get pods --namespace default
kubectl describe pod port.host.network

# The NODE IP is the same as the POD
NODE_IP=$(kubectl get nodes -o go-template='{{range (index .items 0).status.addresses}}{{if eq .type "InternalIP"}}{{.address}}{{end}}{{end}}')
PORTS=$(kubectl get pods port.host.network -o go-template='{{range .spec.containers}}{{if eq .name "server-nginx"}} {{range .ports}}{{if eq .protocol "TCP"}}{{.hostPort}} {{end}}{{end}}{{end}}{{end}}')

if [[ -z $PORTS ]]; then
    echo "There are no ports to use"
    exit 1
fi

for i in {1..2}; do
    sleep 5
    for j in $PORTS; do
        if [[ $(curl -vvv -X GET http://$NODE_IP:$j | grep --count "Hello") -eq 1 ]]; then
            { echo "OK"; exit 0; }
        fi
    done
done