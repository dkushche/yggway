#!/bin/bash

docker build --tag yggdrasil_gateway_image yggdrasil
docker build --tag alfis_resolver_image alfis

./scripts/stop_gateway.sh

mkdir -p storage

docker run --name yggdrasil_gateway_container \
           --network="host" \
           --cap-add=NET_ADMIN \
           --device=/dev/net/tun:/dev/net/tun \
           --volume $PWD/storage:/mnt/storage \
           --detach --rm --interactive --tty yggdrasil_gateway_image

resolv_conf=`cat /etc/resolv.conf`
echo -e "# Alfis DNS resolver\nnameserver 127.0.0.1\n$resolv_conf" \
        | sudo tee /etc/resolv.conf

docker run --name alfis_resolver_container \
           --network="host" \
           --volume $PWD/storage:/mnt/storage \
           --detach --rm --interactive --tty alfis_resolver_image
