FROM clojure

RUN  useradd -c 'C2' -m -d /home/a -s /bin/bash -u 1333 a && mkdir -p /opt/ccp /mnt/crates/cache && chown -R a:a /opt/ccp /mnt/crates
WORKDIR /opt/ccp
RUN git clone https://github.com/puppetlabs/crates-caching-proxy . \
	&& lein deps && line compile
