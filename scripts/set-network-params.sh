#!/bin/bash

# adapted from https://stakeking.notion.site/Join-Celestia-Devnet-2-d4c08af1d0534b3faca7aaa8c1e9266d

set -e

MONIKER=$1

if [ -z "${MONIKER}" ]; then
  echo "Pass moniker as first arg" >&2
  exit 1
fi

if [ -d ./.celestia-app/ ]; then
  echo "Config already exists, refusing to overwrite config"
  exit 1
fi

mkdir ./.celestia-app

docker run \
  --rm \
  -it \
  --entrypoint bash \
  -e MONIKER \
  -v $(pwd)/.celestia-app:/celestia-app/.celestia-app \
  celestia-appd \
  -c "/celestia-app/celestia-appd init $MONIKER --chain-id devnet-2" > ./.celestia-app/account.json

echo "Wrote config data to ./.celestia-app/"
echo "Wrote account json to account.json"


echo "Overwriting genesis.json with content from networks repo"

cp ./submodules/celestiaorg/networks/devnet-2/genesis.json ./.celestia-app/config/


echo "Updating seeds config"

#update seeds
seeds='"74c0c793db07edd9b9ec17b076cea1a02dca511f@46.101.28.34:26656"'
echo $seeds
sed -i.bak -e "s/^seeds *=.*/seeds = $seeds/" ./.celestia-app/config/config.toml
