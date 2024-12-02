FROM debian:bullseye

EXPOSE 3306

RUN apt update
RUN apt install -y mariadb-server

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/entry.sh /usr/local/bin/

ENTRYPOINT ["/bin/bash","/usr/local/bin/entry.sh"]
