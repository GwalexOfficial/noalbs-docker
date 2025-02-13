FROM alpine:3.21.2 AS builder

RUN apk update && apk upgrade && \
    apk add --no-cache cargo

RUN wget 'https://github.com/NOALBS/nginx-obs-automatic-low-bitrate-switching/releases/download/v2.12.0/noalbs-v2.12.0-x86_64-unknown-linux-musl.tar.gz' && \
    tar xvzf noalbs-v2.12.0-x86_64-unknown-linux-musl.tar.gz && \
    mv -R noalbs-v2.12.0-x86_64-unknown-linux-musl/ noalbs/ && \
    cd noalbs/ && \
    cargo run --release

FROM alpine:3.21.2

RUN apk update && apk upgrade && \
    apk add --no-cache

COPY --from=builder /noalbs /usr/local/noalbs

CMD ["/usr/local/noalbs", "-g", "daemon off;"]
