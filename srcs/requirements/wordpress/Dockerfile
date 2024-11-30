FROM debian:bullseye

EXPOSE 9000

RUN apt-get update && apt-get install wget php-fpm php

COPY ./conf/www.conf /var/www/html/
COPY ./tools/launch_wp.sh ~

ENTRYPOINT ["~/launch_wp.sh"]

WORKDIR /var/www/html

CMD ["/usr/sbin/php-fpm"] 
