#!/bin/bash

# Write the DEV_HUB_AUTH_URL to a file
echo $DEV_HUB_AUTH_URL > /tmp/dev_hub_auth_url

# Authenticate the DevHub
sfdx org auth sfdx-url -f /tmp/dev_hub_auth_url -a DevHub -d

rm /tmp/dev_hub_auth_url

# Start the default shell
exec "$SHELL"