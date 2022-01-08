#!/bin/bash

./scripts/stop_gateway.sh

docker rmi -f alfis_resolver_image
docker rmi -f yggdrasil_gateway_image
