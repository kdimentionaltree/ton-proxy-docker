#!/bin/bash
set -e
mkdir -p /app/keyring && cd /app/keyring
RESULT=$(../generate-random-id -m adnlid)
read -a ADNL_ARRAY <<< "$RESULT"
ADNL_HEX=${ADNL_ARRAY[0]}
ADNL=${ADNL_ARRAY[1]}

echo "ADNL_HEX: $ADNL_HEX, ADNL: $ADNL"
echo -n "$ADNL_HEX" > /output/adnl-hex
echo -n "$ADNL" > /output/adnl
cat $ADNL_HEX > /output/adnl-private
