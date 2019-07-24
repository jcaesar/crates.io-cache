FROM clojure

RUN apt update && apt -y install proxychains && rm -rf /var/*/apt /var/cache/dpkg

RUN  useradd -c 'C2' -m -d /home/a -s /bin/bash -u 1333 a && mkdir -p /opt/ccp /mnt/cache/crates && chown -R a:a /opt/ccp /mnt/cache
#USER a TODO
WORKDIR /opt/ccp
RUN git clone https://github.com/puppetlabs/crates-caching-proxy . \
	&& lein deps && lein compile && lein uberjar # TODO: Would be nice to run that jar in a different stage. Or maybe we can replace it by nginx entirely?

VOLUME /mnt/cache
COPY cratecache-runscript /usr/local/bin/
ENTRYPOINT ["cratecache-runscript"]
