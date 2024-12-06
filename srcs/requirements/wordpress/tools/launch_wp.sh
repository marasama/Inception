#!/bin/bash

MYSQL_USER_PASSWORD=$(cat /run/secrets/db_pass)

WP_ADMIN_PASS=$(cat /run/secrets/wp_admin_pass)

WP_USER_PASSWORD=$(cat /run/secrets/wp_pass)

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp-cli.phar

WP="/usr/local/bin/wp-cli.phar"

mkdir -p /run/php/

touch /run/php/php7.4-fpm.pid

chmod -R 755 /var/www/html/

chown -R www-data: /var/www/html/

#------

if [ ! -f "/var/www/wordpress/index.php" ]; then

  mkdir -p /var/www/html;
  cd /var/www/html;

  $WP core download --allow-root;

  $WP config create --allow-root \
  --dbhost=$MYSQL_HOST:3306 \
  --dbname=$MYSQL_DATABASE \
  --dbuser=$MYSQL_USERNAME \
  --dbpass=$MYSQL_USER_PASSWORD;

  $WP core install --allow-root \
  --url=$DOMAIN_NAME \
  --title=$WP_TITLE \
  --admin-user=$WP_ADMIN_USERNAME \
  --admin-password=$WP_ADMIN_PASS \
  --admin-email=$WP_ADMIN_EMAIL;

  $WP user create --allow-root
  $WP_USER_USERNAME \
  $WP_USER_EMAIL \
  --user-pass=$WP_USER_PASSWORD;

fi

exec "$@"

exec /usr/sbin/php-fpm7.4 --nodaemonize