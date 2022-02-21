ARG VERSION=latest
FROM ubuntu:${VERSION}

LABEL type="webServer"

ENV NGINX_NAME nginx-1.20.2

WORKDIR /home/root/Downloads

# Second line is what we need to install nginx from source. Curl or wget is also needed.
RUN apt update && apt-get install --yes curl vim wget jq procps ca-certificates lsb-release gnupg man \
    build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev && \
    wget https://nginx.org/download/${NGINX_NAME}.tar.gz -O ${NGINX_NAME}.tar.gz && \
    tar -xzf ${NGINX_NAME}.tar.gz && cd ${NGINX_NAME} && \
    ./configure --with-pcre \
    --sbin-path=/usr/bin/nginx \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --pid-path=/var/run/nginx.pid \
    --with-http_ssl_module && make && make install

CMD [ "nginx", "-g", "daemon off;" ]