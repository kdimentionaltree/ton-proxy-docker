# TON Proxy Docker
This repository allows you easily run [rldp-http-proxy](https://ton.org/docs/#/web3/sites-and-proxy?id=running-ton-site) to deploy your site in TON network. The **rldp-http-proxy** is running in Docker container with `network_mode=host`.

## Running proxy:
* Set ton repo branch in docker-compose file section `rldp-proxy.build.args`.
* Build image: `docker-compose build`.
* Init proxy configuration: `./init.sh`.
    * You can change settings in file `.env`.
* Run proxy: `docker-compose up -d`.

## Proxy settings
Settings are located in file `.env` in the root of the repo.
* `TON_PROXY_PORT=8080`: HTTP listening port (parameter `-p`).
* `TON_PROXY_SERVER_IP=<your-public-ip>`: a public IP of your server.
    * How to get your IP: `curl https://ipinfo.io/ip`.
* `TON_PROXY_ADNL_PORT=3333`: a port for ADNL queries.
* `TON_PROXY_REMOTE_ADDR="localhost:80"`: at this address HTTP requests will be proxied (`-R` parameter)
* `TON_PROXY_VERBOSITY=3`: verbosity level (for production better use `0`).
* `TON_PROXY_PROXY_ALL=NO`: proxy all HTTP requests (default only *.ton and *.adnl).
