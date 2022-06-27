#!/bin/bash

docker build --tag yggdrasil_gateway_image yggdrasil
docker build --tag alfis_resolver_image alfis

./scripts/stop_gateway.sh

mkdir -p storage

docker run --name yggdrasil_gateway_container \
           --restart=always \
           --network="host" \
           --cap-add=NET_ADMIN \
           --device=/dev/net/tun:/dev/net/tun \
           --volume $PWD/storage:/mnt/storage \
           --detach --interactive --tty yggdrasil_gateway_image

docker run --name alfis_resolver_container \
           --restart=always \
           --network="host" \
           --volume $PWD/storage:/mnt/storage \
           --detach --interactive --tty alfis_resolver_image

sudo apt-get update
sudo apt-get install -y resolvconf

sudo systemctl start resolvconf.service
sudo systemctl enable resolvconf.service

sudo mkdir -p /etc/resolvconf/resolv.conf.d
echo -e "nameserver 127.0.0.1" | sudo tee /etc/resolvconf/resolv.conf.d/head

sudo systemctl restart resolvconf.service
sudo systemctl restart systemd-resolved.service
