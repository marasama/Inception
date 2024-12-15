FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/mariadb.sh /tmp/

RUN chmod +x /tmp/mariadb.sh

ENTRYPOINT [ "/tmp/mariadb.sh" ]

CMD [ "mariadbd" ]