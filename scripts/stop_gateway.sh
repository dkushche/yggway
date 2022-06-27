#!/bin/bash

echo "" | sudo tee /etc/resolvconf/resolv.conf.d/head

sudo systemctl restart resolvconf.service
sudo systemctl restart systemd-resolved.service

docker update --restart=no alfis_resolver_container
docker update --restart=no yggdrasil_gateway_container

docker rm -f alfis_resolver_container
docker rm -f yggdrasil_gateway_container
