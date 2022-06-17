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

connection_name=`nmcli con show --active | grep -v NAME | head -n1 | awk '{print $1}'`

nmcli con mod $connection_name ipv4.ignore-auto-dns yes
nmcli con mod $connection_name ipv4.dns "127.0.0.1"

nmcli con down $connection_name
nmcli con up $connection_name

docker run --name alfis_resolver_container \
           --network="host" \
           --volume $PWD/storage:/mnt/storage \
           --detach --rm --interactive --tty alfis_resolver_image
