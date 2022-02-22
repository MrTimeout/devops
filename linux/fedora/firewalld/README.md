# Firewalld

firewalld is a firewall service daemon that provides a dynamic customizable host-based firewall with a __D-Bus__ interface (PolicyKit authentication methods). Being dynamic, it enables creating, changing, and deleting the rules without the necessity to restart the firewall daemon each time the rules are changed.

There is no need to reload all firewall kernel modules.

## Zones

Zones are predefined sets of _rules_. 

A network zone defines the level of trust for network connections.
This is a one to many relation, which means that a connection can only be part of one zone, but a zone can be used for many network connections.

- __Network interfaces__ and __sources__ can be assigned to a zone.
- The traffic allowed depends on the __network__ your computer is connected to and the __security level__ this network is assigned.
- Firewall services are predefined rules that cover all necessary things to __allow incomming traffic__ for a specific service and they apply within a zone.

## Services

A service is a combination of port and/or protocol entries.

- Services use one or more __ports__ or __addresses__ for network communication.
- Firewalls filter communication based on __ports__.
- __firewalld__ blocks all traffic on ports that are not explicitly set as open.
- Some zones, such as trusted, allow all traffic by default.

## ICMP blocks

Select Internet Control Message protocol messages.

## Masquerading

The addresses of a private network are mapped to and hidden begind a public IP address. This is a form of address translation.

## Forward ports

A port is either mapped to another port and/or to another host.