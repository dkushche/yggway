# Yggdrasil Gateway

With this repo, you could fast set up a gateway to the Yggdrasil network and Alfis DNS resolver. In `yggdrasil/configuration.py` you may preset a list of public peers. I use Ukrainian peers, but you can choose the most suitable for you from the [peers list](https://github.com/yggdrasil-network/public-peers). Also after the first start, you could modify Alfis settings in `alfis/alfis.toml`. Scripts are automatically caring about the nameserver setup. If you want to use docker-compose you will need to figure out how to set up a default nameserver by yourself. Firefox works fine with .ygg domains, Google Chrome doesn't. If you want to use Google Chrome you may resolve domains with dig or nslookup, or even ping and then open via Chrome.

## Gateway manipulation example

```
./scripts/start_gateway.sh
./scripts/stop_gateway.sh
./scripts/remove_gateway.sh
```

## Docker-compose example

```
  yggdrasil_gateway:
    build: yggdrasil
    network_mode: host
    cap_add:
      - NET_ADMIN
    devices:
      - /dev/net/tun
    volumes:
      - './yggdrasil:/yggdrasil'
  alfis_resolver:
    build: alfis
    network_mode: host
    volumes:
      - './alfis:/alfis'
```
