FROM alpine:3.21.2 AS builder

RUN apk update && apk upgrade && \
    apk add --no-cache 

RUN wget ''

FROM alpine:3.21.2

RUN apk update && apk upgrade && \
    apk add --no-cache

COPY --from=builder /usr/local/nginx /usr/local/nginx

RUN wget -O /usr/local/nginx/conf/nginx.conf https://raw.githubusercontent.com/GwalexOfficial/rtmp-server-docker/main/nginx/conf/nginx.conf

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
