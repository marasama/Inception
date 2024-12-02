FROM debian:bullseye

EXPOSE 9000

RUN apt update -y
RUN apt install -y curl php7.4 php7.4-fpm php7.4-mysql 

COPY ./tools/launch_wp.sh /

RUN chmod +x ./launch_wp.sh

RUN mkdir -p /var/www/wordpress

ENTRYPOINT ["./launch_wp.sh"]

