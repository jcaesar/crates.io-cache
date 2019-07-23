# crates.io caching proxy

A full blown caching proxy for both https://github.com/rust-lang/crates.io-index and https://crates.io/api/v1/crates.
Based on [puppetlabs/crates-caching-proxy](https://github.com/puppetlabs/crates-caching-proxy).

Several tests showed that downloading crates is somewhat flaky, especially when using `http_proxy`. Use at own disgression, or send PRs.

## Usage
```bash
docker-compose rm -vfs && docker-compose up --build # Sure, -d it, miss the error message. ;)
```
Then, place
```
[source]

[source.localcrates]
registry = "git://localhost/crates.io-index.git"

[source.crates-io]
```
at `~/.cargo/config`.

Proceed as usual.

## Configuration
is done via environment variables:
 * `CRATE_PROXY_PORT`: Local listening port of the crates.io proxy
 * `CACHE_EXT_URL`: Externally reachable http(s) URL that ends up making requests to `CRATE_PROXY_PORT`
 * `DEFAULT_GIT_PORT`: Listening port for the github repository proxy.
