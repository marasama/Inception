FROM debian:bullseye

EXPOSE 9000

RUN apt update -y
RUN apt install -y curl php7.4 php7.4-fpm php7.4-mysql sendmail

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/launch_wp.sh /

RUN chmod +x ./launch_wp.sh

RUN mkdir -p /var/www/html

ENTRYPOINT ["./launch_wp.sh"]