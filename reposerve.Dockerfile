FROM alpine
RUN apk add git-daemon && rm -rf /var/cache/apk
ENTRYPOINT git daemon --reuseaddr --export-all --base-path=/mnt/repo /mnt/repo
