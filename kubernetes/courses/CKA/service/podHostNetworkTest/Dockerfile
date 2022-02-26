ARG VERSION=latest
FROM nginx:latest

LABEL template=yes

COPY --chown=root:root ./nginx.conf /etc/nginx/nginx.conf.template

CMD ["/bin/bash", "-c", "envsubst < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && nginx -g 'daemon off;'"]