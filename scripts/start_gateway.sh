#!/bin/bash

set -e

screen_dimensions=`xdpyinfo | grep dimensions | awk '{print $2}'`

export DISPLAY_WIDTH=`echo "$screen_dimensions" | cut -d 'x' -f 1`
export DISPLAY_HEIGHT=`echo "$screen_dimensions" | cut -d 'x' -f 2`

docker-compose config 1> /dev/null

./scripts/stop_gateway.sh

mkdir -p storage/firefox
cp config/alfis.toml storage

docker-compose up --detach
