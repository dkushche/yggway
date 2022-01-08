#!/bin/bash

set -euxo pipefail

conf_file=/alfis/alfis.toml

if [ ! -f ${conf_file} ]; then
    alfis -g > ${conf_file}
fi

exec alfis -w /alfis
