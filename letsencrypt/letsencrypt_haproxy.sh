#!/bin/bash

LE_PATH="/etc/letsencrypt/live"
HAPROXY_PATH="/etc/ssl/haproxy"

if [[ "${1}" == "" ]]; then
  echo "Missing domain argument"
  exit
fi

CERT_PATH="${LE_PATH}/${1}"

echo "Generating letsencrypt cert for haproxy"
cd $CERT_PATH
cat privkey.pem > haproxy_fullchain.pem 
cat fullchain.pem  >> haproxy_fullchain.pem 
ln -s "${CERT_PATH}/haproxy_fullchain.pem" "${HAPROXY_PATH}/${1}"
systemctl reload haproxy
