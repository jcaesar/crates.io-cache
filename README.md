# crates.io caching proxy

A caching proxy for both https://github.com/rust-lang/crates.io-index and https://crates.io/api/v1/crates.
Based on [puppetlabs/crates-caching-proxy](https://github.com/puppetlabs/crates-caching-proxy).

Use at own risk, send PRs.

## Usage
```bash
docker-compose rm -vfs && docker-compose up --build # Sure, -d it, miss the error message. ;)
```
Then, place
```toml
[source]

[source.localcrates]
registry = "git://localhost/crates.io-index.git"
# Does not need to be on localhost

[source.crates-io]
```
at `~/.cargo/config`.

Proceed as usual.

## Configuration
is done via environment variables:
 * `CRATE_PROXY_PORT`: Local listening port of the crates.io proxy
 * `CACHE_EXT_URL`: Externally reachable http(s) URL that ends up making requests to `CRATE_PROXY_PORT`
 * `DEFAULT_GIT_PORT`: Listening port for the github repository proxy.
