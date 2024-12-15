#!/bin/bash

chown -R www-data: /var/www/*;
chmod -R 755 /var/www/*;
mkdir -p /run/php/;
touch /run/php/php7.4-fpm.pid;

if [ ! -f /var/www/html/wp-config.php ]; then
    cd /var/www/html;

    wp-cli core download --allow-root;

    wp-cli config create --allow-root \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$(cat /var/run/secrets/db_login) \
        --dbpass=$(cat /var/run/secrets/db_pass) \
        --dbhost=$MYSQL_DB_HOST;

    echo "Wordpress: setting up..."

    wp-cli core install --allow-root \
        --url=$DOMAIN \
        --title=$WP_TITLE \
        --admin_user=$(cat /var/run/secrets/wp_admin_pass) \
        --admin_password=$(cat /var/run/secrets/wp_admin_login) \
        --admin_email=$(cat /var/run/secrets/wp_admin_email);

    wp-cli user create --allow-root \
        $(cat /var/run/secrets/wp_user_login) $(cat /var/run/secrets/wp_user_email)\
        --user_pass=$(cat /var/run/secrets/wp_user_pass);
fi

echo "Wordpress is set up. You can login from $DOMAIN"

exec "$@"
