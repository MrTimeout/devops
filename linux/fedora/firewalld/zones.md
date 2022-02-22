# Zones in firewalld

## drop

Any incoming network packets are dropped, there is no reply. Only outgoing network connections are possible.

## block

Any incoming network connections are rejected with an `icmp-host-prohibited` message for IPv4 and `icmp6-adm-prohibited` for IPv6. Only network connections initiated within this system are possible.

## public

For use in public areas. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.

## external

For use on external networks with masquerading enabled especially for routers. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.

## dmz

For computers in your demilitarized zone that are publicly-accessible with limited access to your internal network. Only selected incoming connections are accepted.

## work

For use in work area. you mostly trust the other computers on networks to not harm your computer.

## home

for use in home areas. You mostly trust the other computers on networks to not harm your computer.

## internal

For use on internal networks.

## trusted

All network connections are accepted. This is the only one that accepts all the connections.