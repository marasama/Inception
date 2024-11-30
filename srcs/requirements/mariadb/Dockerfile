FROM debian:bullseye

ARG MYSQL_DATABASE
ARG MYSQL_USERNAME
ARG MYSQL_USER_PASSWORD
ARG MYSQL_ROOT_PASSWORD

ENV MYSQL_DATABASE=${MYSQL_DATABASE}
ENV MYSQL_USERNAME=${MYSQL_USERNAME}
ENV MYSQL_USER_PASSWORD=${MYSQL_USER_PASSWORD}
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}

EXPOSE 3306

RUN apt update
RUN apt install -y mariadb-server

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/commands.sql .

# RUN service mysql start && mysql < ./commands.sql && rm -f ./commands.sql
RUN mysqld_safe --skip-grant-tables & sleep 5 && \
    mysql < ./commands.sql && \
    rm -f ./commands.sql && \
    tail -f /dev/null  
