FROM debian:bullseye

EXPOSE 9000

RUN apt update -y && apt install -y wget php-fpm php

COPY ./conf/www.conf /var/www/html/
COPY ./tools/launch_wp.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/launch_wp.sh

WORKDIR /var/www/html

ENTRYPOINT ["/bin/bash", "/usr/local/bin/launch_wp.sh"]

CMD ["/usr/sbin/php-fpm7.4","-F"] 
