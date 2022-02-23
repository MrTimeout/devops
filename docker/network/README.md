# Networks

## Drivers

### Bridge

- The default network driver.
- If you don't specify a driver, this is the type of network you are creating.
- Bridge networks are usually used when your apps run in standalone containers that need to comunicate.
- It means that no others containers can connect to the ones inside the network.
- User-defined bridge networks are superior to the default bridge network.

#### Differences between user-defined bridges and the default bridge

- User-defined bridges provide __automatic DNS__ resolution between containers.
    + Default bridge can't resolve DNS. They have to connect each other using IP addresses or use the legacy option `--link`.
    + Using the legacy `--link` option, you have to create links in both ways or manage the file `/etc/hosts`
- User-defined bridges provide __better isolation__.
    + It is obvious why it is the best option
- Containers can be attached and detached from user-defined networks on the __fly__.
    + To remove a container from the default bridge network, you need to stop the container and recreate it with different networks options.
- Each user-defined network creates a configurable bridge.
- __Linked containers__ on the default bridge network __share environment variables__. How to share env variables using user-defined network:
    + Multiple containers can mount a file or directory containing the shared information, using a Docker volume.
    + Multiple containers can be started together using `docker-compose` and the compose file can define the shared variables.
    + You can use swarm services instead of standalone containers, and take advantage of shared secrets and configs.

#### Manage a user-defined bridge

```sh
docker network create network_name

# Here we are creating a container with the name "server", publishing 12345 port to the "world" and in the user-defined network "network_name"
docker container run --name server \
    --publish 12345:80 \
    --network network_name nginx:latest

docker network connect network_name server

# You must disconnect the containers of the user-defined network before deleting it
docker network disconnect network_name server

docker network rm network_name
```

#### Running on IPv6

IPv6 networking is only supported on Docker daemons running on linux hosts

Edit `/etc/docker/daemon.json` and fill the json with the following attributes:

```json
{
    "ipv6": true,
    "fixed-cidr-v6": "2001:db8:1::/64"
}
```

And reload the docker daemon:

```sh
systemctl reload docker
service docker reload
```

#### Enable forwarding from Docker containers to the outside world

By default, traffic from containers connected to the default bridge network is not forwarded to the outside world.

- Configure the linux kernel to allow ip forwarding: `sysctl net.ipv4.conf.all.forwarding=1`
- Change the policy for the `iptables FORWARD` policy from `DROP` to `ACCEPT`: `sudo iptables -P FORWARD ACCEPT`

#### Configure the default bridge network

```json
{
  "bip": "192.168.1.1/24",
  "fixed-cidr": "192.168.1.0/25",
  "fixed-cidr-v6": "2001:db8::/64",
  "mtu": 1500,
  "default-gateway": "192.168.1.254",
  "default-gateway-v6": "2001:db8:abcd::89",
  "dns": ["10.20.1.2","10.20.1.3"]
}
```

## Links

- [Network Bridge](https://docs.docker.com/network/bridge/)
- [Legacy container links](https://docs.docker.com/network/links/)
- [Enable IPv6 Support](https://docs.docker.com/config/daemon/ipv6/)