#!/bin/bash

service mariadb start

sleep 7

echo "MariaDB: setting up..."

mariadb -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE"
mariadb -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASS';"
mariadb -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
mariadb -e "FLUSH PRIVILEGES;"
mariadb -e "SHUTDOWN;"

echo "MariaDB: set up!"

exec "$@"
