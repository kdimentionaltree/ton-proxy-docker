#!/bin/bash
set -e

mkdir -p ./private/

echo "Generating ADNL address"
docker run --rm -v `pwd`/private:/output rldp-http-proxy:latest ./generate_adnl.sh

wget https://ton.org/global-config.json -q -O private/global.config.json
# wget https://ton-blockchain.github.io/testnet-global.config.json -q-O private/global.config.json # testnet config

PUBLIC_IP=$(curl -s https://ipinfo.io/ip)
echo "TON_PROXY_PORT=8080" > .env
echo "TON_PROXY_SERVER_IP=$PUBLIC_IP" >> .env
echo "TON_PROXY_ADNL_PORT=3333" >> .env
echo "TON_PROXY_REMOTE_ADDR=\"127.0.0.1:80\"" >> .env
echo "TON_PROXY_VERBOSITY=3" >> .env
echo "TON_PROXY_PROXY_ALL=NO" >> .env
