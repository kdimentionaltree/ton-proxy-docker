#!/bin/bash
set -e

ADNL=$(cat /run/secrets/adnl)
ADNL_HEX=$(cat /run/secrets/adnl-hex)

mkdir -p keyring
cat /run/secrets/adnl-private > keyring/$ADNL_HEX
chmod 600 keyring/$ADNL_HEX

ls -la keyring
curl http://${TON_PROXY_REMOTE_ADDR} -v
printenv

./rldp-http-proxy -p ${TON_PROXY_PORT:-8080} \
                  -a ${TON_PROXY_SERVER_IP}:${TON_PROXY_ADNL_PORT:-3333} \
                  -A ${ADNL} \
                  -C /run/secrets/global-config \
                  -P ${TON_PROXY_PROXY_ALL:-NO} \
                  --verbosity ${TON_PROXY_VERBOSITY:-3} \
                  -R '*'@${TON_PROXY_REMOTE_ADDR:-127.0.0.1:80}
