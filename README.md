# TON Proxy Docker
This repository allows you easily run [rldp-http-proxy](https://ton.org/docs/#/web3/sites-and-proxy?id=running-ton-site) to deploy your site in TON network. The **rldp-http-proxy** is running in Docker container with `network_mode=host`.

## Running proxy:
* Set ton repo branch in docker-compose file section `rldp-proxy.build.args`.
* Build image: `docker-compose build`.
* Init proxy configuration: `./init.sh`. It generates new adnlid, downloads mainnet config and creates `.env`-file with settings.
    * If you already have ADNL, you should put user-friendly form to `private/adnl`, hex form to `private/adnl-hex` and copy content from your `keyring` file in `adnl-private`.
* Run proxy: `docker-compose up -d`. Assume that your site is already running on port 80 on the same machine.
* File `private/adnl` contains user-friendly adnl-form. Use this address to access to your site.

## Proxy settings
Settings are located in file `.env` in the root of the repo.
* `TON_PROXY_PORT=8080`: HTTP listening port (parameter `-p`).
* `TON_PROXY_SERVER_IP=<your-public-ip>`: a public IP of your server.
    * How to get your IP: `curl https://ipinfo.io/ip`.
* `TON_PROXY_ADNL_PORT=3333`: a port for ADNL queries.
* `TON_PROXY_REMOTE_ADDR="127.0.0.1:80"`: at this address HTTP requests will be proxied (`-R` parameter). Change this to proxy requests to another machine.
* `TON_PROXY_VERBOSITY=3`: verbosity level (for production better use `0`).
* `TON_PROXY_PROXY_ALL=NO`: proxy all HTTP requests (default only *.ton and *.adnl).
