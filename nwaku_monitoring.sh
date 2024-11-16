#!/bin/bash

FILE_PATH="$HOME/nwaku-compose/docker-compose.yml"

VPN_IP=$(ip -4 addr show tun0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

if [[ -z "$VPN_IP" ]]; then
  echo "$VPN_IP not found."
  exit 1
fi

if [[ ! -f "$FILE_PATH" ]]; then
  echo "$FILE_PATH not found."
  exit 1
fi

sed -i "s/127.0.0.1:8003:8003/$VPN_IP:8003:8003/" "$FILE_PATH"

echo "IP ($VPN_IP) changed in $FILE_PATH."
