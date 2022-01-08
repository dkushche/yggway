#!/bin/bash

cat /etc/resolv.conf | grep Alfis

if [ $? -eq 0 ]; then
    tail +3 /etc/resolv.conf | sudo tee /etc/resolv.conf
fi

docker kill alfis_resolver_container
docker kill yggdrasil_gateway_container
