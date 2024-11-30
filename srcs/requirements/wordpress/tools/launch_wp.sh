#!/bin/sh

if [ -f ./wordpress/wp-config.php]
then
  echo "Wordpress is already installed"
else
  wget https://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz
	rm -rf latest.tar.gz

  rm -rf /etc/php/php-fpm.d/www.conf
  cp /var/www/html/www.conf /etc/php/php-fpm.d/

  cd /var/www/html/wordpress
  sed -i s"s/username_here/$WP_USER_USERNAME/g" wp-config-sample.php
  sed -i s"s/password_here/$WP_USER_PASSWORD/g" wp-config-sample.php
  sed -i s"s/localhost/$MYSQL_HOST/g" wp-config-sample.php
  sed -i s"s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php

  mv wp-config-sample.php wp-config.php

fi

exec "$@"
