#!/bin/bash

MYSQL_PASS=$(cat /run/secrets/db_pass)
MYSQL_ROOT_PASS=$(cat /run/secrets/db_admin_pass)

service mariadb start

sleep 3

echo "MariaDB: setting up..."

mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASS}';"

mariadb -e "CREATE DATABASE IF NOT EXISTS '$MYSQL_DATABASE';"
mariadb -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASS';"
mariadb -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
mariadb -e "FLUSH PRIVILEGES;"
mariadb -e "SHUTDOWN;"

echo "MariaDB: set up!"

exec "$@"