#!/bin/bash
set -e

ADNL=$(cat /run/secrets/adnl)
ADNL_HEX=$(cat /run/secrets/adnl-hex)

mkdir -p keyring
cat /run/secrets/adnl-private > keyring/$ADNL_HEX
chmod 600 keyring/$ADNL_HEX

ls -la keyring

# if specified TON_PROXY_REMOTE_HOST
if [[ ! -z "$TON_PROXY_REMOTE_HOST" ]]; then
    resolved=$(dig +short $TON_PROXY_REMOTE_HOST)
    if [[ ! -z "$resolved" ]]; then
        echo "Hostname resolved to $resolved"
        TON_PROXY_REMOTE_HOST=$resolved
    fi
    TON_PROXY_REMOTE_ADDR=$TON_PROXY_REMOTE_HOST:$TON_PROXY_REMOTE_PORT
fi

echo "Remote addr: $TON_PROXY_REMOTE_ADDR"
curl http://${TON_PROXY_REMOTE_ADDR} -v || echo 'WARNING!'
printenv

./rldp-http-proxy -p ${TON_PROXY_PORT:-8080} \
                  -a ${TON_PROXY_SERVER_IP}:${TON_PROXY_ADNL_PORT:-3333} \
                  -A ${ADNL} \
                  -C /run/secrets/global-config \
                  -P ${TON_PROXY_PROXY_ALL:-NO} \
                  --verbosity ${TON_PROXY_VERBOSITY:-3} \
                  -R '*'@${TON_PROXY_REMOTE_ADDR:-127.0.0.1:80}
