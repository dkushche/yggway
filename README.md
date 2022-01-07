# Yggdrasil Gateway

With this repo, you could fast set up a gateway to the Yggdrasil network. In `configuration.py` you may preset a list of public peers. I use Ukrainian peers, but you can choose most suitable for you from the [peers list](https://github.com/yggdrasil-network/public-peers)

## Gateway manipulation example

```
./scripts/start_gateway.sh
./scripts/stop_gateway.sh
./scripts/remove_gateway.sh
```

## Docker-compose example

```
  yggdrasil_gateway:
    build: .
    network_mode: host
    cap_add:
      - NET_ADMIN
    devices:
      - /dev/net/tun
    volumes:
      - './yggdrasil_config:/config'
  alfis_dns:
    image: "cofob/alfis"
    port:
      - 53:53/tcp
      - 53:53/udp
```