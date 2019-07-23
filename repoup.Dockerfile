FROM debian

RUN apt update && apt -y install git jq && rm -rf /var/*/apt /var/cache/dpkg

RUN useradd -c 'Equus' -m -d /home/a -s /bin/bash -u 1333 a \
	&& mkdir -p /mnt/repo/crates.io-index /mnt/repo/crates.io-index.git \
	&& cd /mnt/repo/crates.io-index && git init . && git remote add origin https://github.com/rust-lang/crates.io-index \
	&& cd /mnt/repo/crates.io-index.git && git init --bare . \
	&& chown -R a:a /mnt/repo
VOLUME /mnt/repo

USER a
RUN true \
	&& git config --global user.name "Shiny Metal Donkey" \
	&& git config --global user.email "example@example.example" \
	&& git config --global push.default simple

ENTRYPOINT ["/usr/local/bin/updatecrates"]
COPY updatecrates /usr/local/bin
