FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    nginx \
    openssl

EXPOSE 443

COPY ./conf/default /etc/nginx/sites-enabled/default
COPY ./tools/nginx_ssl.sh /tmp/

RUN chmod +x /tmp/nginx_ssl.sh

ENTRYPOINT ["/tmp/nginx_ssl.sh"]

CMD ["nginx", "-g", "daemon off;"]