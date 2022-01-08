#!/bin/bash

docker build --tag yggdrasil_gateway_image yggdrasil
docker build --tag alfis_resolver_image alfis

./scripts/stop_gateway.sh

docker run --name yggdrasil_gateway_container \
           --network="host" \
           --cap-add=NET_ADMIN \
           --device=/dev/net/tun:/dev/net/tun \
           --volume $PWD/yggdrasil:/yggdrasil \
           --detach --rm --interactive --tty yggdrasil_gateway_image

docker run --name alfis_resolver_container \
           --network="host" \
           --volume $PWD/alfis:/alfis \
           --detach --rm --interactive --tty alfis_resolver_image
