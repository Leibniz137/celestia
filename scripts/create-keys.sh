#!/bin/bash

# adapted from https://stakeking.notion.site/Join-Celestia-Devnet-2-d4c08af1d0534b3faca7aaa8c1e9266d

set -e

WALLET_NAME=$1

if [ -z "${WALLET_NAME}" ]; then
  echo "Pass wallet name as first arg" >&2
  exit 1
fi


docker run \
  --rm \
  -it \
  --entrypoint bash \
  -e WALLET_NAME=$WALLET_NAME \
  -v $(pwd)/submodules/celestiaorg/networks:/networks \
  -v $(pwd)/.celestia-app:/celestia-app/.celestia-app \
  --workdir=/networks/scripts \
  celestia-appd \
  -c 'PATH=${PATH}:/celestia-app ./1_create_key.sh ${WALLET_NAME}'
