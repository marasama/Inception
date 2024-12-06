FROM debian:bullseye

RUN apt update
RUN apt install -y nginx openssl

EXPOSE 443

COPY ./conf/default /etc/nginx/sites-enabled/default

COPY ./tools/nginx_start.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/nginx_start.sh

ENTRYPOINT ["nginx_start.sh"]