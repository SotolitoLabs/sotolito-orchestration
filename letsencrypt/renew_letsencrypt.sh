#!/bin/bash


LE_PATH="/etc/letsencrypt/live"

function gen_fullchain() {
    HAPROXY_PATH="/etc/ssl/haproxy"
    echo "Generating haproxy fullchain for: ${1}"

    if [[ "${1}" == "" ]]; then
        echo "Missing domain argument"
        exit
    fi

    CERT_PATH="${LE_PATH}/${1}"

    echo "Generating letsencrypt cert for haproxy"
    cd $CERT_PATH
    cat privkey.pem > haproxy_fullchain.pem 
    cat fullchain.pem  >> haproxy_fullchain.pem 
    ln -fs "${CERT_PATH}/haproxy_fullchain.pem" "${HAPROXY_PATH}/${1}"
}


/usr/bin/certbot renew
#echo "DEBUG: /usr/bin/certbot renew"

cd $LE_PATH
for d in *
do 
    if [[ -d "${LE_PATH}/${d}" ]]; then
        gen_fullchain $d
    fi
done

#echo "DEBUG: systemctl reload haproxy"
systemctl reload haproxy
