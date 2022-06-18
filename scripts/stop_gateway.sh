#!/bin/bash

sudo rm -rf /etc/resolvconf/resolv.conf.d/head

connection_name=`nmcli con show --active | grep -v NAME | head -n1 | awk '{print $1}'`

nmcli con mod $connection_name ipv4.dns ""
nmcli con mod $connection_name ipv4.ignore-auto-dns no

nmcli con down $connection_name
nmcli con up $connection_name

docker update --restart=no alfis_resolver_container
docker update --restart=no yggdrasil_gateway_container

docker rm -f alfis_resolver_container
docker rm -f yggdrasil_gateway_container
