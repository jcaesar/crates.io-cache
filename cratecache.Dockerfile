FROM clojure as builder

WORKDIR /opt/ccp
RUN git clone https://github.com/puppetlabs/crates-caching-proxy . \
	&& lein deps && lein compile && lein uberjar \
	&& mv target/crates-caching-proxy-*-standalone.jar ccp.jar

FROM openjdk

RUN curl http://springdale.math.ias.edu/data/puias/unsupported/7/x86_64//proxychains-ng-4.11-1.sdl7.x86_64.rpm -o pcng.rpm \
	&& echo "24c7bd1a52a7751e1decc1bf23aa373dd7005713b6c74f34247036d25d811990  pcng.rpm" | sha256sum -c \
	&& yum install -y pcng.rpm && rm -rf pcng.rpm

VOLUME /mnt/crate-cache
COPY --from=builder /opt/ccp/ccp.jar /opt/
COPY cratecache-runscript /usr/local/bin/
ENTRYPOINT ["cratecache-runscript"]
