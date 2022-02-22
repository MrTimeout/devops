#!/bin/bash

# Display all zones with its description
firewall-cmd --list-all-zones

# Get all zones and print each one in a different line.
firewall-cmd --get-zones | sed 's/ /\n/g'

# Let us to get the default zone that we are using.
firewall-cmd --get-default-zone

firewall-cmd --get-active-zones
# Output:
# FedoraServer
#   interfaces: enp4s0

# This will display all the info about a zone
firewall-cmd --info-zone FedoraServer
# Output
# FedoraServer (active)
#   target: default
#   icmp-block-inversion: no
#   interfaces: enp4s0
#   sources:
#   services: cockpit dhcpv6-client ssh
#   ports:
#   protocols:
#   forward: no
#   masquerade: no
#   forward-ports:
#   source-ports:
#   icmp-blocks:
#   rich rules: