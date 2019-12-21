#!/bin/bash

LE_PATH="/etc/letsencrypt/live"

if [[ "${1}" == "" ]]; then
  echo "Missing domain argument"
  exit
fi

CERT_PATH="${LE_PATH}/${1}"

echo "Generating letsencrypt cert for haproxy"
cd $CERT_PATH
cat privkey.pem > haproxy_fullchain.pem 
cat fullchain.pem  >> haproxy_fullchain.pem 
systemctl reload haproxy
