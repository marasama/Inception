#!/bin/bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp-cli.phar

WP="/usr/local/bin/wp-cli.phar"

cd /var/www/wordpress/

chmod -R 755 /var/www/wordpress/

chown -R www-data:www-data /var/www/wordpress

#------

if [ ! -f "/var/www/wordpress/index.php" ]; then

  $WP core download --allow-root

  $WP config create --dbhost=mariadb:3306 --dbname="$MYSQL_HOST" --dbuser="$MYSQL_USERNAME" --dbpass="$MYSQL_USER_PASSWORD" --allow-root 

  $WP core install --url="$ADDRESS" --title="$WP_TITLE" --admin-user="$WP_ADMIN_USERNAME" --admin-password="$WP_ADMIN_PASS" --admin-email="$WP_ADMIN_EMAIL" --allow-root

  $WP user create "$WP_USER_USERNAME" "$WP_USER_EMAIL" --user-pass="$WP_USER_PASSWORD" --role="author" --allow-root

  $WP option update comment_whitelist 0 --allow-root

fi

sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf

mkdir -p /run/php

exec /usr/sbin/php-fpm7.4 -F
