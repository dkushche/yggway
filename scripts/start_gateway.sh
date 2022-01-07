#!/bin/bash

docker build --tag yggdrasil_gateway_image .

./scripts/stop_gateway.sh

docker run --name yggdrasil_gateway_container \
           --network="host" \
           --cap-add=NET_ADMIN \
           --device=/dev/net/tun:/dev/net/tun \
           --volume $PWD/yggdrasil_config:/config \
           --detach --rm --interactive --tty yggdrasil_gateway_image

docker run --name alfis \
           --network="host" \
           --detach --rm cofob/alfis
