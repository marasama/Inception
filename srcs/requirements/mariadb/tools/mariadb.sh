#!/bin/bash

service mariadb start

sleep 3

echo "MariaDB: setting up..."

mariadb -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mariadb -e "CREATE USER IF NOT EXISTS '$(cat /var/run/secrets/db_login)'@'%' IDENTIFIED BY '$(cat /var/run/secrets/db_pass)';"
mariadb -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$(cat /var/run/secrets/db_login)'@'%';"
mariadb -e "FLUSH PRIVILEGES;"
mariadb -e "SHUTDOWN;"

echo "MariaDB: set up!"

exec "$@"