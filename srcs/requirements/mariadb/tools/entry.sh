# #!/bin/bash

export MYSQL_DATABASE=my_database
export MYSQL_USERNAME=my_user
export MYSQL_USER_PASSWORD=my_password
export MYSQL_ROOT_PASSWORD=root_password

# Start MySQL in safe mode
mysqld_safe  & sleep 7
while ! mysqladmin ping --silent; do
    sleep 1
done

# Execute SQL commands
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USERNAME}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USERNAME}'@'%';
FLUSH PRIVILEGES;
EOF

# Restart MySQL normally
mysqladmin shutdown
mysqld_safe &
while ! mysqladmin ping --silent; do
    sleep 1
done

# Change root password
mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

tail -f
# Execute remaining commands
exec "$@"
#
# mysqld_safe skip-grant-tables & sleep 5
# mysql -u root <<EOF
# CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}; \
# CREATE USER IF NOT EXISTS '${MYSQL_USERNAME}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}'; \
# GRANT ALL PRIVILEGES ON `${MYSQL_DATABASE}`.* TO '${MYSQL_USERNAME}'@'%'; \
# FLUSH PRIVILEGES; \
# ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; \
# EOF
#
# exec "$@"
