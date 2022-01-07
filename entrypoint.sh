#!/usr/bin/dumb-init /bin/bash

set -euxo pipefail

conf_file=/config/yggdrasil.conf

mkdir -p /config

if [ ! -f ${conf_file} ]; then
    yggdrasil -genconf -json > ${conf_file}
    python3 configurator.py
fi

dns_ip=`dig google.com  | grep SERVER: | awk '{ print $3 }' | cut -d# -f1`

function iptables_rules() {
    local action="$1"

    for proto in tcp udp; do
        iptables -t nat $action OUTPUT -p $proto \
                 --dport 53 -m string --algo bm --hex-string '|03|ygg|00|' \
                 -j DNAT --to-destination 127.0.0.1:53
        iptables -t nat $action OUTPUT -p $proto \
                 --sport 53 --source 127.0.0.1 \
                 -j SNAT --to-source $dns_ip
    done
}

iptables -t nat -F OUTPUT
iptables_rules '-A'

exec yggdrasil -useconffile ${conf_file}
