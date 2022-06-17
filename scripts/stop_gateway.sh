#!/bin/bash

sudo rm -rf /etc/resolvconf/resolv.conf.d/head

connection_name=`nmcli con show --active | grep -v NAME | head -n1 | awk '{print $1}'`

nmcli con mod $connection_name ipv4.dns ""
nmcli con mod $connection_name ipv4.ignore-auto-dns no

nmcli con down $connection_name
nmcli con up $connection_name

docker kill alfis_resolver_container
docker kill yggdrasil_gateway_container
