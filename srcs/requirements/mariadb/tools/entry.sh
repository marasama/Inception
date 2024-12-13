#!/bin/bash

MYSQL_PASS=$(cat /run/secrets/db_pass)
MYSQL_ROOT_PASS=$(cat /run/secrets/db_root_pass)

service mariadb start

sleep 3

echo "MariaDB: setting up..."

mariadb -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mariadb -e "CREATE USER IF NOT EXISTS '$MYSQL_USERNAME'@'%' IDENTIFIED BY '$MYSQL_PASS';"
mariadb -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USERNAME'@'%';"
mariadb -e "FLUSH PRIVILEGES;"
mariadb -e "SHUTDOWN;"

echo "MariaDB: set up!"

exec "$@"