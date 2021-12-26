#!/usr/bin/dumb-init /bin/bash

set -euxo pipefail

conf_file=/config/yggdrasil.conf

mkdir -p /config

if [ ! -f ${conf_file} ]; then
    yggdrasil -genconf -json > ${conf_file}
    python3 configurator.py
fi

exec yggdrasil -useconffile ${conf_file}
