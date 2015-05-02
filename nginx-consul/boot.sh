#!/bin/bash

# Fail hard and fast
set -eo pipefail

export HOST_IP=${HOST_IP:-172.17.42.1}
export CONSUL=${CONSUL:-consul:8500}
export DOMAIN=${DOMAIN:-example.com}
export REGION=${REGION:-core}
export HTPASSWD="$(openssl passwd -apr1 ${HTPASSWD:-password})"

# Specify where we will install
# the xip.io certificate
SSL_DIR="/etc/nginx/certs"

# Set the wildcarded domain
# we want to use
MAIN_DOMAIN="*.${DOMAIN}"

# A blank passphrase
PASSPHRASE=""

# Set our CSR variables
SUBJ="
C=US
ST=Connecticut
O=
localityName=New Haven
commonName=$MAIN_DOMAIN
organizationalUnitName=
emailAddress=
"

echo "admin:${HTPASSWD}" > /etc/nginx/.htpasswd
openssl req -subj "$(echo -n "$SUBJ" | tr "\n" "/")" -x509 -nodes -days 365 -newkey rsa:2048 -keyout "$SSL_DIR/default.key" -out "$SSL_DIR/default.crt" -passin pass:$PASSPHRASE

echo "[nginx] booting container. CONSUL: $CONSUL"

# Loop Consul Template
consul-template -consul=$CONSUL -config="/consul/config/nginx.hcl"

# Start nginx
echo "[nginx] starting nginx service..."
service nginx start

# Tail all nginx log files
tail -f /var/log/nginx/*.log
