#!/bin/bash

# Displays al the services
firewall-cmd --get-services | sed 's/ /\n/g'

# Displays the services of the default zone
# We can filter by --permanent with --zone or/and --policy
firewall-cmd --list-services

# Display the info about cockpit service
firewall-cmd --info-service cockpit

# cockpit
#   ports: 9090/tcp
#   protocols:
#   source-ports:
#   modules:
#   destination:
#   includes:
#   helpers: